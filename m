From: carl peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c-designware: Add suport for AMD i2c controller
Date: Mon, 15 Sep 2014 19:58:29 +0800
Message-ID: <CAC5e1FoA5g7dGuWbjjafirzXFrk+zCR3eegmgizTmYp2B1tNsQ@mail.gmail.com>
References: <1409833805-1574-1-git-send-email-carlpeng008@gmail.com>
	<20140904125029.GD3632@lahna.fi.intel.com>
	<CAC5e1Fppiin2OczBUeyACOijWN3DocUKcRJKw31G+8-zX+mxpg@mail.gmail.com>
	<20140905093601.GQ3632@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140905093601.GQ3632-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Mika,

Excuse me, Could I consult one more question with you?
Could I add the AMD i2c controller private data like clk rate in the
platform_driver-->id_table but not in the
platform_driver-->acpi_match_table? The cause is as follow:


As you suggestion, I try to pass the clock rate in the ->driver_data,
so I add a line in the
dw_i2c_acpi_match[] array (drivers/i2c/busses/i2c-designware-platdrv.c):

       static const struct acpi_device_id dw_i2c_acpi_match[] = {
                      ...
                      { "AMD0010", (unsigned long)&amd_i2c_config}
                      ...
       }
       define the clock rate as a member of the amd_i2c_config structure.

But I find that I can not pass the clock rate by this way, since when
platform device match with with platform driver,
The driver_data of platform_driver-->acpi_match_table will not be
assigned to pdev->id_entry,
just the driver_data of platform_driver-->id_table will be assigned to
pdev->id_entry, as you know, AMD i2c controller
is a ACPI device, should use platform_driver-->acpi_match_table not
platform_driver-->id_table.

platform_match(drivers/base/platform.c)
|
acpi_driver_match_device(dev, drv)
|
return !!acpi_match_device(drv->acpi_match_table, dev);
|
return __acpi_match_device(adev, ids)(drivers/acpi/scan.c)
|
return id
Just return id, but will not assign id to pdev->id_entry.

Really expect your suggestion!
Thanks a lot!

Carl

On Fri, Sep 5, 2014 at 5:36 PM, Mika Westerberg
<mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> On Fri, Sep 05, 2014 at 03:19:50PM +0800, carl peng wrote:
>> Hi Mika,
>>
>> Could I consult a problem with you?
>
> Sure.
>
>>
>> As you suggest, there are some samples that add the device clk to the
>> clock framework in the acpi_lpss.c. But I encounter some problems when
>> add the AMD i2c clk to the clock framework.
>> In acpi_lpss.c, as the patch d6ddaaac8f5c37ad84d said, When the
>> CONFIG_X86_INTEL_LPSS is not defined, then only add the device ID
>> list, but not implement the callbacks like "attach =
>> acpi_lpss_create_device" , so if
>> CONFIG_X86_INTEL_LPSS is not defined, will not create clk dev.
>>
>> So there will be some problems when I add the AMD i2c clk to the clock
>> framework.
>> if I do not define CONFIG_X86_INTEL_LPSS, then even though I add the IDs and
>> lpss_device_desc struct into the acpi_lpss.c, the AMD i2c clk will
>> also can not  be added into the clock framework. But if I add the AMD
>> i2c related IDs and struct in the CONFIG_X86_INTEL_LPSS, it may cause
>> some misunderstand in the future, it is a AMD device, why is it put
>> into the CONFIG_X86_INTEL_LPSS branch.
>>
>> So, Could you please give some suggestions to me?
>> Which should I choose?
>> Add the AMD i2c clk IDs and related lpss_device_desc into the
>> CONFIG_X86_INTEL_LPSS branch, or re-write a new branch by imitating
>> the
>> CONFIG_X86_INTEL_LPSS branch  included by CONFIG_AMD_INTEL_LPSS.
>
> Since the AMD part is probably too different from Intel LPSS devices, I
> would rather not add it there. So you have two options AFAICT:
>
>  1) Add the clock in drivers/acpi/acpi_platform.c
>  2) Create custom i2c_get_clk_rate_khz() in the driver, just like in
>     this patch but drop all the unnecessary vendor etc. dance.
>
> For the 2) you could pass the clock rate in ->driver_data and if it is
> non-zero, setup a custom clock rate function that then uses the value
> from ->driver_data or so.
>
> Not sure if Wolfram likes that but we don't have too many places in x86
> world where we can create clocks :-(
