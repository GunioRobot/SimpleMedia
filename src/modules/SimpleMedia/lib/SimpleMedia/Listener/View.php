<?php
/**
 * SimpleMedia.
 *
 * @copyright Axel Guckelsberger
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package SimpleMedia
 * @author Axel Guckelsberger <info@guite.de>.
 * @link http://zikula.de
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.5.4 (http://modulestudio.de) at Mon Nov 28 12:34:51 CET 2011.
 */

/**
 * Event handler implementation class for view-related events.
 */
class SimpleMedia_Listener_View
{
    /**
     * Listener for the `view.init` event.
     *
     * Occurs just before `Zikula_View#__construct()` finishes.
     * The subject is the Zikula_View instance.
     */
    public static function init(Zikula_Event $event)
    {
    }

    /**
     * Listener for the `view.postfetch` event.
     *
     * Filter of result of a fetch. Receives `Zikula_View` instance as subject, args are
     * `array('template' => $template)`, $data was the result of the fetch to be filtered.
     */
    public static function postFetch(Zikula_Event $event)
    {
    }
}
