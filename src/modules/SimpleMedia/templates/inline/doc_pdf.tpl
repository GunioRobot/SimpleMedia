{* Purpose of this template: Shows a pdf file *}
<object id="sm{$idprefix}doc{$medium.id}"
        classid="clsid:CA8A9780-280D-11CF-A24D-444553540000"
        width="340" height="200">
    <param name="src" value="{$medium.theFileFullPathURL}" />
    <embed src="{$medium.theFileFullPathURL}" width="340" height="200" type="application/pdf" pluginspage="http://www.adobe.com/products/acrobat/readstep.html" />
    <noembed>
        Your browser does not support embedded PDF files.<br />
        Please click <a href="{$medium.theFileFullPathURL}">here</a> to download the file you requested.<br />
        <a href="http://www.adobe.com/products/acrobat/readstep2.html" title="Download Acrobat Reader" target="_blank">
            {img src='logo_pdf.png' alt='Download Acrobat Reader'}
        </a>
    </noembed>
</object>
