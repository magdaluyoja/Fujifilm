using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Fujifilm_WMS.Models
{
    public class DataHelper
    {
        string retVal = "";
        public String GetData(string field, string table, string condition, string asVar = "")
        {
            retVal = "";
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Fujifilm_WMS"].ConnectionString.ToString()))
                {
                    conn.Open();
                    string sql = "SELECT " + field + " FROM " + table + " WHERE " + condition;
                    using (SqlCommand comm = new SqlCommand(sql, conn))
                    {
                        SqlDataReader reader = comm.ExecuteReader();
                        if (reader.Read())
                        {
                            if (asVar != "")
                                retVal = reader[asVar].ToString();
                            else
                                retVal = reader[field].ToString();
                        }
                    }
                    conn.Close();
                }
            }
            catch (Exception err)
            {
                string errmsg;
                if (err.InnerException != null)
                    errmsg = "An error occured: " + err.InnerException.ToString();
                else
                    errmsg = "An error occured: " + err.ToString();
            }
            return retVal;
        }
    }
}
