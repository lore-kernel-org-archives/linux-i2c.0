From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: DT connectors, thoughts
Date: Thu, 21 Jul 2016 23:42:08 +1000
Message-ID: <20160721134208.GD12120@voom.fritz.box>
References: <577ACE0D.9050700@gmail.com>
 <20160718142037.GS16769@voom.fritz.box>
 <442C02A9-582D-4FD8-8F05-7A6FCD5B6BCA@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <442C02A9-582D-4FD8-8F05-7A6FCD5B6BCA@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, stephen.boyd@linaro.org, broonie@kernel.org, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, marex@denx.de, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2016 at 11:59:44PM +0300, Pantelis Antoniou wrote:
> Hi David,
>=20
> Spent some time looking at this, and it looks like it=E2=80=99s going to =
the right direction.
>=20
> Comments inline.
>=20
> > On Jul 18, 2016, at 17:20 , David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >=20
> > Hi,
> >=20
> > Here's some of my thoughts on how a connector format for the DT could
> > be done.  Sorry it's taken longer than I hoped - I've been pretty
> > swamped in my day job.
> >=20
> > This is pretty early thoughts, but gives an outline of the approach I
> > prefer.
> >=20
> > So.. start with an example of a board DT including a widget socket,
> > which contains pins for an MMIO bus, an i2c bus and 2 interrupt lines.
> >=20
> > /dts-v1/;
> >=20
> > / {
> > 	compatible =3D "foo,oldboard";
> > 	ranges;
> > 	soc@... {
> > 		ranges;
> > 		mmio: mmio-bus@... {
> > 			#address-cells =3D <2>;
> > 			#size-cells =3D <2>;
> > 			ranges;
> > 		};
>=20
> MMIO busses are going the way of the dodo and we have serious problems
> handling them in linux in a connector (and a portable manner).
> While we have drivers for GPMC devices we don=E2=80=99t have an in kernel=
 framework
> for handling them.
>=20
> A single address range does not contain enough information to program a G=
PMC interface
> with all the timings and chip select options. It might be possible to dec=
lare a
> pre-define memory window on the connector, but it=E2=80=99s use on a real=
 system might
> be limited.

Ok.  I think the example has some value in showing how MMIO ranges and
mapping could be expressed even if it's only part of something more
complex than a simple MMIO bus.

For example I could imagine a connector which includes PCI and some
irq lines.  The PCI part is probable, of course, but a PCI device
wired to one of the hard interrupt lines instead of a PCI interrupt
line would need some DT information.  Of course non-Express, non-MSI
PCI is pretty much extinct too, but it's not much of a stretch to
imagine that something which requires some portion of MMIO mapping is
out there or will come along.

> I think it=E2=80=99s best we focus on standard busses like i2c/spi/i2s/mm=
c and gpios and
> interrupts for now.
>=20
> > 		i2c: i2c@... {
> > 		};
> > 		intc: intc@... {
> > 			#interrupt-cells =3D <2>;
> > 		};
> > 	};
> >=20
> > 	connectors {
> > 		widget1 {
> > 			compatible =3D "foo,widget-socket";
> > 			w1_irqs: irqs {
> > 				interrupt-controller;
> > 				#address-cells =3D <0>;
> > 				#interrupt-cells =3D <1>;
> > 				interrupt-map-mask =3D <0xffffffff>;
> > 				interrupt-map =3D <
> > 					0 &intc 7 0
> > 					1 &intc 8 0
> > 				>;
> > 			};
>=20
> This is fine. We need an interrupt controller node.

Actually I think we only need an interrupt nexus, not an interrupt
controller (in IEEE1275 terminology).  (An interrupt controller would
generally require it's own driver, to ack/mask irqs, whereas this just
demonstrates the routing to an existing interrupt controller).  Which
makes that example slightly incorrect (it shouldn't have the
interrupt-controller property).

> In a similar manner we need GPIOs too for every GPIO option on the
> connector. Could we fold this in the same node?

IIRC the GPIO binding is pretty much modeled on the interrupt binding
and has a similar "nexus" concept.  I was expecting the same thing for
GPIO.  It's expressed with different properties to those for irqs,
obviously, so I guess it could be in the same node.  Whether it's
clearer to have them in the same or separate nodes I suspect would
depend on the specifics of the board.

> > 			aliases =3D {
> > 				i2c =3D &i2c;
> > 				intc =3D &w1_irqs;
> > 				mmio =3D &mmio;
> > 			};
> > 		};
> > 	};
> > };
> >=20
> > Note that the symbols are local to the connector, and explicitly
> > listed, rather than including all labels in the tree.  This is to
> > enforce (or at the very least encourage) plugins to only access those
> > parts of the base tree.
> >=20
> > Note also the use of an interrupt nexus node contained within the
> > connector to control which irqs the socketed device can use.  I think
> > this needs some work to properly handle unit addresses, but hope
> > that's enough to give the rough idea.
> >=20
> > So, what does the thing that goes in the socket look like?  I'm
> > thinking some new dts syntax like this:
> >=20
> > /dts-v1/;
> >=20
> > /plugin/ foo,widget-socket {
> > 	compatible =3D "foo,whirligig-widget";
> > };
> >=20
> > &i2c {
> > 	whirligig-controller@... {
> > 		...
> > 		interrupt-parent =3D <&widget-irqs>;
> > 		interrupts =3D <0>;
> > 	};
> > };
> >=20
>=20
> OK, this is brand new syntax. I=E2=80=99m all for it if it makes things e=
asier.
>=20
> > Use of the /plugin/ keyword is rather different from existing
> > practice, so we may want a new one instead.
> >=20
>=20
> It=E2=80=99s a bit weird looking and is bound to cause confusion.
> How about something like /expansion/ ?

