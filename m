From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH v1 32/40] i2c: stm32f4: Use generic definitions for bus
 frequencies
Date: Mon, 2 Mar 2020 09:39:59 +0100
Message-ID: <b43ed1f1-70e8-8d6e-d013-8ceb62e64010@st.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
 <20200224151530.31713-32-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:2942 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727242AbgCBIkH (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 2 Mar 2020 03:40:07 -0500
In-Reply-To: <20200224151530.31713-32-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>

Hi

Look good to me.

Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Thanks

On 2/24/20 4:15 PM, Andy Shevchenko wrote:
> Since we have generic definitions for bus frequencies, let's use them.
> 
> Cc: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-stm32f4.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
> index ba600d77a3f8..0a67b44f2755 100644
> --- a/drivers/i2c/busses/i2c-stm32f4.c
> +++ b/drivers/i2c/busses/i2c-stm32f4.c
> @@ -91,7 +91,6 @@
>  #define STM32F4_I2C_MIN_STANDARD_FREQ	2U
>  #define STM32F4_I2C_MIN_FAST_FREQ	6U
>  #define STM32F4_I2C_MAX_FREQ		46U
> -#define HZ_TO_MHZ			1000000
>  
>  /**
>   * struct stm32f4_i2c_msg - client specific data
> @@ -154,7 +153,7 @@ static int stm32f4_i2c_set_periph_clk_freq(struct stm32f4_i2c_dev *i2c_dev)
>  	u32 cr2 = 0;
>  
>  	i2c_dev->parent_rate = clk_get_rate(i2c_dev->clk);
> -	freq = DIV_ROUND_UP(i2c_dev->parent_rate, HZ_TO_MHZ);
> +	freq = DIV_ROUND_UP(i2c_dev->parent_rate, HZ_PER_MHZ);
>  
>  	if (i2c_dev->speed == STM32_I2C_SPEED_STANDARD) {
>  		/*
> @@ -190,7 +189,7 @@ static int stm32f4_i2c_set_periph_clk_freq(struct stm32f4_i2c_dev *i2c_dev)
>  
>  static void stm32f4_i2c_set_rise_time(struct stm32f4_i2c_dev *i2c_dev)
>  {
> -	u32 freq = DIV_ROUND_UP(i2c_dev->parent_rate, HZ_TO_MHZ);
> +	u32 freq = DIV_ROUND_UP(i2c_dev->parent_rate, HZ_PER_MHZ);
>  	u32 trise;
>  
>  	/*
> @@ -243,7 +242,7 @@ static void stm32f4_i2c_set_speed_mode(struct stm32f4_i2c_dev *i2c_dev)
>  		 * parent rate is not higher than 46 MHz . As a result val
>  		 * is at most 8 bits wide and so fits into the CCR bits [11:0].
>  		 */
> -		val = i2c_dev->parent_rate / (100000 << 1);
> +		val = i2c_dev->parent_rate / (I2C_STANDARD_MODE_FREQ << 1);
>  	} else {
>  		/*
>  		 * In fast mode, we compute CCR with duty = 0 as with low
> @@ -263,7 +262,7 @@ static void stm32f4_i2c_set_speed_mode(struct stm32f4_i2c_dev *i2c_dev)
>  		 * parent rate is not higher than 46 MHz . As a result val
>  		 * is at most 6 bits wide and so fits into the CCR bits [11:0].
>  		 */
> -		val = DIV_ROUND_UP(i2c_dev->parent_rate, 400000 * 3);
> +		val = DIV_ROUND_UP(i2c_dev->parent_rate, I2C_FAST_MODE_FREQ * 3);
>  
>  		/* Select Fast mode */
>  		ccr |= STM32F4_I2C_CCR_FS;
> @@ -807,7 +806,7 @@ static int stm32f4_i2c_probe(struct platform_device *pdev)
>  
>  	i2c_dev->speed = STM32_I2C_SPEED_STANDARD;
>  	ret = of_property_read_u32(np, "clock-frequency", &clk_rate);
> -	if (!ret && clk_rate >= 400000)
> +	if (!ret && clk_rate >= I2C_FAST_MODE_FREQ)
>  		i2c_dev->speed = STM32_I2C_SPEED_FAST;
>  
>  	i2c_dev->dev = &pdev->dev;
> 
