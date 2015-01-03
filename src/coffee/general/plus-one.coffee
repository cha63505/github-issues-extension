(->

  # Holds list of participants who +1'd the issue.
  participants = {}


  # Returns true if content starts with "+1", excluding whitespace.
  startsWith = (content = '') ->
    /^\s*\+1/.test content


  # Returns true if content only contains "+1".
  # Some people add dot or exclamation mark after it (e.g. "+1!"), so we also
  # return true if content contains "+1" and one more character.
  onlyContains = (content = '') ->
    /^\s*\+1.{0,1}\s*$/.test content


  # Retrieves info about person from the comment node. This is later used to
  # construct list of people who +1'd the issue.
  getParticipantInfo = (node) ->
    # first link in comment node contains avatar icon and user info
    link = node.querySelector 'a'
    avatar = link.querySelector 'img'

    {
      id: avatar.dataset.user
      url: link.href
      name: avatar.alt
    }


  # Constructs HTML code for user icon.
  getUserIcon = (user = {}) ->
    icon = createElement 'img', {
      alt: user.name
      width: '20'
      height: '20'
      class: 'avatar'
      src: "https://avatars0.githubusercontent.com/u/#{user.id}?v=2&s=40"
    }

    link = createElement 'a', {
      href: user.url
      class: 'participant-avatar'
    }

    link.appendChild icon

    link


  # Loop for walking through comment nodes and getting data about +1 votes.
  for element in document.querySelectorAll '.timeline-comment-wrapper'

    content = element.querySelector('.comment-body').textContent

    if startsWith content
      participant = getParticipantInfo element
      participants[participant.id] = participant

      if onlyContains content
        element.classList.add 'plus-one-comment'


  # If there are any +1 votes, display summary in the sidebar.
  plus_one_count = Object.keys(participants).length
  if plus_one_count > 0

    # Add list of people who +1'd this issue to the sidebar.
    sidebar_content = document.createDocumentFragment()
    for id, participant of participants
      sidebar_content.appendChild getUserIcon participant

    addSidebarItem(
      "+1 (#{plus_one_count}×)"
      sidebar_content
      'participation'
      'participation-avatars'
    )

)()
