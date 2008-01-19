From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 1/2] i2c: check for i2c_add_adapter() failures
Date: Sat, 19 Jan 2008 20:55:26 +0100
Message-ID: <20080119205526.214f3f2b@hyperion.delvare>
References: <200801041336.33058.bjorn.helgaas@hp.com>
	<200801041337.54913.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801041337.54913.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
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

On Fri, 4 Jan 2008 13:37:54 -0700, Bjorn Helgaas wrote:
> Check for i2c_add_adapter() failure so we can release resources before the
> driver is unloaded.  I copied the strategy from i2c-ali1563.c.

This patch also changes the log message on device registration error
for many (most?) drivers in an attempt to make them all look alike,
right? This should at least be mentioned in the patch summary. Ideally
this should even be a separate patch...

> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> 
> ---
>  drivers/i2c/busses/i2c-ali1535.c |   38 +++++++++++++++++++++++---------------
>  drivers/i2c/busses/i2c-ali1563.c |    2 +-
>  drivers/i2c/busses/i2c-ali15x3.c |   26 +++++++++++++++++++-------
>  drivers/i2c/busses/i2c-amd756.c  |    3 +--
>  drivers/i2c/busses/i2c-amd8111.c |    1 +
>  drivers/i2c/busses/i2c-i801.c    |    5 ++---
>  drivers/i2c/busses/i2c-nforce2.c |    2 +-
>  drivers/i2c/busses/i2c-pasemi.c  |    1 +
>  drivers/i2c/busses/i2c-piix4.c   |    2 +-
>  drivers/i2c/busses/i2c-sis5595.c |    1 +
>  drivers/i2c/busses/i2c-sis630.c  |   24 ++++++++++++++++++------
>  drivers/i2c/busses/i2c-sis96x.c  |   18 +++++++++++-------
>  drivers/i2c/busses/i2c-viapro.c  |    3 ++-
>  drivers/i2c/busses/scx200_acb.c  |    4 ++--
>  14 files changed, 84 insertions(+), 46 deletions(-)

I'm worried that there are many unrelated changes in your patch. For
example...

> 
> Index: work3/drivers/i2c/busses/i2c-ali1535.c
> ===================================================================
> --- work3.orig/drivers/i2c/busses/i2c-ali1535.c	2008-01-04 11:44:46.000000000 -0700
> +++ work3/drivers/i2c/busses/i2c-ali1535.c	2008-01-04 13:25:01.000000000 -0700
> @@ -141,7 +141,6 @@
>     defined to make the transition easier. */
>  static int ali1535_setup(struct pci_dev *dev)
>  {
> -	int retval = -ENODEV;
>  	unsigned char temp;
>  
>  	/* Check the following things:
> @@ -156,14 +155,14 @@
>  	if (ali1535_smba == 0) {
>  		dev_warn(&dev->dev,
>  			"ALI1535_smb region uninitialized - upgrade BIOS?\n");
> -		goto exit;
> +		return -ENODEV;
>  	}
>  
>  	if (!request_region(ali1535_smba, ALI1535_SMB_IOSIZE,
>  			    ali1535_driver.name)) {
>  		dev_err(&dev->dev, "ALI1535_smb region 0x%x already in use!\n",
>  			ali1535_smba);
> -		goto exit;
> +		return -ENODEV;
>  	}
>  
>  	/* check if whole device is enabled */
> @@ -193,14 +192,16 @@
>  	pci_read_config_byte(dev, SMBREV, &temp);
>  	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
>  	dev_dbg(&dev->dev, "ALI1535_smba = 0x%X\n", ali1535_smba);
> -
> -	retval = 0;
> -exit:
> -	return retval;
> +	return 0;
>  
>  exit_free:
>  	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
> -	return retval;
> +	return -ENODEV;
> +}

... This change isn't fixing any bug, right? It looks like a simple
cleanup to me.

> +
> +static void ali1535_shutdown(struct pci_dev *dev)
> +{
> +	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
>  }

Same for this function, it's just a different way to organize the same
code, and I don't see much benefit.

>  
>  static int ali1535_transaction(struct i2c_adapter *adap)
> @@ -488,24 +489,31 @@
>  
>  static int __devinit ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
> -	if (ali1535_setup(dev)) {
> -		dev_warn(&dev->dev,
> -			"ALI1535 not detected, module not inserted.\n");
> -		return -ENODEV;
> -	}
> +	int error;
> +
> +	if ((error = ali1535_setup(dev)))
> +		goto exit;
>  
>  	/* set up the sysfs linkage to our parent device */
>  	ali1535_adapter.dev.parent = &dev->dev;
>  
>  	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),
>  		"SMBus ALI1535 adapter at %04x", ali1535_smba);
> -	return i2c_add_adapter(&ali1535_adapter);
> +	if ((error = i2c_add_adapter(&ali1535_adapter)))
> +		goto exit_shutdown;
> +	return 0;
> +
> +exit_shutdown:
> +	ali1535_shutdown(dev);
> +exit:
> +	dev_err(&dev->dev, "SMBus probe failed (%d)\n", error);
> +	return error;
>  }

While this is a real bug fix...

>  
>  static void __devexit ali1535_remove(struct pci_dev *dev)
>  {
>  	i2c_del_adapter(&ali1535_adapter);
> -	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
> +	ali1535_shutdown(dev);
>  }
>  
>  static struct pci_driver ali1535_driver = {

When changing many drivers at once you really can't add unrelated
cleanups, otherwise it becomes very hard to review. Please remove all
the unrelated cleanups / arbitrary changes from this patch.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
