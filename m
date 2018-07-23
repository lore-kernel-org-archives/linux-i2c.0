From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH/RFT 2/6] i2c: imx: use open drain for recovery GPIO
Date: Mon, 23 Jul 2018 14:47:28 +0200
Message-ID: <1532350048.3163.101.camel@pengutronix.de>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
         <20180713210920.3648-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713210920.3648-3-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-i2c@vger.kernel.org

Am Freitag, den 13.07.2018, 23:09 +0200 schrieb Wolfram Sang:
> I2C is open drain, so set up the GPIO accordingly.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I don't think this matters on any of the i.MX platforms, as the GPIO
pin configuration (including open-drain) is only taken from the DT
pinctrl, with the GPIO driver not being able to change any of those. On
 the flipside this results in a near zero probability of regressions.
;)

As this is obviously right even if it doesn't have any effect on
current software:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/i2c/busses/i2c-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 0207e194f84b..3e23ee26c55c 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1010,7 +1010,7 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
> >  	i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx->pinctrl,
> >  			"gpio");
> >  	rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_IN);
> > -	rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl", GPIOD_OUT_HIGH);
> > +	rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
>  
> >  	if (PTR_ERR(rinfo->sda_gpiod) == -EPROBE_DEFER ||
> >  	    PTR_ERR(rinfo->scl_gpiod) == -EPROBE_DEFER) {
