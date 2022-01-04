module Export::Pdf::Passes
  class PaddlePass
    def initialize(person, options = {})
      @person = person
      @options = options
    end

    def pdf
      @pdf ||= Prawn::Document.new(render_options)
    end

    def render
      render_sections
      pdf.render
    end

    def render_sections
      sections.each do |section|
        section.render
      end
    end

    def sections
      @sections ||= [Sections::Logo, Sections::PaddlePasses::Content].collect do |section|
        section.new(pdf, @person, @options)
      end
    end

    
    def render_options
      @options.to_h.merge(
        page_size: 'A4',
        page_layout: :portrait,
      )
    end
  end
end
