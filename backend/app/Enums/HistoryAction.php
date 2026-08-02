<?php

namespace App\Enums;

enum HistoryAction: string
{
    case SUBMIT = 'submit';

    case REVIEW = 'review';

    case REVISION = 'revision';

    case RESUBMIT = 'resubmit';

    case APPROVE = 'approve';

    case REJECT = 'reject';
}