From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: Support for Netlogic XLP9XX/5XX I2C
 controller.
Date: Sat, 14 Mar 2015 21:01:24 +0100
Message-ID: <20150314200124.GB5105@pengutronix.de>
References: <1426228198-3314-1-git-send-email-jchandra@broadcom.com>
 <1426228198-3314-3-git-send-email-jchandra@broadcom.com>
 <20150313102406.GP952@pengutronix.de>
 <20150314114836.GB611@jayachandranc.netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150314114836.GB611-l4W0uAg2RDvWG0bvociYJ/An/qbn1+6FOui0OUZsNXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jayachandran C." <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Sat, Mar 14, 2015 at 05:18:37PM +0530, Jayachandran C. wrote:
> On Fri, Mar 13, 2015 at 11:24:06AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Mar 13, 2015 at 11:59:58AM +0530, Jayachandran C wrote:
> > > diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses=
/i2c-xlp9xx.c
> > > new file mode 100644
> > > index 00000000..2f303ad
> > > --- /dev/null
> > > +++ b/drivers/i2c/busses/i2c-xlp9xx.c
> > > @@ -0,0 +1,446 @@
> > > [...]
> > > +
> > > +/*
> > > + * see Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt for =
device
> > > + * tree bindings documentation
> > > + */
> > When I asked for documentation here, I didn't meant the device tree
> > binding, but the hardware reference manual.
>=20
> Unfortunately there is no standalone documentation for the I2C contro=
ller,
> this block is used in XLP9xx and XLP5xx SoCs and you can get the docu=
mentation
> for the whole SoC from support.broadcom.com if you have an account th=
ere.
I don't. According to the instructions to get such an account I have to
contact my "Sales/Engineering contacts at Broadcom or its
Distributors/Manufacturer's representatives directly". Who would that b=
e
for me? You?

> > > [...]
> > > +static void xlp9xx_i2c_mask_irq(struct xlp9xx_i2c_dev *priv, u32=
 mask)
> > > +{
> > > +	mask =3D xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_INTEN) & ~mask;
> > > +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_INTEN, mask);
> > You didn't comment on my suggestion to add a variable here for impr=
oved
> > readability:
> >=20
> > 	u32 inten =3D xlp9xx_read_i2c_reg(...);
> > 	inten &=3D ~mask;
> > 	xlp9xx_write_i2c_reg(...);
> >=20
>=20
> Thought it was not really needed, but it is a little better than the
> current code, will update.
Yeah, for the generated code it probably doesn't make much difference--=
-if
at all. Readability and so maintainability is a good reason to update
code if there is no overhead in the compiled result. (And sometimes eve=
n
although there is overhead.)

> > > [...]
> > > +static int xlp9xx_i2c_init(struct xlp9xx_i2c_dev *priv)
> > > +{
> > > +	u32 prescale;
> > > +
> > > +	/*
> > > +	 * The controller uses 5 * SCL clock internally.
> > > +	 * So prescale value should be divided by 5.
> > > +	 */
> > > +	prescale =3D (((XLP9XX_I2C_IP_CLK_FREQ / priv->clk_hz) - 8) / 5=
) - 1;
> > I still wonder if you should round differently here.
>=20
> Are you thinking of making sure that we don't exceed the given clock =
freq
> because of rounding? I don't think this is an issue.
Right, that and also in the other direction not to give up speed becaus=
e
the calculation is not optimal.

> > > +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, XLP9XX_I2C_CTRL_RST=
);
> > > +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, XLP9XX_I2C_CTRL_EN =
|
> > > +			     XLP9XX_I2C_CTRL_MASTER);
> > > +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_DIV, prescale);
> > > +	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_INTEN, 0);
> > > +
> > > +	return 0;
> > > +}
>=20
> I will post a v4 (which takes care of another comment I have seen in =
this
> thread as well).
BTW, I fully agree to Arnd's request to use the full SoC's name in the
compatible string. Pick the first SoC to fix the name, and for the late=
r
SoCs use both strings. This method proved to be flexible enough to work
even if Broadcom might release a SoC next year with a name that
matches 9xx but an incompatible i2c device.
=46or Freescale devices it works exactly like this. There are (to the b=
est
of our knowledge) 3 similar implementations. On i.MX51 the device is
used that first appeared in the i.MX21 and imx51.dtsi has:

	compatible =3D "fsl,imx51-i2c", "fsl,imx21-i2c";

=2E

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
