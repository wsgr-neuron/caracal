require_relative "../../automated_init"

context "Docx Fixtures" do
  context "Body Fixture" do
    context "Assert Paragraphs" do
      control_xml_1 = <<~XML
      <w:p val="1"/>
      XML

      control_xml_2 = <<~XML
      <w:p val="2"/>
      XML

      body_xml = <<~XML
      <w:body>
        #{control_xml_1.chomp}
        #{control_xml_2.chomp}
      </w:body>
      XML

      paragraph_test_titles = ["XML Equality (strict)", "Equal"]

      fixture = Fixtures::Docx::Body.build(body_xml) do |body|
        body.assert_paragraphs(control_xml_1, control_xml_2)
      end

      original_position = fixture.paragraph_position

      fixture.()

      (1..2).each do |position|
        titles = ["Paragraph: #{position}", *paragraph_test_titles]

        test_text = titles.join(" : ")
        context "Test: #{test_text.inspect}" do
          passed = fixture.test_session.one_test_passed?(*titles)

          test "Passed" do
            assert(passed)
          end
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
