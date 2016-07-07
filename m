From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Portable Device Tree Connector -- conceptual
Date: Thu, 7 Jul 2016 14:51:35 +1000
Message-ID: <20160707045135.GU14675@voom.fritz.box>
References: <5775B2FD.2000103@gmail.com>
 <199EAB87-47DA-4213-BE60-43C2E062AAD5@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MjBORTcaENZKFEO1"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:57666 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867AbcGGFMt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 7 Jul 2016 01:12:49 -0400
Content-Disposition: inline
In-Reply-To: <199EAB87-47DA-4213-BE60-43C2E062AAD5@konsulko.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org


--MjBORTcaENZKFEO1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 01, 2016 at 01:59:58PM +0300, Pantelis Antoniou wrote:
> Hi Frank,
>=20
> Comments inline.
>=20
> > On Jul 1, 2016, at 03:02 , Frank Rowand <frowand.list@gmail.com> wrote:
> >=20
> > Hi All,
> >=20
> > I've been trying to wrap my head around what Pantelis and Rob have writ=
ten
> > on the subject of a device tree representation of a connector for a
> > daughter board to connect to (eg a cape or a shield) and the representa=
tion
> > of the daughter board.  (Or any other physically pluggable object.)
> >=20
> > After trying to make sense of what had been written (or presented via s=
lides
> > at a conference - thanks Pantelis!), I decided to go back to first prin=
cipals
> > of what we are trying to accomplish.  I came up with some really simple=
 bogus
> > examples to try to explain what my thought process is.
> >=20
> > To start with, assume that the device that will eventually be on a daug=
hter
> > board is first soldered onto the main board.  Then the device tree will
> > look like:
> >=20
> > $ cat board.dts
> > /dts-v1/;
> >=20
> > / {
> >        #address-cells =3D < 1 >;
> >        #size-cells =3D < 1 >;
> >=20
> >        tree_1: soc@0 {
> >                reg =3D <0x0 0x0>;
> >=20
> >                spi_1: spi1 {
> >                };
> >        };
> >=20
> > };
> >=20
> > &spi_1 {
> >        ethernet-switch@0 {
> >                compatible =3D "micrel,ks8995m";
> >        };
> > };
> >=20
> > #include "spi_codec.dtsi"
> >=20
> > $ cat spi_codec.dtsi
> > &spi_1 {
> > 	codec@1 {
> > 		compatible =3D "ti,tlv320aic26";
> > 	};
> > };
> >=20
> >=20
> > #----- codec chip on cape
> >=20
> > Then suppose I move the codec chip to a cape.  Then I will have the same
> > exact .dts and .dtsi and everything still works.
> >=20
> >=20
> > @----- codec chip on cape, overlay
> >=20
> > If I want to use overlays, I only have to add the version and "/plugin/=
",
> > then use the '-@' flag for dtc (both for the previous board.dts and
> > this spi_codec_overlay.dts):
> >=20
> > $ cat spi_codec_overlay.dts
> > /dts-v1/;
> >=20
> > /plugin/;
> >=20
> > &spi_1 {
> > 	codec@1 {
> > 		compatible =3D "ti,tlv320aic26";
> > 	};
> > };
> >=20
>=20
> The correct form now for the /plugin/ declaration should be like
>=20
> /dts-v1/ /plugin/;
>=20
> The old method still works for backward compatibility.
>=20
> In fact with the new patches you don=E2=80=99t even /plugin/ since when
> compiling an overlay we can turn on the plugin flag by looking
> at the output type (dtbo).

I'd prefer to see the dtbo option go away however, in favour of the
/plugin/ flag.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MjBORTcaENZKFEO1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfd/XAAoJEGw4ysog2bOS8qsP/3CjUuWsS5lKY0mtmBALXrBB
z1ECNkUyWUrmVfxbD2RgaR9rZQ0JbvZxFcVxHh53qxf1jIxOGhLpWbCgkSRn+gAB
LJT3/I60DrJqbEO0XcSzU8Ic1ARjU4BTeyjgY7WqHOlEWToaOZRaXJQy0glhA1R5
gELZeXXnVg70OEThI9JIkxJB3rs5rv0k2gkjsX9J+M2PtlkbaO38V4+CSoH2b2I3
83rDyPE+bdivlDMfDh1vPVLfScFCXjGh7/Wmp13K3YPd0k+7Jdq8Huzbpsxax24N
ElvOaUJp1wdIDr3FZvnzZy2EOoT/1nj/FuwAkVab+MKiv4norBhf9Cg7n+yTdb96
Z51EHwlXpUMdVvdTpGJw8YMQpYk5M36IN2cHdkfj6eCGJFcYlCwEnQP+/1hmBDI3
5WaUZB4c53kl0B5VtKZAifUGzpqMrsFXn/TG1bbNTpJmCwNyhnA4anJazzrv2NZw
NrCvc7L5xExu8Z59Jc1Knqg3CLe1U+iKgWil0YYtR43i3+OXoUaFvkeHgO47H4Rp
sIY7lfLy53yLxza0dT5WTsDZ18XEEixwBntRyPaR8yZ1Z5GC51LEYyuKBtVFWL7D
TyoQieni3M0a36jKudj7EiTtYaAfUlcwvMV5dLhsPmhxBxzecp7wIymB3xEFTkXl
laM5DLMsGbKvVtrmL+kv
=E741
-----END PGP SIGNATURE-----

--MjBORTcaENZKFEO1--
