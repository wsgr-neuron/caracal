require_relative "automated_init"

context "Section Break" do
  docx_data = Caracal::Document.render do |docx|
    docx.p do |p|
      p.section_properties(:continuous, columns: 2)

      p.text "Some text"
    end

    docx.p do |p|
      p.section_properties(:page)

      p.text "Some other text"
    end
  end

  fixture(Docx::Fixtures::Package, docx_data) do |docx|
    docx.assert_document do |document|
      document.assert_body do |body|
        body.assert_next_paragraph(<<~XML)
        <w:p>
          <w:pPr>
            <w:sectPr>
              <w:type w:val="continuous"/>
              <w:cols w:num="2"/>
            </w:sectPr>
          </w:pPr>
          <w:r>
            <w:rPr/>
            <w:t xml:space="preserve">Some text</w:t>
          </w:r>
        </w:p>
        XML

        body.assert_next_paragraph(<<~XML)
        <w:p>
          <w:pPr>
            <w:sectPr>
              <w:type w:val="page"/>
            </w:sectPr>
          </w:pPr>
          <w:r>
            <w:rPr/>
            <w:t xml:space="preserve">Some other text</w:t>
          </w:r>
        </w:p>
        XML
      end
    end
  end
end
