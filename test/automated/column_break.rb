require_relative "automated_init"

context "Column Break" do
  docx_data = Caracal::Document.render do |docx|
    docx.p do |p|
      p.text "Some text"

      p.column_break

      p.text "Some other text"
    end
  end

  fixture(Docx::Fixtures::Package, docx_data) do |docx|
    docx.assert_document do |document|
      document.assert_next_paragraph do |paragraph|
        paragraph.assert_next_run do |run|
          run.assert_text("Some text")
        end

        paragraph.assert_next_run do |run|
          run.assert_column_break
        end

        paragraph.assert_next_run do |run|
          run.assert_text("Some other text")
        end

        paragraph.assert_final_run
      end

      document.assert_final_paragraph
    end
  end
end
