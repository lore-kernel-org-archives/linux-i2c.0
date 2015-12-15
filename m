From: Jianqun Xu <jay.xu@rock-chips.com>
Subject: Re: [PATCH v1 1/3] i2c: rk3x: add calc_divs ops for new version
Date: Tue, 15 Dec 2015 08:32:44 +0800
Message-ID: <566F5FAC.3080404@rock-chips.com>
References: <1449844384-6236-1-git-send-email-wdc@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449844384-6236-1-git-send-email-wdc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Wu <wdc@rock-chips.com>, heiko@sntech.de
Cc: wsa@the-dreams.de, dianders@chromium.org, huangtao@rock-chips.com, zyw@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>
List-Id: linux-i2c@vger.kernel.org

Hi David:

It's better to add a cover-letter, and add changes note for new version=
,
such as:

changes since v0:
- split patch to two patches or more, one patch for one new feature (He=
iko)

and NOT to have two same signed-off-by

=D4=DA 11/12/2015 22:33, David Wu =D0=B4=B5=C0:
> The calc_divs of new version is different form the old.
> The time of tHD;sda, tHD;sda, tSU;sta, tHD;sta and tSU;sto
> could be configured by RKI2C_CON register.
> So it need a new way to calc_divs for new i2c controller.
>
> Signed-off-by: David Wu <wdc@rock-chips.com>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>
>   drivers/i2c/busses/i2c-rk3x.c | 54 ++++++++++++++++++++++++++++++++=
++---------
>   1 file changed, 43 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-r=
k3x.c
> index c1935eb..0ff299f 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -58,6 +58,12 @@ enum {
>   #define REG_CON_LASTACK   BIT(5) /* 1: send NACK after last receive=
d byte */
>   #define REG_CON_ACTACK    BIT(6) /* 1: stop if NACK is received */
>
> +#define VERSION_MASK	  0xffff0000
> +#define VERSION_SHIFT	  16
> +
> +#define RK3X_I2C_V0	  0x0
> +#define RK3X_I2C_V1	  0x1
> +
>   /* REG_MRXADDR bits */
>   #define REG_MRXADDR_VALID(x) BIT(24 + (x)) /* [x*8+7:x*8] of MRX[R]=
ADDR valid */
>
> @@ -90,10 +96,22 @@ struct rk3x_i2c_soc_data {
>   	int grf_offset;
>   };
>
> +struct rk3x_i2c_ops {
> +	int (*calc_divs)(unsigned long,
> +			 unsigned long,
> +			 unsigned long,
> +			 unsigned long,
> +			 unsigned long,
> +			 unsigned long *,
> +			 unsigned long *,
> +			 unsigned int *);
> +};
> +
>   struct rk3x_i2c {
>   	struct i2c_adapter adap;
>   	struct device *dev;
>   	struct rk3x_i2c_soc_data *soc_data;
> +	struct rk3x_i2c_ops ops;
>
>   	/* Hardware resources */
>   	void __iomem *regs;
> @@ -116,6 +134,7 @@ struct rk3x_i2c {
>   	u8 addr;
>   	unsigned int mode;
>   	bool is_last_msg;
> +	unsigned int time_con;
>
>   	/* I2C state machine */
>   	enum rk3x_i2c_state state;
> @@ -151,7 +170,8 @@ static void rk3x_i2c_start(struct rk3x_i2c *i2c)
>   	i2c_writel(i2c, REG_INT_START, REG_IEN);
>
>   	/* enable adapter with correct mode, send START condition */
> -	val =3D REG_CON_EN | REG_CON_MOD(i2c->mode) | REG_CON_START;
> +	val =3D i2c->time_con | REG_CON_EN | REG_CON_MOD(i2c->mode)
> +		| REG_CON_START;
>
>   	/* if we want to react to NACK, set ACTACK bit */
>   	if (!(i2c->msg->flags & I2C_M_IGNORE_NAK))
> @@ -443,16 +463,19 @@ out:
>    * @sda_fall_ns: How many ns it takes for SDA to fall.
>    * @div_low: Divider output for low
>    * @div_high: Divider output for high
> + * @con: version0 is not used
>    *
>    * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow.=
 In that case
>    * a best-effort divider value is returned in divs. If the target r=
ate is
>    * too high, we silently use the highest possible rate.
>    */
> -static int rk3x_i2c_calc_divs(unsigned long clk_rate, unsigned long =
scl_rate,
> -			      unsigned long scl_rise_ns,
> -			      unsigned long scl_fall_ns,
> -			      unsigned long sda_fall_ns,
> -			      unsigned long *div_low, unsigned long *div_high)
> +static int rk3x_i2c_v0_calc_divs(unsigned long clk_rate, unsigned lo=
ng scl_rate,
> +				 unsigned long scl_rise_ns,
> +				 unsigned long scl_fall_ns,
> +				 unsigned long sda_fall_ns,
> +				 unsigned long *div_low,
> +				 unsigned long *div_high,
> +				 unsigned int *con)
>   {
>   	unsigned long spec_min_low_ns, spec_min_high_ns;
>   	unsigned long spec_setup_start, spec_max_data_hold_ns;
> @@ -616,17 +639,19 @@ static int rk3x_i2c_calc_divs(unsigned long clk=
_rate, unsigned long scl_rate,
>
>   static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long =
clk_rate)
>   {
> +	unsigned int con =3D 0;
>   	unsigned long div_low, div_high;
>   	u64 t_low_ns, t_high_ns;
>   	int ret;
>
> -	ret =3D rk3x_i2c_calc_divs(clk_rate, i2c->scl_frequency, i2c->scl_r=
ise_ns,
> +	ret =3D i2c->ops.calc_divs(clk_rate, i2c->scl_frequency, i2c->scl_r=
ise_ns,
>   				 i2c->scl_fall_ns, i2c->sda_fall_ns,
> -				 &div_low, &div_high);
> +				 &div_low, &div_high, &con);
>   	WARN_ONCE(ret !=3D 0, "Could not reach SCL freq %u", i2c->scl_freq=
uency);
>
>   	clk_enable(i2c->clk);
>   	i2c_writel(i2c, (div_high << 16) | (div_low & 0xffff), REG_CLKDIV)=
;
> +	i2c->time_con =3D con;
>   	clk_disable(i2c->clk);
>
>   	t_low_ns =3D div_u64(((u64)div_low + 1) * 8 * 1000000000, clk_rate=
);
> @@ -661,13 +686,14 @@ static int rk3x_i2c_clk_notifier_cb(struct noti=
fier_block *nb, unsigned long
>   	struct clk_notifier_data *ndata =3D data;
>   	struct rk3x_i2c *i2c =3D container_of(nb, struct rk3x_i2c, clk_rat=
e_nb);
>   	unsigned long div_low, div_high;
> +	unsigned int con =3D 0;
>
>   	switch (event) {
>   	case PRE_RATE_CHANGE:
> -		if (rk3x_i2c_calc_divs(ndata->new_rate, i2c->scl_frequency,
> +		if (i2c->ops.calc_divs(ndata->new_rate, i2c->scl_frequency,
>   				       i2c->scl_rise_ns, i2c->scl_fall_ns,
>   				       i2c->sda_fall_ns,
> -				       &div_low, &div_high) !=3D 0)
> +				       &div_low, &div_high, &con) !=3D 0)
>   			return NOTIFY_STOP;
>
>   		/* scale up */
> @@ -816,7 +842,8 @@ static int rk3x_i2c_xfer(struct i2c_adapter *adap=
,
>
>   			/* Force a STOP condition without interrupt */
>   			i2c_writel(i2c, 0, REG_IEN);
> -			i2c_writel(i2c, REG_CON_EN | REG_CON_STOP, REG_CON);
> +			i2c_writel(i2c, i2c->time_con | REG_CON_EN |
> +				   REG_CON_STOP, REG_CON);
>
>   			i2c->state =3D STATE_IDLE;
>
> @@ -871,6 +898,7 @@ static int rk3x_i2c_probe(struct platform_device =
*pdev)
>   	u32 value;
>   	int irq;
>   	unsigned long clk_rate;
> +	unsigned int version;
>
>   	i2c =3D devm_kzalloc(&pdev->dev, sizeof(struct rk3x_i2c), GFP_KERN=
EL);
>   	if (!i2c)
> @@ -983,6 +1011,10 @@ static int rk3x_i2c_probe(struct platform_devic=
e *pdev)
>
>   	platform_set_drvdata(pdev, i2c);
>
> +	version =3D (readl(i2c->regs + REG_CON) & VERSION_MASK) >> VERSION_=
SHIFT;
> +	if (version =3D=3D RK3X_I2C_V0)
> +		i2c->ops.calc_divs =3D rk3x_i2c_v0_calc_divs;
> +
>   	ret =3D clk_prepare(i2c->clk);
>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "Could not prepare clock\n");
>

--=20
***********************************************************************=
*****
=D0=ED=BD=A3=C8=BA
=46uzhou Rockchip Electronics Co., Ltd
=B5=D8=D6=B7=A3=BA=B8=A3=BD=A8=CA=A1=B8=A3=D6=DD=CA=D0=CD=AD=C5=CC=C2=B7=
=C8=ED=BC=FE=B4=F3=B5=C089=BA=C5=C8=ED=BC=FE=D4=B0A=C7=F821=BA=C5=C2=A5
ADDR: No.21 bldg, Fuzhou Software Park,Fuzhou,Fujian,P.R.China
Email: xjq@rock-chips.com
***********************************************************************=
*****
=B1=A3=C3=DC=CC=E1=CA=BE=A3=BA=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=
=BA=AC=D3=D0=BB=FA=C3=DC=D0=C5=CF=A2=C0=B4=D7=D4=B8=A3=D6=DD=C8=F0=D0=BE=
=CE=A2=B5=E7=D7=D3=B9=C9=B7=DD=D3=D0=CF=DE=B9=AB=CB=BE=A3=AC=BD=F6=B7=A2=
=20
=CB=CD=B8=F8=B1=BE=D3=CA=BC=FE=CB=F9=D6=B8=CC=D8=B6=A8=CA=D5=BC=FE=C8=CB=
=A1=A3=C8=F4=B7=C7=B8=C3=CC=D8=B6=A8=CA=D5=BC=FE=C8=CB=A3=AC=C7=EB=CE=F0=
=B8=B4=D6=C6=A1=A2 =CA=B9=D3=C3=BB=F2=C5=FB=C2=B6=B1=BE=D3=CA=BC=FE=20
=B5=C4=C8=CE=BA=CE=C4=DA=C8=DD=A1=A3=C8=F4=CE=F3=CA=D5=B1=BE=D3=CA=BC=FE=
=A3=AC=C7=EB=B4=D3=CF=B5=CD=B3=D6=D0=D3=C0=BE=C3=D0=D4=C9=BE=B3=FD=B1=BE=
=D3=CA=BC=FE=BC=B0=CB=F9=D3=D0=B8=BD=BC=FE=A3=AC=B2=A2=D2=D4=BB=D8=B8=B4=
=20
=D3=CA=BC=FE=BB=F2=C6=E4=CB=FB=B7=BD=CA=BD=BC=B4=BF=CC=B8=E6=D6=AA=B7=A2=
=BC=FE=C8=CB=A1=A3=B8=A3=D6=DD=C8=F0=D0=BE=CE=A2=B5=E7=D7=D3=D3=D0=CF=DE=
=B9=AB=CB=BE=D3=B5=D3=D0=B1=BE=D3=CA=BC=FE=D0=C5=CF=A2=B5=C4=D6=F8=D7=F7=
=20
=C8=A8=BC=B0=BD=E2=CA=CD=C8=A8=A3=AC=BD=FB=D6=B9=C8=CE=BA=CE=CE=B4=BE=AD=
=CA=DA=C8=A8=D0=ED=BF=C9=B5=C4=C7=D6=C8=A8=D0=D0=CE=AA=A1=A3
IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co.,=20
Ltd .The contents of this email and any attachments may contain=20
information that is privileged, confidential and/or exempt from=20
disclosure under applicable law and relevant NDA. If you are not the=20
intended recipient, you are hereby notified that any disclosure,=20
copying, distribution, or use of the information is STRICTLY PROHIBITED=
=2E=20
Please immediately contact the sender as soon as possible and destroy=20
the material in its entirety in any format. Thank you.
***********************************************************************=
*****
