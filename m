From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: enable High-speed mode for pcidrv
Date: Fri, 09 Oct 2015 12:31:07 +0300
Message-ID: <1444383067.8361.517.camel@linux.intel.com>
References: <1444380426-17953-1-git-send-email-wangxfdu@gmail.com>
	 <1444380426-17953-2-git-send-email-wangxfdu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444380426-17953-2-git-send-email-wangxfdu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wangxfdu@gmail.com, xiang.a.wang@intel.com, wsa@the-dreams.de, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2015-10-09 at 16:47 +0800, wangxfdu@gmail.com wrote:
> From: Xiang Wang <xiang.a.wang@intel.com>
> 
> 1. Support setting hs_hcnt and hs_lcnt
> 2. Get bus speed mode from ACPI companion of the
> i2c controller.
> 
> Signed-off-by: Xiang Wang <xiang.a.wang@intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c 
> b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index 6643d2d..0f4c0c4 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -54,8 +54,10 @@ enum dw_pci_ctl_id_t {
>  struct dw_scl_sda_cfg {
>  	u32 ss_hcnt;
>  	u32 fs_hcnt;
> +	u32 hs_hcnt;
>  	u32 ss_lcnt;
>  	u32 fs_lcnt;
> +	u32 hs_lcnt;
>  	u32 sda_hold;
>  };
>  
> @@ -237,8 +239,10 @@ static int i2c_dw_pci_probe(struct pci_dev 
> *pdev,
>  		cfg = controller->scl_sda_cfg;
>  		dev->ss_hcnt = cfg->ss_hcnt;
>  		dev->fs_hcnt = cfg->fs_hcnt;
> +		dev->hs_hcnt = cfg->hs_hcnt;
>  		dev->ss_lcnt = cfg->ss_lcnt;
>  		dev->fs_lcnt = cfg->fs_lcnt;
> +		dev->hs_lcnt = cfg->hs_lcnt;
>  		dev->sda_hold_time = cfg->sda_hold;
>  	}
>  
> @@ -246,6 +250,9 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
>  
>  	dev->tx_fifo_depth = controller->tx_fifo_depth;
>  	dev->rx_fifo_depth = controller->rx_fifo_depth;
> +
> +	i2c_dw_acpi_setup_speed(&pdev->dev, dev);

Don't see a relationship between PCI driver and this ACPI stuff.

> +
>  	r = i2c_dw_init(dev);
>  	if (r)
>  		return r;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
