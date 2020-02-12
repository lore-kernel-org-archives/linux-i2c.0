From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: i2c: jz4780: silence log flood on txabrt
Date: Wed, 12 Feb 2020 15:46:19 +0100
Message-ID: <213C52CC-E5DC-4641-BE68-3D5C4FEA1FB5@goldelico.com>
References: <cover.1581457290.git.hns@goldelico.com> <7facef52af9cff6ebe26ff321a7fd4f1ac640f74.1581457290.git.hns@goldelico.com> <20200212094628.GB1143@ninjato>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200212094628.GB1143@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Paul Cercueil <paul@crapouillou.net>, Paul Boddie <paul@boddie.org.uk>, Alex Smith <alex.smith@imgtec.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "David S. Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Andi Kleen <ak@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Miquel Raynal <miquel.raynal@bootlin.com>, =?utf-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>, Richard Fontana <rfontana@redhat.com>, Allison Randal <allison@lohutok.net>, Stephen Boyd <swboyd@chro>
List-Id: linux-i2c@vger.kernel.org

Hi,

> Am 12.02.2020 um 10:46 schrieb Wolfram Sang <wsa@the-dreams.de>:
>=20
>=20
> The printout for txabrt is way too talkative. Reduce it to the =
minimum,
> the rest can be gained by I2C core debugging and datasheet =
information.
> Also, make it a debug printout, it won't help the regular user.
>=20
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>=20
> Sorry, normally I don't do counter patches. Yet, this time I realized
> that it would be faster to actually do what I envisioned than to
> describe it in words. I hope you don't feel offended.

No problem. I had thought a little about that myself, but did not
dare to solve more than my problem...

> This driver has
> way too many dev_err anyhow, so this may be a start.
>=20
> Obviously, I can't test, does it work for you?

Yes,it works.

Do you want to push your patch yourself, or should I add it to my
patch series and resubmit in a v2?

BR and thanks,
Nikolaus

>=20
> drivers/i2c/busses/i2c-jz4780.c | 36 ++-------------------------------
> 1 file changed, 2 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-jz4780.c =
b/drivers/i2c/busses/i2c-jz4780.c
> index 16a67a64284a..b426fc956938 100644
> --- a/drivers/i2c/busses/i2c-jz4780.c
> +++ b/drivers/i2c/busses/i2c-jz4780.c
> @@ -78,25 +78,6 @@
>=20
> #define X1000_I2C_DC_STOP		BIT(9)
>=20
> -static const char * const jz4780_i2c_abrt_src[] =3D {
> -	"ABRT_7B_ADDR_NOACK",
> -	"ABRT_10ADDR1_NOACK",
> -	"ABRT_10ADDR2_NOACK",
> -	"ABRT_XDATA_NOACK",
> -	"ABRT_GCALL_NOACK",
> -	"ABRT_GCALL_READ",
> -	"ABRT_HS_ACKD",
> -	"SBYTE_ACKDET",
> -	"ABRT_HS_NORSTRT",
> -	"SBYTE_NORSTRT",
> -	"ABRT_10B_RD_NORSTRT",
> -	"ABRT_MASTER_DIS",
> -	"ARB_LOST",
> -	"SLVFLUSH_TXFIFO",
> -	"SLV_ARBLOST",
> -	"SLVRD_INTX",
> -};
> -
> #define JZ4780_I2C_INTST_IGC		BIT(11)
> #define JZ4780_I2C_INTST_ISTT		BIT(10)
> #define JZ4780_I2C_INTST_ISTP		BIT(9)
> @@ -576,21 +557,8 @@ static irqreturn_t jz4780_i2c_irq(int irqno, void =
*dev_id)
>=20
> static void jz4780_i2c_txabrt(struct jz4780_i2c *i2c, int src)
> {
> -	int i;
> -
> -	dev_err(&i2c->adap.dev, "txabrt: 0x%08x\n", src);
> -	dev_err(&i2c->adap.dev, "device addr=3D%x\n",
> -		jz4780_i2c_readw(i2c, JZ4780_I2C_TAR));
> -	dev_err(&i2c->adap.dev, "send cmd count:%d  %d\n",
> -		i2c->cmd, i2c->cmd_buf[i2c->cmd]);
> -	dev_err(&i2c->adap.dev, "receive data count:%d  %d\n",
> -		i2c->cmd, i2c->data_buf[i2c->cmd]);
> -
> -	for (i =3D 0; i < 16; i++) {
> -		if (src & BIT(i))
> -			dev_dbg(&i2c->adap.dev, "I2C TXABRT[%d]=3D%s\n",
> -				i, jz4780_i2c_abrt_src[i]);
> -	}
> +	dev_dbg(&i2c->adap.dev, "txabrt: 0x%08x, cmd: %d, send: %d, =
recv: %d\n",
> +		src, i2c->cmd, i2c->cmd_buf[i2c->cmd], =
i2c->data_buf[i2c->cmd]);
> }
>=20
> static inline int jz4780_i2c_xfer_read(struct jz4780_i2c *i2c,
> --=20
> 2.20.1
>=20
