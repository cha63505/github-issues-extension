(function() {
  var constructSettingsLink, getSettingsLink, menu_element;

  getSettingsLink = function() {
    var element;
    element = constructSettingsLink();
    element.href = chrome.extension.getURL('options.html');
    element.target = 'github-extension-settings';
    return element;
  };

  constructSettingsLink = function() {
    var element;
    element = document.createElement('a');
    element.appendChild(document.createTextNode('GitHub Issues extension'));
    element.className = 'menu-item';
    return element;
  };

  menu_element = document.querySelector('.menu');

  menu_element.appendChild(getSettingsLink());

}).call(this);
