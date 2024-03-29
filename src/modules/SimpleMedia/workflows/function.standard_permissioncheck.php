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
 * Check permissions during the workflow.
 *
 * @param array $obj
 * @param int $permLevel
 * @param int $currentUser
 * @return bool
 */
function SimpleMedia_workflow_simpleapproval_permissioncheck($obj, $permLevel, $currentUser)
{
    /** TODO */
    $component = 'SimpleMedia::';
    // process $obj and calculate an instance
    /** TODO */
    $instance = '::';

    return SecurityUtil::checkPermission($component, $instance, $permLevel, $currentUser);
}
