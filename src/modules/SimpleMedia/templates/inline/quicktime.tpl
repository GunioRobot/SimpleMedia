{* Purpose of this template: Shows files within the quicktime media player inline *}
{assign var='playerWidth' value=' width="150"'}
{assign var='playerHeight' value=' height="150"'}
{*if $file.fileInfo.video.resolution_x ne ''}
    {assign var='playerWidth' value=" width=\"`$file.fileInfo.video.resolution_x`\""}
{/if}
{if $file.fileInfo.video.resolution_y ne ''}
    {assign var='playerHeight' value=$file.fileInfo.video.resolution_y+16}
    {assign var='playerHeight' value=" height=\"`$playerheight`\""}
{else*}
    {assign var='playerHeight' value=' height="129"'} {* 113 + 16 *}
{*/if*}
{if $medium.theFileMeta.extension eq 'mid' || $medium.theFileMeta.extension eq 'mp3' || $medium.theFileMeta.extension eq 'wav'}
    {assign var='playerHeight' value=' height="16"'}
{/if}
<!--[if !IE]> -->
    <object id="sm{$idprefix}media{$medium.id}"
            type="{*video/quicktime*}{$mimeType}"
            data="{$medium.theFileFullPathURL}"
            {$playerWidth}{$playerHeight}>
<!-- <![endif]-->
<!--[if IE]>
    <object id="sm{$idprefix}media{$file.fileid}"
            classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B"
            codebase="http://www.apple.com/qtactivex/qtplugin.cab"
            {$playerWidth}{$playerHeight}>
        <param name="src" value="{$medium.theFileFullPathURL}" />
<!--><!---->
        <param name="autoplay" value="0" />
        <param name="scale" value="aspect" />
        <p>
            Your browser does not support embedded media files of this type.<br />
            Please click <a href="{$medium.theFileFullPathURL}">here</a> to download the file you requested.<br />
            <a href="http://www.apple.com/quicktime/download" title="Download Quicktime Player" target="_blank">
                {img src='logo_quicktime.png' alt='Download Quicktime Player'}
            </a>
        </p>
    </object>
<!-- <![endif]-->