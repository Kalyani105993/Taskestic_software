package com.dakshabhi.common.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;

import com.dakshabhi.common.log.Loger;
import java.util.Collections;

public class QueryHelper {

    /** database connection */
    private Connection _con = null;

    /** connection pool */
    private ConnectionPool _conPool = null;

    /** Database type (for example, DatabaseType.ORACLE) */
    private int _dbType;

    /** prepared statement used in calls to runQuery() and runQueryKeepConnOpen() */
    private PreparedStatement _prepStatement = null;

    /** maximum rows to return in a SELECT statement */
    private int _maxRows = 100000;

    /** timeout interval for long running queries */
    private int _timeoutInSec = 0; // 0 = no timeout

    /** number of rows updated in last runQuery() */
    private int _numRecordsUpdated = 0;

    /** ArrayList which stores the SQL parameters (?) */
    private ArrayList<Object> _params = null;
    
	private int _lastGeneratedKey = -1;

    /**
     * Constructor uses provided connection pool
     */
    public QueryHelper() {

        this._conPool = ConnectionPool.getInstance();
        _con = _conPool.getConnection();
        _dbType = DatabaseType.getDbType(_con);
        _params = new ArrayList<Object>();
        // System.out.println("pool size - " + this._conPool.conPool.size());
    }

    public QueryHelper(String category) {

        this._conPool = ConnectionPool.getInstance(category);
        _con = _conPool.getConnection();
        _dbType = DatabaseType.getDbType(_con);
        _params = new ArrayList<Object>();
        // System.out.println("pool size - " + this._conPool.conPool.size());
    }

    /**
     * Getter for connection
     * 
     * @return Connection
     */
    public Connection getConnection() {
        if (_con == null)
            _con = _conPool.getConnection();

        try {
            if (_con.isClosed())
                _con = _conPool.getConnection();
        } catch (Exception ex) {
        }

        return (_con);
    }

    /**
     * Clears out the query parameter list
     */
    public void clearParams() {
        if (_params != null) {
            _params.clear();
        }
    }

    /**
     * Adds a query parameter to the list
     * 
     * @param param
     *            parameter to add to list
     */
    public void addParam(Object param) {
        try {
            _params.add(param);
        } catch (NullPointerException npe) {
            Loger.log(Loger.DEBUG, "Exception While Adding Parameters");
        }
    }

    /**
     * Adds an int query parameter to the list
     * 
     * @param param
     *            parameter to add to list
     */
    public void addParam(int param) {
        addParam(new Integer(param));
    }

    /**
     * Adds a long query parameter to the list
     * 
     * @param param
     *            parameter to add to list
     */
    public void addParam(long param) {
        addParam(new Long(param));
    }

    /**
     * Adds a double query parameter to the list
     * 
     * @param param
     *            parameter to add to list
     */
    public void addParam(double param) {
        addParam(new Double(param));
    }

    /**
     * Adds a boolean query parameter to the list
     * 
     * @param param
     *            parameter to add to list
     */
    public void addParam(boolean param) {
        addParam(new Boolean(param));
    }

    /**
     * Adds a float query parameter to the list
     * 
     * @param param
     *            parameter to add to list
     */
    public void addParam(float param) {
        addParam(new Float(param));
    }

    /**
     * Adds a short query parameter to the list
     * 
     * @param param
     *            parameter to add to list
     */
    public void addParam(short param) {
        addParam(new Short(param));
    }

