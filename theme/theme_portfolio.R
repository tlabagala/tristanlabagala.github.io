# theme_portfolio.R
# Shared ggplot2 theme so every R figure across the portfolio looks like one
# body of work. Source this in a project page, then add theme_portfolio() to
# each plot.
#
#   source(here::here("theme/theme_portfolio.R"))
#   ggplot(df, aes(x, y)) + geom_col() + theme_portfolio()

library(ggplot2)

theme_portfolio <- function(base_size = 12) {
  theme_minimal(base_size = base_size, base_family = "Inter") +
    theme(
      # Left-align the title to the plot edge, not the panel. This is the single
      # change that most makes a chart read as editorial rather than default.
      plot.title.position = "plot",
      plot.caption.position = "plot",

      plot.title    = element_text(face = "bold", size = rel(1.15)),
      plot.subtitle = element_text(colour = "grey35", margin = margin(b = 12)),
      plot.caption  = element_text(colour = "grey50", hjust = 0,
                                   margin = margin(t = 12)),

      # Strip visual noise: no minor gridlines, no vertical major gridlines.
      panel.grid.minor   = element_blank(),
      panel.grid.major.x = element_blank(),

      axis.title = element_text(colour = "grey35", size = rel(0.9)),
      axis.text  = element_text(colour = "grey45"),

      strip.text = element_text(face = "bold", hjust = 0),

      legend.position = "top",
      legend.title = element_blank()
    )
}

# Palette. Use portfolio_accent for the one series that matters and
# portfolio_grey for everything non-focal. Highlighting against grey reads as
# far more considered than a rainbow scale across many categories.
#
# These MUST stay in step with the palette in styles.scss. ggplot2 knows nothing
# about the site CSS, so the values are necessarily duplicated. If you change
# $accent there, change portfolio_accent here.
portfolio_accent <- "#185fa5"  # $accent
portfolio_warm   <- "#b5622f"  # $accent-warm
portfolio_green  <- "#2f7d5f"  # $accent-green
portfolio_grey   <- "grey75"
portfolio_ink    <- "#24211f"  # $ink

# Ordered categorical palette, for the cases where a chart genuinely has several
# comparable series and no single one to highlight. Four is the ceiling: past
# that, facet the chart instead of adding colours.
portfolio_palette <- c(portfolio_accent, portfolio_warm,
                       portfolio_green, portfolio_grey)

scale_colour_portfolio <- function(...) {
  scale_colour_manual(values = portfolio_palette, ...)
}
scale_fill_portfolio <- function(...) {
  scale_fill_manual(values = portfolio_palette, ...)
}

# Convenience scale: TRUE gets the accent, FALSE gets grey. Handy for
# highlighting a single group.
scale_colour_highlight <- function(...) {
  scale_colour_manual(values = c(`TRUE` = portfolio_accent,
                                 `FALSE` = portfolio_grey), ...)
}
scale_fill_highlight <- function(...) {
  scale_fill_manual(values = c(`TRUE` = portfolio_accent,
                               `FALSE` = portfolio_grey), ...)
}
