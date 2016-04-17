require 'minitest/autorun'
require 'qbxml'

class XmlToHashTest < Minitest::Test

  def test_xml_to_hash
    qbxml = Qbxml.new
    h = {"qbxml"=>{"xml_attributes"=>{}, "qbxml_msgs_rq"=>{"xml_attributes"=>{}, "customer_query_rq"=>{"xml_attributes"=>{}, "list_id"=>"GUID-GOES-HERE"}}}}
    assert_equal h, qbxml.from_qbxml("<?qbxml version=\"7.0\"?>\n<QBXML>\n  <QBXMLMsgsRq>\n    <CustomerQueryRq>\n      <ListID>GUID-GOES-HERE</ListID>\n    </CustomerQueryRq>\n  </QBXMLMsgsRq>\n</QBXML>\n")
  end

  def test_array_of_strings
    qbxml = Qbxml.new
    h = {
      "qbxml" => {
        "xml_attributes" => {},
        "qbxml_msgs_rq" => {
          "xml_attributes" => {},
          'invoice_query_rq' => {
            "xml_attributes" => {},
            'include_ret_element' => ['TxnID', 'RefNumber']
          }
        }
      }
    }
    assert_equal h, qbxml.from_qbxml("<?qbxml version=\"7.0\"?>\n<QBXML>\n  <QBXMLMsgsRq>\n    <InvoiceQueryRq>\n      <IncludeRetElement>TxnID</IncludeRetElement>\n    <IncludeRetElement>RefNumber</IncludeRetElement>\n    </InvoiceQueryRq>\n  </QBXMLMsgsRq>\n</QBXML>\n")
  end

  def test_empty_response
    response_str = "<?xml version=\"1.0\"?>\r<?qbxml version=\"7.0\"?>\r<QBXML>\r<QBXMLMsgsRs />\r</QBXML>\r"
    qbxml = Qbxml.new
    h = { "qbxml" => { "xml_attributes" => {}, "qbxml_msgs_rs" => {} } }
    assert_equal h, qbxml.from_qbxml(response_str)
  end
end