    /**
     * Runs the sql and does NOT close the connection
     * 
     * @param sql
     *            sql command to run
     * @return SQLResults if it's a query, null otherwise
     */
    public SQLResults runQuery(String sql) {
        SQLResults results = null;
        ResultSet rs = null;
        Connection con = null;
        PreparedStatement prepStatement = null;
        long startTime = System.currentTimeMillis();
        _numRecordsUpdated = 0;
        try {
            con = _conPool.getConnection();
            prepStatement = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

            setPrepStatementParameters(prepStatement);

            boolean isSelectStatement = isSelectStatement(sql);
			if ((_dbType != DatabaseType.ORACLE) && (isSelectStatement == false)) {
				prepStatement.setMaxRows(_maxRows);
				_numRecordsUpdated = prepStatement.executeUpdate();
				ResultSet grs = prepStatement.getGeneratedKeys();
				try {
					if (grs.last()) {
						_lastGeneratedKey = grs.getInt(1);
					}
				} finally {
					grs.close();
				}
			} else {
				if (_timeoutInSec > 0)
					prepStatement.setQueryTimeout(_timeoutInSec);

				if (isSelectStatement(sql)) {
					prepStatement.setMaxRows(_maxRows);
					rs = prepStatement.executeQuery();
				} else {
					_numRecordsUpdated = prepStatement.executeUpdate();

				}
			}

            if (isSelectStatement) {
                // SELECT statement, so get results
                ResultSetMetaData rsmd = rs.getMetaData();
                int columnCount = rsmd.getColumnCount();
                results = new SQLResults(_dbType, columnCount);

                // add field values to ResultSet object
                while (rs.next()) {
                    for (int i = 0; i < columnCount; i++)
                        results.add(rs.getObject(i + 1));
                }
                // add column names to ResultSet object
                for (int i = 0; i < columnCount; i++)
                    results.addColumnName(rsmd.getColumnName(i + 1));
            }
        } catch (SQLException e) {
            throw ExceptionFactory.getException(_dbType, e.getMessage() + "\nSQL Failed: " + sql, e);
        } finally {
            try {
                rs.close();
                prepStatement.close();
            } catch (Exception ex) {
            }
            prepStatement = null;
            try {
                rs.close();
            } catch (Exception ex) {
            }
            try {
                con.close();
                //System.out.println("---CONNECTION CLOSE---");
            } catch (Exception ex) {
            }
            con = null;
            clearParams();
        }
        /*if((System.currentTimeMillis() - startTime) > 100){
	        System.out.println("-----------------");
	        System.out.println("Time taken: " + (System.currentTimeMillis() - startTime));
	        System.out.println("Query: " + sql);
	        System.out.println("-----------------");
        }*/
        return (results);
    }
    
    
    public static String preparePlaceHolders(int length) {
        return String.join(",", Collections.nCopies(length, "?"));
    }

    private void setPrepStatementParameters(PreparedStatement prepStatement) throws SQLException {
        if (_params != null) {
            for (int i = 0; i < _params.size(); i++) {
                Object param = _params.get(i);
                if (param instanceof Integer) {
                    int value = ((Integer) param).intValue();
                    prepStatement.setInt(i + 1, value);
                } else if (param instanceof Short) {
                    short sh = ((Short) param).shortValue();
                    prepStatement.setShort(i + 1, sh);
                } else if (param instanceof String) {
                    String s = (String) param;
                    prepStatement.setString(i + 1, s);
                } else if (param instanceof Double) {
                    double d = ((Double) param).doubleValue();
                    prepStatement.setDouble(i + 1, d);
                } else if (param instanceof Float) {
                    float f = ((Float) param).floatValue();
                    prepStatement.setFloat(i + 1, f);
                } else if (param instanceof Long) {
                    long l = ((Long) param).longValue();
                    prepStatement.setFloat(i + 1, l);
                } else if (param instanceof Boolean) {
                    boolean b = ((Boolean) param).booleanValue();
                    prepStatement.setBoolean(i + 1, b);
                } else if (param instanceof java.sql.Date) {
                    prepStatement.setDate(i + 1, (java.sql.Date) param);
                } else if (param instanceof java.sql.Time) {
                    prepStatement.setTime(i + 1, (java.sql.Time) param);
                } else if (param instanceof java.sql.Timestamp) {
                    prepStatement.setTimestamp(i + 1, (java.sql.Timestamp) param);
                } else {
                    clearParams();
                    throw ExceptionFactory.getException(_dbType, "Unknown parameter type: param " + i);
                }
            }
        }
    }

