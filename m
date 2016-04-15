From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v5 2/2] i2c: rk3x: add i2c support for rk3399 soc
Date: Fri, 15 Apr 2016 14:17:58 +0200
Message-ID: <4971788.LeT208jGID@diego>
References: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com> <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:50652 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbcDOMSN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 15 Apr 2016 08:18:13 -0400
In-Reply-To: <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: wsa@the-dreams.de, dianders@chromium.org, andy.shevchenko@gmail.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <wdc@rock-chips.com>

Hi David,

Am Donnerstag, 17. M=E4rz 2016, 00:57:18 schrieb David Wu:
> From: David Wu <wdc@rock-chips.com>
>=20
> - new method to caculate i2c timings for rk3399:
>   There was an timing issue about "repeated start" time at the I2C
>   controller of version0, controller appears to drop SDA at .875x (7/=
8)
>   programmed clk high. On version 1 of the controller, the rule(.875x=
)
>   isn't enough to meet tSU;STA
>   requirements on 100k's Standard-mode. To resolve this issue,
>   sda_update_config, start_setup_config and stop_setup_config for I2C
>   timing information are added, new rules are designed to calculate
>   the timing information at new v1.
> - pclk and function clk are separated at rk3399.
> - support i2c highspeed mode: 1.7MHz for rk3399
>=20
> Signed-off-by: David Wu <david.wu@rock-chips.com>

[...]

> @@ -83,11 +88,34 @@ enum rk3x_i2c_state {
>  	STATE_STOP
>  };
>=20
> +struct rk3x_i2c;
> +
> +/**
> + * struct rk3x_i2c_calced_timings:
> + * @div_low: Divider output for low
> + * @div_high: Divider output for high
> + * @sda_update_cfg: Used to config sda change state when scl is low,
> + * used to adjust setup/hold time
> + * @stp_sta_cfg: Start setup config for setup start time and hold st=
art
> time + * @stp_sto_cfg: Stop setup config for setup stop time
> + */
> +struct rk3x_i2c_calced_timings {
> +	unsigned long div_low;
> +	unsigned long div_high;
> +	unsigned int sda_update_cfg;
> +	unsigned int stp_sta_cfg;
> +	unsigned int stp_sto_cfg;
> +};
> +
>  /**
>   * @grf_offset: offset inside the grf regmap for setting the i2c typ=
e
>   */
>  struct rk3x_i2c_soc_data {
>  	int grf_offset;
> +
> +	int (*clk_init)(struct rk3x_i2c *, unsigned long *);
> +	int (*calc_timings)(unsigned long, struct i2c_timings *,
> +			    struct rk3x_i2c_calced_timings *);
>  };
>=20
>  struct rk3x_i2c {
> @@ -97,11 +125,13 @@ struct rk3x_i2c {
>=20
>  	/* Hardware resources */
>  	void __iomem *regs;
> -	struct clk *clk;
> +	struct clk *pclk; /* APB clock */
> +	struct clk *clk; /* Func clk for rk3399 or Func & APB clks for othe=
rs */
>  	struct notifier_block clk_rate_nb;

please use regular kernel-doc for the struct elements (aka @pclk: somet=
hing)=20
like some of the other fields already have.

I can't spot anything else, but also don't know enough about i2c itself=
 :-)


Heiko
