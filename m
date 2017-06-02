From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH v2 2/2] i2c: xgene-slimpro: Add ACPI support by using PCC mailbox
Date: Fri, 2 Jun 2017 13:58:03 -0700
Message-ID: <CAFHUOYxYLwWpz__Wu_XYbQeuMDf0uKEcwJJLj2QW7OVM1x8JBA@mail.gmail.com>
References: <1493056826-16776-1-git-send-email-hotran@apm.com>
 <1493056826-16776-3-git-send-email-hotran@apm.com> <20170602203128.uxuy5lgzyopvvpkr@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170602203128.uxuy5lgzyopvvpkr@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Loc Ho <lho@apm.com>, Keyur Chudgar <kchudgar@apm.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 2, 2017 at 1:31 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Mon, Apr 24, 2017 at 11:00:26AM -0700, Hoan Tran wrote:
>> This patch adds ACPI support by using PCC mailbox communication
>> interface.
>>
>> Signed-off-by: Hoan Tran <hotran@apm.com>
>
> Please make use checkpatch:
>
> WARNING: braces {} are not necessary for single statement blocks
> #149: FILE: drivers/i2c/busses/i2c-xgene-slimpro.c:242:
> +       if (!acpi_disabled) {
> +               mbox_chan_txdone(ctx->mbox_chan, 0);
> +       }
>
> Fixed that and applied to for-next, thanks!

Thanks, Wolfram!

Regards,
Hoan

>
> BTW is there anyone inside apm.com who is willing to take over maintainership
> for this driver? This person needs to review patches thoroughly, yet it usually
> means patches will go in faster.
>
> Regards,
>
>    Wolfram
>
