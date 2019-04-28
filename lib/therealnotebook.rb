require "prawn"
require "prawn/measurement_extensions"

module TheRealNoteBook
  RULE_PADDING = 10
  CLEF_PADDING = 35
  TEXT_RULING_PADDING = 7.mm
  PAGE_COUNT = 96

  extend self

  # A4 - 210 × 297 mm 
  def call
    Prawn::Document.generate("therealnotebook.pdf", margin: 12.mm, left_margin: 25.mm, page_size: "A4") do |pdf| 
      render_cover(pdf)

      render_blank_page(pdf)

      (PAGE_COUNT / 2).times do
        render_text_sheet(pdf)
        render_note_sheet(pdf)
      end
    end
  end

  def render_blank_page(pdf)
    pdf.start_new_page
  end

  def render_text_sheet(pdf)
    37.times { pdf.pad_bottom(TEXT_RULING_PADDING) { pdf.stroke_horizontal_rule } }
    pdf.start_new_page
  end

  def render_note_sheet(pdf)
    9.times { pdf.pad_bottom(CLEF_PADDING) { render_clef(pdf) } }
    pdf.start_new_page
  end

  def render_cover(pdf)
    a4_page_box = [210.mm - 12.mm - 25.mm, 297.mm - 12.mm - 12.mm]
    pdf.image "./manhog_cover.png", fit: a4_page_box
  end

  def render_clef(pdf)
    5.times { pdf.pad_bottom(RULE_PADDING) { pdf.stroke_horizontal_rule } }
  end
end
