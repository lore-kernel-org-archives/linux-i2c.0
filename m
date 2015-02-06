From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: i801: Use managed devm_* memory and irq
 allocation
Date: Fri, 6 Feb 2015 15:51:38 +0100
Message-ID: <20150206155138.348efaa3@endymion.delvare>
References: <1423231013-29514-1-git-send-email-jarkko.nikula@linux.intel.com>
	<1423231013-29514-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423231013-29514-2-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jarkko,

On Fri,  6 Feb 2015 15:56:53 +0200, Jarkko Nikula wrote:
> This simplifies the error and remove paths.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-i801.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index e31aa987b281..b4369d1835ca 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1138,7 +1138,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	int err, i;
>  	struct i801_priv *priv;
>  
> -	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	priv = devm_kzalloc(&dev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> @@ -1252,8 +1252,9 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (priv->features & FEATURE_IRQ) {
>  		init_waitqueue_head(&priv->waitq);
>  
> -		err = request_irq(dev->irq, i801_isr, IRQF_SHARED,
> -				  dev_driver_string(&dev->dev), priv);
> +		err = devm_request_irq(&dev->dev, dev->irq, i801_isr,
> +				       IRQF_SHARED,
> +				       dev_driver_string(&dev->dev), priv);
>  		if (err) {
>  			dev_err(&dev->dev, "Failed to allocate irq %d: %d\n",
>  				dev->irq, err);
> @@ -1274,7 +1275,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	err = i2c_add_adapter(&priv->adapter);
>  	if (err) {
>  		dev_err(&dev->dev, "Failed to add SMBus adapter\n");
> -		goto exit_free_irq;
> +		goto exit_release;
>  	}
>  
>  	i801_probe_optional_slaves(priv);
> @@ -1285,12 +1286,9 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  
>  	return 0;
>  
> -exit_free_irq:
> -	if (priv->features & FEATURE_IRQ)
> -		free_irq(dev->irq, priv);
> +exit_release:
>  	pci_release_region(dev, SMBBAR);
>  exit:
> -	kfree(priv);
>  	return err;
>  }
>  
> @@ -1302,11 +1300,8 @@ static void i801_remove(struct pci_dev *dev)
>  	i2c_del_adapter(&priv->adapter);
>  	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
>  
> -	if (priv->features & FEATURE_IRQ)
> -		free_irq(dev->irq, priv);
>  	pci_release_region(dev, SMBBAR);
>  
> -	kfree(priv);
>  	/*
>  	 * do not call pci_disable_device(dev) since it can cause hard hangs on
>  	 * some systems during power-off (eg. Fujitsu-Siemens Lifebook E8010)

Looks good, but what about also converting pci_request_region to
devm_request_region?

-- 
Jean Delvare
SUSE L3 Support
