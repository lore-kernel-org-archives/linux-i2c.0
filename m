From: carl peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] i2c: designware: Add support for AMD i2c controller
Date: Fri, 19 Sep 2014 13:29:33 +0800
Message-ID: <CAC5e1Fr7aX_184BaV0A6QoOv9vW7F1BJu+GddVNZbhjxUwHS7g@mail.gmail.com>
References: <1410930885-1379-1-git-send-email-carlpeng008@gmail.com>
	<20140918091910.GE10854@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140918091910.GE10854-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Mika,

It works good on my machine.
It is really perfect to create a uniform clk using sequence for
platform and acpi device by using clk_register_fixed_rate.
Thanks a lot for your continuous help!

Best Regards
Carl

On Thu, Sep 18, 2014 at 5:19 PM, Mika Westerberg
<mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> On Wed, Sep 17, 2014 at 01:14:45PM +0800, Carl Peng wrote:
>> AMD i2c bus controller is ACPI device, its ACPI ID
>> is "AMD0010". This patch is used to add support for
>> AMD i2c bus controller in the Designware platform
>> driver.
>>
>> Signed-off-by: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-designware-platdrv.c | 53 +++++++++++++++++++++++------
>>  1 file changed, 43 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index bc87733..20015e6 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -43,14 +43,18 @@
>>  #include <linux/acpi.h>
>>  #include "i2c-designware-core.h"
>>
>> +struct dw_i2c_config {
>> +     u32 clk_rate_khz;
>> +};
>> +
>>  static struct i2c_algorithm i2c_dw_algo = {
>>       .master_xfer    = i2c_dw_xfer,
>>       .functionality  = i2c_dw_func,
>>  };
>> -static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
>> -{
>> -     return clk_get_rate(dev->clk)/1000;
>> -}
>> +
>> +static struct dw_i2c_config amd_i2c_config = {
>> +     .clk_rate_khz = 133 * 1000,
>> +};
>>
>>  #ifdef CONFIG_ACPI
>>  static void dw_i2c_acpi_params(struct platform_device *pdev, char method[],
>> @@ -107,7 +111,8 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
>>       { "INT3433", 0 },
>>       { "80860F41", 0 },
>>       { "808622C1", 0 },
>> -     { }
>> +     { "AMD0010", (unsigned long)&amd_i2c_config },
>> +     {},
>>  };
>>  MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
>>  #else
>> @@ -117,12 +122,35 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
>>  }
>>  #endif
>>
>> +static const struct dw_i2c_config *i2c_dw_get_config(
>> +                                     struct dw_i2c_dev *dev)
>> +{
>> +     const struct acpi_device_id *id;
>> +
>> +     id = acpi_match_device(dw_i2c_acpi_match, dev->dev);
>
> This fails to compile if !CONFIG_ACPI.
>
> But it doesn't matter because I changed my mind about how this should be
> implemented ;-)
>
> I think it will be better if we just register the clock in ACPI parts of
> this driver in case of AMD device. That keeps the generic parts of the
> platform driver cleaner.
>
> I will send you a new version in a minute. Please let me know what you
> think and if it works on your machine.
>
>> +     if (id)
>> +             return (const struct dw_i2c_config *)id->driver_data;
>> +
>> +     return NULL;
>> +}
