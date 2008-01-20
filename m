From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2/2] i2c: announce SMBus host controllers
Date: Sun, 20 Jan 2008 10:14:26 +0100
Message-ID: <20080120101426.06a0711a@hyperion.delvare>
References: <200801041336.33058.bjorn.helgaas@hp.com>
	<200801041338.39470.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801041338.39470.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Bjorn,

On Fri, 4 Jan 2008 13:38:39 -0700, Bjorn Helgaas wrote:
> Note where we find SMBus host controllers and what resources they use.
> 
> I tried to put these in the probe() methods just before returning success,
> but in some cases I put them in a setup() method instead to be closer to
> the request_resource() call.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> 
> ---
>  drivers/i2c/busses/i2c-ali1535.c |    5 +++--
>  drivers/i2c/busses/i2c-ali1563.c |    5 +++--
>  drivers/i2c/busses/i2c-ali15x3.c |    6 ++++--
>  drivers/i2c/busses/i2c-amd756.c  |    5 +++--
>  drivers/i2c/busses/i2c-amd8111.c |    3 +++
>  drivers/i2c/busses/i2c-i801.c    |   10 +++++-----
>  drivers/i2c/busses/i2c-nforce2.c |    4 +++-
>  drivers/i2c/busses/i2c-pasemi.c  |    2 ++
>  drivers/i2c/busses/i2c-piix4.c   |   14 +++++++++-----
>  drivers/i2c/busses/i2c-sis5595.c |    4 +++-
>  drivers/i2c/busses/i2c-sis630.c  |    5 ++++-
>  drivers/i2c/busses/i2c-sis96x.c  |    4 ++--
>  drivers/i2c/busses/i2c-via.c     |    3 +++
>  drivers/i2c/busses/i2c-viapro.c  |    3 +++
>  drivers/i2c/busses/scx200_acb.c  |   13 +++++++++++--
>  15 files changed, 61 insertions(+), 25 deletions(-)
> 

I'm mostly OK with this patch, with just the minor comments below:

> Index: work3/drivers/i2c/busses/i2c-i801.c
> ===================================================================
> --- work3.orig/drivers/i2c/busses/i2c-i801.c	2008-01-04 13:30:02.000000000 -0700
> +++ work3/drivers/i2c/busses/i2c-i801.c	2008-01-04 13:30:24.000000000 -0700
> @@ -605,11 +605,6 @@
>  	}
>  	pci_write_config_byte(I801_dev, SMBHSTCFG, temp);
>  
> -	if (temp & SMBHSTCFG_SMB_SMI_EN)
> -		dev_dbg(&dev->dev, "SMBus using interrupt SMI#\n");
> -	else
> -		dev_dbg(&dev->dev, "SMBus using PCI Interrupt\n");
> -
>  	/* set up the sysfs linkage to our parent device */
>  	i801_adapter.dev.parent = &dev->dev;
>  
> @@ -618,6 +613,11 @@
>  	err = i2c_add_adapter(&i801_adapter);
>  	if (err)
>  		goto exit_release;
> +
> +	dev_info(&dev->dev, "SMBus Host Controller at ioports 0x%lx-0x%lx "
> +		"using %s\n", i801_smba,
> +		(unsigned long) (i801_smba + pci_resource_len(dev, SMBBAR) - 1),
> +		temp & SMBHSTCFG_SMB_SMI_EN ? "SMI#" : "PCI interrupt");
>  	return 0;
>  
>  exit_release:

I am slightly worried that you are displaying interrupt configuration
information while the driver doesn't actually make use of interrupts
(which is why it was only a debug message so far.) This might make the
users believe that the driver is interrupt-driven, while it isn't.

Same goes for the i2c-piix4 driver. I'd rather leave the debug messages
about interrupt configuration alone to avoid any confusion.

> Index: work3/drivers/i2c/busses/i2c-nforce2.c
> ===================================================================
> --- work3.orig/drivers/i2c/busses/i2c-nforce2.c	2008-01-04 13:30:02.000000000 -0700
> +++ work3/drivers/i2c/busses/i2c-nforce2.c	2008-01-04 13:30:24.000000000 -0700
> @@ -335,7 +335,9 @@
>  		release_region(smbus->base, smbus->size);
>  		return -1;
>  	}
> -	dev_info(&smbus->adapter.dev, "nForce2 SMBus adapter at %#x\n", smbus->base);
> +
> +	dev_info(&smbus->adapter.dev, "SMBus Host Controller at ioports "
> +		"0x%x-0x%x\n", smbus->base, smbus->base+smbus->size-1);
>  	return 0;
>  }
>  

Note: this is the only driver that uses the i2c_adapter for the
dev_info() message, instead of the PCI device. You might want to "fix"
this so that the message looks the same for all drivers. Especially
since you removed the "nForce2" string from the message there is no way
to know which driver printed the message anymore.

> Index: work3/drivers/i2c/busses/i2c-sis630.c
> ===================================================================
> --- work3.orig/drivers/i2c/busses/i2c-sis630.c	2008-01-04 13:30:02.000000000 -0700
> +++ work3/drivers/i2c/busses/i2c-sis630.c	2008-01-04 13:30:24.000000000 -0700
> @@ -441,7 +441,10 @@
>  		goto exit;
>  	}
>  
> -	retval = 0;
> +	dev_info(&sis630_dev->dev, "SMBus Host Controller at ioports "
> +		"0x%x-0x%x\n", acpi_base + SMB_STS,
> +		acpi_base + SMB_STS + SIS630_SMB_IOREGION - 1);
> +	return 0;
>  
>  exit:
>  	if (retval)


Changing "retval = 0" into "return 0" is a half-done cleanup, making
the code even more confusing. Please don't change the code flow, if you
really want to clean up this function, that would be in a separate
patch.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
