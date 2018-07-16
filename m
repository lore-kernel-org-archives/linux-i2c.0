From: Ulrich Hecht <ulrich.hecht@gmail.com>
Subject: Re: [PATCH/RFT 6/6] i2c: recovery: remove bogus check if SDA GPIO is
 set to output
Date: Mon, 16 Jul 2018 11:29:29 +0200
Message-ID: <CAO3366ySBBKpz1fpZ8orLTVF-tU+Gw3A7CiqaJWtmyGiU6kdYA@mail.gmail.com>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com> <20180713210920.3648-7-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713210920.3648-7-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, kernel@pengutronix.de, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 13, 2018 at 11:09 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> This check did not work as intended. I2C is open drain, so this function
> will likely always have presented the GPIO as input because
> gpiod_get_direction doesn't know about open drain states. Remove this
> check for now. We can add it again once we know how to get more precise
> information about the GPIO.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/i2c-core-base.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 301285c54603..7c5f012f561c 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -261,9 +261,7 @@ static void i2c_init_recovery(struct i2c_adapter *adap)
>                 bri->set_scl = set_scl_gpio_value;
>                 if (bri->sda_gpiod) {
>                         bri->get_sda = get_sda_gpio_value;
> -                       /* FIXME: add proper flag instead of '0' once available */
> -                       if (gpiod_get_direction(bri->sda_gpiod) == 0)
> -                               bri->set_sda = set_sda_gpio_value;
> +                       bri->set_sda = set_sda_gpio_value;
>                 }
>                 return;
>         }
> --
> 2.11.0
>

Reviewed-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

CU
Uli
