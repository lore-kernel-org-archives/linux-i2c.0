From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: DT connectors, thoughts
Date: Wed, 20 Jul 2016 23:59:44 +0300
Message-ID: <442C02A9-582D-4FD8-8F05-7A6FCD5B6BCA@konsulko.com>
References: <577ACE0D.9050700@gmail.com> <20160718142037.GS16769@voom.fritz.box>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160718142037.GS16769@voom.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, stephen.boyd@linaro.org, broonie@kernel.org, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, marex@denx.de, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

Spent some time looking at this, and it looks like it=E2=80=99s going t=
o the right direction.

Comments inline.

> On Jul 18, 2016, at 17:20 , David Gibson <david@gibson.dropbear.id.au=
> wrote:
>=20
> Hi,
>=20
> Here's some of my thoughts on how a connector format for the DT could
> be done.  Sorry it's taken longer than I hoped - I've been pretty
> swamped in my day job.
>=20
> This is pretty early thoughts, but gives an outline of the approach I
> prefer.
>=20
> So.. start with an example of a board DT including a widget socket,
> which contains pins for an MMIO bus, an i2c bus and 2 interrupt lines=
=2E
>=20
> /dts-v1/;
>=20
> / {
> 	compatible =3D "foo,oldboard";
> 	ranges;
> 	soc@... {
> 		ranges;
> 		mmio: mmio-bus@... {
> 			#address-cells =3D <2>;
> 			#size-cells =3D <2>;
> 			ranges;
> 		};

MMIO busses are going the way of the dodo and we have serious problems
handling them in linux in a connector (and a portable manner).
While we have drivers for GPMC devices we don=E2=80=99t have an in kern=
el framework
for handling them.

A single address range does not contain enough information to program a=
 GPMC interface
with all the timings and chip select options. It might be possible to d=
eclare a
pre-define memory window on the connector, but it=E2=80=99s use on a re=
al system might
be limited.

I think it=E2=80=99s best we focus on standard busses like i2c/spi/i2s/=
mmc and gpios and
interrupts for now.

> 		i2c: i2c@... {
> 		};
> 		intc: intc@... {
> 			#interrupt-cells =3D <2>;
> 		};
> 	};
>=20
> 	connectors {
> 		widget1 {
> 			compatible =3D "foo,widget-socket";
> 			w1_irqs: irqs {
> 				interrupt-controller;
> 				#address-cells =3D <0>;
> 				#interrupt-cells =3D <1>;
> 				interrupt-map-mask =3D <0xffffffff>;
> 				interrupt-map =3D <
> 					0 &intc 7 0
> 					1 &intc 8 0
> 				>;
> 			};

This is fine. We need an interrupt controller node.

In a similar manner we need GPIOs too for every GPIO option on the
connector. Could we fold this in the same node?

> 			aliases =3D {
> 				i2c =3D &i2c;
> 				intc =3D &w1_irqs;
> 				mmio =3D &mmio;
> 			};
> 		};
> 	};
> };
>=20
> Note that the symbols are local to the connector, and explicitly
> listed, rather than including all labels in the tree.  This is to
> enforce (or at the very least encourage) plugins to only access those
> parts of the base tree.
>=20
> Note also the use of an interrupt nexus node contained within the
> connector to control which irqs the socketed device can use.  I think
> this needs some work to properly handle unit addresses, but hope
> that's enough to give the rough idea.
>=20
> So, what does the thing that goes in the socket look like?  I'm
> thinking some new dts syntax like this:
>=20
> /dts-v1/;
>=20
> /plugin/ foo,widget-socket {
> 	compatible =3D "foo,whirligig-widget";
> };
>=20
> &i2c {
> 	whirligig-controller@... {
> 		...
> 		interrupt-parent =3D <&widget-irqs>;
> 		interrupts =3D <0>;
> 	};
> };
>=20

OK, this is brand new syntax. I=E2=80=99m all for it if it makes things=
 easier.

> Use of the /plugin/ keyword is rather different from existing
> practice, so we may want a new one instead.
>=20

It=E2=80=99s a bit weird looking and is bound to cause confusion.
How about something like /expansion/ ?

