From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2] i2c-designware: Add suport for AMD i2c controller
Date: Mon, 15 Sep 2014 15:10:31 +0300
Message-ID: <20140915121031.GR10854@lahna.fi.intel.com>
References: <1409833805-1574-1-git-send-email-carlpeng008@gmail.com>
 <20140904125029.GD3632@lahna.fi.intel.com>
 <CAC5e1Fppiin2OczBUeyACOijWN3DocUKcRJKw31G+8-zX+mxpg@mail.gmail.com>
 <20140905093601.GQ3632@lahna.fi.intel.com>
 <CAC5e1FoA5g7dGuWbjjafirzXFrk+zCR3eegmgizTmYp2B1tNsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAC5e1FoA5g7dGuWbjjafirzXFrk+zCR3eegmgizTmYp2B1tNsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: carl peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 15, 2014 at 07:58:29PM +0800, carl peng wrote:
> Hi Mika,
> 
> Excuse me, Could I consult one more question with you?

Sure.

> Could I add the AMD i2c controller private data like clk rate in the
> platform_driver-->id_table but not in the
> platform_driver-->acpi_match_table? The cause is as follow:
> 
> 
> As you suggestion, I try to pass the clock rate in the ->driver_data,
> so I add a line in the
> dw_i2c_acpi_match[] array (drivers/i2c/busses/i2c-designware-platdrv.c):
> 
>        static const struct acpi_device_id dw_i2c_acpi_match[] = {
>                       ...
>                       { "AMD0010", (unsigned long)&amd_i2c_config}
>                       ...
>        }
>        define the clock rate as a member of the amd_i2c_config structure.
> 
> But I find that I can not pass the clock rate by this way, since when
> platform device match with with platform driver,
> The driver_data of platform_driver-->acpi_match_table will not be
> assigned to pdev->id_entry,
> just the driver_data of platform_driver-->id_table will be assigned to
> pdev->id_entry, as you know, AMD i2c controller
> is a ACPI device, should use platform_driver-->acpi_match_table not
> platform_driver-->id_table.
> 
> platform_match(drivers/base/platform.c)
> |
> acpi_driver_match_device(dev, drv)
> |
> return !!acpi_match_device(drv->acpi_match_table, dev);
> |
> return __acpi_match_device(adev, ids)(drivers/acpi/scan.c)
> |
> return id
> Just return id, but will not assign id to pdev->id_entry.

You can call acpi_match_device(dw_i2c_acpi_match, &pdev->dev) in the
driver and look up the id->driver_data from the returned pointer.
