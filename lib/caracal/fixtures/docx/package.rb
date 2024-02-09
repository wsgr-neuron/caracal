module Caracal
  module Fixtures
    module Docx
      class Package
        include TestBench::Fixture
        include Initializer

        initializer :docx_package, :test_block

        def self.build(docx_package, &test_block)

          new(docx_package, test_block)
        end

        def call
          test_block.(self)
        end

        def assert_part(path, &block)
          docx_zip = Zip::File.open_buffer(docx_package)

          xml = docx_zip.read(path)

          context "Part: #{path}" do
            block.(xml)
          end
        end

        def assert_document(&block)
          assert_part("word/document.xml") do |xml|
            fixture(Document, xml, &block)
          end
        end

        def assert_styles(&block)
          assert_part("word/styles.xml") do |xml|
            fixture(Document, xml, &block)
          end
        end

        def assert_numbering(&block)
          assert_part("word/numbering.xml") do |xml|
            fixture(Document, xml, &block)
          end
        end
      end
    end
  end
end
