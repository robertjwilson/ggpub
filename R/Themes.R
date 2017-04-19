#' Theme to make creating journal ready figures easier
#'
#'
#' @param base_size Font size
#' @param base_family Font used for everything, unless axis fonts etc. are defined
#' @param plot_grid = Do you want a grid? (all = major/minor, none = no grid, major = major grid)
#' @param lines_lwd = width of lines
#' @param title_size = font size of title
#' @param legend_size = font size of legend
#' @param legend_title = Do you want the legend title? (TRUE/FALSE)
#' @param bg_col = background colour
#' @param title_font = font use for title
#' @param base_col  = font colour
#' @param horz_grid = Do you want a horizontal grid?
#' @param bord_size = width of a rectangular border
#' @param alpha_leg = opacity of the legend. 0 = totally transparent
#' @param strip_bg = colour background for facets
#' @param grid_thick = A multiplier to apply to the grid lines.
#' @param grid_type = Grid type. Default is a solid line
#' @param ticks_xy = Do you want ticks on the x or y axis? "x" = x-axis only, "y" = y-axis only, "xy" = both axes.
#' @param grid_cols = Colour of the grid. 2 element vector. First element is major grid colour. If only one element, the first will be used for minor grid.
#' @return ggplot2 theme
#'
#' @export


theme_pub <- function(base_size = 11,
											base_family = "Arial",
											plot_grid = "none",
											lines_lwd = 0.50,
											bg_col = "white",
											axis_lines = TRUE,
											horz_grid = ifelse(plot_grid == "none", FALSE, TRUE),
											vert_grid = ifelse(plot_grid == "none", FALSE, TRUE),
											ticks_type = "outer",
											ticks_xy  = "xy",
											alpha_leg = 0.1,
											bord_size = lines_lwd,
											legend_bg = "white",
											strip_bg = "white",
											title_size = base_size * 1.2,
											legend_size = base_size * 0.9,
											grid_thick = 1,
											grid_type = "solid",
											grid_cols = c("grey10", "grey30"),
											legend_title = TRUE,
											plot_box = TRUE) {
	minor_grid = ifelse(plot_grid == "all", TRUE, FALSE)
	
	if (legend_title)
		title_element <- element_text()
	else
		title_element <- element_blank()
	if (axis_lines)
		axis_line =  element_line(size = ifelse(axis_lines, grid::unit(lines_lwd, "mm"), 0),
															color = "black")
	else
		axis_line <- element_blank()
	
	if (plot_box)
		panel_border <-
			ggplot2::element_rect(colour = "black",
														fill = NA,
														size = bord_size)
	else
		panel_border <- element_blank()
	
	
	theme_bw() +
		ggplot2::theme(
			text = ggplot2::element_text(family = base_family, size = base_size),
			axis.line =  axis_line,
			axis.ticks.length = grid::unit(ifelse(ticks_type == "outer", 0.15,-0.15), "cm"),
			axis.ticks.x =  element_line(
				size = ifelse(
					stringr::str_detect(ticks_xy, "x"),
					grid::unit(lines_lwd, "cm"),
					0
				),
				color = "black"
			),
			axis.ticks.y =  element_line(
				size = ifelse(
					stringr::str_detect(ticks_xy, "y"),
					grid::unit(lines_lwd, "cm") ,
					0
				),
				color = "black"
			),
			axis.text.x = ggplot2::element_text(
				size = base_size,
				family = base_family,
				margin = ggplot2::margin(ifelse(ticks_type == "inner", 11, 5), 5, 10, 5, "pt")
			),
			axis.text.y = ggplot2::element_text(
				size = base_size,
				family = base_family,
				margin = ggplot2::margin(5, ifelse(ticks_type == "inner", 11, 5), 10, 5, "pt")
			),
			axis.title.y = ggplot2::element_text(
				size =  base_size,
				vjust = 1.5,
				family = base_family
			),
			axis.title.x = ggplot2::element_text(
				size = base_size,
				vjust = -.5,
				family = base_family
			),
			panel.background = ggplot2::element_rect(fill = bg_col),
			plot.background = ggplot2::element_rect(fill = bg_col),
			panel.border = panel_border,
			panel.grid.major.x = ggplot2::element_line(
				linetype = grid_type,
				colour = ifelse(vert_grid, grid_cols[1], bg_col),
				size = ifelse(vert_grid, 0.25 * grid_thick, 0)
			),
			panel.grid.minor.x = ggplot2::element_line(
				linetype = grid_type,
				colour = ifelse(vert_grid, ifelse(minor_grid, grid_cols[2 - (length(grid_cols) == 1)], bg_col), bg_col),
				size = ifelse(vert_grid, 0.15 * grid_thick, 0)
			),
			panel.grid.major.y = ggplot2::element_line(
				linetype = grid_type,
				colour = ifelse(horz_grid, grid_cols[1], bg_col),
				size = ifelse(horz_grid, 0.25 * grid_thick, 0)
			),
			panel.grid.minor.y = ggplot2::element_line(
				linetype = grid_type,
				colour = ifelse(horz_grid, ifelse(minor_grid, grid_cols[2 - (length(grid_cols) == 1)], bg_col), bg_col),
				size = ifelse(horz_grid, 0.15 * grid_thick, 0)
			),
			plot.title = ggplot2::element_text(
				face = "bold",
				vjust = 2,
				size = title_size,
				family = base_family
			),
			legend.background = ggplot2::element_rect(fill = scales::alpha(legend_bg, alpha_leg)),
			legend.key = ggplot2::element_blank(),
			legend.text = ggplot2::element_text(size = legend_size, family = base_family),
			legend.title = title_element,
			strip.background =  ggplot2::element_rect(colour = strip_bg, fill = strip_bg),
			strip.text.x = ggplot2::element_text(size = base_size + 1),
			strip.text.y = ggplot2::element_text(size = base_size + 1),
			plot.caption = element_text(hjust = 0)
		)
}
