From: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-mux-gpio: use gpio_set_value_cansleep()
Date: Fri, 11 Oct 2013 13:21:19 +0200
Message-ID: <87wqlkgij4.fsf@thor.barco.com>
References: <5257CE71.5060408@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5257CE71.5060408-OYasijW0DpE@public.gmane.org> (Ionut Nicu's message of "Fri, 11 Oct
	2013 12:09:53 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "IN" == Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org> writes:

IN> Some gpio chips may have get/set operations that
IN> can sleep. gpio_set_value() only works for chips
IN> which do not sleep, for the others we will get a
IN> kernel warning. Using gpio_set_value_cansleep()
IN> will work for both chips that do sleep and those
IN> who don't.

IN> Signed-off-by: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
IN> ---
IN>  drivers/i2c/muxes/i2c-mux-gpio.c |    4 ++--
IN>  1 files changed, 2 insertions(+), 2 deletions(-)

IN> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
IN> index a764da7..550e094 100644
IN> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
IN> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
IN> @@ -30,8 +30,8 @@ static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
IN>     int i;

IN>     for (i = 0; i < mux->data.n_gpios; i++)
IN> -           gpio_set_value(mux->gpio_base + mux->data.gpios[i],
IN> -                          val & (1 << i));
IN> +           gpio_set_value_cansleep(mux->gpio_base + mux->data.gpios[i],
IN> +                           val & (1 << i));

The indentation of the 2nd line seems wrong (should match
mux->gpio_base), otherwise it looks good:

Acked-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

--
Sorry about disclaimer - It's out of my control.
Bye, Peter Korsgaard
This message is subject to the following terms and conditions: MAIL DISCLAIMER<http://www.barco.com/en/maildisclaimer>
