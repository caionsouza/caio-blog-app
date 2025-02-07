const hiddenField = document.getElementById('url_field');
const url = window.location;
const domainApp = url.href.replace("/signup", "")

hiddenField.value = domainApp