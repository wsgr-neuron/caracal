require_relative "../../automated_init"

context "Docx Fixtures" do
  context "Document Fixture" do
    context "Assert Body" do
      control_xml = Controls::Docx::Document::XML.example

      effect = nil
      block_argument = nil

      fixture = Fixtures::Docx::Document.build(control_xml) do |document|
        document.assert_body do |body|
          effect = :_
          block_argument = body
        end
      end

      fixture.()

      test "Block is executed" do
        refute(effect.nil?)
      end

      context "Block Argument" do
        body_fixture = block_argument.instance_of?(Fixtures::Docx::Body)

        test "Body fixture" do
          assert(body_fixture)
        end
      end
    end
  end
end
