module Caracal
  module Fixtures
    module Docx
      class Body
        include TestBench::Fixture
        include Initializer

        def paragraph_position
          @paragraph_position ||= 0
        end
        attr_writer :paragraph_position

        attr_accessor :namespaces
        attr_accessor :body_element_fixture

        initializer :body_element, :test_block

        def self.build(xml_or_body_element, paragraph_position: nil, namespaces: nil, &test_block)
          namespaces ||= self.namespaces

          body_element = XML::Fixtures::Element.element(xml_or_body_element, namespaces)

          instance = new(body_element, test_block)
          instance.namespaces = namespaces
          instance.paragraph_position = paragraph_position
          instance
        end

        def self.namespaces
          {
            w: "http://schemas.openxmlformats.org/wordprocessingml/2006/main"
          }
        end

        def call
          fixture(XML::Fixtures::Element, body_element, namespaces:) do |body_element_fixture|
            self.body_element_fixture = body_element_fixture

            test_block.(self)
          end
        end

        def assert_one_paragraph(xml)
          assert_paragraphs(xml)
        end

        def assert_paragraphs(xml, *xmls)
          [xml, *xmls].each do |control_xml|
            assert_next_paragraph(control_xml)
          end

          assert_final_paragraph
        end

        def assert_section_properties(xml)
          context "Section Properties" do
            body_element_fixture.assert_element("> w|sectPr") do |section_properties|
              section_properties.assert_xml(xml)
            end
          end
        end

        def assert_next_paragraph(control_xml)
          self.paragraph_position += 1

          assert_paragraph(control_xml, paragraph_position)
        end

        def assert_paragraph(control_xml, position)
          context "Paragraph: #{position}" do
            body_element_fixture.assert_element("> w|p:nth-child(#{position})") do |paragraph|
              paragraph.assert_xml(control_xml)
            end
          end
        end

        def assert_final_paragraph
          context "Final Paragraph" do
            final_position = self.final_position

            detail "Paragraph Position: #{paragraph_position.inspect}"
            detail "Final Position: #{final_position.inspect}"

            test do
              assert(paragraph_position == final_position)
            end
          end
        end

        def assert_paragraph_position(control_position)
          context "Paragraph Position: #{control_position}" do
            comment paragraph_position.inspect
            detail "Control: #{control_position.inspect}"

            test do
              assert(paragraph_position == control_position)
            end
          end
        end
        alias :assert_position :assert_paragraph_position

        def final_position
          paragraph_elements.count
        end

        def paragraph_elements
          body_element.children.select do |element|
            element.name == "p"
          end
        end

        def section_paragraph_elements
          body_element.css("> w|sectPr", namespaces)
        end
      end
    end
  end
end
