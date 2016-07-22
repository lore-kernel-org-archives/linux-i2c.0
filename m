From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: DT connectors, thoughts
Date: Fri, 22 Jul 2016 14:25:56 +1000
Message-ID: <20160722042556.GL15941@voom.fritz.box>
References: <577ACE0D.9050700@gmail.com>
 <20160718142037.GS16769@voom.fritz.box>
 <CAL_JsqLkMA1VHfHpP4oCWtONWq5GeyS731r8PjjeL_DZ4u1Z_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1X+6QtwRodzgDPAC"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:35499 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbcGVE0D (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jul 2016 00:26:03 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqLkMA1VHfHpP4oCWtONWq5GeyS731r8PjjeL_DZ4u1Z_g@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Pantelis Antoniou <panto@antoniou-consulting.com>


--1X+6QtwRodzgDPAC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2016 at 02:15:57PM -0500, Rob Herring wrote:
> On Mon, Jul 18, 2016 at 9:20 AM, David Gibson
> <david@gibson.dropbear.id.au> wrote:
> > Hi,
> >
> > Here's some of my thoughts on how a connector format for the DT could
> > be done.  Sorry it's taken longer than I hoped - I've been pretty
> > swamped in my day job.
> >
> > This is pretty early thoughts, but gives an outline of the approach I
> > prefer.
> >
> > So.. start with an example of a board DT including a widget socket,
> > which contains pins for an MMIO bus, an i2c bus and 2 interrupt lines.
> >
> > /dts-v1/;
> >
> > / {
> >         compatible =3D "foo,oldboard";
> >         ranges;
> >         soc@... {
> >                 ranges;
> >                 mmio: mmio-bus@... {
> >                         #address-cells =3D <2>;
> >                         #size-cells =3D <2>;
> >                         ranges;
> >                 };
> >                 i2c: i2c@... {
> >                 };
> >                 intc: intc@... {
> >                         #interrupt-cells =3D <2>;
> >                 };
> >         };
> >
> >         connectors {
> >                 widget1 {
> >                         compatible =3D "foo,widget-socket";
> >                         w1_irqs: irqs {
> >                                 interrupt-controller;
> >                                 #address-cells =3D <0>;
> >                                 #interrupt-cells =3D <1>;
> >                                 interrupt-map-mask =3D <0xffffffff>;
> >                                 interrupt-map =3D <
> >                                         0 &intc 7 0
> >                                         1 &intc 8 0
> >                                 >;
> >                         };
> >                         aliases =3D {
> >                                 i2c =3D &i2c;
> >                                 intc =3D &w1_irqs;
>=20
> I understand how you are using i2c alias, but not the intc. It would
> help if the same names were not used in multiple places unless they
> are the same thing.

Yes, sorry.  We have both the /soc/intc node which is the base board's
master interrupt controller.  Then we have the connector local 'intc'
alias which describes the local interrupt space for just the
connector.

> What does using aliases here buy us vs. just properties with a
> phandle?

Um.. I'm not sure what you mean.

> >                                 mmio =3D &mmio;
> >                         };
> >                 };
> >         };
> > };
> >
> > Note that the symbols are local to the connector, and explicitly
> > listed, rather than including all labels in the tree.  This is to
> > enforce (or at the very least encourage) plugins to only access those
> > parts of the base tree.
> >
> > Note also the use of an interrupt nexus node contained within the
> > connector to control which irqs the socketed device can use.  I think
> > this needs some work to properly handle unit addresses, but hope
> > that's enough to give the rough idea.
> >
> > So, what does the thing that goes in the socket look like?  I'm
> > thinking some new dts syntax like this:
> >
> > /dts-v1/;
> >
> > /plugin/ foo,widget-socket {
> >         compatible =3D "foo,whirligig-widget";
> > };
> >
> > &i2c {
> >         whirligig-controller@... {
> >                 ...
> >                 interrupt-parent =3D <&widget-irqs>;
> >                 interrupts =3D <0>;
> >         };
> > };
> >
> > Use of the /plugin/ keyword is rather different from existing
> > practice, so we may want a new one instead.
> >
> > The idea is that this would be compiled to something like:
> >
> > /dts-v1/;
> >
> > / {
> >         socket-type =3D "foo,widget-socket";
> >         compatible =3D "foo,whirligig-widget";
> >
> >         fragment@0 {
> >                 target-alias =3D "i2c";
>=20
> Yet another way to express the target... Every new feature for
> overlays seems to define a new way.

Well, yes.  Frankly I think that's because the original ways of
describing the target were not well thought out.  Using a phandle is
awkward because it will always be -1 until fixups are applied, which
seems a bit pointless (why not have the alias/label directly).  Using
a full path means that the overlay can overwrite anywhere in the base
tree which doesn't seem like good practice.

> My thinking was the target is a
> connector node and all devices are under it.

I thought about this, and I think it's technically possible, but it
gets really ugly.  The trouble is that connectors frequently have pins
onto multiple buses.  In order to combine those into a single parent
node, we'd have to combine the address spaces of all those buses.
That can be done using some complex multi-cell encoding, but it won't
be pretty.  Then to make the connection point be a single node in the
base tree you'd essentially have to combine all the buses used in the
connector throughout the base board DT, so that ugly multi-cell
encoding will have to be used throughout most of the base DT, not just
in the connector stuff.

> In your case, the
> connector is not part of the hierarchy for any devices in the overlay.
> That may simplify adding OS support, but seems to be a less accurate
> representation of the h/w.

I think its the best we can do.  Because connectors usually combine
multiple logically distinct buses, they really don't exist as a
well-defined point in a single heirarchy.

> >                 __overlay__ {
> >                         whirligig-controller@... {
> >                                 ...
> >                                 interrupt-parent =3D <0xffffffff>;
> >                                 interrupts =3D <0>;
> >                         };
> >                 };
> >         };
> >         __phandle_fixups__ {
> >                 /* These are (path, property, offset) tuples) */
> >                 widget-irqs =3D
> >                         "/fragment@0/__overlay__/whirligig-controller@.=
=2E.",
> >                         "interrupt-parent", <0>;
> >         };
> > };
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1X+6QtwRodzgDPAC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkaBUAAoJEGw4ysog2bOSZY8P/0ZFMrH/3sFIX+QAlR2iHrut
7FmT7kbRn5BNi6RkVg+zWh3MM5H0LtxxHzeqmkeFuEtKK1b5/0Lx1kGV7bcW5oqU
qTzWiwpFSC3v7oISMA9KLQLd2hvfyIBca2Qepa9zxsjXNWqtJyZhJaioYArNIwZR
IOrXEJg/L6yef/QdtoEzCTOH0lA5e4zFaQ5Vs/NKgeQwXl/bNMT1Xi0RR51uqmy6
58qQ/DN6MrUKsuCqEwZJ2Ienb8dD5yuMB63C3Vec/NoRmhjHOSWJ6fbReuDDkVV3
29MUa2RxEo2VyAv5WB6s33d3uhhizf80Kq5lhnDr2eQvY1llTHYx2ycBM8WepRwx
4F0TkekK9PBLO0/I+LKf3qPau9i+t2kDoMfMWHerlKd7/EcZRkhgrjLibVK6ZEZD
tW6RB4cw6y01TePCH5JpPwlWjYLt7kXSS8VFPhrzeOBNahEljBMbQx8JLYXKe4wt
8YtTV2g41O/qXdH5sM/Mxr/j5s2+8CRoeQ78fqKGR9gNyuf8FbRaE6Sh7cVPUoKi
IPx37Igmra3+bNscbKdiyTq7TAmbxnWVn+RPgZb92HdkdkV36gJjJDIrRf0fKme2
qVe1tASmFTZN3szrUvkWKUcvTL98lM4orkYmiMIoVkHnY6f+OPtyMclPFPpofbQZ
cyHMsM45VqDSLX8smLKw
=29EC
-----END PGP SIGNATURE-----

--1X+6QtwRodzgDPAC--
