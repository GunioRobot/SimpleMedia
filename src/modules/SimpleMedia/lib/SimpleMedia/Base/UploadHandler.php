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
 * Upload handler base class.
 */
class SimpleMedia_Base_UploadHandler
{
    /**
     * @var array List of object types with upload fields.
     */
    protected $allowedObjectTypes;

    /**
     * @var array List of file types to be considered as images.
     */
    protected $imageFileTypes;

    /**
     * @var array List of dangerous file types to be rejected.
     */
    protected $forbiddenFileTypes;

    /**
     * Constructor initialising the supported object types.
     */
    public function __construct()
    {
        $this->allowedObjectTypes = array('medium');
        $this->imageFileTypes = array('gif', 'jpeg', 'jpg', 'png');
        $this->forbiddenFileTypes = array('cgi', 'pl', 'asp', 'phtml', 'php', 'php3', 'php4', 'php5', 'exe', 'com', 'bat', 'jsp', 'cfm', 'shtml');
    }

    /**
     * Process a file upload.
     *
     * @param string $objectType Currently treated entity type.
     * @param string $fileData   Form data array.
     * @param string $fieldName  Name of upload field.
     *
     * @return array Resulting file name and collected meta data.
     */
    public function performFileUpload($objectType, $fileData, $fieldName)
    {
        $dom = ZLanguage::getModuleDomain('SimpleMedia');

        $result = array('fileName' => '',
                        'metaData' => array());

        // check whether uploads are allowed for the given object type
        if (!in_array($objectType, $this->allowedObjectTypes)) {
            return $result;
        }

        // perform validation
        if (!$this->validateFileUpload($fileData[$fieldName])) {
            // skip this upload field
            return $result;
        }

        // retrieve the final file name
        $fileName = $fileData[$fieldName]['name'];
        $extensionarr = explode('.', $fileName);
        $extension = strtolower($extensionarr[count($extensionarr) - 1]);

        // retrieve the final file name
        $basePath = SimpleMedia_Util_Controller::getFileBaseFolder($objectType, $fieldName);
        $fileName = $this->determineFileName($objectType, $fieldName, $basePath, $fileName, $extension);

        if (!move_uploaded_file($fileData[$fieldName]['tmp_name'], $basePath . $fileName)) {
            return LogUtil::registerError(__('Error! Could not move your file to the destination folder.', $dom));
        }

        // collect data to return
        $result['fileName'] = $fileName;
        $result['metaData'] = $this->readMetaDataForFile($fileName, $basePath . $fileName);

        return $result;
    }

    /**
     * Check if an upload file meets all validation criteria.
     *
     * @param array $file Reference to data of uploaded file.
     *
     * @return boolean true if file is valid else false
     */
    protected function validateFileUpload($file)
    {
        $dom = ZLanguage::getModuleDomain('SimpleMedia');

        // check if a file has been uploaded properly without errors
        if ((!is_array($file)) || (is_array($file) && ($file['error'] != '0'))) {
            if (is_array($file)) {
                return $this->handleError($file);
            }
            return LogUtil::registerError(__('Error! No file found.', $dom));
        }

        // extract file extension
        $fileName = $file['name'];
        $extensionarr = explode('.', $fileName);
        $extension = strtolower($extensionarr[count($extensionarr) - 1]);

        // validate extension
        $isValidExtension = $this->isAllowedFileExtension($objectType, $fieldName, $extension);
        if ($isValidExtension === false) {
            return LogUtil::registerError(__('Error! This file type is not allowed. Please choose another file format.', $dom));
        }

        // validate image file
        $imgInfo = array();
        $isImage = in_array($extension, $this->imageFileTypes);
        if ($isImage) {
            $imgInfo = getimagesize($file['tmp_name']);
            if (!is_array($imgInfo) || !$imgInfo[0] || !$imgInfo[1]) {
                return LogUtil::registerError(__('Error! This file type seems not to be a valid image.', $dom));
            }
        }

        return true;
    }

    /**
     * Read meta data from a certain file.
     *
     * @param string $fileName  Name of file to be processed.
     * @param string $filePath  Path to file to be processed.
     *
     * @return array collected meta data
     */
    public function readMetaDataForFile($fileName, $filePath)
    {
        $meta = array();
        if (empty($fileName)) {
            return $meta;
        }

        $extensionarr = explode('.', $fileName);
        $meta = array();
        $meta['extension'] = $extensionarr[count($extensionarr) - 1];
        $meta['size'] = filesize($filePath);
        $meta['isImage'] = (in_array($meta['extension'], $this->imageFileTypes) ? true : false);

        if (!$meta['isImage']) {
            return $meta;
        }

        $imgInfo = getimagesize($filePath);
        if (!is_array($imgInfo)) {
            return $meta;
        }

        $meta['width'] = $imgInfo[0];
        $meta['height'] = $imgInfo[1];

        if ($imgInfo[1] < $imgInfo[0]) {
            $meta['format'] = 'landscape';
        } elseif ($imgInfo[1] > $imgInfo[0]) {
            $meta['format'] = 'portrait';
        } else {
            $meta['format'] = 'square';
        }

        return $meta;
    }

