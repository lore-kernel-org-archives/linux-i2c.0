From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [v1] i2c: busses: i2c-designware-pcidrv:- Handle return NULL
 error from pcim_iomap_table
Date: Thu, 22 Dec 2016 13:50:33 +0200
Message-ID: <20161222115033.GO1460@lahna.fi.intel.com>
References: <1482406759-13094-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:35669 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756443AbcLVLvD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Dec 2016 06:51:03 -0500
Content-Disposition: inline
In-Reply-To: <1482406759-13094-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: jarkko.nikula@linux.intel.com, wsa@the-dreams.de, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 22, 2016 at 05:09:19PM +0530, Arvind Yadav wrote:
> Here, If pcim_iomap_table will fail. It will return NULL.
> Kernel can run into a NULL-pointer dereference.
> This error check will avoid NULL pointer dereference.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index d6423cf..6a1907d 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -235,6 +235,10 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
>  	dev->controller = controller;
>  	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
>  	dev->base = pcim_iomap_table(pdev)[0];
> +	if (!dev->base) {
> +		dev_err(&pdev->dev, "I/O map table allocation failed\n");
> +		return -ENOMEM;

Are you sure this can actually happen?

IIRC pcim_iomap_regions() (which is called before this) makes sure the
BARs you access here are valid.
