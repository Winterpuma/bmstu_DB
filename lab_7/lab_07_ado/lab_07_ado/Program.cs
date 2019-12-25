using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace lab_07_ado
{
    class Program
    {

        /* Соединенная модель (.NET Data Provider - ряд компонентов, включая Connection, Command, DataReader, и объекты DataAdapter)
         * Отсоединенная модель (DataSet). */

        
        static void Main(string[] args)
        {
            //DataSet data = null;
            Connected.GetTablePeopleLen();
            //Connected.ReadPeople();
            //Connected.CreateFunction();
            //Connected.CallFunction();
            var data = Disconnected.ConnectToData();
            //Disconnected.GetTablePeopleLen(data.dataSet);
            //Disconnected.ReadPeople(data.dataSet);
            //Disconnected.InsertPerson(data.adapter, data.dataSet);
            //Disconnected.UpdatePersonName(data.adapter, data.dataSet);

            Console.Read();
        }
    }
}
