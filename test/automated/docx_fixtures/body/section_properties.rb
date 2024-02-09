require_relative "../../automated_init"

context "Docx Fixtures" do
  context "Body Fixture" do
    context "Section Properties" do
      body_xml = <<~XML
      <w:body>
        <w:p/>
        <w:sectPr>
          <w:cols type="continuous"/>
        </w:sectPr>
      </w:body>
      XML

      fixture = Fixtures::Docx::Body.build(body_xml) do |body|
        body.assert_one_paragraph(<<~XML)
        <w:p/>
        XML

        body.assert_section_properties(<<~XML)
        <w:sectPr>
          <w:cols type="continuous"/>
        </w:sectPr>
        XML
      end

      fixture.()

      titles = ["Section Properties", "XML Equality (strict)", "Equal"]
      test_text = titles.join(" : ")
      context "Test: #{test_text.inspect}" do
        passed = fixture.test_session.one_test_passed?(*titles)

        test "Passed" do
          assert(passed)
        end
      end

      context "Preceding Paragraph" do
        titles = ["Paragraph: 1", "XML Equality (strict)", "Equal"]

        test_text = titles.join(" : ")
        context "Test: #{test_text.inspect}" do
          passed = fixture.test_session.one_test_passed?(*titles)

          test "Passed" do
            assert(passed)
          end
        end
      end
    end
  end
end
