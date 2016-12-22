From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [v1] i2c: busses: i2c-designware-pcidrv:- Handle return NULL
 error from pcim_iomap_table
Date: Thu, 22 Dec 2016 16:35:09 +0200
Message-ID: <1482417309.9552.128.camel@linux.intel.com>
References: <1482406759-13094-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45465 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933162AbcLVOfN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Dec 2016 09:35:13 -0500
In-Reply-To: <1482406759-13094-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, jarkko.nikula@linux.intel.com, wsa@the-dreams.de
Cc: mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2016-12-22 at 17:09 +0530, Arvind Yadav wrote:
> Here, If pcim_iomap_table will fail. It will return NULL.
> Kernel can run into a NULL-pointer dereference.
> This error check will avoid NULL pointer dereference.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c
> b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index d6423cf..6a1907d 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -235,6 +235,10 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
>  	dev->controller = controller;
>  	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
>  	dev->base = pcim_iomap_table(pdev)[0];
> +	if (!dev->base) {
> +		dev_err(&pdev->dev, "I/O map table allocation
> failed\n");
> +		return -ENOMEM;
> +	}

NAK.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
