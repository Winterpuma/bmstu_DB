using System;
using Npgsql;

namespace lab_4
{
    class Program
    {
        private static string Host = "127.0.0.1";
        private static string User = "VisualStudio";
        private static string Password = "VSvsvs";
        private static string DBname = "RK3";
        private static string Port = "5432";
        
        static void Main(string[] args)
        {
            string connString =
                String.Format(
                    "Server={0}; User Id={1}; Database={2}; Port={3}; Password={4};SSLMode=Prefer",
                    Host,
                    User,
                    DBname,
                    Port,
                    Password);

            using (var conn = new NpgsqlConnection(connString))
            {

                Console.Out.WriteLine("Opening connection");
                conn.Open();
                
                string reqStr = "with counted as (" +
                    "select id, count(*) as cnt" +
                    "from employee join record on employee.id = record.id_employee" +
                    "where department = 'ИТ' and record.rtime > '9:00' and record.rtime > '9:00' and rtype = 2" +
                    "group by id" +
                    ")" +
                    "select id" +
                    "from counted" +
                    "where cnt = (select max(cnt) from counted)";

                using (var command = new NpgsqlCommand(reqStr, conn))
                {
                    var reader = command.ExecuteReader();
                    
                    while (reader.Read())
                    {
                        Console.WriteLine(
                            string.Format(
                                "Employee id {0}",
                                reader.GetInt32(0).ToString()
                                )
                            );
                    }
                }
                
                conn.Close();
            }
        

            Console.WriteLine("Press RETURN to exit");
            Console.ReadLine();
        }
    }
}

