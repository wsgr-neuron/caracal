module Caracal
  module Fixtures
    module Docx
      class Document
        include TestBench::Fixture
        include Initializer

        attr_accessor :document_fixture

        initializer :document, :test_block

        def self.build(xml, &test_block)
          document = XML::Fixtures::Document.document(xml)

          new(document, test_block)
        end

        def call
          fixture(XML::Fixtures::Document, document) do |document_fixture|
            self.document_fixture = document_fixture

            test_block.(self)
          end
        end

        def assert_body(&test_block)
          context "Body" do
            body_element = document_fixture.assert_element("> w|body")

            fixture(Body, body_element, &test_block)
          end
        end

        def assert_xml(control_xml)
          compare_xml = document.to_xml
          fixture(XML::Fixtures::Equality, compare_xml, control_xml)
        end
      end
    end
  end
end
