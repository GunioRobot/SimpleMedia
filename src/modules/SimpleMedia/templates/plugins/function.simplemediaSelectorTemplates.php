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
 * @version Generated by ModuleStudio 0.5.3 (http://modulestudio.de) at Sun Oct 30 11:20:55 CET 2011.
 */

/**
 * The simplemediaSelectorTemplates plugin provides items for a dropdown selector.
 *
 * Available parameters:
 *   - assign:   If set, the results are assigned to the corresponding variable instead of printed out.
 *
 * @param  array            $params  All attributes passed to this function from the template.
 * @param  Zikula_Form_View $view    Reference to the view object.
 *
 * @return string The output of the plugin.
 */
function smarty_function_simplemediaSelectorTemplates($params, $view)
{
    $result = array();

    $result[] = array('text' => 'Nur Titel'/*$view->__('Only item titles')*/, 'value' => 'itemlist_display.tpl');
    $result[] = array('text' => 'Simple Vorschau'/*$view->__('With description')*/, 'value' => 'itemlist_display_description.tpl');
    $result[] = array('text' => 'Galerie'/*$view->__('Gallery')*/, 'value' => 'itemlist_display_gallery.tpl');

    if (array_key_exists('assign', $params)) {
        $view->assign($params['assign'], $result);
        return;
    }
    return $result;
}
