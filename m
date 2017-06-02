From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH v2 2/2] i2c: xgene-slimpro: Add ACPI support by using PCC mailbox
Date: Fri, 2 Jun 2017 13:37:40 -0700
Message-ID: <CAPw-ZTkxjVWeo-bkHfYE5nABFdUZKqEZQLmoWxvVBU4pnhWL6g@mail.gmail.com>
References: <1493056826-16776-1-git-send-email-hotran@apm.com>
 <1493056826-16776-3-git-send-email-hotran@apm.com> <20170602203128.uxuy5lgzyopvvpkr@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170602203128.uxuy5lgzyopvvpkr@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Hoan Tran <hotran@apm.com>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Keyur Chudgar <kchudgar@apm.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

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
>
> BTW is there anyone inside apm.com who is willing to take over maintainership
> for this driver? This person needs to review patches thoroughly, yet it usually
> means patches will go in faster.

Thanks for fixing the warning message. Given that Duc has left MACOM
(previously APM), we are ramping up another person.

Thanks,
Loc