    /**
     * Determines the allowed file extensions for a given object type.
     *
     * @param string $objectType Currently treated entity type.
     * @param string $fieldName  Name of upload field.
     * @param string $extension  Input file extension.
     *
     * @return array the list of allowed file extensions
     */
    protected function isAllowedFileExtension($objectType, $fieldName, $extension)
    {
        // determine the allowed extensions
        $allowedExtensions = array();
        switch ($objectType) {
            case 'medium':
                            $allowedExtensions = explode(',', ModUtil::getVar('SimpleMedia', 'allowedExtensions'));
                            break;
        }

        if (!empty($allowedExtensions)) {
            $extensionCheck = in_array(strtolower($extension), $allowedExtensions);
            if ($extensionCheck === false) {
                return false;
            }
        }

        $extensionCheck = (!in_array($extension, $this->forbiddenFileTypes));
        if ($extensionCheck === false) {
            return false;
        }

        return true;
    }

    /**
     * Determines the final filename for a given input filename.
     *
     * It considers different strategies for computing the result.
     *
     * @param string $objectType Currently treated entity type.
     * @param string $fieldName  Name of upload field.
     * @param string $basePath   Base path for file storage.
     * @param string $fileName   Input file name.
     * @param string $extension  Input file extension.
     *
     * @return string the resulting file name
     */
    protected function determineFileName($objectType, $fieldName, $basePath, $fileName, $extension)
    {
        $backupFileName = $fileName;

        $namingScheme = 0;

        switch ($objectType) {
            case 'medium':
                            $namingScheme = 0;
                            break;
        }


        $iterIndex = -1;
        do {
            if ($namingScheme == 0) {
                // original file name
                $fileNameCharCount = strlen($fileName);
                for ($y = 0; $y < $fileNameCharCount; $y++) {
                    if (preg_match('/[^0-9A-Za-z_\.]/', $fileName[$y])) {
                        $fileName[$y] = '_';
                    }
                }
                // append incremented number
                if ($iterIndex > 0) {
                    // strip off extension
                    $fileName = str_replace('.' . $extension, '', $backupFileName);
                    // add iterated number
                    $fileName .= (string) ++$iterIndex;
                    // readd extension
                    $fileName .= '.' . $extension;
                } else {
                    $iterIndex++;
                }
            } else if ($namingScheme == 1) {
                // md5 name
                $fileName = md5(uniqid(mt_rand(), TRUE)) . '.' . $extension;
            } else if ($namingScheme == 2) {
                // prefix with random number
                $fileName = $fieldName . mt_rand(1, 999999) . '.' . $extension;
            }
        }
        while (file_exists($basePath . $fileName)); // repeat until we have a new name

        // return the new file name
        return $fileName;
    }

    /**
     * Error handling helper method.
     *
     * @param array $file File array from $_FILES.
     *
     * @return boolean false
     */
    private function handleError($file)
    {
        $errmsg = '';
        switch ($file['error']) {
            case UPLOAD_ERR_OK: //no error; possible file attack!
                $errmsg = 'Unknown error';
                break;
            case UPLOAD_ERR_INI_SIZE: //uploaded file exceeds the upload_max_filesize directive in php.ini
                $errmsg = 'File too big';
                break;
            case UPLOAD_ERR_FORM_SIZE: //uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the html form
                $errmsg = 'File too big';
                break;
            case UPLOAD_ERR_PARTIAL: //uploaded file was only partially uploaded
                $errmsg = 'File uploaded partially';
                break;
            case UPLOAD_ERR_NO_FILE: //no file was uploaded
                $errmsg = 'No file uploaded';
                break;
            case UPLOAD_ERR_NO_TMP_DIR: //missing a temporary folder
                $errmsg = 'No tmp folder';
                break;
            default: //a default (error, just in case!  :)
                $errmsg = 'Unknown error';
                break;
        }
        return LogUtil::registerError('Error with upload: ' . $errmsg);
    }

    /**
     * Deletes an existing upload file.
     * For images the thumbnails are removed, too.
     *
     * @param string $objectType Currently treated entity type.
     * @param string $objectData Object data array.
     * @param string $fieldName  Name of upload field.
     *
     * @return mixed Array with updated object data on success, else false.
     */
    public function deleteUploadFile($objectType, $objectData, $fieldName)
    {
        if (!in_array($objectType, $this->allowedObjectTypes)) {
            return false;
        }

        if (empty($objectData[$fieldName])) {
            return $objectData;
        }

        // determine file system information
        $basePath = SimpleMedia_Util_Controller::getFileBaseFolder($objectType, $fieldName);
        $fileName = $objectData[$fieldName];

        // remove original file
        if (!unlink($basePath . $fileName)) {
            return false;
        }
        $objectData[$fieldName] = '';
        $objectData[$fieldName . 'Meta'] = array();


        $fileExtension = FileUtil::getExtension($fileName, false);
        if (!in_array($fileExtension, $this->imageFileTypes)) {
            // we are done, so let's return
            return $objectData;
        }

        // get extension again, but including the dot
        $fileExtension = FileUtil::getExtension($fileName, true);
        $mediaThumbExt = ModUtil::getVar('SimpleMedia', 'mediaThumbExt');
        $thumbFileNameBase = str_replace($fileExtension, '', $fileName) . $mediaThumbExt;
        $thumbFileNameBaseLength = strlen($thumbFileNameBase);

        // remove image thumbnails
        $mediaThumbDir = ModUtil::getVar('SimpleMedia', 'mediaThumbDir');
        $thumbPath = $basePath . $mediaThumbDir;
        $thumbFiles = FileUtil::getFiles($thumbPath, false, true, null, 'f'); // non-recursive, relative pathes
        foreach ($thumbFiles as $thumbFile) {
            $thumbFileBase = substr($thumbFile, 0, $thumbFileNameBaseLength);
            if ($thumbFileBase != $thumbFileNameBase) {
                // let other thumbnails untouched
                continue;
            }
            unlink($thumbPath . $thumbFile);
        }

        return $objectData;
    }
}