That could work.

> > The idea is that this would be compiled to something like:
> >=20
> > /dts-v1/;
> >=20
> > / {
> > 	socket-type =3D "foo,widget-socket";
> > 	compatible =3D "foo,whirligig-widget";
> >=20
> > 	fragment@0 {
> > 		target-alias =3D "i2c";
> > 		__overlay__ {
> > 			whirligig-controller@... {
> > 				...
> > 				interrupt-parent =3D <0xffffffff>;
> > 				interrupts =3D <0>;
> > 			};
> > 		};
> > 	};
> > 	__phandle_fixups__ {
> > 		/* These are (path, property, offset) tuples) */
> > 		widget-irqs =3D
> > 			"/fragment@0/__overlay__/whirligig-controller@...",
> > 			"interrupt-parent", <0>;
> > 	};
>=20
> I=E2=80=99m not quite sure this is going to work for multiple use of widg=
et-irqs handle,
> but it=E2=80=99s a detail for now.

Just concatenate all the tuples, so path, property, offset, path,
property, offset, etc..

> What is the action undertaken when a bus is activated? Looks like it=E2=
=80=99s going to
> be similar to my patch where the target/alias bus is given a status=3D=E2=
=80=9Cokay=E2=80=9D; property
> and activated, after all subnodes that contain i2c devices are copied the=
re.=20

Erm.. what exactly do you mean by "activated"?  At the moment you
could put a status=3D"okay" in the plugin component, and that would be
applied (as long as it goes in one of the accessible attachment
points).

Which does bring up a point.  I did wonder if the approach above
allows the plugin to do too much - e.g. overriding properties in the
i2c controller node, rather than just adding children.  So I did
wonder if we wanted a restriction that only new nodes can be added at
the top level of the plugin fragment.

Alternatively that might be achievable by (as a recommended / best
practice) putting a "container" subnode under each attachable bus on
the master dt and pointing the aliases at that instead of the actual
base bus controller.  With the right 'ranges' etc. that might
accomplish what's needed without extra semantics, but I'm not certain.

Ah.. which makes me think of another point.  In this proposal the
aliases is used to control both where fragments can be attached, and
what nodes can be referenced by phandle.  But we probably want to
split those concepts: e.g. the plugin will need to reference the
interrupt controller / nexus, but probably shouldn't be allowed to
override its properties.

> > };
> >=20
> >=20
> > Suppose then there's a new version of the board.  This extends the
> > widget socket in a backwards compatible way, but there are now two
> > interchangeable sockets, and they're wired up to different irqs and
> > i2c lines on the baseboard:
> >=20
> > /dts-v1/;
> >=20
> > / {
> > 	compatible =3D "foo,newboard";
> > 	ranges;
> > 	soc@... {
> > 		ranges;=09
> > 		mmio: mmio-bus@... {
> > 			#address-cells =3D <2>;
> > 			#size-cells =3D <2>;
> > 			ranges;
> > 		};
> > 		i2c0: i2c@... {
> > 		};
> > 		i2c1: i2c@... {
> > 		};
> > 		intc: intc@... {
> > 		};
> > 	};
> >=20
> > 	connectors {
> > 		widget1 {
> > 			compatible =3D "foo,widget-socket-v2", "foo,widget-socket";
> > 			w1_irqs: irqs {
> > 				interrupt-controller;
> > 				#address-cells =3D <0>;
> > 				#interrupt-cells =3D <1>;
> > 				interrupt-map-mask =3D <0xffffffff>;
> > 				interrupt-map =3D <
> > 					0 &intc 17 0
> > 					1 &intc 8 0
> > 				>;
> > 			};
> > 			aliases =3D {
> > 				i2c =3D &i2c0;
> > 				intc =3D &w1_irqs;
> > 				mmio =3D &mmio;
> > 			};
> > 		};
> > 		widget2 {
> > 			compatible =3D "foo,widget-socket-v2", "foo,widget-socket";
> > 			w2_irqs: irqs {
> > 				interrupt-controller;
> > 				#address-cells =3D <0>;
> > 				#interrupt-cells =3D <1>;
> > 				interrupt-map-mask =3D <0xffffffff>;
> > 				interrupt-map =3D <
> > 					0 &intc 9 0
> > 					1 &intc 10 0
> > 				>;
> > 			};
> > 			aliases =3D {
> > 				i2c =3D &i2c1;
> > 				widget-irqs =3D &w2_irqs;
> > 				mmio =3D &mmio;
> > 			};
> > 		};
> > 	};
> > };
> >=20
> >=20
> > A socketed device could also have it's own connectors - the contrived
> > example below has a little 256 byte mmio space (maybe some sort of LPC
> > thingy?):
> >=20
> >=20
> > /dts-v1/;
> >=20
> > /plugin/ foo,widget-socket-v2 {
> > 	compatible =3D "foo,superduper-widget};
> >=20
> > 	connectors {
> > 		compatible =3D "foo,super-socket";
> > 		aliases {
> > 			superbus =3D &superbus;
> > 		};=09
> > 	};
> > };
> >=20
> > &mmio {
> > 	superbus: super-bridge@100000000 {
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <1>;
> > 		ranges =3D <0x0  0xabcd0000 0x12345600  0x100>;
> > 	};
> > };
> >=20
> > &i2c {
> > 	super-controller@... {
> > 		...
> > 	};
> > 	duper-controller@... {
> > 	};
> > };
> >=20
> > Thoughts?
> >=20
>=20
> It=E2=80=99s a step in the right direction, especially if we nail down the
> syntax.

