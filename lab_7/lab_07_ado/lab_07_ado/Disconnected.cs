using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using Npgsql;
using NpgsqlTypes;

namespace lab_07_ado
{
    class Disconnected
    {
        static string connString =
                String.Format(
                    "Server={0}; User Id={1}; Database={2}; Port={3}; Password={4};SSLMode=Prefer",
                    "127.0.0.1",
                    "VisualStudio",
                    "labs",
                    "5432", //port
                    "VSvsvs");

        public struct dataStuff
        {
            public NpgsqlDataAdapter adapter;
            public DataSet dataSet;
        }


        /// <summary>
        /// Получение DataSet
        /// </summary>
        public static dataStuff ConnectToData()
        {
            NpgsqlConnection connection = new NpgsqlConnection(connString);

                //Create a SqlDataAdapter for the people table.
            NpgsqlDataAdapter adapter = new NpgsqlDataAdapter();

            // A table mapping names the DataTable.
            adapter.TableMappings.Add("Table", "people");

            // Open the connection.
            connection.Open();

            // ----- select command
            // Create a SqlCommand to retrieve people data.
            NpgsqlCommand command = new NpgsqlCommand(
                "select * from people;",
                connection);
            command.CommandType = CommandType.Text;

            // Set the SqlDataAdapter's SelectCommand.
            adapter.SelectCommand = command;


            // ----- insert command
            NpgsqlCommand commandIns = new NpgsqlCommand(
                "insert into people(name, sex, age) values (@PName, @PSex, @PAge);",
                connection);
            
            commandIns.Parameters.Add(new NpgsqlParameter("@PName", NpgsqlDbType.Varchar, 100));
            commandIns.Parameters.Add(new NpgsqlParameter("@PSex", NpgsqlDbType.Varchar));
            commandIns.Parameters.Add(new NpgsqlParameter("@PAge", NpgsqlDbType.Integer));
            
            // Set the SqlDataAdapter's SelectCommand.
            adapter.InsertCommand = commandIns;


            // ---- Update command
            
            adapter.UpdateCommand = new NpgsqlCommand(
           "UPDATE people SET name = @PeopleName " +
           "WHERE id = @PeopleID", connection);

            adapter.UpdateCommand.Parameters.Add(
               "@PeopleName", NpgsqlDbType.Varchar, 15, "PeopleName");

            NpgsqlParameter parameter = adapter.UpdateCommand.Parameters.Add(
              "@PeopleID", NpgsqlDbType.Integer);
            parameter.SourceColumn = "PeopleID";
            parameter.SourceVersion = DataRowVersion.Original;
            

            // Fill the DataSet.
            DataSet dataSet = new DataSet("people");
            adapter.Fill(dataSet);

            // Close the connection.
            connection.Close();

            return new dataStuff { adapter = adapter, dataSet = dataSet };
        }

        /// <summary>
        /// Отсоединенная; вывод значений таблицы people
        /// </summary>
        public static void ReadPeople(DataSet dataSet)
        {
            var reader = dataSet.CreateDataReader();
            while (reader.Read())
            {
                Console.WriteLine(
                    string.Format(
                        "{0}, {1}, {2}, {3}",
                        reader.GetInt32(0).ToString(),
                        reader.GetString(1),
                        reader.GetString(2),
                        reader.GetInt32(3).ToString()
                        )
                    );
            }
        }

        /// <summary>
        /// Отсоединенная; получение длины таблицы people
        /// </summary>
        /// <returns>Длина</returns>
        public static Int64 GetTablePeopleLen(DataSet dataSet)
        {
            Int64 count = 0;
            var reader = dataSet.CreateDataReader();
            while (reader.Read())
            {
                count++;
            }
            Console.Write("{0}\n", count);
            return count;
        }

        /// <summary>
        /// Отсоединенная; вставка нового человека в бд
        /// </summary>
        /// <param name="adapter"></param>
        /// <param name="dataSet"></param>
        public static void InsertPerson(NpgsqlDataAdapter adapter, DataSet dataSet)
        {
            DataRow newRow; 
            // Obtain a new DataRow object from the DataTable.
            newRow = dataSet.Tables["people"].NewRow();

            // Set the DataRow field values as necessary.
            newRow["name"] = "George";
            newRow["sex"] = "m";
            newRow["age"] = 15;

            // Pass that new object into the Add method of the DataTable.
            dataSet.Tables["people"].Rows.Add(newRow);

            //dataSet.AcceptChanges();
            adapter.Update(dataSet.Tables[0]);            
        }

        public static void UpdatePersonName(NpgsqlDataAdapter adapter, DataSet dataSet)
        {

            DataRow categoryRow = dataSet.Tables[0].Rows[0];
            categoryRow["name"] = "HOHO";

            adapter.Update(dataSet.Tables[0]);
        }
    }
}
