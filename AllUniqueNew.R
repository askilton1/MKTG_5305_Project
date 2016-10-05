AllUniqueNew <- function(data,group_by="date"){
  mutate(data, first_time = ifelse(1:length(anonID) %in% match(unique(anonID),anonID),1,0)) %>%
    group_by_(group_by) %>%
    mutate(All = n(),Unique = length(unique(anonID)),New = sum(first_time)) %>%
    ungroup() %>%
    filter(class == "Student") %>%
  return()}

