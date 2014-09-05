From: carl peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c-designware: Add suport for AMD i2c controller
Date: Fri, 5 Sep 2014 15:19:50 +0800
Message-ID: <CAC5e1Fppiin2OczBUeyACOijWN3DocUKcRJKw31G+8-zX+mxpg@mail.gmail.com>
References: <1409833805-1574-1-git-send-email-carlpeng008@gmail.com>
	<20140904125029.GD3632@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140904125029.GD3632-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Mika,

Could I consult a problem with you?

As you suggest, there are some samples that add the device clk to the
clock framework in the acpi_lpss.c. But I encounter some problems when
add the AMD i2c clk to the clock framework.
In acpi_lpss.c, as the patch d6ddaaac8f5c37ad84d said, When the
CONFIG_X86_INTEL_LPSS is not defined, then only add the device ID
list, but not implement the callbacks like "attach =
acpi_lpss_create_device" , so if
CONFIG_X86_INTEL_LPSS is not defined, will not create clk dev.

So there will be some problems when I add the AMD i2c clk to the clock
framework.
if I do not define CONFIG_X86_INTEL_LPSS, then even though I add the IDs and
lpss_device_desc struct into the acpi_lpss.c, the AMD i2c clk will
also can not  be added into the clock framework. But if I add the AMD
i2c related IDs and struct in the CONFIG_X86_INTEL_LPSS, it may cause
some misunderstand in the future, it is a AMD device, why is it put
into the CONFIG_X86_INTEL_LPSS branch.

So, Could you please give some suggestions to me?
Which should I choose?
Add the AMD i2c clk IDs and related lpss_device_desc into the
CONFIG_X86_INTEL_LPSS branch, or re-write a new branch by imitating
the
CONFIG_X86_INTEL_LPSS branch  included by CONFIG_AMD_INTEL_LPSS.

Thank you,
Carl

On Thu, Sep 4, 2014 at 8:50 PM, Mika Westerberg
<mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> On Thu, Sep 04, 2014 at 08:30:05PM +0800, Carl Peng wrote:
>> AMD i2c bus controller is ACPI device, its ACPI ID
>> is "AMD0010". This patch is used to add support for
>> AMD i2c bus controller in the Designware platfrom
>> driver.
>>
>> Signed-off-by: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-designware-core.h    |  1 +
>>  drivers/i2c/busses/i2c-designware-platdrv.c | 35 +++++++++++++++++++++++------
>>  2 files changed, 29 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
>> index d66b6cb..7a0a56e 100644
>> --- a/drivers/i2c/busses/i2c-designware-core.h
>> +++ b/drivers/i2c/busses/i2c-designware-core.h
>> @@ -105,6 +105,7 @@ struct dw_i2c_dev {
>>       u16                     ss_lcnt;
>>       u16                     fs_hcnt;
>>       u16                     fs_lcnt;
>> +     u32                     vendor;
>
> Not needed.
>
>>  };
>>
>>  #define ACCESS_SWAP          0x00000001
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index bc87733..f0556c4 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -43,16 +43,26 @@
>>  #include <linux/acpi.h>
>>  #include "i2c-designware-core.h"
>>
>> +#define AMD_CLK_KHZ          (133 * 1000)
>> +#define AMD_I2C_ACPI_ID              "AMD0010"
>> +#define VENDOR_ID_AMD                0x1022
>> +
>>  static struct i2c_algorithm i2c_dw_algo = {
>>       .master_xfer    = i2c_dw_xfer,
>>       .functionality  = i2c_dw_func,
>>  };
>> +
>
> Unrelated change.
>
>>  static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
>>  {
>>       return clk_get_rate(dev->clk)/1000;
>>  }
>>
>>  #ifdef CONFIG_ACPI
>> +static u32 i2c_amd_get_clk_rate_khz(struct dw_i2c_dev *dev)
>> +{
>> +     return AMD_CLK_KHZ;
>> +}
>
> No, use clock framework to pass correct clock rate to the driver.
>
>> +
>>  static void dw_i2c_acpi_params(struct platform_device *pdev, char method[],
>>                              u16 *hcnt, u16 *lcnt, u32 *sda_hold)
>>  {
>> @@ -107,6 +117,7 @@ static const struct acpi_device_id dw_i2c_acpi_match[] = {
>>       { "INT3433", 0 },
>>       { "80860F41", 0 },
>>       { "808622C1", 0 },
>> +     { AMD_I2C_ACPI_ID, 0 },
>
> Please use "AMD0010" here.
>
>>       { }
>>  };
>>  MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
>> @@ -134,6 +145,9 @@ static int dw_i2c_probe(struct platform_device *pdev)
>>       if (!dev)
>>               return -ENOMEM;
>>
>> +     if (!strncmp(AMD_I2C_ACPI_ID, pdev->name, strlen(AMD_I2C_ACPI_ID)))
>> +             dev->vendor = VENDOR_ID_AMD;
>> +
>
> This and rest of the hunks can be then dropped once you pass clocks
> using clock framework. See how we do it for Intel LPSS devices in
> drivers/acpi/acpi_lpss.c
>
>>       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>       dev->base = devm_ioremap_resource(&pdev->dev, mem);
>>       if (IS_ERR(dev->base))
>> @@ -145,12 +159,15 @@ static int dw_i2c_probe(struct platform_device *pdev)
>>       dev->irq = irq;
>>       platform_set_drvdata(pdev, dev);
>>
>> -     dev->clk = devm_clk_get(&pdev->dev, NULL);
>> -     dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
>> +     if (dev->vendor != VENDOR_ID_AMD) {
>> +             dev->clk = devm_clk_get(&pdev->dev, NULL);
>> +             dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
>>
>> -     if (IS_ERR(dev->clk))
>> -             return PTR_ERR(dev->clk);
>> -     clk_prepare_enable(dev->clk);
>> +             if (IS_ERR(dev->clk))
>> +                     return PTR_ERR(dev->clk);
>> +             clk_prepare_enable(dev->clk);
>> +     } else
>> +             dev->get_clk_rate_khz = i2c_amd_get_clk_rate_khz;
>>
>>       if (pdev->dev.of_node) {
>>               u32 ht = 0;
>> @@ -255,7 +272,9 @@ static int dw_i2c_suspend(struct device *dev)
>>       struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
>>
>>       i2c_dw_disable(i_dev);
>> -     clk_disable_unprepare(i_dev->clk);
>> +
>> +     if (i_dev->vendor != VENDOR_ID_AMD)
>> +             clk_disable_unprepare(i_dev->clk);
>>
>>       return 0;
>>  }
>> @@ -265,7 +284,9 @@ static int dw_i2c_resume(struct device *dev)
>>       struct platform_device *pdev = to_platform_device(dev);
>>       struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
>>
>> -     clk_prepare_enable(i_dev->clk);
>> +     if (i_dev->vendor != VENDOR_ID_AMD)
>> +             clk_prepare_enable(i_dev->clk);
>> +
>>       i2c_dw_init(i_dev);
>>
>>       return 0;
>> --
>> 1.9.1
