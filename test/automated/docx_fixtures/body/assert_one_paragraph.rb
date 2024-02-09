require_relative "../../automated_init"

context "Docx Fixtures" do
  context "Body Fixture" do
    context "Assert One Paragraph" do
      control_xml = <<~XML
      <w:p/>
      XML

      body_xml = <<~XML
      <w:body>
        #{control_xml.chomp}
      </w:body>
      XML

      fixture = Fixtures::Docx::Body.build(body_xml) do |body|
        body.assert_one_paragraph(control_xml)
      end

      original_position = fixture.paragraph_position

      fixture.()

      titles = ["Paragraph: 1", "XML Equality (strict)", "Equal"]

      test_text = titles.join(" : ")
      context "Test: #{test_text.inspect}" do
        passed = fixture.test_session.one_test_passed?(*titles)

        test "Passed" do
          assert(passed)
        end
      end

      test_text = "Final Paragraph"
      context "Test: #{test_text.inspect}" do
        test_passed = fixture.test_session.one_test_passed?(test_text)

        test "Passed" do
          assert(test_passed)
        end
      end
    end
  end
end
