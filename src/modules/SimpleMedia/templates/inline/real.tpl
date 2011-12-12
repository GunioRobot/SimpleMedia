{* Purpose of this template: Shows files within the real player inline *}
{assign var='playerWidth' value=''}
{assign var='playerHeight' value=''}
{*if $file.fileInfo.video.resolution_x ne ''}
    {assign var='playerWidth' value=" width=\"`$file.fileInfo.video.resolution_x`\""}
{/if}
{if $file.fileInfo.video.resolution_y ne ''}
    {assign var='playerHeight' value=" height=\"`$file.fileInfo.video.resolution_y`\""}
{/if*}
<object id="sm{$idprefix}media{$medium.id}"
        classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA"
        standby="Loading Real Player components..."
        type="application/x-oleobject"
        {$playerWidth}{$playerHeight}>
    <param name="src" value="{$medium.theFileFullPathURL}" />
    <param name="autostart" value="0" />
    <param name="maintainaspect" value="1" />
    <embed src="{$medium.theFileFullPathURL}"{$playerWidth}{$playerHeight} type="audio/x-pn-realaudio-plugin" nojava="true" controls="all" console="one" />
    <noembed>
        Your browser does not support embedded real files.<br />
        Please click <a href="{$medium.theFileFullPathURL}">here</a> to download the file you requested.<br />
        <a href="http://www.real.com/" title="Download Real Player" target="_blank">
            {img src='logo_real.png' alt='Download Real Player'}
        </a>
    </noembed>
</object>