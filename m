From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/1] i2c: designware-pcidrv: Add 10bit address feature
 to medfield/merrifield
Date: Wed, 30 Nov 2016 18:11:45 +0200
Message-ID: <1480522305.21899.54.camel@linux.intel.com>
References: <1480517310-28401-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7279 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758181AbcK3QLs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 30 Nov 2016 11:11:48 -0500
In-Reply-To: <1480517310-28401-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On Wed, 2016-11-30 at 15:48 +0100, Alexander Stein wrote:
> Both Merrifield TRM and Medfiel TRM state:

Typo here, should be Medfield

> "Both 7-bit and 10-bit addressing modes are supported."

Other that that
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c
> b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index 300802e7..d6423cf 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -141,6 +141,7 @@ static struct dw_pci_controller
> dw_pci_controllers[] = {
>  		.bus_cfg   = INTEL_MID_STD_CFG |
> DW_IC_CON_SPEED_FAST,
>  		.tx_fifo_depth = 32,
>  		.rx_fifo_depth = 32,
> +		.functionality = I2C_FUNC_10BIT_ADDR,
>  		.clk_khz      = 25000,
>  		.setup = mfld_setup,
>  	},
> @@ -149,6 +150,7 @@ static struct dw_pci_controller
> dw_pci_controllers[] = {
>  		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
>  		.tx_fifo_depth = 64,
>  		.rx_fifo_depth = 64,
> +		.functionality = I2C_FUNC_10BIT_ADDR,
>  		.scl_sda_cfg = &mrfld_config,
>  		.setup = mrfld_setup,
>  	},

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
