```
/*base.user.css*/

:root {

    --side-bar-bg-color: #ddd;			/*左边栏background*/
    --control-text-color: #000;			/*左边栏文本color*/
	
	--bg-color: #ccc;					/*右边栏background*/
	
	--control-text-color: #000;				/*左窗口文本色*/
    --control-bg-hover-color: #00f;			/*左窗口悬停项的文本色*/

    --active-file-bg-color: rgb(34, 34, 34);	/*左窗口选择项的背景色*/		
	--active-file-text-color: #fff;				/*左窗口选择项的文本色*/
	
}

html { font-size: 1rem; }

body {
  font-family: 'Fixedsys Excelsior 3.01';
  font-size: 1rem;
  font-style: normal;
  color: #000;
  height: 1.3rem
}


#write > ul:first-child,
#write > ol:first-child{ margin-top: 30px; }

body > *:first-child { margin-top: 0 !important; }
body > *:last-child { margin-bottom: 0 !important; }
a { color: #4183C4; }

h1:hover a.anchor,
h2:hover a.anchor,
h3:hover a.anchor,
h4:hover a.anchor,
h5:hover a.anchor,
h6:hover a.anchor 
{
    /*background: url("../../images/modules/styleguide/para.png") no-repeat 10px center;*/
    text-decoration: none;
}

li>ol, li>ul { margin: 0 0; }

li p.first { display: inline-block; }
ul, ol { padding-left: 30px; }
ul:first-child, ol:first-child { margin-top: 0; }
ul:last-child, ol:last-child { margin-bottom: 0; }

table 
{
    padding: 0;
    word-break: initial;
}

/* 通用 */
table tr
{
    border-top: 1px solid #888;
    margin: 0;
    padding: 0;
	color: #000;
	background-color: #eee;
	text-align: left;
}

/* table header */
table tr th
{
    font-weight: normal;		
    border: 2px solid #888;
    text-align: left;
    margin: 0;
	background-color: rgba(27, 36, 38, 1);
	color: #ddd;
}

/* 单行 */
table tr td {}

/* 双行 */
table tr:nth-child(2n) { background-color: #ddd; }

table tr th:first-child, table tr td:first-child { margin-top: 0; }
table tr th:last-child, table tr td:last-child { margin-bottom: 0; }




@media screen and (min-width: 914px) {
    /*body {
        width: 95rem;
        margin: 0 auto;
    }*/
}
@media print 
{
    html { font-size: 13px; }
    table, pre { page-break-inside: avoid; }
    pre { word-wrap: break-word; }
}


#write pre.md-meta-block {
	padding: 1rem;
	font-size: 85%;
	line-height: 1.45;
	background-color: #f7f7f7;
	border: 0;
	border-radius: 3px;
	color: #777777;
	margin-top: 0 !important;
}

.mathjax-block>.code-tooltip { bottom: .375rem; }

#write>h3.md-focus:before{
	left: -1.5625rem;
	top: .375rem;
}
#write>h4.md-focus:before{
	left: -1.5625rem;
	top: .285714286rem;
}
#write>h5.md-focus:before{
	left: -1.5625rem;
	top: .285714286rem;
}
#write>h6.md-focus:before{
	left: -1.5625rem;
	top: .285714286rem;
}
.md-image>.md-meta {
    border: 1px solid #ddd;
    border-radius: 3px;
    font-family: Consolas, "Liberation Mono", Courier, monospace;
    padding: 2px 4px 0px 4px;
    font-size: 0.9em;
    color: inherit;
}

.md-tag { color: inherit; }

.sidebar-tabs { border-bottom: none; }

#typora-quick-open {
    border: 1px solid #ddd;
    background-color: #f8f8f8;
}

#typora-quick-open-item {
    background-color: #FAFAFA;
    border-color: #FEFEFE #e5e5e5 #e5e5e5 #eee;
    border-style: solid;
    border-width: 1px;
}

#md-notification:before { top: 10px; }

/** focus mode */
.on-focus-mode blockquote { border-left-color: rgba(85, 85, 85, 0.12); }

header, .context-menu, .megamenu-content, footer{ font-family: "Segoe UI", "Arial", sans-serif; }

.file-node-content:hover .file-node-icon,
.file-node-content:hover .file-node-open-state{ visibility: visible; }

.mac-seamless-mode #typora-sidebar {
    background-color: #fafafa;
    background-color: var(--side-bar-bg-color);
}

.md-lang { color: #b4654d; }

/* 右边栏 ********************************************************************************************************/
#write{
    max-width: 80rem;
	min-width: 80rem;
  	margin: 0 auto;
  	padding: 0px 2rem 4rem 2rem;
}

/* h1~h6 ********************************************************************************************************/
h1,h2,h3,h4,h5,h6 {
    position: relative;
    margin: .2rem 0rem;
	border: 0;
	padding: 0;
	
    border-left-width: 8px;
    border-left-style: solid;
    border-left-color: #f00;
		
	border-top-left-radius: 5px;
	border-bottom-left-radius: 5px;
    
    font-family: 'Fixedsys Excelsior 3.01';
    font-size: 1rem;
    font-style: solid;
    font-weight: normal;
    color: #000;
    line-height: 20px;
    cursor: text;
}

h1{border-left-color: #f00;}
h2{border-left-color: #FF7F50;}
h3{border-left-color: #ff0;}
h4{border-left-color: #0f0;}
h5{border-left-color: #97FFFF;}
h6{border-left-color: #00f;}

/* p ********************************************************************************************************/
p{
	position: relative;
	margin: 1px 0;
	border: 0;
	padding: 0;
	
	border-right-width: 3px;
	border-right-style: solid;
	border-right-color: #f00;
	
	line-height: 21px;
}
/* 代码段 ********************************************************************************************************/
.CodeMirror-gutters { border-right: 2px solid #fff; }

.md-fences 
{
	position: relative;
	margin: 4px 0;
	border: 0;
	padding: 10px 0 6px 0;
	
	border-radius: 3px;
	background-color: #3a4050; /*rgba(27, 36, 38, 1);*/
	
	font-family: 'Fixedsys Excelsior 3.01';
	font-size: 1rem;
	font-style: solid;
	font-weight: normal;
	color: #ccc;
	line-height: 1.3rem;
	cursor: text;
}

/*` `*/
code {
	position: relative;
	margin: 2px 0;
	border: 0;
	padding: 2px 4px;
	
	border-radius: 4px;
	
	background-color: rgba(0, 0, 255, 0.2);
	
	font-family: 'Fixedsys Excelsior 3.01';
	font-size: 1rem;
	font-style: solid;
	font-weight: normal;
	color: #000;
	line-height: 1rem;
	cursor: text;
}

/* > ********************************************************************************************************/
blockquote 
{
	margin: 4px 0;
	border: 0;
	padding: 0 0 0 1rem;
	
    border-left: 4px solid #fff;
	
    color: #777777;
}
blockquote blockquote {
    padding-right: 0;
}

/* TOC ********************************************************************************************************/
.md-toc { 
    margin: 0;
    border: 0;
    padding: 0;
   
    font-family: 'Fixedsys Excelsior 3.01';
    font-size: 1rem;
    font-style: solid;
    font-weight: normal;
    color: #00f;
    line-height: 20px;
}

/* 单项设置 */
a.md-toc-inner 
{ 
    margin: 1px 0;
    border: 0;
    padding: 0;
	
	font-size: 1rem; 
	font-style: normal; 
	font-weight: normal; 
	line-height: 20px; 
	
	border-left-width: 8px;
    border-left-style: solid;
    border-left-color: #f00;
	
	border-radius: 5px;
}
	
/* 分项设置 */
.md-toc-h1 .md-toc-inner { margin-left: 0px; border-left-color: #f00; }
.md-toc-h2 .md-toc-inner { margin-left: 2rem; border-left-color: #FF7F50; }
.md-toc-h3 .md-toc-inner { margin-left: 4rem; border-left-color: #ff0; }
.md-toc-h4 .md-toc-inner { margin-left: 6rem; border-left-color: #0f0; }
.md-toc-h5 .md-toc-inner { margin-left: 8rem; border-left-color: #97ffff; }
.md-toc-h6 .md-toc-inner { margin-left: 10rem; border-left-width: 0px; }


/* 任务 ********************************************************************************************************/
.task-list{
	padding-left: 0; /* 方框前的尺寸 */

	margin: 0;
	border: 0;
	padding: 0;
	line-height: 1.3rem;
}

.task-list-item {
	padding-left: 2rem;	/* 方框与文本之间的尺寸 */
}

.task-list-item input {
  top: -2px;		/* 方框上的尺寸 */
  left: 0.7rem;		/* 方框右的尺寸 */
}

/* *** ********************************************************************************************************/
hr {
    height: 2px;
    padding: 0;
    margin: 16px 0;
	background-color: rgba(27, 36, 38, 1);
    border: 0 none;
    overflow: hidden;
    box-sizing: content-box;
    border-bottom: 1px solid #ddd;
	
	box-shadow: 0px 2px 2px #222;
}

/* 正常模式选择文本色 ********************************************************************************************************/
*.in-text-selection,
::selection {
    background: #4a89dc;
    color: #fff;
    text-shadow: none;
}

/* 源码模式选择文本色 ********************************************************************************************************/
::-moz-selection {
    background: #4a89dc;
    color: #fff;
    text-shadow: none;
}
```

