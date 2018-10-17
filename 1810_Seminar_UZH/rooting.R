library(dynalysis)
library(tidyverse)
library(dynplot)

library(ggraph)
library(tidygraph)

tasks <- read_rds(derived_file("tasks.rds", "2-dataset_characterisation"))

task_id <- "real/fibroblast-reprogramming_treutlein"


task <- extract_row_to_list(tasks, which(tasks$task_id == task_id))


library(dynplot)

plot_graph(task)


method <- dynmethods::description_slngsht()
prediction <- method$run_fun(task$counts())


set.seed(1)
prediction <- root_trajectory(prediction, task$prior_information$end_cells[[1]])
plot_dimred(prediction, grouping_assignment = task$prior_information$grouping_assignment, expression_source = task$expression())
ggsave("img/rooting_1.png")

set.seed(1)
prediction <- root_trajectory(prediction, task$prior_information$start_cells[[1]])
plot_dimred(prediction, grouping_assignment = task$prior_information$grouping_assignment, expression_source = task$expression())
ggsave("img/rooting_2.png")

plot_dimred(prediction, "pseudotime", expression_source = task$expression())
ggsave("img/pseudotime.png")




plot_dimred(prediction, grouping_assignment = task$prior_information$grouping_assignment, expression_source=task$expression())
ggsave("img/dimred.png")

plot_dendro(prediction, grouping_assignment = task$prior_information$grouping_assignment)
ggsave("img/dendro.png")

plot_graph(prediction, grouping_assignment = task$prior_information$grouping_assignment, expression_source=task$expression())
ggsave("img/graph.png")

plot_onedim(prediction, grouping_assignment = task$prior_information$grouping_assignment, expression_source=task$expression())
ggsave("img/onedim.png")

method$plot_fun(prediction)





task$expression <- task$expression()

##
heatmap <- plot_heatmap(prediction, expression=task$expression, grouping_assignment = task$prior_information$grouping_assignment, features_oi = 50)
heatmap
ggsave("img/heatmap.png", heatmap, width=14, height=8)


##

prediction <- prediction %>% add_waypoints_to_wrapper(resolution=sum(prediction$milestone_network$length)/100)

cell_feature_importances <- dynfeature::calculate_cell_feature_importance(prediction, expression=task$expression)

features_oi <- cell_feature_importances %>% group_by(cell_id) %>% top_n(2, importance) %>% pull(feature_id) %>% unique()

heatmap <- plot_heatmap(prediction, cell_feature_importances=cell_feature_importances, expression=task$expression, grouping_assignment = task$prior_information$grouping_assignment, features_oi=features_oi)
heatmap

ggsave("img/heatmap_fimp.png", heatmap, width=14, height=8)


heatmap <- plot_heatmap(prediction, cell_feature_importances=cell_feature_importances, expression=task$expression, grouping_assignment = task$prior_information$grouping_assignment, features_oi=features_oi, heatmap_type = "dotted")
heatmap

ggsave("img/heatmap_dotted_fimp.png", heatmap, width=14, height=8)
