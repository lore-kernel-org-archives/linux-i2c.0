From: Jukka Laitinen <jukka.laitinen@intel.com>
Subject: Re: [PATCH] i2c: designware: Avoid aborted transfers with fast
 reacting I2C slaves
Date: Fri, 30 Sep 2016 10:05:03 +0300
Message-ID: <1e31f11c-70d8-e4a1-275c-0adc91d239bd@intel.com>
References: <20160929130459.11345-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vs14.mail.saunalahti.fi ([62.142.117.201]:33814 "EHLO
        vs14.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbcI3HOT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 30 Sep 2016 03:14:19 -0400
In-Reply-To: <20160929130459.11345-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On 29.09.2016 16:04, Jarkko Nikula wrote:
> By the specification SDA RX hold time extends incoming SDA low to high
> transition by n * ic_clk cycles but only when SCL is high. However it
> seems to help avoid above faulty arbitration lost error.
> 
> Bits 23:16 in IC_SDA_HOLD register define the SDA RX hold time for the
> receiver. Be conservative and enable 1 ic_clk cycle long hold time in
> case boot firmware hasn't set it up.
> 
> Reported-by: Jukka Laitinen <jukka.laitinen@intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 1fe93c43215c..11e866d05368 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -95,6 +95,9 @@
>  #define DW_IC_STATUS_TFE		BIT(2)
>  #define DW_IC_STATUS_MST_ACTIVITY	BIT(5)
>  
> +#define DW_IC_SDA_HOLD_RX_SHIFT		16
> +#define DW_IC_SDA_HOLD_RX_MASK		GENMASK(23, DW_IC_SDA_HOLD_RX_SHIFT)
> +
>  #define DW_IC_ERR_TX_ABRT	0x1
>  
>  #define DW_IC_TAR_10BITADDR_MASTER BIT(12)
> @@ -420,12 +423,20 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  	/* Configure SDA Hold Time if required */
>  	reg = dw_readl(dev, DW_IC_COMP_VERSION);
>  	if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
> -		if (dev->sda_hold_time) {
> -			dw_writel(dev, dev->sda_hold_time, DW_IC_SDA_HOLD);
> -		} else {
> +		if (!dev->sda_hold_time) {
>  			/* Keep previous hold time setting if no one set it */
>  			dev->sda_hold_time = dw_readl(dev, DW_IC_SDA_HOLD);
>  		}
> +		/*
> +		 * Workaround for avoiding TX arbitration lost in case I2C
> +		 * slave pulls SDA down "too quickly" after falling egde of
> +		 * SCL by enabling non-zero SDA RX hold. Specification says it
> +		 * extends incoming SDA low to high transition while SCL is
> +		 * high but it apprears to help also above issue.
> +		 */
> +		if (!(dev->sda_hold_time & DW_IC_SDA_HOLD_RX_MASK))
> +			dev->sda_hold_time |= 1 << DW_IC_SDA_HOLD_RX_SHIFT;
> +		dw_writel(dev, dev->sda_hold_time, DW_IC_SDA_HOLD);
>  	} else {
>  		dev_warn(dev->dev,
>  			"Hardware too old to adjust SDA hold time.\n");
> 

Tested-by: Jukka Laitinen <jukka.laitinen@intel.com>

Tested with kabylake cpu and Ubuntu 16.04 + kernel 4.8-rc6 + ubuntu
sauce from http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.8-rc6/

Regards,
Jukka Laitinen
