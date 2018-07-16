From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH/RFT 1/6] i2c: designware: use open drain for recovery GPIO
Date: Mon, 16 Jul 2018 08:47:37 +0800
Message-ID: <daaf702b-642f-e0fd-6a2e-7f0f817efba3@electromag.com.au>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
 <20180713210920.3648-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713210920.3648-2-wsa+renesas@sang-engineering.com>
Content-Language: en-AU
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 14/07/2018 05:09, Wolfram Sang wrote:
> I2C is open drain, so set up the GPIO accordingly.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   drivers/i2c/busses/i2c-designware-master.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
> index fc7c255c80af..a546db80f53e 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
> @@ -665,7 +665,7 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
>   	struct gpio_desc *gpio;
>   	int r;
>   
> -	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
> +	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
>   	if (IS_ERR(gpio)) {
>   		r = PTR_ERR(gpio);
>   		if (r == -ENOENT || r == -ENOSYS)
> 
G'day Wolfram,

This was intentional. The gpio we use to drive the i2c line is implemented in an
FPGA and signals a buffer attached to the GPIO to drive scl OPEN drain. The GPIO is output
only.
The gpio setup can still specify the the GPIO be allocated OPEN drain if someone wishes
to use a "smarter" gpio.

So while the scl is open drain, there may be hardware in between that isn't.
What would the correct way be to deal with that now?


-- 
Regards
Phil
