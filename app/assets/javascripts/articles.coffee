# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

update_suggestions = (values = []) ->
  container = $('.tag-suggestions')
  if values.length
    container.empty()
    for tag in values
      return if tag_exists(tag.name)
      el = $("<div class='article-tag'>#{tag.name}</div>")
      el.click(suggestion_click(tag))
      container.append el
    if container.html() != '' then container.show()
  else
    container.hide()

suggestion_click = (tag) -> () -> create_new_tag tag.name

clean_input = () ->
  $('.tag-editor__input').val("").focus()
  update_suggestions()

create_new_tag = (value) ->
  if tag_exists value then return
  key = new Date().getTime()
  name = "article[tags_attributes][#{ key }][name]"
  id = "article_tags_attributes_#{ key }_name"

  el = $('.tag-editor span:first').append("
        <span class='article-tag'>
          #{ value }
          <span class='article-tag__delete-tag' title='remove this tag'></span>
          <input type='hidden' value=#{ value } name='#{ name }' id='#{ id }' />
        </span>
  ")
  el.last().find('.article-tag__delete-tag').click (ev) -> $(ev.target.parentNode).remove()
  clean_input()

tag_exists = (value) ->
  tags = $('.tag-editor .article-tag').toArray()
  for x in tags
    return true if $.trim(x.innerText) == value
  return false

generate_tags_url = (value = '') ->
  "/tags#{if value.length then '?name=' + value else ''}"

$(document).on('turbolinks:load', () ->
  $('.article-tag__delete-tag').click (ev) -> $(ev.target.parentNode).remove()
  $('.tag-editor__input').on('input', (e) ->
    { value } = e.target

    if value == "" || value == " "
      clean_input()
      update_suggestions()
      return

    if value.length > 0 && e.originalEvent.data == " "
      create_new_tag value.substring(0, value.length - 1)
      return

    $.ajax(url: generate_tags_url value).done (res) ->
      update_suggestions res
  )
)
