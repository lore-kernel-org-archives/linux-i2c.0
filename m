From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/2] i2c: designware: Print clock freq on invalid
 clock freq error
Date: Sun, 16 Jul 2017 17:02:01 +0300
Message-ID: <1500213721.29303.17.camel@linux.intel.com>
References: <20170713134502.10816-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:23065 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751809AbdGPOFE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 16 Jul 2017 10:05:04 -0400
In-Reply-To: <20170713134502.10816-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org

On Thu, 2017-07-13 at 15:45 +0200, Hans de Goede wrote:
> When we refuse to probe due to an invalid clock frequency, log
> the frequency which is causing this error.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---
> Changes in v2:
> -Also fix the message missing a \n at the end
> Changes in v3:
> -Rebase on latest upstream master (adjust for s/r/ret/)
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 2ea6d0d25a01..d139b156f9c9 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -319,7 +319,8 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  	if (dev->clk_freq != 100000 && dev->clk_freq != 400000
>  	    && dev->clk_freq != 1000000 && dev->clk_freq != 3400000)
> {
>  		dev_err(&pdev->dev,
> -			"Only 100kHz, 400kHz, 1MHz and 3.4MHz
> supported");
> +			"%d Hz is unsupported, only 100kHz, 400kHz,
> 1MHz and 3.4MHz are supported\n",
> +			dev->clk_freq);
>  		ret = -EINVAL;
>  		goto exit_reset;
>  	}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
