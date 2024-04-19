require_relative "automated_init"

context "Section Properties" do
  docx_data = Caracal::Document.render do |docx|
    docx.p do |p|
      p.section_properties(type: "continuous", columns: 2, margin_inches: 1.11)

      p.text "Some text"
    end

    docx.p do |p|
      p.section_properties(type: "nextPage")

      p.text "Some more text"
    end

    docx.p do |p|
      p.section_properties(type: "nextColumn")

      p.text "Yet more text"
    end

    docx.final_section_properties(columns: 3, margin_inches: 2.22)
  end

  fixture(Docx::Fixtures::Package, docx_data) do |docx|
    docx.assert_document do |document|
      document.assert_next_paragraph do |paragraph|
        paragraph.assert_section_properties do |section_properties|
          section_properties.refute_break

          section_properties.assert_columns(2)

          section_properties.assert_page_margins(1.11)
        end

        paragraph.assert_one_run do |run|
          run.assert_text("Some text")
        end
      end

      document.assert_next_paragraph do |paragraph|
        paragraph.assert_section_properties do |section_properties|
          section_properties.assert_page_break
        end

        paragraph.assert_one_run do |run|
          run.assert_text("Some more text")
        end
      end

      document.assert_next_paragraph do |paragraph|
        paragraph.assert_section_properties do |section_properties|
          section_properties.assert_column_break
        end

        paragraph.assert_one_run do |run|
          run.assert_text("Yet more text")
        end
      end

      document.assert_final_paragraph

      document.assert_section_properties do |section_properties|
        section_properties.assert_columns(3)

        section_properties.assert_page_margins(2.22)
      end
    end
  end
end
