require "prawn"
require "prawn/measurement_extensions"

module TheRealNoteBook
  NOTE_RULE_PADDING = 8
  CLEF_PADDING = 28
  CLEFS_PER_PAGE = 12
  TEXT_RULING_PADDING = 7.mm
  TEXT_RULES_PER_PAGE = 40
  PAGE_COUNT = 96

  ODD_MARGINS = { margin: 12.mm, left_margin: 25.mm }
  EVEN_MARGINS = { margin: 12.mm, right_margin: 25.mm }

  extend self

  # A4 - 210 × 297 mm 
  def call
    Prawn::Document.generate("therealnotebook.pdf", margin: 12.mm, left_margin: 25.mm, page_size: "A4") do |pdf| 
      render_cover(pdf)
      render_back_cover(pdf)

      (PAGE_COUNT / 2).times do
        render_note_sheet(pdf)
        render_text_sheet(pdf)
      end
    end
  end

  def render_back_cover(pdf)
    pdf.start_new_page
  end

  def render_text_sheet(pdf)
    pdf.start_new_page(margin: 12.mm, right_margin: 25.mm)
    TEXT_RULES_PER_PAGE.times { pdf.pad_bottom(TEXT_RULING_PADDING) { pdf.stroke_horizontal_rule } }
  end

  def render_note_sheet(pdf)
    pdf.start_new_page(margin: 12.mm, left_margin: 25.mm)
    CLEFS_PER_PAGE.times { pdf.pad_bottom(CLEF_PADDING) { render_clef(pdf) } }
  end

  def render_cover(pdf)
    a4_page_box = [210.mm - 12.mm - 25.mm, 297.mm - 12.mm - 12.mm]
    pdf.image "./manhog_cover.png", fit: a4_page_box
  end

  def render_clef(pdf)
    5.times { pdf.pad_bottom(NOTE_RULE_PADDING) { pdf.stroke_horizontal_rule } }
  end
end
