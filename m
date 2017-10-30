From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH] i2c: xgene-slimpro: Support v2
Date: Mon, 30 Oct 2017 14:33:19 -0700
Message-ID: <CAFHUOYxFsM0GD7zRcOuOnboC5PHcdsNh=_44P8244nfWjkCpnA@mail.gmail.com>
References: <1508796740-2294-1-git-send-email-hotran@apm.com>
 <20171028121135.nltpjjdinzdtfvgj@ninjato> <1509219424.10233.26.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509219424.10233.26.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Loc Ho <lho@apm.com>, patches <patches@apm.com>
List-Id: linux-i2c@vger.kernel.org

Hi Andy,


On Sat, Oct 28, 2017 at 12:37 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Sat, 2017-10-28 at 14:11 +0200, Wolfram Sang wrote:
>> Thanks for the patch!
>>
>> On Mon, Oct 23, 2017 at 03:12:20PM -0700, Hoan Tran wrote:
>> > This patch supports xgene-slimpro-i2c v2 which uses the non-cachable
>> > memory
>> > as the PCC shared memory.
>> >
>> > Signed-off-by: Hoan Tran <hotran@apm.com>
>>
>> I can't tell if __force is justified here but I don't know much about
>> ACPI... Andy, can you have a look?
>
> Few comments to the patch as well.
>
>> > +#ifdef CONFIG_ACPI
>> > +static const struct acpi_device_id xgene_slimpro_i2c_acpi_ids[] = {
>> > +   {"APMC0D40", XGENE_SLIMPRO_I2C_V1},
>> > +   {"APMC0D8B", XGENE_SLIMPRO_I2C_V2},
>> > +   {}
>> > +};
>> > +MODULE_DEVICE_TABLE(acpi, xgene_slimpro_i2c_acpi_ids);
>> > +#endif
>
> No need to move this here...
>
>> > +
>> >  static int xgene_slimpro_i2c_probe(struct platform_device *pdev)
>> >  {
>> >     struct slimpro_i2c_dev *ctx;
>> > @@ -476,6 +490,17 @@ static int xgene_slimpro_i2c_probe(struct
>> > platform_device *pdev)
>> >             }
>> >     } else {
>> >             struct acpi_pcct_hw_reduced *cppc_ss;
>> > +           int version = XGENE_SLIMPRO_I2C_V1;
>> > +#ifdef CONFIG_ACPI
>
> Do you really need this ifdef?
>
>> > +           const struct acpi_device_id *acpi_id;
>> > +
>> > +           acpi_id =
>> > acpi_match_device(xgene_slimpro_i2c_acpi_ids,
>
> ... you may get pointer to id table via pdev.
>
>> > +                                       &pdev->dev);
>> > +           if (!acpi_id)
>> > +                   return -EINVAL;
>> > +
>> > +           version = (int)acpi_id->driver_data;
>> > +#endif
>
>> >             if (ctx->comm_base_addr) {
>> > -                   ctx->pcc_comm_addr = memremap(ctx-
>> > >comm_base_addr,
>> > -                                                 cppc_ss-
>> > >length,
>> > -                                                 MEMREMAP_WB);
>> > +                   if (version == XGENE_SLIMPRO_I2C_V2)
>> > +                           ctx->pcc_comm_addr = (void __force
>> > *)ioremap(
>> > +                                                   ctx-
>> > >comm_base_addr,
>> > +                                                   cppc_ss-
>> > >length);
>
> Commit message actually doesn't explain why we switch to iomap over
> memmap.
>
> (__force here is obviously to suppress __iomap annotation for mapped
> memory)
>
> If you need non-cacheable MEMREMAP_WT I guess will do a job.

Yes, I can switch to MEMREMAP_WT.

I'm going to send out another patch soon.

Thanks
Hoan

>
>> > +                   else
>> > +                           ctx->pcc_comm_addr = memremap(
>> > +                                                   ctx-
>> > >comm_base_addr,
>> > +                                                   cppc_ss-
>> > >length,
>> > +                                                   MEMREMAP_WB
>> > );
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
