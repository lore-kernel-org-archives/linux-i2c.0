From: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH REPOST 2/2] i2c-imx: add device tree probe support
Date: Fri, 9 Sep 2011 19:04:34 +0800
Message-ID: <20110909110433.GH31581@S2100-06.ap.freescale.net>
References: <1315465775-31335-1-git-send-email-shawn.guo@linaro.org>
 <1315465775-31335-3-git-send-email-shawn.guo@linaro.org>
 <4E69A0AE.1060004@gmail.com>
 <20110909071845.GI28816@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110909071845.GI28816-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 09, 2011 at 09:18:45AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Rob,
>=20
> On Fri, Sep 09, 2011 at 12:14:22AM -0500, Rob Herring wrote:
> > > +i2c@83fc4000 { /* I2C2 on i.MX51 */
> > > +	compatible =3D "fsl,imx51-i2c", "fsl,imx1-i2c";
> > > +	reg =3D <0x83fc4000 0x4000>;
> > > +	interrupts =3D <63>;
> > > +};
> > > +
> > > +i2c@70038000 { /* HS-I2C on i.MX51 */
> >=20
> > The mainline driver doesn't support the HS-I2C block does it?
> >=20
> > The high speed and "old" i2c blocks on MX51 are basically different
> > blocks, so the compatible property should be different.
> I stumbled about that recently, too and found in
> arch/arm/plat-mxc/devices/platform-imx-i2c.c that the third device
> description for imx51 is a normal "imx-i2c" one using
> MX51_HSI2C_DMA_BASE_ADDR. So I concluded it's different but compatibl=
e.
>=20
> board-mx51_babbage.c uses imx51_add_hsi2c but doesn't add a bus
> description. So It might not attract attention if the driver doesn't
> match the device.
>=20
Aha, I was confused by the platform codes.  Will drop HSI2C.

Thanks for catching this, Rob.

--=20
Regards,
Shawn
