require_relative "../../automated_init"

context "Docx Fixtures" do
  context "Body Fixture" do
    context "Assert Next Paragraph" do
      control_xml = "<w:p />"

      body_xml = <<~XML
      <w:body>
        #{control_xml}
      </w:body>
      XML

      fixture = Fixtures::Docx::Body.build(body_xml) do |body|
        body.assert_next_paragraph(control_xml)
      end

      original_position = fixture.paragraph_position

      fixture.()

      context "Paragraph Position" do
        position = fixture.paragraph_position

        comment position.inspect

        test "Incremented" do
          assert(position == original_position + 1)
        end
      end

      test_text = "Paragraph: #{original_position + 1}"
      context "Test: #{test_text.inspect}" do
        executed = fixture.test_session.context?(test_text)

        test "Executed" do
          assert(executed)
        end
      end
    end
  end
end
