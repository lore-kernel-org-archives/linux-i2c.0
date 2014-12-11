From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4] i2c: rk3x: fix bug that cause measured high_ns
 doesn't meet I2C specification
Date: Thu, 11 Dec 2014 08:47:38 +0100
Message-ID: <20141211074738.GL13486@pengutronix.de>
References: <1418007589-3688-1-git-send-email-addy.ke@rock-chips.com>
 <1418277650-25215-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418277650-25215-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

I like it now. There are only a few small nitpicks, not sure its worth
to respin if noone else has concerns. See below.

On Thu, Dec 11, 2014 at 02:00:49PM +0800, Addy Ke wrote:
> The number of clock cycles to be written into the CLKDIV register
> that determines the I2C clk high phase includes the rise time.
> So to meet the timing requirements defined in the I2C specification
> which defines the minimal time SCL has to be high, the rise time
> has to taken into account. The same applies to the low phase with
> falling time.
>=20
> In my test on RK3288-Pink2 board, which is not an upstream board yet,
> if external pull-up resistor is 4.7K, rise_ns is about 700ns.
> So the measured high_ns is about 3900ns, which is less than 4000ns
> (the minimum high_ns in I2C specification for Standard-mode).
>=20
> To fix this bug, min_low_ns should include fall time and min_high_ns
s/,//

> should include rise time too.
I'd skip the "too". If you want to keep it, s/time/time,/.
=20
> This patch merged the patch that Doug submitted to chromium project,
AFAIK s/,//

=46or correctness, does this patch needs Doug's Sob?

> which can get the rise and fall times for signals from the device tre=
e.
> This allows us to more accurately calculate timings. see:
> https://chromium-review.googlesource.com/#/c/232774/
>=20
> Signed-off-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> [...]
> @@ -469,29 +476,33 @@ static int rk3x_i2c_calc_divs(unsigned long clk=
_rate, unsigned long scl_rate,
> [...]
>  	if (scl_rate <=3D 100000) {
> -		min_low_ns =3D 4700;
> -		min_high_ns =3D 4000;
> -		max_data_hold_ns =3D 3450;
> -		data_hold_buffer_ns =3D 50;
> +		/* Standard-mode */
> +		spec_min_low_ns =3D 4700;
> +		spec_min_high_ns =3D 4000;
> +		spec_max_data_hold_ns =3D 3450;
> +		spec_data_hold_buffer_ns =3D 50;
>  	} else {
> -		min_low_ns =3D 1300;
> -		min_high_ns =3D 600;
> -		max_data_hold_ns =3D 900;
> -		data_hold_buffer_ns =3D 50;
> +		/* Fast-mode */
> +		spec_min_low_ns =3D 1300;
> +		spec_min_high_ns =3D 600;
> +		spec_max_data_hold_ns =3D 900;
> +		spec_data_hold_buffer_ns =3D 50;
The background of my question regarding data_hold_buffer_ns in the last
round was: If data_hold_buffer_ns doesn't appear in the I2C
specification, should it be renamed to spec_... ? *shrug*

>  	}
> -	max_low_ns =3D max_data_hold_ns * 2 - data_hold_buffer_ns;
> +	min_low_ns =3D spec_min_low_ns + fall_ns;
> +	min_high_ns =3D spec_min_high_ns + rise_ns;
> +	max_low_ns =3D spec_max_data_hold_ns * 2 - spec_data_hold_buffer_ns=
;
>  	min_total_ns =3D min_low_ns + min_high_ns;
> =20
>  	/* Adjust to avoid overflow */
> @@ -510,8 +521,8 @@ static int rk3x_i2c_calc_divs(unsigned long clk_r=
ate, unsigned long scl_rate,
>  	min_div_for_hold =3D (min_low_div + min_high_div);
> =20
>  	/*
> -	 * This is the maximum divider so we don't go over the max.
> -	 * We don't round up here (we round down) since this is a max.
> +	 * This is the maximum divider so we don't go over the maximum.
> +	 * We don't round up here (we round down) since this is a maximum.
>  	 */
>  	max_low_div =3D clk_rate_khz * max_low_ns / (8 * 1000000);
> =20
> @@ -544,7 +555,7 @@ static int rk3x_i2c_calc_divs(unsigned long clk_r=
ate, unsigned long scl_rate,
>  		ideal_low_div =3D DIV_ROUND_UP(clk_rate_khz * min_low_ns,
>  					     scl_rate_khz * 8 * min_total_ns);
> =20
> -		/* Don't allow it to go over the max */
> +		/* Don't allow it to go over the maximum */
>  		if (ideal_low_div > max_low_div)
>  			ideal_low_div =3D max_low_div;
> =20
> @@ -588,8 +599,8 @@ static void rk3x_i2c_adapt_div(struct rk3x_i2c *i=
2c, unsigned long clk_rate)
>  	u64 t_low_ns, t_high_ns;
>  	int ret;
> =20
> -	ret =3D rk3x_i2c_calc_divs(clk_rate, i2c->scl_frequency, &div_low,
> -				 &div_high);
> +	ret =3D rk3x_i2c_calc_divs(clk_rate, i2c->scl_frequency, i2c->rise_=
ns,
> +				 i2c->fall_ns, &div_low, &div_high);
> =20
>  	WARN_ONCE(ret !=3D 0, "Could not reach SCL freq %u", i2c->scl_frequ=
ency);
> =20
> @@ -633,9 +644,9 @@ static int rk3x_i2c_clk_notifier_cb(struct notifi=
er_block *nb, unsigned long
>  	switch (event) {
>  	case PRE_RATE_CHANGE:
>  		if (rk3x_i2c_calc_divs(ndata->new_rate, i2c->scl_frequency,
> -				      &div_low, &div_high) !=3D 0) {
> +				       i2c->rise_ns, i2c->fall_ns, &div_low,
> +				       &div_high) !=3D 0)
>  			return NOTIFY_STOP;
> -		}
> =20
>  		/* scale up */
>  		if (ndata->new_rate > ndata->old_rate)
> @@ -859,6 +870,21 @@ static int rk3x_i2c_probe(struct platform_device=
 *pdev)
>  		i2c->scl_frequency =3D DEFAULT_SCL_RATE;
>  	}
> =20
> +	/*
> +	 * Read rise and fall ns.
> +	 * If not, there use the default maximum from specification.
I'd write:

	Read rise and fall time from device tree. If not available use
	the default maximum timing from the specification.

(Otherwise I think the comma needs to go after "there" in your
sentence.)

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
