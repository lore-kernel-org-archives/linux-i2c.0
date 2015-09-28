From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/6] i2c: ismt: improve usage of devres API
Date: Mon, 28 Sep 2015 13:45:32 +0300
Message-ID: <1443437132.8361.237.camel@linux.intel.com>
References: <1442413443-123579-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12611 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932297AbbI1Kro (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 28 Sep 2015 06:47:44 -0400
In-Reply-To: <1442413443-123579-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Neil Horman <nhorman@tuxdriver.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wed, 2015-09-16 at 17:23 +0300, Andy Shevchenko wrote:
> pcim_release() will release any requested region. There is no need to 
> duplicate
> this effort in the driver.

Any comments on that clean up series?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-ismt.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c
> -ismt.c
> index f994712..b7a68b5 100644
> --- a/drivers/i2c/busses/i2c-ismt.c
> +++ b/drivers/i2c/busses/i2c-ismt.c
> @@ -904,8 +904,7 @@ ismt_probe(struct pci_dev *pdev, const struct 
> pci_device_id *id)
>  	priv->smba = pcim_iomap(pdev, SMBBAR, len);
>  	if (!priv->smba) {
>  		dev_err(&pdev->dev, "Unable to ioremap SMBus 
> BAR\n");
> -		err = -ENODEV;
> -		goto fail;
> +		return -ENODEV;
>  	}
>  
>  	if ((pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) != 0) ||
> @@ -915,32 +914,26 @@ ismt_probe(struct pci_dev *pdev, const struct 
> pci_device_id *id)
>  						 DMA_BIT_MASK(32)) 
> != 0)) {
>  			dev_err(&pdev->dev, "pci_set_dma_mask fail 
> %p\n",
>  				pdev);
> -			err = -ENODEV;
> -			goto fail;
> +			return -ENODEV;
>  		}
>  	}
>  
>  	err = ismt_dev_init(priv);
>  	if (err)
> -		goto fail;
> +		return err;
>  
>  	ismt_hw_init(priv);
>  
>  	err = ismt_int_init(priv);
>  	if (err)
> -		goto fail;
> +		return err;
>  
>  	err = i2c_add_adapter(&priv->adapter);
>  	if (err) {
>  		dev_err(&pdev->dev, "Failed to add SMBus iSMT 
> adapter\n");
> -		err = -ENODEV;
> -		goto fail;
> +		return -ENODEV;
>  	}
>  	return 0;
> -
> -fail:
> -	pci_release_region(pdev, SMBBAR);
> -	return err;
>  }
>  
>  /**
> @@ -952,7 +945,6 @@ static void ismt_remove(struct pci_dev *pdev)
>  	struct ismt_priv *priv = pci_get_drvdata(pdev);
>  
>  	i2c_del_adapter(&priv->adapter);
> -	pci_release_region(pdev, SMBBAR);
>  }
>  
>  /**

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
