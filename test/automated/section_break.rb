require_relative "automated_init"

context "Section Break" do
  docx_data = Caracal::Document.render do |docx|
    docx.p do |p|
      p.section_properties("continuous", columns: 2)

      p.text "Some text"
    end

    docx.p do |p|
      p.section_properties("nextPage")

      p.text "Some more text"
    end

    docx.p do |p|
      p.section_properties("nextColumn")

      p.text "Yet more text"
    end
  end

  fixture(Docx::Fixtures::Package, docx_data) do |docx|
    docx.assert_document do |document|
      document.assert_body do |body|
        body.assert_next_paragraph do |paragraph|
          paragraph.assert_section_properties do |section_properties|
            section_properties.refute_break

            section_properties.assert_columns(2)
          end

          paragraph.assert_one_run do |run|
            run.assert_text("Some text")
          end
        end

        body.assert_next_paragraph do |paragraph|
          paragraph.assert_section_properties do |section_properties|
            section_properties.assert_page_break
          end

          paragraph.assert_one_run do |run|
            run.assert_text("Some more text")
          end
        end

        body.assert_next_paragraph do |paragraph|
          paragraph.assert_section_properties do |section_properties|
            section_properties.assert_column_break
          end

          paragraph.assert_one_run do |run|
            run.assert_text("Yet more text")
          end
        end

        body.assert_final_paragraph
      end
    end
  end
end
