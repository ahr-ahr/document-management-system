<?php

namespace App\Enums;

enum ReviewResult: string
{
    case APPROVED = 'approved';

    case REVISION = 'revision';

    case REJECTED = 'rejected';
}