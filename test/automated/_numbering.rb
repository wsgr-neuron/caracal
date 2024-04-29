require_relative "automated_init"

context "Numbering" do
  numbering_id = 11

  docx_data = Caracal::Document.render do |docx|
    docx.list_style do |list_style|
      list_style.type :ordered
      list_style.level 1
      list_style.format "decimal"
      list_style.value "%1."
      list_style.start 1
      list_style.align :left
    end

    docx.style do |style|
      style.id "SomeStyle"
      style.name "Some Style"
    end

    docx.ol do |ol|
      ol.li "Some text", style: "Some Style"
    end
  end

  File.write("tmp/x.docx", docx_data)
  break
  
  fixture(Docx::Fixtures::Package, docx_data) do |docx|
    docx.assert_part("word/numbering.xml") do |numbering|
      numbering.assert_xml(<<~XML)
      <w:numbering xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
        <w:abstractNum w:abstractNumId="0">
          <w:lvl w:ilvl="0">
            <w:start w:val="1"/>
            <w:numFmt w:val="decimal"/>
            <w:lvlText w:val="%1."/>
            <w:lvlJc w:val="left"/>
          </w:lvl>
        </w:abstractNum>
        <w:num w:numId="#{numbering_id}">
          <w:abstractNumId w:val="0"/>
        </w:num>
      </w:numbering>
      XML
    end
  end
end
