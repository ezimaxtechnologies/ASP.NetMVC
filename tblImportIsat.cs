//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EDS
{
    using System;
    using System.Collections.Generic;
    
    public partial class tblImportIsat
    {
        public int ImportIsatId { get; set; }
        public int ImportId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string MiddleName { get; set; }
        public string StateId { get; set; }
        public string BirthDate { get; set; }
        public string Grade { get; set; }
        public string Test { get; set; }
        public string Score { get; set; }
        public string PerformanceLevel { get; set; }
        public string Perc { get; set; }
        public string Goal_Score_1 { get; set; }
        public string Goal_Score_2 { get; set; }
        public string Goal_Score_3 { get; set; }
        public string Goal_Score_4 { get; set; }
        public string Goal_Score_5 { get; set; }
        public string Goal_Score_6 { get; set; }
        public string Goal_Score_7 { get; set; }
        public string Goal_Score_8 { get; set; }
        public string Goal_Score_9 { get; set; }
        public string Goal_Score_10 { get; set; }
    
        public virtual tblImport tblImport { get; set; }
    }
}
