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

    let container = createElemt('div', document.body, [{
            key: "width",
            val: "100vw"
        },
        {
            key: "height",
            val: "100vh"
        },
        {
            key: 'position',
            val: "absolute"
        },
        {
            key: "top",
            val: "0px"
        },
        {
            key: "text-align",
            val: "left"
        },
        {
            key: "background",
            val: "lightgrey"
        },
        {
            key: "overflow",
            val: "hidden"
        },
    ], [{
        key: "id",
        val: "container"
    }, ])

    var loadingTextFontSize = Math.floor(tobBarHeight * 1.5)
    var loadingTextTop = window.innerHeight / 2
    if (loadingTextTop < tobBarHeight) loadingTextTop = loadingTextTop
    let loadingTextContainer = createElemt('div', container, [{
            key: "width",
            val: "100vw"
        },
        {
            key: "align-items",
            val: "center"
        },
        {
            key: "justify-content",
            val: "center"
        },
        {
            key: "pointer-events",
            val: "none"
        },
        {
            key: "display",
            val: "flex"
        },
    ], )

    let loadingText = createElemt('div', loadingTextContainer, [{
            key: 'position',
            val: "absolute"
        },
        {
            key: "top",
            val: loadingTextTop + "px"
        },
        {
            key: "font-size",
            val: loadingTextFontSize - 4 + 'px'
        },
        {
            key: "overflow",
            val: "hidden"
        },
        {
            key: "z-positon",
            val: "-1"
        },
        {
            key: "padding",
            val: "10px"
        },
        {
            key: "border-radius",
            val: "10px"
        },
        {
            key: "border",
            val: "none"
        },
        {
            key: "background",
            val: "white"
        },
    ], [{
            key: "innerText",
            val: "Lädt..."
        },
        {
            key: "id",
            val: "loadingText"
        },
    ])

    let topBar = createElemt('div', container, [{
            key: "width",
            val: "100vw"
        },
        {
            key: "height",
            val: tobBarHeight + 'px'
        },
        {
            key: "margin-bottom",
            val: tobBarMarginBottom + 'px'
        },
    ])

    let titel = createElemt('h1', topBar, [{
            key: "border",
            val: "none"
        },
        {
            key: "display",
            val: "inline"
        },
        {
            key: "font-size",
            val: tobBarHeight - 4 + 'px'
        },
        {
            key: "margin-left",
            val: '2px'
        },
        {
            key: "font-family",
            val: "sans-serif"
        },
    ], [{
        key: "innerText",
        val: title
    }, ])

    let closeButton = createElemt('img', topBar, [{
            key: "width",
            val: tobBarHeight + 'px'
        },
        {
            key: "height",
            val: tobBarHeight + 'px'
        },
        {
            key: "border",
            val: "none"
        },
        {
            key: "position",
            val: "absolute"
        },
        {
            key: "right",
            val: "0px"
        },
    ], [{
            key: "src",
            val: "/round_cancel_black_96dp.png"
        },
        {
            key: "onclick",
            val: () => {
                container.parentElement.removeChild(document.getElementById(container.id))
            }
        },
    ])

    let embeddedWebside = createElemt('iframe', container, [{
            key: "width",
            val: "100vw"
        },
        {
            key: "height",
            val: window.innerHeight - tobBarHeight - tobBarMarginBottom + 'px'
        },
        {
            key: "border",
            val: "none"
        },
        {
            key: "align-self",
            val: "stretch"
        },
    ], [{
            key: "src",
            val: url
        },
        {
            key: "onload",
            val: () => {
                loadingText.parentElement.removeChild(document.getElementById(loadingText.id))
            }
        },
    ])

    window.addEventListener("resize", () => {
        embeddedWebside.style.height = window.innerHeight - tobBarHeight - tobBarMarginBottom + 'px'
    })
}


/**
 * Opens a webpage in a new Tab
 * @param {string} url The url of the page
 */
function openInNewTab(url, alertText) {
    let container = createElemt('div', document.body, [{
            key: "width",
            val: "100vw"
        },
        {
            key: "height",
            val: "100vh"
        },
        {
            key: 'position',
            val: "absolute"
        },
        {
            key: "top",
            val: "0px"
        },
        {
            key: "text-align",
            val: "left"
        },
        {
            key: "background-color",
            val: "hsla(260, 100%, 5%, 0.5)"
        },
        {
            key: "overflow",
            val: "hidden"
        },
        {
            key: "display",
            val: "flex"
        },
        {
            key: "align-items",
            val: "center"
        },
    ], [{
        key: "id",
        val: "container"
    }, ])

    let box = createElemt('div', container, [{
            key: "padding",
            val: "10px"
        },
        {
            key: "border-radius",
            val: "10px"
        },
        {
            key: "border",
            val: "none"
        },
        {
            key: "background",
            val: "white"
        },
        {
            key: "left",
            val: "0"
        },
        {
            key: "right",
            val: "0"
        },
        {
            key: "top",
            val: "0"
        },
        {
            key: "bottom",
            val: "0"
        },
        {
            key: "margin",
            val: "auto"
        },
    ], [])

    let text = createElemt('p', box, [], [{
        key: 'innerText',
        val: alertText ?? 'Das Model wird in einem neuen Tab geöffnet.'
    }])

    let buttonStyle = [{
        key: "color",
        val: "blue"
    }, {
        key: "background",
        val: "lightgrey"
    }, {
        key: "padding",
        val: "5px"
    }, {
        key: "border-radius",
        val: "5px"
    }, {
        key: "margin",
        val: "5px"
    }, {
        key: "border",
        val: "none"
    }, {
        key: "text-decoration",
        val: "none"
    }, ]

    let buttonClose = createElemt('a', box, buttonStyle,
        [{
                key: "innerText",
                val: "abbrechen"
            },
            {
                key: "onclick",
                val: () => {
                    container.parentElement.removeChild(document.getElementById(container.id))
                }
            },
        ])
    let buttonOpen = createElemt('a', box, buttonStyle,
        [{
                key: "innerText",
                val: "ok"
            },
            {
                key: "href",
                val: url
            },
            {
                key: "target",
                val: '_blank'
            },
            {
                key: "onclick",
                val: () => {
                    container.parentElement.removeChild(document.getElementById(container.id))
                }
            },
        ])
}