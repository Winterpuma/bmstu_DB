using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Npgsql;

namespace lab_07_ado
{
    static class Connected
    {
        static string connString =
                String.Format(
                    "Server={0}; User Id={1}; Database={2}; Port={3}; Password={4};SSLMode=Prefer",
                    "127.0.0.1",
                    "VisualStudio",
                    "labs",
                    "5432", //port
                    "VSvsvs");

        /// <summary>
        /// Соединенная; вывод значений таблицы people
        /// </summary>
        public static void ReadPeople()
        {
            var connection = new NpgsqlConnection(connString);
            connection.Open();
            using (var command = new NpgsqlCommand("select * from people", connection))
            {
                var reader = command.ExecuteReader();

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
            connection.Close();
        }

        /// <summary>
        /// Соединенная; получение длины таблицы people
        /// </summary>
        /// <returns>Длина</returns>
        public static Int64 GetTablePeopleLen()
        {
            Int64 count = 0;
            var connection = new NpgsqlConnection(connString);
            connection.Open();
            using (var cmdScalar = new NpgsqlCommand("select count(*) from people", connection))
            {
                // Execute the query and obtain the value of the first column of the first row
                count = (Int64)cmdScalar.ExecuteScalar();
                Console.Write("{0}\n", count);
            }
            connection.Close();
            return count;
        }

        /// <summary>
        /// Соединенная; создание функции getpeople
        /// </summary>
        public static void CreateFunction()
        {
            string query = "create or replace function getpeople(int) returns people as " +
                "$$ " +
                "select * " +
                "from people " +
                "where age = $1; " +
                "$$ language sql;";
            var connection = new NpgsqlConnection(connString);
            connection.Open();
            using (var cmdFunc = new NpgsqlCommand(query, connection))
            {
                var dr = cmdFunc.ExecuteNonQuery();
            }
            connection.Close();
        }

        /// <summary>
        /// Совединеная; вызов функции getpeople
        /// </summary>
        public static void CallFunction()
        {
            var connection = new NpgsqlConnection(connString);
            connection.Open();
            using (var cmdFunc = new NpgsqlCommand("select * from getpeople(@id)", connection)) // функция принимает int
            {
                cmdFunc.Parameters.AddWithValue("id", 4); // а можно просто захардкодить в команду 
                                                          //cmdFunc.CommandType = System.Data.CommandType.StoredProcedure; // для function; procedure через call

                NpgsqlDataReader reader = cmdFunc.ExecuteReader();
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
            connection.Close();
        }
    }
}
