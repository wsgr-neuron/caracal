require_relative "../../../automated_init"

context "Docx Fixtures" do
  context "Body Fixture" do
    context "Assert Paragraph" do
      body_xml = <<~XML
      <w:body>
        <w:p>
          <w:r>
            <w:t>Some text</w:t>
          </w:r>
        </w:p>

        <w:p />
      </w:body>
      XML

      control_xml = <<~XML
      <w:p>
        <w:r>
          <w:t>Some text</w:t>
        </w:r>
      </w:p>
      XML

      test_titles = ["XML Equality (strict)", "Equal"]

      context "XML Corresponds" do
        position = 1

        fixture = Fixtures::Docx::Body.build(body_xml) do |body|
          body.assert_paragraph(control_xml, position)
        end

        fixture.()

        titles = ["Paragraph: #{position}", *test_titles]

        test_text = titles.join(" : ")
        context "Test: #{test_text.inspect}" do
          passed = fixture.test_session.one_test_passed?(*titles)

          test "Passed" do
            assert(passed)
          end
        end
      end

      context "XML Doesn't Correspond" do
        position = 2

        fixture = Fixtures::Docx::Body.build(body_xml) do |body|
          body.assert_paragraph(control_xml, position)
        end

        fixture.()

        titles = ["Paragraph: #{position}", *test_titles]

        test_text = titles.join(" : ")
        context "Test: #{test_text.inspect}" do
          failed = fixture.test_session.one_test_failed?(*titles)

          test "Failed" do
            assert(failed)
          end
        end
      end
    end
  end
end
