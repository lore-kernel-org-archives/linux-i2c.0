From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/2] dt-bindings: i2c: mv64xxx: Add YAML schemas
Date: Wed, 5 Jun 2019 14:11:25 +0200
Message-ID: <20190605121125.4p2eyt7zhtai652b@flea>
References: <20190525141821.20082-1-maxime.ripard@bootlin.com>
 <20190525141821.20082-2-maxime.ripard@bootlin.com>
 <87k1e2k98v.fsf@FE-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2931956928720380166=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87k1e2k98v.fsf@FE-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============2931956928720380166==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jcggnhf3ykfk7lac"
Content-Disposition: inline


--jcggnhf3ykfk7lac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Jun 03, 2019 at 04:56:48PM +0200, Gregory CLEMENT wrote:
> > +++ b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
> > @@ -0,0 +1,106 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/i2c/marvell,mv64xxx-i2c.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Marvell MV64XXX I2C Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Chen-Yu Tsai <wens@csie.org>
> > +  - Maxime Ripard <maxime.ripard@bootlin.com>
>
> If you take over the maintenanceship and became maintainer for this
> driver, then update the MAINTAINERS files too. For now it was assigned
> to me, but I don't mind letting this for both of you.
>
> Actually I gave my acked-by to a patch from Wolfram adding the
> Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt file to the "I2C
> MV64XXX MARVELL AND ALLWINNER DRIVER" entry "MAINTAINERS: add DT
> bindings to i2c-mv64xxx" so I guess this patch have to be discarded or
> at least updated.

Sorry for that, it's definitely not intentional. I'll fix it and resend.

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jcggnhf3ykfk7lac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPexbQAKCRDj7w1vZxhR
xe/dAP9810+E+YG6xK7o/znoo25OToisA4qAfR89Ox8darfLQgEAjPOHR1jQl2S+
xakb+9c/vF+oAFjJD//9cLNS1UOxHgE=
=JR2U
-----END PGP SIGNATURE-----

--jcggnhf3ykfk7lac--


--===============2931956928720380166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2931956928720380166==--
