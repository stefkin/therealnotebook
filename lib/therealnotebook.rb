require "prawn"
require "prawn/measurement_extensions"

module TheRealNoteBook
  NOTE_RULE_PADDING = (152.0/59.0).mm
  CLEF_PADDING = 11.mm
  CLEFS_PER_PAGE = 12
  # (x * 5 + 11) * 12 - 11 - x = 273
  # 60x + 132 - 11 - x = 273
  # 59x = 152
  # x = 152 / 59
  TEXT_RULING_PADDING = 7.mm
  TEXT_RULES_PER_PAGE = 40
  # (40 - 1) * 7 = 273
  PAGE_COUNT = 96
  A4_PAGE_BOX = [210.mm - 12.mm - 25.mm, 297.mm - 12.mm - 12.mm]
  # 297 - 24 = 273
  ODD_MARGINS = { margin: 12.mm, left_margin: 25.mm }
  EVEN_MARGINS = { margin: 12.mm, right_margin: 25.mm }

  extend self

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
    pdf.image "./manhog_cover.png", fit: A4_PAGE_BOX
  end

  def render_clef(pdf)
    5.times { pdf.pad_bottom(NOTE_RULE_PADDING) { pdf.stroke_horizontal_rule } }
  end
end