> The idea is that this would be compiled to something like:
>=20
> /dts-v1/;
>=20
> / {
> 	socket-type =3D "foo,widget-socket";
> 	compatible =3D "foo,whirligig-widget";
>=20
> 	fragment@0 {
> 		target-alias =3D "i2c";
> 		__overlay__ {
> 			whirligig-controller@... {
> 				...
> 				interrupt-parent =3D <0xffffffff>;
> 				interrupts =3D <0>;
> 			};
> 		};
> 	};
> 	__phandle_fixups__ {
> 		/* These are (path, property, offset) tuples) */
> 		widget-irqs =3D
> 			"/fragment@0/__overlay__/whirligig-controller@...",
> 			"interrupt-parent", <0>;
> 	};

I=E2=80=99m not quite sure this is going to work for multiple use of wi=
dget-irqs handle,
but it=E2=80=99s a detail for now.

What is the action undertaken when a bus is activated? Looks like it=E2=
=80=99s going to
be similar to my patch where the target/alias bus is given a status=3D=E2=
=80=9Cokay=E2=80=9D; property
and activated, after all subnodes that contain i2c devices are copied t=
here.=20
> };
>=20
>=20
> Suppose then there's a new version of the board.  This extends the
> widget socket in a backwards compatible way, but there are now two
> interchangeable sockets, and they're wired up to different irqs and
> i2c lines on the baseboard:
>=20
> /dts-v1/;
>=20
> / {
> 	compatible =3D "foo,newboard";
> 	ranges;
> 	soc@... {
> 		ranges;=09
> 		mmio: mmio-bus@... {
> 			#address-cells =3D <2>;
> 			#size-cells =3D <2>;
> 			ranges;
> 		};
> 		i2c0: i2c@... {
> 		};
> 		i2c1: i2c@... {
> 		};
> 		intc: intc@... {
> 		};
> 	};
>=20
> 	connectors {
> 		widget1 {
> 			compatible =3D "foo,widget-socket-v2", "foo,widget-socket";
> 			w1_irqs: irqs {
> 				interrupt-controller;
> 				#address-cells =3D <0>;
> 				#interrupt-cells =3D <1>;
> 				interrupt-map-mask =3D <0xffffffff>;
> 				interrupt-map =3D <
> 					0 &intc 17 0
> 					1 &intc 8 0
> 				>;
> 			};
> 			aliases =3D {
> 				i2c =3D &i2c0;
> 				intc =3D &w1_irqs;
> 				mmio =3D &mmio;
> 			};
> 		};
> 		widget2 {
> 			compatible =3D "foo,widget-socket-v2", "foo,widget-socket";
> 			w2_irqs: irqs {
> 				interrupt-controller;
> 				#address-cells =3D <0>;
> 				#interrupt-cells =3D <1>;
> 				interrupt-map-mask =3D <0xffffffff>;
> 				interrupt-map =3D <
> 					0 &intc 9 0
> 					1 &intc 10 0
> 				>;
> 			};
> 			aliases =3D {
> 				i2c =3D &i2c1;
> 				widget-irqs =3D &w2_irqs;
> 				mmio =3D &mmio;
> 			};
> 		};
> 	};
> };
>=20
>=20
> A socketed device could also have it's own connectors - the contrived
> example below has a little 256 byte mmio space (maybe some sort of LP=
C
> thingy?):
>=20
>=20
> /dts-v1/;
>=20
> /plugin/ foo,widget-socket-v2 {
> 	compatible =3D "foo,superduper-widget};
>=20
> 	connectors {
> 		compatible =3D "foo,super-socket";
> 		aliases {
> 			superbus =3D &superbus;
> 		};=09
> 	};
> };
>=20
> &mmio {
> 	superbus: super-bridge@100000000 {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		ranges =3D <0x0  0xabcd0000 0x12345600  0x100>;
> 	};
> };
>=20
> &i2c {
> 	super-controller@... {
> 		...
> 	};
> 	duper-controller@... {
> 	};
> };
>=20
> Thoughts?
>=20

It=E2=80=99s a step in the right direction, especially if we nail down =
the syntax.

>=20
> --=20
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _o=
ther_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson

Regards

=E2=80=94 Pantelis
