From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-designware: make *CNT values configurable
Date: Mon, 8 Jul 2013 15:42:17 +0200
Message-ID: <20130708134216.GB6402@ab42.lan>
References: <1373283927-21677-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1373283927-21677-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 08, 2013 at 02:45:26PM +0300, Mika Westerberg wrote:
> The DesignWare I2C controller has high count (HCNT) and low count (LC=
NT)
> registers for each of the I2C speed modes (standard and fast). These
> registers are programmed based on the input clock speed in the driver=
=2E
>=20
> However, that is not always the most accurate way. For example on Int=
el
> BayTrail we have 100MHz input clock and calculated *CNT values result=
 as
> measured by one of our team:
>=20
>  Standard mode: 100.25kHz
>  Fast mode    : 315.41kHZ
>=20
> The fast mode speed is over 20% lower than what is expected.

We have observed similar issues and I am wondering if this effect is du=
e
to the overly-pessimistic formulas in i2c_dw_scl_lcnt and
i2c_dw_scl_hcnt. The comments in these functions are a bit confusing an=
d
I don't pretend having fully understood what the intention is. I'm
having the impression that defining the arguments tf in function of the
hardware would be the "correct" way to achieve better clock accuracy.

> It might be
> that there are things like strenght of the pull-up resistors, bus
> capacitance etc. that are very platform specific and have an effect o=
n the
> clock signal.

I believe tf is supposed to model these things. I just haven't clearly
understood how. In my understanding, transition times should be
subtracted rather than added to cycle times or am I getting something
fundamentally wrong here?

> With this patch we let the platform code to specify more accurate, op=
timal
> *CNT values if they are known beforehand.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 46 +++++++++++++++++++---=
----------
>  drivers/i2c/busses/i2c-designware-core.h | 12 +++++++++
>  2 files changed, 40 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/b=
usses/i2c-designware-core.c
> index ad46616..f31469e 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -308,29 +308,39 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  	/* set standard and fast speed deviders for high/low periods */
> =20
>  	/* Standard-mode */
> -	hcnt =3D i2c_dw_scl_hcnt(input_clock_khz,
> -				40,	/* tHD;STA =3D tHIGH =3D 4.0 us */
> -				3,	/* tf =3D 0.3 us */
> -				0,	/* 0: DW default, 1: Ideal */
> -				0);	/* No offset */
> -	lcnt =3D i2c_dw_scl_lcnt(input_clock_khz,
> -				47,	/* tLOW =3D 4.7 us */
> -				3,	/* tf =3D 0.3 us */
> -				0);	/* No offset */
> +	if (dev->ss_hcnt && dev->ss_lcnt) {
> +		hcnt =3D dev->ss_hcnt;
> +		lcnt =3D dev->ss_lcnt;
> +	} else {
> +		hcnt =3D i2c_dw_scl_hcnt(input_clock_khz,
> +					40,	/* tHD;STA =3D tHIGH =3D 4.0 us */
> +					3,	/* tf =3D 0.3 us */
> +					0,	/* 0: DW default, 1: Ideal */
> +					0);	/* No offset */
> +		lcnt =3D i2c_dw_scl_lcnt(input_clock_khz,
> +					47,	/* tLOW =3D 4.7 us */
> +					3,	/* tf =3D 0.3 us */
> +					0);	/* No offset */
> +	}
>  	dw_writel(dev, hcnt, DW_IC_SS_SCL_HCNT);
>  	dw_writel(dev, lcnt, DW_IC_SS_SCL_LCNT);
>  	dev_dbg(dev->dev, "Standard-mode HCNT:LCNT =3D %d:%d\n", hcnt, lcnt=
);
> =20
>  	/* Fast-mode */
> -	hcnt =3D i2c_dw_scl_hcnt(input_clock_khz,
> -				6,	/* tHD;STA =3D tHIGH =3D 0.6 us */
> -				3,	/* tf =3D 0.3 us */
> -				0,	/* 0: DW default, 1: Ideal */
> -				0);	/* No offset */
> -	lcnt =3D i2c_dw_scl_lcnt(input_clock_khz,
> -				13,	/* tLOW =3D 1.3 us */
> -				3,	/* tf =3D 0.3 us */
> -				0);	/* No offset */
> +	if (dev->fs_hcnt && dev->fs_lcnt) {
> +		hcnt =3D dev->fs_hcnt;
> +		lcnt =3D dev->fs_lcnt;
> +	} else {
> +		hcnt =3D i2c_dw_scl_hcnt(input_clock_khz,
> +					6,	/* tHD;STA =3D tHIGH =3D 0.6 us */
> +					3,	/* tf =3D 0.3 us */
> +					0,	/* 0: DW default, 1: Ideal */
> +					0);	/* No offset */
> +		lcnt =3D i2c_dw_scl_lcnt(input_clock_khz,
> +					13,	/* tLOW =3D 1.3 us */
> +					3,	/* tf =3D 0.3 us */
> +					0);	/* No offset */
> +	}
>  	dw_writel(dev, hcnt, DW_IC_FS_SCL_HCNT);
>  	dw_writel(dev, lcnt, DW_IC_FS_SCL_LCNT);
>  	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT =3D %d:%d\n", hcnt, lcnt);
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/b=
usses/i2c-designware-core.h
> index 912aa22..e8a7565 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -61,6 +61,14 @@
>   * @tx_fifo_depth: depth of the hardware tx fifo
>   * @rx_fifo_depth: depth of the hardware rx fifo
>   * @rx_outstanding: current master-rx elements in tx fifo
> + * @ss_hcnt: standard speed HCNT value
> + * @ss_lcnt: standard speed LCNT value
> + * @fs_hcnt: fast speed HCNT value
> + * @fs_lcnt: fast speed LCNT value
> + *
> + * HCNT and LCNT parameters can be used if the platform knows more a=
ccurate
> + * values than the one computed based only on the input clock freque=
ncy.
> + * Leave them to be %0 if not used.
>   */
>  struct dw_i2c_dev {
>  	struct device		*dev;
> @@ -91,6 +99,10 @@ struct dw_i2c_dev {
>  	unsigned int		rx_fifo_depth;
>  	int			rx_outstanding;
>  	u32			sda_hold_time;
> +	u16			ss_hcnt;
> +	u16			ss_lcnt;
> +	u16			fs_hcnt;
> +	u16			fs_lcnt;
>  };
> =20
>  #define ACCESS_SWAP		0x00000001
> --=20
> 1.8.3.2
>=20

--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
