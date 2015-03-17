From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: Support for Netlogic XLP9XX/5XX I2C
 controller.
Date: Tue, 17 Mar 2015 15:41:47 +0100
Message-ID: <20150317144147.GI10068@pengutronix.de>
References: <1426228198-3314-1-git-send-email-jchandra@broadcom.com>
 <1426228198-3314-3-git-send-email-jchandra@broadcom.com>
 <20150313102406.GP952@pengutronix.de>
 <20150314114836.GB611@jayachandranc.netlogicmicro.com>
 <20150314200124.GB5105@pengutronix.de>
 <20150317143039.GG19012@jayachandranc.netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150317143039.GG19012-l4W0uAg2RDvWG0bvociYJ/An/qbn1+6FOui0OUZsNXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jayachandran C." <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Tue, Mar 17, 2015 at 08:00:40PM +0530, Jayachandran C. wrote:
> On Sat, Mar 14, 2015 at 09:01:24PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Sat, Mar 14, 2015 at 05:18:37PM +0530, Jayachandran C. wrote:
> > > On Fri, Mar 13, 2015 at 11:24:06AM +0100, Uwe Kleine-K=F6nig wrot=
e:
> > > > On Fri, Mar 13, 2015 at 11:59:58AM +0530, Jayachandran C wrote:
> > > > > diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/bu=
sses/i2c-xlp9xx.c
> > > > > new file mode 100644
> > > > > index 00000000..2f303ad
> > > > > --- /dev/null
> > > > > +++ b/drivers/i2c/busses/i2c-xlp9xx.c
> > > > > @@ -0,0 +1,446 @@
> > > > > [...]
> > > > > +
> > > > > +/*
> > > > > + * see Documentation/devicetree/bindings/i2c/i2c-xlp9xx.txt =
for device
> > > > > + * tree bindings documentation
> > > > > + */
> > > > When I asked for documentation here, I didn't meant the device =
tree
> > > > binding, but the hardware reference manual.
> > >=20
> > > Unfortunately there is no standalone documentation for the I2C co=
ntroller,
> > > this block is used in XLP9xx and XLP5xx SoCs and you can get the =
documentation
> > > for the whole SoC from support.broadcom.com if you have an accoun=
t there.
> > I don't. According to the instructions to get such an account I hav=
e to
> > contact my "Sales/Engineering contacts at Broadcom or its
> > Distributors/Manufacturer's representatives directly". Who would th=
at be
> > for me? You?
>=20
> Not really. If you want to develop drivers for a XLP9xx board you
> have, then you should have an account at support site and the
> instructions apply.
I don't want to develop drivers for such a board, among other reasons
because I don't own one. But I want to make a review of such a driver.
And therefor a datasheet would be helpful.
=20
> The rationale given in device tree guidelines is that the silicon ven=
dor
> may release future chips which break the wildcard. In this specific c=
ase
> that issue will not happen, because the driver is from the silicon ve=
ndor.
> Anyway, for consistency, we will take out the wildcard in v4.
I honestly hope the high trust in your employer is justified. It didn't
work for me (for a different employer of course).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
