require_relative "../../automated_init"

context "Docx Fixtures" do
  context "Body Fixture" do
    context "Assert Final Position" do
      body_xml = <<~XML
      <w:body>
        <w:p />
        <w:p />
      </w:body>
      XML

      control_position = 1
      test_text = "Paragraph Position: #{control_position}"

      context "Paragraph Position Corresponds" do
        paragraph_position = control_position

        fixture = Fixtures::Docx::Body.build(body_xml, paragraph_position:) do |body|
          body.assert_paragraph_position(control_position)
        end

        fixture.()

        context "Test: #{test_text.inspect}" do
          test_passed = fixture.test_session.one_test_passed?(test_text)

          test "Passed" do
            assert(test_passed)
          end
        end
      end

      context "Paragraph Position Doesn't Correspond" do
        paragraph_position = control_position + 1

        fixture = Fixtures::Docx::Body.build(body_xml, paragraph_position:) do |body|
          body.assert_paragraph_position(control_position)
        end

        fixture.()

        context "Test: #{test_text.inspect}" do
          test_failed = fixture.test_session.one_test_failed?(test_text)

          test "Failed" do
            assert(test_failed)
          end
        end
      end
    end
  end
end
