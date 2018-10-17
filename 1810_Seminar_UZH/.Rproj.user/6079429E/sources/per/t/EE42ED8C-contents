library(esfiji)
library(xml2)
library(tidyverse)


# pipeline.svg

xml <- read_xml("../pipeline.svg")

group_ids <- c("modules", "module_start", "module_middle", "module_end", "benchmark", "benchmark_pipeline", "benchmark_web", "benchmark_pull", "benchmark_versioning")
folder <- "img/pipeline"
fs::file_delete(fs::dir_ls(folder))
fs::dir_create(folder)
svg_groups_build(xml, group_ids, folder = folder, output_prefix = "pipeline")


# stages.svg
xml <- read_xml("img/stages.svg")

group_ids <- c("1", "2", "3")
folder <- "img/stages"
fs::file_delete(fs::dir_ls(folder))
fs::dir_create(folder)
svg_groups_build(xml, group_ids, folder = folder, output_prefix = "stage")
