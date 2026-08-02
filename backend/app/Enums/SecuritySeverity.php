<?php

namespace App\Enums;

enum SecuritySeverity: string
{
    case INFO = 'info';

    case WARNING = 'warning';

    case ERROR = 'error';

    case CRITICAL = 'critical';
}