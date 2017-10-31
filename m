From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH v2] i2c: xgene-slimpro: Support v2
Date: Tue, 31 Oct 2017 13:27:52 -0700
Message-ID: <CAFHUOYyPF5pJ0OTxOJV1RsxN=8ZzMvt7w5hM40iHRoe3z0by_Q@mail.gmail.com>
References: <1509402256-3357-1-git-send-email-hotran@apm.com> <1509441294.10233.81.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45045 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752023AbdJaU1x (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 31 Oct 2017 16:27:53 -0400
Received: by mail-oi0-f65.google.com with SMTP id v132so417620oie.1
        for <linux-i2c@vger.kernel.org>; Tue, 31 Oct 2017 13:27:53 -0700 (PDT)
In-Reply-To: <1509441294.10233.81.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Loc Ho <lho@apm.com>, patches <patches@apm.com>

Hi Andy,

On Tue, Oct 31, 2017 at 2:14 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2017-10-30 at 15:24 -0700, Hoan Tran wrote:
>> This patch supports xgene-slimpro-i2c v2 which uses the non-cachable
>> memory
>> as the PCC shared memory.
>>
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> (I'm totally fine with ACPI bits here, for the rest I hope it had been
> tested and works as expected)

Yes, it had been tested.

Thanks
Hoan

>
>> Signed-off-by: Hoan Tran <hotran@apm.com>
>> ---
>> v2:
>>  - Remove un-necessary ifdef CONFIG_ACPI
>>  - Use acpi_match_table pointer from pdev
>>  - Use MEMREMAP_WT for non-cachable memory
>>
>>  drivers/i2c/busses/i2c-xgene-slimpro.c | 30
>> ++++++++++++++++++++++++++----
>>  1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c
>> b/drivers/i2c/busses/i2c-xgene-slimpro.c
>> index 7e89ba6..a7ac746 100644
>> --- a/drivers/i2c/busses/i2c-xgene-slimpro.c
>> +++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
>> @@ -129,6 +129,11 @@ struct slimpro_i2c_dev {
>>  #define to_slimpro_i2c_dev(cl)       \
>>               container_of(cl, struct slimpro_i2c_dev, mbox_client)
>>
>> +enum slimpro_i2c_version {
>> +     XGENE_SLIMPRO_I2C_V1 = 0,
>> +     XGENE_SLIMPRO_I2C_V2 = 1,
>> +};
>> +
>>  /*
>>   * This function tests and clears a bitmask then returns its old
>> value
>>   */
>> @@ -476,6 +481,15 @@ static int xgene_slimpro_i2c_probe(struct
>> platform_device *pdev)
>>               }
>>       } else {
>>               struct acpi_pcct_hw_reduced *cppc_ss;
>> +             const struct acpi_device_id *acpi_id;
>> +             int version = XGENE_SLIMPRO_I2C_V1;
>> +
>> +             acpi_id = acpi_match_device(pdev->dev.driver-
>> >acpi_match_table,
>> +                                         &pdev->dev);
>> +             if (!acpi_id)
>> +                     return -EINVAL;
>> +
>> +             version = (int)acpi_id->driver_data;
>>
>>               if (device_property_read_u32(&pdev->dev, "pcc-
>> channel",
>>                                            &ctx->mbox_idx))
>> @@ -514,9 +528,16 @@ static int xgene_slimpro_i2c_probe(struct
>> platform_device *pdev)
>>                */
>>               ctx->comm_base_addr = cppc_ss->base_address;
>>               if (ctx->comm_base_addr) {
>> -                     ctx->pcc_comm_addr = memremap(ctx-
>> >comm_base_addr,
>> -                                                   cppc_ss-
>> >length,
>> -                                                   MEMREMAP_WB);
>> +                     if (version == XGENE_SLIMPRO_I2C_V2)
>> +                             ctx->pcc_comm_addr = memremap(
>> +                                                     ctx-
>> >comm_base_addr,
>> +                                                     cppc_ss-
>> >length,
>> +                                                     MEMREMAP_WT);
>> +                     else
>> +                             ctx->pcc_comm_addr = memremap(
>> +                                                     ctx-
>> >comm_base_addr,
>> +                                                     cppc_ss-
>> >length,
>> +                                                     MEMREMAP_WB);
>>               } else {
>>                       dev_err(&pdev->dev, "Failed to get PCC comm
>> region\n");
>>                       rc = -ENOENT;
>> @@ -581,7 +602,8 @@ MODULE_DEVICE_TABLE(of, xgene_slimpro_i2c_dt_ids);
>>
>>  #ifdef CONFIG_ACPI
>>  static const struct acpi_device_id xgene_slimpro_i2c_acpi_ids[] = {
>> -     {"APMC0D40", 0},
>> +     {"APMC0D40", XGENE_SLIMPRO_I2C_V1},
>> +     {"APMC0D8B", XGENE_SLIMPRO_I2C_V2},
>>       {}
>>  };
>>  MODULE_DEVICE_TABLE(acpi, xgene_slimpro_i2c_acpi_ids);
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
