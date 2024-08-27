pageextension 50242 SalesOrderExt extends "Sales Order"
{
    layout
    {
        addbefore(Control1903720907)
        {
            part("Sales Line Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Sales Line Attachments';
                Provider = SalesLines;
                SubPageLink = "Table ID" = const(Database::"Sales Line"),
                              "No." = field("Document No."),
                              "Document Type" = field("Document Type"),
                              "Line No." = field("Line No.");
            }
        }
    }
}

codeunit 50242 SalesLineAttachmentHandler
{
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", OnBeforeDrillDown, '', false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef);
    var
        SalesLine: Record "Sales Line";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::"Sales Line":
                begin
                    RecRef.Open(DATABASE::"Sales Line");
                    if SalesLine.Get(DocumentAttachment."Document Type", DocumentAttachment."No.", DocumentAttachment."Line No.") then
                        RecRef.GetTable(SalesLine);
                end;
        end;
    end;
}