Excellent.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkNEvAAoJEGw4ysog2bOSTxIQAJNrPtABzLP+HpS5UaI6RKdL
G9avJarc4+6Jcrmx06AFvkW3Yy4vO2KyBkFlM+jTpb9NUTBwOz5H5pIRAfdl7RI9
nBwbJVN5cyUTojUavI0ihzDQGxpqZTOGPh7cKJa31dfxMLG8701EtIsaVp7SJxOS
cRxS1SHsejRWkg7CpP9GULEKAv8ipQ+u44sBMb9/3WZBlhd+4nw6DNGJYg3AFVPc
5DPx6pOtSsglKeR2jy4T6og+GCOckcdS7fmH/4VM9euIPNUN9EUY25h5pPdkZJC2
GGkBfibqyvpjQXQUtzhnN2/eg9e7LnBn0/Uon2EWdcCgvqm18ffzDkLvuKn6iJuA
pE3plYRAdXqWoMnuokkKhPilVOIR93IvJIQ4kBjviYzQeXhZW5Xxw1hJSbP85148
0qUH6tNNYChYw92nKmHitWxMKYIGdwqUnp4yjiTvfo1NcqapYiKlqPcqvsEvqaoN
XF1BLItX5OueOknA722/xwpB2KsOPfZXgneUE1o+43mo4XtNLLx/ZTeffDJWh548
cNfFaertYGYD6EUJzUvWJHgWuBpo5P3wHa72/pPqG2Em5xfYrvG56T8sulBm6vKp
IMsWhs9UWae3ziHcg8csQEvg55l/85+i5xnP1+TgHixTi9NSfJScVIyjFiaFGefL
x6VO4YNWW9FJDQXKG2cK
=J2fw
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
