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
    
    public partial class tblKnowledgeBaseAttachment
    {
        public int KnowledgeBaseAttachmentId { get; set; }
        public int KnowledgeBaseId { get; set; }
        public int AttachmentId { get; set; }
        public int CreatedUserId { get; set; }
        public System.DateTime CreatedDate { get; set; }
        public Nullable<int> ModifiedUserId { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
    
        public virtual tblKnowledgeBase tblKnowledgeBase { get; set; }
        public virtual tblAttachment tblAttachment { get; set; }
    }
}