module Locomotive
  module Steam

    class EditableElementRepository

      include Models::Repository

      attr_accessor :page

      mapping :editable_elements, entity: EditableElement do
        localized_attributes :content, :source, :default_content, :default_source_url

        default_attribute :page, -> (repository) { repository.page }
      end

      # TODO

    end

  end
end
