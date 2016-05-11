From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH v8 8/8] i2c: rk3x: support fast-mode plus for rk3399
Date: Wed, 11 May 2016 19:44:58 +0800
Message-ID: <57331B3A.7050801@gmail.com>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
 <1462908794-27333-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462908794-27333-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: heiko@sntech.de, wsa@the-dreams.de, mark.rutland@arm.com, huangtao@rock-chips.com, xjq@rock-chips.com, hl@rock-chips.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, linux-kernel@vger.kernel.org, cf@rock-chips.com, andy.shevchenko@gmail.com, robh+dt@kernel.org, linux-i2c@vger.kernel.org, galak@codeaurora.org, zyw@rock-chips.com, briannorris@google.com, davidriley@google.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org



=E5=9C=A8 2016=E5=B9=B405=E6=9C=8811=E6=97=A5 03:33, David Wu =E5=86=99=
=E9=81=93:
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Tested-by: Caesar Wang <wxt@rock-chips.com>
> ---
> Change in v8:
> - None
>
>   drivers/i2c/busses/i2c-rk3x.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-r=
k3x.c
> index 25ed1ad..0ba25ee 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -126,6 +126,17 @@ static const struct i2c_spec_values fast_mode_sp=
ec =3D {
>   	.min_hold_buffer_ns =3D 1300,
>   };
>  =20
> +static const struct i2c_spec_values fast_mode_plus_spec =3D {
> +	.min_hold_start_ns =3D 260,
> +	.min_low_ns =3D 500,
> +	.min_high_ns =3D 260,
> +	.min_setup_start_ns =3D 260,
> +	.max_data_hold_ns =3D 400,
> +	.min_data_setup_ns =3D 50,
> +	.min_setup_stop_ns =3D 260,
> +	.min_hold_buffer_ns =3D 500,
> +};
> +
>   /**
>    * struct rk3x_i2c_calced_timings:
>    * @div_low: Divider output for low
> @@ -531,8 +542,10 @@ static const struct i2c_spec_values *rk3x_i2c_ge=
t_spec(unsigned int speed)
>   {
>   	if (speed <=3D 100000)
>   		return &standard_mode_spec;
> -	else
> +	else if (speed <=3D 400000)
>   		return &fast_mode_spec;
> +	else
> +		return &fast_mode_plus_spec;
>   }
>  =20
>   /**
> @@ -743,9 +756,9 @@ static int rk3x_i2c_v1_calc_timings(unsigned long=
 clk_rate,
>   	const struct i2c_spec_values *spec;
>   	int ret =3D 0;
>  =20
> -	/* Support standard-mode and fast-mode */
> -	if (WARN_ON(t->bus_freq_hz > 400000))
> -		t->bus_freq_hz =3D 400000;
> +	/* Support standard-mode, fast-mode and fast-mode plus */
> +	if (WARN_ON(t->bus_freq_hz > 1000000))
> +		t->bus_freq_hz =3D 1000000;
>  =20
>   	/* prevent scl_rate_khz from becoming 0 */
>   	if (WARN_ON(t->bus_freq_hz < 1000))


--=20
Thanks,
Caesar