    /**
     * Runs the sql and does NOT close the connection. Returns a standard JDBC ResultSet object which can be scrolled
     * through using rs.next(). This method is preferable to runQuery() when your ResultSet is too large to fit into
     * memory (a SQLResults object).
     * 
     * @param sql
     *            sql command to run
     * @return ResultSet if it's a query, null otherwise
     */
    public ResultSet runQueryStreamResults(String sql) {
        ResultSet rs = null;
        // Connection con = null;
        PreparedStatement prepStatement = null;
        long startTime = System.currentTimeMillis();
        _numRecordsUpdated = 0;
        try {
            _con = getConnection();
            if (_prepStatement == null)
                prepStatement = _con.prepareStatement(sql);

            setPrepStatementParameters(prepStatement);

            boolean isSelectStatement = isSelectStatement(sql);
            if ((_dbType != DatabaseType.ORACLE) && (isSelectStatement == false)) {
                prepStatement.setMaxRows(_maxRows);
                _numRecordsUpdated = prepStatement.executeUpdate();
            } else {
                if (_timeoutInSec > 0)
                    prepStatement.setQueryTimeout(_timeoutInSec);

                if (isSelectStatement(sql)) {
                    prepStatement.setMaxRows(_maxRows);
                    rs = prepStatement.executeQuery();
                } else {
                    _numRecordsUpdated = prepStatement.executeUpdate();
                }
            }
        } catch (SQLException e) {
            throw ExceptionFactory.getException(_dbType, e.getMessage() + "\nSQL Failed: " + sql, e);
        } finally {
            clearParams();
        }
        /*if((System.currentTimeMillis() - startTime) > 100){
	        System.out.println("-----------------");
	        System.out.println("Time taken: " + (System.currentTimeMillis() - startTime));
	        System.out.println("Query: " + sql);
	        System.out.println("-----------------");
        }*/
        return (rs);
    }

    /**
     * Runs the sql and automatically closes the connection when done
     * 
     * @param sql
     *            sql command to execute
     * @return SQLResults if it's a query, null otherwise
     */
    public SQLResults runQueryCloseCon(String sql) {
        try {
            return (runQuery(sql));
        } finally {
            // conPool.closeConnection(con, dbType);
        }
    }

    /**
     * Is this SQL statement a select statement (returns rows?)
     * 
     * @param sql
     *            String
     * @return boolean
     */
    private boolean isSelectStatement(String sql) {
        StringBuffer sb = new StringBuffer(sql.trim());
        String s = (sb.substring(0, 6));
        return (s.equalsIgnoreCase("SELECT"));
    }

    /**
     * Cancels the currently running query if both the database and driver support aborting an SQL statement. This
     * method can be used by one thread to cancel a statement that is being executed by another thread.
     */
    public void cancelQuery() {
        try {
            if (_prepStatement != null)
                _prepStatement.cancel();
        } catch (SQLException e) {
            throw ExceptionFactory.getException(_dbType, e.getMessage());
        }
    }

    /**
     * Closes the SQLExecutor's statement object (releasing database and JDBC resources immediately instead of waiting
     * for this to happen when the SQLExecutor object is garbage collected).
     */
    public void closeQuery() {
        try {
            if (_prepStatement != null) {
                _prepStatement.close();
                _prepStatement = null;
            }
        } catch (SQLException e) {
            throw ExceptionFactory.getException(_dbType, e.getMessage());
        }
    }

    /**
     * Gets the auto-commit status
     * 
     * @return true if in auto-commit mode, false otherwise
     */
    public boolean getAutoCommit() {
        try {
            return (_con.getAutoCommit());
        } catch (SQLException e) {
            throw ExceptionFactory.getException(_dbType, "Unable to get the auto commit status", e);
        }
    }

    /**
     * Sets the auto-commit status
     * 
     * @param autoCommit
     *            boolean
     */
    public void setAutoCommit(boolean autoCommit) {
        try {
            _con.setAutoCommit(autoCommit);
        } catch (SQLException e) {
            throw ExceptionFactory.getException(_dbType, "Unable to set the auto commit status = " + autoCommit, e);
        }
    }

