From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [PATCH] i2c: designware: Don't set SCL timings and speed mode
 when in slave mode
Date: Wed, 22 Nov 2017 11:15:53 +0000
Message-ID: <345affbc-a4af-9396-8d2e-8f24e4f2a8f7@synopsys.com>
References: <20170823134612.26117-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:48332 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdKVLQK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 22 Nov 2017 06:16:10 -0500
In-Reply-To: <20170823134612.26117-1-jarkko.nikula@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Luis Oliveira <Luis.Oliveira@synopsys.com>, Joao Pinto <Joao.Pinto@synopsys.com>Wolfram Sang <wsa@the-dreams.de>

Hi Jarkko,

Sorry for making you wait so long but finally I've got my setup back.
I tested it and everything works fine.

On 23-Aug-17 14:46, Jarkko Nikula wrote:
> According to data sheet SCL timing parameters and DW_IC_CON SPEED mode
> bits are not used when operating in slave mode.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> I've done quick testing with i2c-slave-eeprom and i2cdump over together
> hooked busses without issues. Would like to hear tested by or comment
> from Luis though. Patch is not urgent so can wait after vacation etc.
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 11 -----
>  drivers/i2c/busses/i2c-designware-slave.c   | 64 -----------------------------
>  2 files changed, 75 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 56a17fdc2270..962c7ab25b93 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -201,17 +201,6 @@ static void i2c_dw_configure_slave(struct dw_i2c_dev *dev)
>  			 DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED;
>  
>  	dev->mode = DW_IC_SLAVE;
> -
> -	switch (dev->clk_freq) {
> -	case 100000:
> -		dev->slave_cfg |= DW_IC_CON_SPEED_STD;
> -		break;
> -	case 3400000:
> -		dev->slave_cfg |= DW_IC_CON_SPEED_HIGH;
> -		break;
> -	default:
> -		dev->slave_cfg |= DW_IC_CON_SPEED_FAST;
> -	}
>  }
>  
>  static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool prepare)
> diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
> index ea9578ab19a1..d42558d1b002 100644
> --- a/drivers/i2c/busses/i2c-designware-slave.c
> +++ b/drivers/i2c/busses/i2c-designware-slave.c
> @@ -51,9 +51,7 @@ static void i2c_dw_configure_fifo_slave(struct dw_i2c_dev *dev)
>   */
>  static int i2c_dw_init_slave(struct dw_i2c_dev *dev)
>  {
> -	u32 sda_falling_time, scl_falling_time;
>  	u32 reg, comp_param1;
> -	u32 hcnt, lcnt;
>  	int ret;
>  
>  	ret = i2c_dw_acquire_lock(dev);
> @@ -79,68 +77,6 @@ static int i2c_dw_init_slave(struct dw_i2c_dev *dev)
>  	/* Disable the adapter. */
>  	__i2c_dw_enable_and_wait(dev, false);
>  
> -	/* Set standard and fast speed deviders for high/low periods. */
> -	sda_falling_time = dev->sda_falling_time ?: 300; /* ns */
> -	scl_falling_time = dev->scl_falling_time ?: 300; /* ns */
> -
> -	/* Set SCL timing parameters for standard-mode. */
> -	if (dev->ss_hcnt && dev->ss_lcnt) {
> -		hcnt = dev->ss_hcnt;
> -		lcnt = dev->ss_lcnt;
> -	} else {
> -		hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
> -				       4000,	/* tHD;STA = tHIGH = 4.0 us */
> -				       sda_falling_time,
> -				       0,	/* 0: DW default, 1: Ideal */
> -				       0);	/* No offset */
> -		lcnt = i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
> -				       4700,	/* tLOW = 4.7 us */
> -				       scl_falling_time,
> -				       0);	/* No offset */
> -	}
> -	dw_writel(dev, hcnt, DW_IC_SS_SCL_HCNT);
> -	dw_writel(dev, lcnt, DW_IC_SS_SCL_LCNT);
> -	dev_dbg(dev->dev, "Standard-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
> -
> -	/* Set SCL timing parameters for fast-mode or fast-mode plus. */
> -	if ((dev->clk_freq == 1000000) && dev->fp_hcnt && dev->fp_lcnt) {
> -		hcnt = dev->fp_hcnt;
> -		lcnt = dev->fp_lcnt;
> -	} else if (dev->fs_hcnt && dev->fs_lcnt) {
> -		hcnt = dev->fs_hcnt;
> -		lcnt = dev->fs_lcnt;
> -	} else {
> -		hcnt = i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
> -				       600,	/* tHD;STA = tHIGH = 0.6 us */
> -				       sda_falling_time,
> -				       0,	/* 0: DW default, 1: Ideal */
> -				       0);	/* No offset */
> -		lcnt = i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
> -				       1300,	/* tLOW = 1.3 us */
> -				       scl_falling_time,
> -				       0);	/* No offset */
> -	}
> -	dw_writel(dev, hcnt, DW_IC_FS_SCL_HCNT);
> -	dw_writel(dev, lcnt, DW_IC_FS_SCL_LCNT);
> -	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
> -
> -	if ((dev->slave_cfg & DW_IC_CON_SPEED_MASK) ==
> -		DW_IC_CON_SPEED_HIGH) {
> -		if ((comp_param1 & DW_IC_COMP_PARAM_1_SPEED_MODE_MASK)
> -			!= DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH) {
> -			dev_err(dev->dev, "High Speed not supported!\n");
> -			dev->slave_cfg &= ~DW_IC_CON_SPEED_MASK;
> -			dev->slave_cfg |= DW_IC_CON_SPEED_FAST;
> -		} else if (dev->hs_hcnt && dev->hs_lcnt) {
> -			hcnt = dev->hs_hcnt;
> -			lcnt = dev->hs_lcnt;
> -			dw_writel(dev, hcnt, DW_IC_HS_SCL_HCNT);
> -			dw_writel(dev, lcnt, DW_IC_HS_SCL_LCNT);
> -			dev_dbg(dev->dev, "HighSpeed-mode HCNT:LCNT = %d:%d\n",
> -				hcnt, lcnt);
> -		}
> -	}
> -
>  	/* Configure SDA Hold Time if required. */
>  	reg = dw_readl(dev, DW_IC_COMP_VERSION);
>  	if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
> 

Tested-by: Luis Oliveira <lolivei@synopsys.com>
