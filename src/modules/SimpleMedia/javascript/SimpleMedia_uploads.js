
function simmedBrowserKnowsFileApi() {
    return (window.File && window.FileReader && window.FileList) ? true : false;
}

function simmedFileHandler(options) {
    this.options = Object.extend(
        {
            /**
             * @var boolean
             * Whether multiple files can be uploaded together or not
             */
            multiple: false,

            /**
             * @var int
             * Allowed maximum filesize in bytes, set to 0 for disable the check
             */
            maxSize: 0,

            /**
             * @var string
             * Type filter, corresponds to mime groups (image, audio, video, document, ...)
             */
            typeFilter: '',

            /**
             * @var string
             * Id of file input element
             */
            inputId: '',

            /**
             * @var string
             * Id of output list element
             */
            outputId: '',

            /**
             * @var string
             * Id of drop zone element for desktop drag-in
             */
            dropZoneId: '',

            /**
             * @var string
             * Id of progress bar container element
             */
            progressBarId: '',

            /**
             * @var string
             * Id of progress indicator
             */
            progressId: ''
        }, 
        options || {}
    );              

    var self = this;

    var inputElem       = (this.options.inputId !== '')         ? $(this.options.inputId)           : null;
    var outputElem      = (this.options.outputId !== '')        ? $(this.options.outputId)          : null;
    var dropZone        = (this.options.dropZoneId !== '')      ? $(this.options.dropZoneId)        : null;
    var typeFilter      = (this.options.typeFilter !== '')      ? this.options.typeFilter + '.*'    : '';

    var reader;
    var progressBar     = (this.options.progressBarId !== '')   ? $(this.options.progressBarId)     : null;
    var progress        = (this.options.progressId !== '')      ? $(this.options.progressId)        : null;

    this.supportsProgressBar = function () {
        return (progressBar !== null);
    };

    this.onInputFileSelect = function (evt) {
        var files = evt.target.files;
        self.processFileList(files);
    };

    this.onFileDragStart = function (evt) {
        evt.stopPropagation();
        evt.preventDefault();
        dropZone.addClassName('hover');
    };

    this.onFileDragOverDropZone = function (evt) {
        evt.stopPropagation();
        evt.preventDefault();
    };

    this.onFileDragEnd = function (evt) {
        evt.stopPropagation();
        evt.preventDefault();
        dropZone.removeClassName('hover');
    };

    this.onFileDrop = function (evt) {
        evt.stopPropagation();
        evt.preventDefault();
        dropZone.removeClassName('hover');

        var files = evt.dataTransfer.files;
        self.processFileList(files);
    };

    this.processFileList = function (files) {
        for (var i = 0, f; f = files[i]; i++) {
            // Check type
            if (typeFilter != '' && !f.type.match(typeFilter)) {
                continue;
            }

            reader = new FileReader();
            reader.onerror = self.errorHandler;

            if (self.supportsProgressBar()) {
                reader.onloadstart = function (evt) {
                    progressBar.addClassName('loading');
                };
            }

            reader.onloadend = function (evt) {
                //Zikula.UI.Alert('Ende', 'Test information');
            };

            if (self.supportsProgressBar()) {
                // Reset progress indicator on new file selection.
                progress.style.width = '0%';
                progress.update('0%');

                // Configure reader
                reader.onprogress = self.updateProgress;
            }

            reader.onabort = function (evt) {
                Zikula.UI.Alert('File read aborted', 'Information');
            };

            // Need a closure to capture the file information.
            reader.onload = (function (theFile) {
                return function (evt) {
                    if (self.supportsProgressBar()) {
                        // Ensure that the progress bar displays 100% at the end.
                        progress.style.width = '100%';
                        progress.update('100%');
                        setTimeout("$('" + progressBar.getAttribute('id') + "').removeClassName('loading');", 2000);
                    }
                    // Check size
                    if (self.options.maxSize == 0 || self.options.maxSize < theFile.size) {
                        if (outputElem !== null) {
                            if (typeFilter === 'image.*' || theFile.type.match('image.*')) {
                                // Render thumbnail.
                                var newElem = document.createElement('span');
                                newElem.update('<img class="thumb" src="' + evt.target.result + '" title="' + theFile.name + ' (' + theFile.size + ' bytes)"/>');
                            } else {
                                var newElem = document.createElement('p');
                                newElem.update('<strong>' + theFile.name + '</strong>' + (theFile.type ? ' (' + theFile.type + ') ' : '') + ' - ' + theFile.size + ' bytes' + (theFile.lastModifiedDate ? ', last modified: ' + theFile.lastModifiedDate.toLocaleDateString() : ''));
                                //Zikula.UI.Alert(evt.target.result, 'Test Information');
                            }

                            if (self.options.multiple === false) {
                                outputElem.update('');
                            }
                            outputElem.insertBefore(newElem, null);
                        }
                    }
                };
            })(f);

            reader.readAsDataURL(f); // returns a data url http://en.wikipedia.org/wiki/Data_URI_scheme
            // Alternatives:
            // reader.readAsBinaryString(f) - returns a binary string (each byte represented by an integer)
            // reader.readAsText(f, encoding = 'UTF-8') - returns a text string
            // reader.readAsArrayBuffer(f) - returns an ArrayBuffer object https://cvs.khronos.org/svn/repos/registry/trunk/public/webgl/doc/spec/TypedArray-spec.html
        }

        return false;
    };



    if (inputElem !== null) {
        inputElem.observe('change', this.onInputFileSelect);
    }

    if (dropZone !== null) {
        dropZone.observe('dragenter', this.onFileDragStart)
                .observe('dragover', this.onFileDragOverDropZone)
                .observe('dragleave', this.onFileDragEnd)
                .observe('drop', this.onFileDrop);
    }

    this.errorHandler = function (evt) {
        switch (evt.target.error.code) {
            case evt.target.error.NOT_FOUND_ERR:
                Zikula.UI.Alert('File Not Found!', 'Error');
                break;
            case evt.target.error.NOT_READABLE_ERR:
                Zikula.UI.Alert('File is not readable', 'Error');
                break;
            case evt.target.error.ABORT_ERR:
                break; // noop
            default:
                Zikula.UI.Alert('An error occurred reading this file.', 'Error');
        };
    };

    this.updateProgress = function (evt) {
        // evt is a ProgressEvent.
        if (evt.lengthComputable) {
            var percentLoaded = Math.round((evt.loaded / evt.total) * 100);
            // Increase the progress bar length.
            if (percentLoaded < 100) {
                progress.style.width = percentLoaded + '%';
                progress.update(percentLoaded + '%');
            }
        }
    };
};
