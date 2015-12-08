From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 4/9] i2c: rcar: switch to i2c generic dt parsing
Date: Tue, 08 Dec 2015 12:59:20 +0200
Message-ID: <1449572360.30729.31.camel@linux.intel.com>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
	 <1449567473-2084-5-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1449567473-2084-5-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2015-12-08 at 10:37 +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Switch to the new generic functions. Plain convert, no functionality
> added yet.

One style nitpick.

>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> =C2=A0drivers/i2c/busses/i2c-rcar.c | 16 +++++++++-------
> =C2=A01 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-
> rcar.c
> index d4322a9096786f..c663f4389bf898 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -162,12 +162,15 @@ static int rcar_i2c_bus_barrier(struct
> rcar_i2c_priv *priv)
> =C2=A0	return -EBUSY;
> =C2=A0}
> =C2=A0
> -static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv, u32
> bus_speed)
> +static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
> struct i2c_timings *t)
> =C2=A0{
> =C2=A0	u32 scgd, cdf, round, ick, scl, cdf_width;
> =C2=A0	unsigned long rate;
> =C2=A0	struct device *dev =3D rcar_i2c_priv_to_dev(priv);
> =C2=A0
> +	/* Fall back to previously used values if not supplied */
> +	t->bus_freq_hz =3D t->bus_freq_hz ?: 100000;

On one hand it seems enough space to put one more t->bus_freq_hz, on
the other why not

if (!t->bus_freq_hz)
=C2=A0 =3D 100000;

I think a bit better to maintain latter.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

