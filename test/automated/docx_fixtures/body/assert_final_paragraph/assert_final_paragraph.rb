require_relative "../../../automated_init"

context "Docx Fixtures" do
  context "Body Fixture" do
    context "Assert Final Paragraph" do
      body_xml = <<~XML
      <w:body>
        <w:p />
        <w:p />
      </w:body>
      XML

      test_text = "Final Paragraph"

      context "Initial Position" do
        fixture = Fixtures::Docx::Body.build(body_xml) do |body|
          body.assert_final_paragraph
        end

        fixture.()

        context "Test: #{test_text.inspect}" do
          test_failed = fixture.test_session.one_test_failed?(test_text)

          test "Failed" do
            assert(test_failed)
          end
        end
      end

      context "Inner Position" do
        paragraph_position = 1

        fixture = Fixtures::Docx::Body.build(body_xml, paragraph_position:) do |body|
          body.assert_final_paragraph
        end

        fixture.()

        context "Test: #{test_text.inspect}" do
          test_failed = fixture.test_session.one_test_failed?(test_text)

          test "Failed" do
            assert(test_failed)
          end
        end
      end

      context "Final Position" do
        paragraph_position = 2

        fixture = Fixtures::Docx::Body.build(body_xml, paragraph_position:) do |body|
          body.assert_final_paragraph
        end

        fixture.()

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
