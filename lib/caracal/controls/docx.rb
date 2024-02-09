module Caracal
  module Controls
    module Docx
      module Document
        module XML
          def self.example
            File.read(path)
          end

          def self.path
            File.join(__dir__, "docx", "document.xml")
          end
        end
      end

      module Styles
        module XML
          def self.example
            File.read(path)
          end

          def self.path
            File.join(__dir__, "docx", "styles.xml")
          end
        end
      end

      module Numbering
        module XML
          def self.example
            File.read(path)
          end

          def self.path
            File.join(__dir__, "docx", "numbering.xml")
          end
        end
      end
    end
  end
end
