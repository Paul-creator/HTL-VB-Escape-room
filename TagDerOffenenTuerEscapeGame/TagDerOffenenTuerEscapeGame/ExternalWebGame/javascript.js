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
function showWebside(title, url) {
    let container = createElemt('div', document.body, [
        { key: "width", val: "100vw" },
        { key: "height", val: "100vh" },
    ], [
        { key: "id", val: "container" },
    ])

    let tobBarHeight = 30
    let tobBarMarginBottom = 2
    let topBar = createElemt('div', container, [
        { key: "width", val: "100vw" },
        { key: "height", val: tobBarHeight + 'px' },
        { key: "margin-bottom", val: tobBarMarginBottom + 'px' },
    ])

    let titel = createElemt('h1', topBar, [
        { key: "border", val: "none" },
        { key: "display", val: "inline" },
        { key: "height", val: tobBarHeight + 'px' },
        { key: "font-size", val: tobBarHeight + 'px' },
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
        { key: "border-radius", val: "100px" },
        { key: "backgroundColor", val: "white" },
    ], [
        { key: "src", val: "/round_cancel_black_96dp.png" },
        {
            key: "onclick", val: () => {
                document.body.removeChild(document.getElementById(container.id))
            }
        },
    ])

    let embeddedWebside = createElemt('iframe', container, [
        { key: "width", val: "100vw" },
        { key: "height", val: document.body.clientHeight - tobBarHeight - tobBarMarginBottom + 'px' },
        { key: "border", val: "none" },
        { key: "align-self", val: "stretch" },
    ], [
        { key: "src", val: url },
    ])

    window.addEventListener("resize", () => {
        embeddedWebside.style.height = document.body.clientHeight - tobBarHeight - tobBarMarginBottom + 'px'
    })
}

showWebside('Titel', "http://www.htlvb.at")