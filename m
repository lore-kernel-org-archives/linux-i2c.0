From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH 2/2] i2c: xgene-slimpro: Add ACPI support by using PCC mailbox
Date: Thu, 20 Apr 2017 13:38:53 -0700
Message-ID: <CAFHUOYxfivQ6kQwBwyX5X8QESbCFo4E_KM5iFHyjuChtTZq+uQ@mail.gmail.com>
References: <1490733977-23760-1-git-send-email-hotran@apm.com>
 <1490733977-23760-3-git-send-email-hotran@apm.com> <20170420080552.7hymw4gqy4kzecns@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yb0-f176.google.com ([209.85.213.176]:34525 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941540AbdDTUiz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 20 Apr 2017 16:38:55 -0400
Received: by mail-yb0-f176.google.com with SMTP id 11so33572836ybw.1
        for <linux-i2c@vger.kernel.org>; Thu, 20 Apr 2017 13:38:55 -0700 (PDT)
In-Reply-To: <20170420080552.7hymw4gqy4kzecns@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Loc Ho <lho@apm.com>, Keyur Chudgar <kchudgar@apm.com>

Hi Wolfram,

On Thu, Apr 20, 2017 at 1:05 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Hi,
>
> have you tested these patches also without PCC? So, we can be sure there
> is no regression?

These patches are tested with/without PCC.

>
>> diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
>> index 96545aa..a5771c1 100644
>> --- a/drivers/i2c/busses/i2c-xgene-slimpro.c
>> +++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
>> @@ -32,6 +32,8 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/version.h>
>>
>> +#include <acpi/pcc.h>
>> +
>
> Please keep it sorted alphabetically.
>
>> +#define PCC_CMD_GENERATE_DB_INT              BIT(15)
>> +#define PCC_STS_CMD_COMPLETE         BIT(0)
>> +#define PCC_STS_SCI_DOORBELL         BIT(1)
>> +#define PCC_STS_ERR                  BIT(2)
>> +#define PCC_STS_PLAT_NOTIFY          BIT(3)
>
> Please keep it sorted by number.
>
>> +     if (!acpi_disabled) {
>> +             mutex_lock(&ctx->tx_mutex);
>> +             init_completion(&ctx->rd_complete);
>
> reinit_completion?

OK,

>
>> +             slimpro_i2c_pcc_tx_prepare(ctx, msg);
>> +     }
>> +
>> +     mutex_init(&ctx->tx_mutex);
>
> Why this mutex, by the way? The i2c-core serializes access to the
> adapter. Maybe I am missing something?

That's a good point, let me remove this mutex.

>
>> +             cppc_ss = ctx->mbox_chan->con_priv;
>> +             if (!cppc_ss) {
>> +                     dev_err(&pdev->dev, "PPC subspace not found\n");
>> +                     rc = -ENODEV;
>> +                     goto mbox_err;
>> +             }
>> +
>> +             if (!ctx->mbox_chan->mbox->txdone_irq) {
>> +                     dev_err(&pdev->dev, "PCC IRQ not supported\n");
>> +                     rc = -ENODEV;
>> +                     goto mbox_err;
>> +             }
>>
>> +             /*
>> +              * This is the shared communication region
>> +              * for the OS and Platform to communicate over.
>> +              */
>> +             ctx->comm_base_addr = cppc_ss->base_address;
>> +             if (ctx->comm_base_addr) {
>> +                     ctx->pcc_comm_addr = memremap(ctx->comm_base_addr,
>> +                                                   cppc_ss->length,
>> +                                                   MEMREMAP_WB);
>> +             } else {
>> +                     dev_err(&pdev->dev, "Failed to get PCC comm region\n");
>> +                     rc = -ENODEV;
>> +                     goto mbox_err;
>> +             }
>
> I think it doesn't make sense to print a dev_err and return ENODEV which
> is treated by the driver core as a non-error. It means "not present, but
> OK". You probably want other error codes here.

How about -EINVAL for these -ENODEV error codes? Do you have any suggestion?

Thank for your comments!
Hoan


>
> Regards,
>
>    Wolfram
>
