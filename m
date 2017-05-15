From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH v2 0/2] i2c: xgene-slimpro: Add ACPI support
Date: Mon, 15 May 2017 16:06:24 -0700
Message-ID: <CAFHUOYzxd3gcX0Hz3iPRrg=AcUKT=mepdLG7hDW4JYEmbe1qsA@mail.gmail.com>
References: <1493056826-16776-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yb0-f171.google.com ([209.85.213.171]:35389 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbdEOXGZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 15 May 2017 19:06:25 -0400
Received: by mail-yb0-f171.google.com with SMTP id p143so31400377yba.2
        for <linux-i2c@vger.kernel.org>; Mon, 15 May 2017 16:06:25 -0700 (PDT)
In-Reply-To: <1493056826-16776-1-git-send-email-hotran@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Loc Ho <lho@apm.com>, Keyur Chudgar <kchudgar@apm.com>, Hoan Tran <hotran@apm.com>

Hi All,

Do you have any comments on this patch set?

Thanks
Hoan

On Mon, Apr 24, 2017 at 11:00 AM, Hoan Tran <hotran@apm.com> wrote:
> This patch set adds ACPI support by using PCC mailbox communication interface.
>
> v2:
>  * Alphabeltical order
>  * Use reinit_completion
>  * Remove mutex
>  * Use ENOENT instead of ENODEV
>
> Hoan Tran (2):
>   i2c: xgene-slimpro: Use a single function to send command message
>   i2c: xgene-slimpro: Add ACPI support by using PCC mailbox
>
>  drivers/i2c/busses/i2c-xgene-slimpro.c | 241 +++++++++++++++++++++++++--------
>  1 file changed, 187 insertions(+), 54 deletions(-)
>
> --
> 1.9.1
>
