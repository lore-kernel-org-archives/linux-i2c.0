From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [Patch V3 0/5] I2C ACPI operation region handler
Date: Tue, 20 May 2014 23:25:46 +0200
Message-ID: <6169981.jIBZPeBvRE@vostro.rjw.lan>
References: <1400590764-11108-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400590764-11108-1-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday, May 20, 2014 08:59:19 PM Lan Tianyu wrote:
> ACPI 5.0 spec(5.5.2.4.5) defines GenericSerialBus(i2c, spi, uart) operation
> region. It allows ACPI aml code able to access such kind of devices to
> implement some ACPI standard method.
> 
> On the Asus T100TA, Bios use GenericSerialBus operation region to access
> i2c device to get battery info. So battery function depends on the I2C
> operation region support. Here is the bug link.
> https://bugzilla.kernel.org/show_bug.cgi?id=69011
> 
> Change since V2:
>         Drop patchs of adding I2C smbus quick read/write and word/block
> process call functions because not find machines supporting such protocols
> so far and can't test these functions.
>         Merge patchs of "I2C ACPI related code clear up" and "Add CONFIG_I2C_ACPI
> config"
> 	Patch 2: Add acpi_bus_detach_private_data() function to detach data from
> ACPI handle and replace ACPI_ERROR() with acpi_handle_debug() to avoid some redundant
> error log.  
> 
> Change since V1:
>        Fix some code style issues. Change prefix i2c_acpi to acpi_i2c.
> Move ACPI related code in the i2c core to i2c-acpi.c. Add CONFIG_I2C_ACPI
> and make i2c core built-in when it's set to avoid i2c ACPI operation region
> being removed.
> 
> Lan Tianyu (5):
>   ACPICA: Export acpi_buffer_to_resource symbol

Redundant?

>   ACPI: Add acpi_bus_attach_private_data() to facilitate to attach data
>     to ACPI handle
>   ACPI/Thermal: Use acpi_bus_attach_private_data() to attach private
>     data

I can take the above two regardless of the I2C material below I guess?

>   I2C/ACPI: Add i2c ACPI operation region support
>   I2C/ACPI: Clean up I2C ACPI code and Add CONFIG_I2C_ACPI config
> 
>  drivers/acpi/acpica/rscreate.c |   1 +
>  drivers/acpi/bus.c             |  28 +++-
>  drivers/acpi/thermal.c         |  11 +-
>  drivers/i2c/Kconfig            |  18 +-
>  drivers/i2c/Makefile           |   5 +-
>  drivers/i2c/i2c-acpi.c         | 362 +++++++++++++++++++++++++++++++++++++++++
>  drivers/i2c/i2c-core.c         |  97 +----------
>  include/acpi/acpi_bus.h        |   2 +
>  include/linux/acpi.h           |  11 ++
>  include/linux/i2c.h            |  12 ++
>  10 files changed, 439 insertions(+), 108 deletions(-)
>  create mode 100644 drivers/i2c/i2c-acpi.c
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
