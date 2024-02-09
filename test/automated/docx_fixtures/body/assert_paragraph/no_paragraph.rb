require_relative "../../../automated_init"

context "Docx Fixtures" do
  context "Body Fixture" do
    context "Assert Paragraph" do
      context "No Paragraph At Given Position" do
        control_xml = "<w:p />"

        body_xml = <<~XML
        <w:body>
          #{control_xml}
          #{control_xml}
        </w:body>
        XML

        context "Position Is Zero" do
          position = 0

          fixture = Fixtures::Docx::Body.build(body_xml) do |body|
            body.assert_paragraph(control_xml, position)
          end

          fixture.()

          context_text = "Paragraph: #{position}"
          test_text = "Element: > w|p:nth-child(#{position})"

          context "Test: #{test_text.inspect}" do
            failed = fixture.test_session.test_failed?(context_text, test_text)

            test "Failed" do
              assert(failed)
            end
          end
        end

        context "Position Exceeds Final Position" do
          position = 3

          fixture = Fixtures::Docx::Body.build(body_xml) do |body|
            body.assert_paragraph(control_xml, position)
          end

          fixture.()

          context_text = "Paragraph: #{position}"
          test_text = "Element: > w|p:nth-child(#{position})"

          context "Test: #{test_text.inspect}" do
            failed = fixture.test_session.test_failed?(context_text, test_text)

            test "Failed" do
              assert(failed)
            end
          end
        end
      end
    end
  end
end
