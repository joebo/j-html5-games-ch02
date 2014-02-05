coclass'ch02'
coinsert'jhs'

DEBUG=:1
FILE=:'~user/projects/j-html5-games-ch02/ch02.ijs'

NB. need to add mimetypes for these types since JHS does is not configured for them by default
addMimeTypes =: 3 : 0
if. ((1{"1 mimetypes_jfilesrc_) i. (<'ttf')) = (# mimetypes_jfilesrc_) 
do.
mimetypes_jfilesrc_ =:  mimetypes_jfilesrc_ , ('application/octet-stream';'ttf')
end.
if. ((1{"1 mimetypes_jfilesrc_) i. (<'woff')) = (# mimetypes_jfilesrc_) 
do.
mimetypes_jfilesrc_ =:  mimetypes_jfilesrc_ , ('application/octet-stream';'woff')
end.
)

addMimeTypes''

html =: 0 : 0
<!DOCTYPE HTML>
<html lang="en-US">
<head>
    <meta charset="UTF-8">
    <title>Jewel Warrior</title>
    <base href="~user/projects/j-html5-games-ch02/"></base>
    <link rel="stylesheet" href="styles/main.css" />
    <link rel="stylesheet" href="styles/fontfaces.css" />
    <script src="scripts/modernizr.js"></script>
    <script src="scripts/loader.js"></script>
</head>
<body>
    <div id="game">
        <div class="screen" id="splash-screen">
            <h1 class="logo">Jewel <br/>Warrior</h1>
            <span class="continue">Click to continue</span>
        </div>

        <div class="screen" id="main-menu"></div>
        <div class="screen" id="game-screen"></div>
        <div class="screen" id="high-scores"></div>
    </div>
</body>
</html>
)



jev_get=: 3 : 0
if. DEBUG do. checkLatestScript'' end.
render html
)

NB. Utility functions

render =: 3 : 0
'text/html' gsrcf y
)


NB. sets a global variable for when the script was loaded
setLoadTime=: 3 : 0
LOAD=:(< 6!:0 'hh:mm:ss')
)

setLoadTime''

NB. reloads the file if it hasn't been loaded in a second
checkLatestScript=: 3 : 0
if. 0=((< 6!:0 'hh:mm:ss') -: LOAD) do.
  setLoadTime
  load jpath FILE
end.
)


NB. these are defined in j8, but apparently not j7 linux build
gsrchead=: toCRLF 0 : 0
HTTP/1.1 200 OK
Server: JHS
Last-Modified: Mon, 01 Mar 2010 00:23:24 GMT
Accept-Ranges: bytes
Content-Length: <LENGTH>
Keep-Alive: timeout=15, max=100
Connection: Keep-Alive
Content-Type: <TYPE>

)

gsrcf=: 4 : 0
htmlresponse y,~gsrchead rplc '<TYPE>';x;'<LENGTH>';":#y
)
