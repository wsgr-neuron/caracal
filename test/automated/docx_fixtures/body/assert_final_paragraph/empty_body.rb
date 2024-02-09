require_relative "../../../automated_init"

context "Docx Fixtures" do
  context "Body Fixture" do
    context "Assert Final Paragraph" do
      context "Empty Body" do
        body_xml = <<~XML
        <w:body />
        XML

        fixture = Fixtures::Docx::Body.build(body_xml) do |body|
          body.assert_final_paragraph
        end

        fixture.()

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
end
