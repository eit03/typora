
/* Please visit the URL below for more information: */
/*   https://shd101wyy.github.io/markdown-preview-enhanced/#/customize-css */
/* ~/.mume/style.less */

.markdown-preview.markdown-preview {

    ///> box

    // 40rem(content) + 0.63rem(padding) + 1rem(scroll_bar) + 0.6rem(page_padding)
    max-width: 42.23rem !important;
    min-width: 42.23rem !important;

    margin: 1rem !important; // invalid
    border: 0px solid red !important;
    padding: 0.5rem !important;

    ///> color
    background: #f8f8f8;

    ///> fonts
    html, h1, h2, h3, h4, h5, h6, p, table, pre, code, ol, li {
      font-family: "Fixedsys Excelsior 3.01";
      font-size: 16px !important;
      font-style: normal !important;
      font-weight: normal !important;
      color: black !important;
    }

    ///> hr
    hr {
        margin: 8px 0 !important;
        border: 0px solid red !important;
        padding: 0 !important;

        background-color: rgba(27, 36, 38, 1) !important;
        height: 2px !important;

        overflow: hidden !important;
        box-sizing: content-box !important;
        border-bottom: 1px solid #ddd !important;
        box-shadow: 0px 2px 2px #222 !important;
    }

    ///> page
    p {
        margin: 0.3rem 0rem !important;
        border: 0px solid red !important;
        border-bottom: 1px solid #30303008 !important;
        padding: 0.1rem 0.3rem !important;

        line-height: 1.1rem;
    }

    p > code {
        padding: 0px 0px !important;
    }


    ///> header
    h1, h2, h3, h4, h5, h6 {
        margin: 0.3rem 0rem !important;
        border: 0px solid red !important;
        border-left: 8px solid #f00 !important;
        border-top-left-radius: 4px !important;
        border-bottom-left-radius: 4px !important;
        padding: 0px !important;
        height: 1.2rem !important;
    }

    h1{border-left-color: #f00 !important;}
    h2{border-left-color: #FF7F50 !important;}
    h3{border-left-color: #ff0 !important;}
    h4{border-left-color: #0f0 !important;}
    h5{border-left-color: #97FFFF !important;}
    h6{border-left-color: #00f !important;}

    h1 > code, h2 > code, h3 > code, h4 > code, h5 > code, h6 > code {
        margin: 0 !important;
        border: 0px solid red !important;
        border-top-left-radius: 0px !important;
        border-bottom-left-radius: 0px !important;
        padding: 0.1rem 0 !important;
        height: 1.2rem !important;
    }

    ///> pre > code

    // four space "    "
    pre {
        margin: 0.3rem 0rem !important;
        border: 0px solid red !important;
        padding: 0px 5px 5px 5px !important;

        background-color: #3a4055 !important;
        color: #ccc !important;
    }

    // double three grave accent "```"
    code {
       background-color: #0000ff45 !important;
    }

    pre > code {
        margin: 0.3rem 0rem !important;
        border: 0px solid red !important;
        padding: 0 !important;

        background-color: #00000000 !important;
        color: #ccc !important;
    }

    ///> table
    // table > thead > tr > th
    // table > tbody > tr > td

    tr {
        line-height: 1rem !important;
    }

    th {
        border: none !important;
        border-top: 2px solid #40404080 !important;
        border-bottom: 2px solid #40404080 !important;
        text-align:left !important;
    }

    td {
        border: none !important;
        border-top:    1px solid #d6d6d6 !important;
        border-bottom: 1px solid #d6d6d6 !important;
    }

    ///> ol ul li
    ol ul {
      margin: 0 !important;
      border: 1px solid red !important;
      padding: 0 !important;
    }
    ol li {
        margin: 0 0 0 1rem !important;
        line-height: 1.2rem;
    }



    ///> cpp

    // className structName

}
