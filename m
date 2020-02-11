From: Thor Thayer <thor.thayer@linux.intel.com>
Subject: Re: [PATCH v2] i2c: altera: Fix potential integer overflow
Date: Tue, 11 Feb 2020 13:54:29 -0600
Message-ID: <4e1127bc-a4f2-fea2-225f-dfb00f0b5a10@linux.intel.com>
References: <20200211144704.GA6461@embeddedor>
Reply-To: thor.thayer@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40698 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730182AbgBKTwW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 11 Feb 2020 14:52:22 -0500
In-Reply-To: <20200211144704.GA6461@embeddedor>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, David Laight <David.Laight@ACULAB.COM>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On 2/11/20 8:47 AM, Gustavo A. R. Silva wrote:
> Factor out 100 from the equation and do 32-bit arithmetic (3 * clk_mhz / 10)
> instead of 64-bit.
> 
> Notice that clk_mhz is MHz, so the multiplication will never wrap 32 bits
> and there is no need for div_u64().
> 
> Addresses-Coverity: 1458369 ("Unintentional integer overflow")
> Fixes: 0560ad576268 ("i2c: altera: Add Altera I2C Controller driver")
> Suggested-by: David Laight <David.Laight@ACULAB.COM>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>   - Update subject and changelog text.
>   - Avoid the need for 64-bit arithmetic at all.
> 
>   drivers/i2c/busses/i2c-altera.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-altera.c b/drivers/i2c/busses/i2c-altera.c
> index 5255d3755411..1de23b4f3809 100644
> --- a/drivers/i2c/busses/i2c-altera.c
> +++ b/drivers/i2c/busses/i2c-altera.c
> @@ -171,7 +171,7 @@ static void altr_i2c_init(struct altr_i2c_dev *idev)
>   	/* SCL Low Time */
>   	writel(t_low, idev->base + ALTR_I2C_SCL_LOW);
>   	/* SDA Hold Time, 300ns */
> -	writel(div_u64(300 * clk_mhz, 1000), idev->base + ALTR_I2C_SDA_HOLD);
> +	writel(3 * clk_mhz / 10, idev->base + ALTR_I2C_SDA_HOLD);
>   
>   	/* Mask all master interrupt bits */
>   	altr_i2c_int_enable(idev, ALTR_I2C_ALL_IRQ, false);
> 
Reviewed-by: Thor Thayer <thor.thayer@linux.intel.com>
