// Define RegEx which matches the with gender star, colon
// or 'Innen' gendered text.
const gender_regex = RegExp("(?:([A-Za-zÄÖÜäöüß]+)[:\*][Ii]nnen)|(?:([A-Za-zÄÖÜäöüß]+)[I]{1}nnen((?:[^A-Za-z])|$))", "g");

// Remove all gender language in the given node and, if
// 'recursive' is set as 'true', it's children.
function replace_gendered_language(dom_node, recursive) {
    // Check if the target node is a text node.
    if (dom_node.nodeType === Node.TEXT_NODE) {
        // Prevent the replace on textareas so that the user still
        // can write text containing the gender star.
        if (dom_node.parentNode && dom_node.parentNode.nodeName === 'TEXTAREA') {
            return;
        }
        
        // Remove all ':[Ii]nnen', '*[Ii]nnen' or
        // 'Innen' from the text.
        dom_node.textContent = dom_node.textContent.replace(gender_regex, "$1$2$3");
    }
    else {
        if (recursive === true) {
            // This node contains more than just text, call replaceText() on each
            // of its children.
            for (let i = 0; i < dom_node.childNodes.length; i++) {
                replace_gendered_language(dom_node.childNodes[i], true);
            }
        }
    }
}

// Process the website body after loading
replace_gendered_language(document.body, true);

// Watch for changes in the html document and repeat the
// operation if the content has changed.
const website_observer = new MutationObserver((mutations) => {
  mutations.forEach((mutation) => {
    if (mutation.addedNodes && mutation.addedNodes.length > 0) {
      for (let i = 0; i < mutation.addedNodes.length; i++) {
          const newNode = mutation.addedNodes[i];
          replace_gendered_language(newNode, false);
      }
    }
  });
});

website_observer.observe(document.body, {
  childList: true,
  subtree: true
});
