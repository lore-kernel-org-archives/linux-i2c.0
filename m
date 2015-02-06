From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: i801: Remove i801_driver forward declaration
Date: Fri, 6 Feb 2015 15:38:24 +0100
Message-ID: <20150206153824.123a8aa5@endymion.delvare>
References: <1423231013-29514-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423231013-29514-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jarkko,

On Fri,  6 Feb 2015 15:56:52 +0200, Jarkko Nikula wrote:
> struct pci_driver i801_driver forward declaration is needed only for
> accessing the name field. Remove it and use dev_driver_string() instead.

This will make the driver binary slightly larger but I can live with
that.

Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>

> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-i801.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 8fafb254e42a..e31aa987b281 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -223,8 +223,6 @@ struct i801_priv {
>  #endif
>  };
>  
> -static struct pci_driver i801_driver;
> -
>  #define FEATURE_SMBUS_PEC	(1 << 0)
>  #define FEATURE_BLOCK_BUFFER	(1 << 1)
>  #define FEATURE_BLOCK_PROC	(1 << 2)
> @@ -1204,7 +1202,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		goto exit;
>  	}
>  
> -	err = pci_request_region(dev, SMBBAR, i801_driver.name);
> +	err = pci_request_region(dev, SMBBAR, dev_driver_string(&dev->dev));
>  	if (err) {
>  		dev_err(&dev->dev, "Failed to request SMBus region "
>  			"0x%lx-0x%Lx\n", priv->smba,
> @@ -1255,7 +1253,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  		init_waitqueue_head(&priv->waitq);
>  
>  		err = request_irq(dev->irq, i801_isr, IRQF_SHARED,
> -				  i801_driver.name, priv);
> +				  dev_driver_string(&dev->dev), priv);
>  		if (err) {
>  			dev_err(&dev->dev, "Failed to allocate irq %d: %d\n",
>  				dev->irq, err);


-- 
Jean Delvare
SUSE L3 Support