    /**
     * Sets the transaction isolation level
     * 
     * @param level
     *            int
     */
    public void setTransactionIsolation(int level) {
        try {
            _con.setTransactionIsolation(level);
        } catch (SQLException e) {
            throw ExceptionFactory.getException(_dbType, "Attempted to set an invalid transaction isolation level", e);
        }
    }

    /**
     * Commits the current transaction
     */
    public void commitTrans() {
        try {
            _con.commit();
        } catch (SQLException e) {
            throw ExceptionFactory.getException(_dbType, "Failure during transaction commit", e);
        }
    }

    /**
     * Rolls back the current transaction
     */
    public void rollbackTrans() {
        try {
            _con.rollback();
        } catch (SQLException e) {
            throw ExceptionFactory.getException(_dbType, "Failure during transaction rollback", e);
        }
    }

    /**
     * Sets the current connection readOnly status
     * 
     * @param readOnly
     *            boolean
     */
    public void setReadOnly(boolean readOnly) {
        try {
            _con.setReadOnly(readOnly);
        } catch (SQLException e) {
            throw ExceptionFactory.getException(_dbType, "Exception during setReadOnly", e);
        }
    }

    /**
     * Is the current connection read only?
     * 
     * @return boolean
     */
    public boolean isReadOnly() {
        try {
            return (_con.isReadOnly());
        } catch (SQLException e) {
            throw ExceptionFactory.getException(_dbType, "Failure while accessing readOnly status of connection", e);
        }
    }

    /**
     * Setter for the maximum number of rows that a query can return
     * 
     * @param maxRow
     *            int
     */
    public void setMaxRows(int maxRows) {
        this._maxRows = maxRows;
    }

    /**
     * Getter for the maximum number of rows that a query can return
     * 
     * @return int
     */
    public int getMaxRows() {
        return (_maxRows);
    }

    /**
     * Getter for numRecordsUpdated. Call this method to find out how many rows were updated in the last runQuery() call
     * that did an INSERT, UPDATE, or DELETE.
     * 
     * @return int
     */
    public int getNumRecordsUpdated() {
        return (_numRecordsUpdated);
    }
    
    public int getLastGeneratedKey() {
		return _lastGeneratedKey;
	}

    /**
     * Getter for timeoutInSec
     * 
     * @return int query timeout in seconds
     */
    public int getTimeoutInSec() {
        return (_timeoutInSec);
    }

    /**
     * Setter for timeoutInSec
     * 
     * @param timeoutInSec
     *            int sets the query timeout in seconds
     */
    public void setTimeoutInSec(int timeoutInSec) {
        this._timeoutInSec = timeoutInSec;
    }

    /**
     * Closes this connection.
     */
    public void closeConnection() {
        if (_prepStatement != null) {
            try {
                _prepStatement.close();
                _prepStatement = null;
            } catch (Exception ex) {
            }
        }
        try { // _con.commit();
            if (_con != null) {
                _con.close();
                _con = null;
            }
        } catch (Exception ex) {
            // ex.printStackTrace();
        }
        // conPool.closeConnection(con, dbType);
        //System.out.println("---CONNECTION CLOSE---");
    }

    /**
     * Releases this connection (sets its available status = true). It does not close the connection. It merely makes
     * the connection available for re-use.
     * 
     * @param conPool
     *            ConnectionPool
     */
    public void releaseConnection() {
        if (_prepStatement != null) {
            try {
                _prepStatement.close();
                _prepStatement = null;
            } catch (Exception ex) {
            }
        }
        try { // _con.commit();
            if (_con != null) {
                _con.close();
                _con = null;
            }
        } catch (Exception ex) {
        }
        // conPool.releaseConnection(con, dbType);
        // conPool.closeConnection(con, dbType);
        //System.out.println("---CONNECTION CLOSE---");
    }

}
