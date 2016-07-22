From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: DT connectors, thoughts
Date: Fri, 22 Jul 2016 13:47:15 +1000
Message-ID: <20160722034715.GJ15941@voom.fritz.box>
References: <577ACE0D.9050700@gmail.com>
 <20160718142037.GS16769@voom.fritz.box>
 <442C02A9-582D-4FD8-8F05-7A6FCD5B6BCA@konsulko.com>
 <20160721134208.GD12120@voom.fritz.box>
 <A1018E27-B604-4DD5-ADBA-95EF76F6DDAC@konsulko.com>
 <CAL_JsqLc0N8o2Nc_dEcZChJqWyN3UtZEgzLd=j6dR=1y3xOvdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5cSRzy0VGBWAML+b"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:33424 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294AbcGVE0D (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jul 2016 00:26:03 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqLc0N8o2Nc_dEcZChJqWyN3UtZEgzLd=j6dR=1y3xOvdA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Frank Rowand <frowand.list@gmail.com>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--5cSRzy0VGBWAML+b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2016 at 02:09:18PM -0500, Rob Herring wrote:
> On Thu, Jul 21, 2016 at 9:14 AM, Pantelis Antoniou
> <pantelis.antoniou@konsulko.com> wrote:
> > Hi David,
> >
> >> On Jul 21, 2016, at 16:42 , David Gibson <david@gibson.dropbear.id.au>=
 wrote:
> >>
> >> On Wed, Jul 20, 2016 at 11:59:44PM +0300, Pantelis Antoniou wrote:
> >>> Hi David,
> >>>
> >>> Spent some time looking at this, and it looks like it=E2=80=99s going=
 to the right direction.
> >>>
> >>> Comments inline.
> >>>
> >>>> On Jul 18, 2016, at 17:20 , David Gibson <david@gibson.dropbear.id.a=
u> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> Here's some of my thoughts on how a connector format for the DT could
> >>>> be done.  Sorry it's taken longer than I hoped - I've been pretty
> >>>> swamped in my day job.
> >>>>
> >>>> This is pretty early thoughts, but gives an outline of the approach I
> >>>> prefer.
>=20
> [...]
>=20
> >>>>             i2c: i2c@... {
> >>>>             };
> >>>>             intc: intc@... {
> >>>>                     #interrupt-cells =3D <2>;
> >>>>             };
> >>>>     };
> >>>>
> >>>>     connectors {
> >>>>             widget1 {
> >>>>                     compatible =3D "foo,widget-socket";
> >>>>                     w1_irqs: irqs {
> >>>>                             interrupt-controller;
> >>>>                             #address-cells =3D <0>;
> >>>>                             #interrupt-cells =3D <1>;
> >>>>                             interrupt-map-mask =3D <0xffffffff>;
> >>>>                             interrupt-map =3D <
> >>>>                                     0 &intc 7 0
> >>>>                                     1 &intc 8 0
> >>>>                             >;
> >>>>                     };
> >>>
> >>> This is fine. We need an interrupt controller node.
> >>
> >> Actually I think we only need an interrupt nexus, not an interrupt
> >> controller (in IEEE1275 terminology).  (An interrupt controller would
> >> generally require it's own driver, to ack/mask irqs, whereas this just
> >> demonstrates the routing to an existing interrupt controller).  Which
> >> makes that example slightly incorrect (it shouldn't have the
> >> interrupt-controller property).
> >
> > Hmm, as far as I can tell we only have a concept of an interrupt contro=
ller
> > in the kernel. An interrupt nexus is something new. We should get by wi=
thout
> > a driver but hacking the interrupt lookup path at DT.
>=20
> Interrupt nexus is the interrupt-map property which is fully
> supported. I'd expect we'll end up with a gpio nexus (i.e. gpio-map)
> for connector gpios, too.

Exactly.  I don't know if a gpio-map is already defined, but if it's
not it should be.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5cSRzy0VGBWAML+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkZdDAAoJEGw4ysog2bOSUcMP/ifV15IlioQlmIMPg9cNHStf
Nyt53MPUYmHDkSwwUGkdUXHQnVR0hzQxZT9nZXoq4X74YqHM0UsY4lZw5UCQRooD
ruIZri1sDCeopBR156KB4HAQI26mDQ5OlhBVn6PthCam3usnG8ocGa8WMxM4t36Q
72s7SzGEHQE01Z3RC/6adBrn18fus0fbZTfmtk+g23HfDmit2KrMYoqgnnFzMNE4
QyLVHV0ISKTz/g59KZRx8nA7cBdIk2CRtm66bT0W2P9SavnVfswBoNBgpcXHESY+
y982W5k5W5FoIomstlNW1F+CKvpGetTb4TcM5LRgEiuaFz7c+iD+8NVqVUNd2xJ3
OYU+A0NVPOrgan2/ti61aF0bnOhW1Erph6qRn/vphWXvFjEcVFUGKAdygoU5g4zM
vMY+27lyxW1Srm6C2FW+AkvnLglqgvTSTE46/esLC+geyG6445ZiJCTDQoH2wbqJ
eFp9Y6Y04CLqHdPj17NcI47IVXr2+I7+UwSFN9STa2zJrc1+y72IETG8XGhr3PmP
N2pBawv1Uj4yMe9k9AZ2Mzonbf90KGVbB88rZ/F6JJF1b+eIWkntQWsK6pscxynT
5IjR1mHIZTe9mdv6Y+BP1e8hGDBSo3M3fUzSYBkPDnbptl5lPLieEEdyRX5tnLZU
DKJjUYOq+awKJ79GqrKP
=3WON
-----END PGP SIGNATURE-----

--5cSRzy0VGBWAML+b--
