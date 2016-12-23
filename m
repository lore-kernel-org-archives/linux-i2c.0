From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [v1] i2c: busses: i2c-designware-pcidrv:- Unmap region obtained
 by pcim_iomap_regions
Date: Fri, 23 Dec 2016 13:55:21 +0200
Message-ID: <1482494121.9552.144.camel@linux.intel.com>
References: <1482487893-17589-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:53691 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbcLWLzZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Dec 2016 06:55:25 -0500
In-Reply-To: <1482487893-17589-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, jarkko.nikula@linux.intel.com, wsa@the-dreams.de, mika.westerberg@linux.intel.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2016-12-23 at 15:41 +0530, Arvind Yadav wrote:
> Release IO memory mapping, if i2c_dw_pci_probe is not successful.
> 

Second NAK, and seems (due to kbot message) you didn't even bother to
compile test.

What are you doing?

> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c
> b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index d6423cf..75e6e27 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -228,8 +228,10 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
>  	}
>  
>  	dev = devm_kzalloc(&pdev->dev, sizeof(struct dw_i2c_dev),
> GFP_KERNEL);
> -	if (!dev)
> -		return -ENOMEM;
> +	if (!dev) {
> +		r = -ENOMEM;
> +		goto error;
> +	}
>  
>  	dev->clk = NULL;
>  	dev->controller = controller;
> @@ -241,7 +243,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
>  	if (controller->setup) {
>  		r = controller->setup(pdev, controller);
>  		if (r)
> -			return r;
> +			goto error;
>  	}
>  
>  	dev->functionality = controller->functionality |
> @@ -270,7 +272,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
>  
>  	r = i2c_dw_probe(dev);
>  	if (r)
> -		return r;
> +		goto error;
>  
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
>  	pm_runtime_use_autosuspend(&pdev->dev);
> @@ -278,6 +280,8 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
>  	pm_runtime_allow(&pdev->dev);
>  
>  	return 0;
> +error:
> +	pcim_iounmap_regions(pdev, 1 << 0);
>  }
>  
>  static void i2c_dw_pci_remove(struct pci_dev *pdev)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
