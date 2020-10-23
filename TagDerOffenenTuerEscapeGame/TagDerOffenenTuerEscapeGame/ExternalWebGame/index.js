/**
 * creates a HTML-element add adds it to the dom
 * @param {string} element The Elementtype to create
 * @param {HTMLElement} parent The parent element
 * @param {[{key: string, val: string}]} style The style of the element
 * @param {[{key: string, val: any}]} attributes The style of the element
 * @returns {HTMLElement} The created Element
 */
function createElemt(elemntType, parent, style, attributes) {
    var element = document.createElement(elemntType)
    if (style)
        for (i = 0; i < style.length; i++)
            element.style[style[i].key] = style[i].val

    if (attributes)
        for (i = 0; i < attributes.length; i++)
            element[attributes[i].key] = attributes[i].val

    parent.appendChild(element)
    return element
}

/**
 * Opens a closeable embedded HTML-page
 * @param {string} title The of the page
 * @param {string} url The url of the page
 */
function showWebsite(title, url) {
    let tobBarHeight = 30
    let tobBarMarginBottom = 0

    let container = createElemt('div', document.body, [
        { key: "width", val: "100vw" },
        { key: "height", val: "100vh" },
        { key: 'position', val: "absolute" },
        { key: "top", val: "0px" },
        { key: "text-align", val: "left" },
        { key: "background", val: "lightgrey" },
        { key: "overflow", val: "hidden" },
    ], [
        { key: "id", val: "container" },
    ])

    var loadingTextFontSize = Math.floor(tobBarHeight * 1.5)
    var loadingTextTop = window.innerHeight / 2
    if (loadingTextTop < tobBarHeight) loadingTextTop = loadingTextTop
    let loadingText = createElemt('div', container, [
        { key: "width", val: "100vw" },
        { key: 'position', val: "absolute" },
        { key: "top", val: loadingTextTop+"px" },
        { key: "font-size", val: loadingTextFontSize - 4 + 'px' },
        { key: "overflow", val: "hidden" },
        { key: "text-align", val: "center"},
        { key: "z-positon", val: "-1"},
    ], [
        { key: "innerText", val: "Lädt..." },
        { key: "id", val: "loadingText" },
    ])
    
    let topBar = createElemt('div', container, [
        { key: "width", val: "100vw" },
        { key: "height", val: tobBarHeight + 'px' },
        { key: "margin-bottom", val: tobBarMarginBottom + 'px' },
    ])

    let titel = createElemt('h1', topBar, [
        { key: "border", val: "none" },
        { key: "display", val: "inline" },
        { key: "font-size", val: tobBarHeight - 4 + 'px' },
        { key: "margin-left", val: '2px' },
        { key: "font-family", val: "sans-serif" },
    ], [
        { key: "innerText", val: title },
    ])

    let closeButton = createElemt('img', topBar, [
        { key: "width", val: tobBarHeight + 'px' },
        { key: "height", val: tobBarHeight + 'px' },
        { key: "border", val: "none" },
        { key: "position", val: "absolute" },
        { key: "right", val: "0px" },
    ], [
        { key: "src", val: "/round_cancel_black_96dp.png" },
        {
            key: "onclick", val: () => {
                container.parentElement.removeChild(document.getElementById(container.id))
            }
        },
    ])

    let embeddedWebside = createElemt('iframe', container, [
        { key: "width", val: "100vw" },
        { key: "height", val: window.innerHeight - tobBarHeight - tobBarMarginBottom + 'px' },
        { key: "border", val: "none" },
        { key: "align-self", val: "stretch" },
    ], [
        { key: "src", val: url },
        { key: "onload", val: () => {
            loadingText.parentElement.removeChild(document.getElementById(loadingText.id))
        } },
    ])

    window.addEventListener("resize", () => {
        embeddedWebside.style.height = window.innerHeight - tobBarHeight - tobBarMarginBottom + 'px'
    })
}
