From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: DT connectors, thoughts
Date: Fri, 22 Jul 2016 13:46:42 +1000
Message-ID: <20160722034642.GI15941@voom.fritz.box>
References: <577ACE0D.9050700@gmail.com>
 <20160718142037.GS16769@voom.fritz.box>
 <442C02A9-582D-4FD8-8F05-7A6FCD5B6BCA@konsulko.com>
 <20160721134208.GD12120@voom.fritz.box>
 <A1018E27-B604-4DD5-ADBA-95EF76F6DDAC@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fmvA4kSBHQVZhkR6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <A1018E27-B604-4DD5-ADBA-95EF76F6DDAC@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--fmvA4kSBHQVZhkR6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2016 at 05:14:33PM +0300, Pantelis Antoniou wrote:
> Hi David,
>=20
> > On Jul 21, 2016, at 16:42 , David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >=20
> > On Wed, Jul 20, 2016 at 11:59:44PM +0300, Pantelis Antoniou wrote:
> >> Hi David,
> >>=20
> >> Spent some time looking at this, and it looks like it=E2=80=99s going =
to the right direction.
> >>=20
> >> Comments inline.
> >>=20
> >>> On Jul 18, 2016, at 17:20 , David Gibson <david@gibson.dropbear.id.au=
> wrote:
> >>>=20
> >>> Hi,
> >>>=20
> >>> Here's some of my thoughts on how a connector format for the DT could
> >>> be done.  Sorry it's taken longer than I hoped - I've been pretty
> >>> swamped in my day job.
> >>>=20
> >>> This is pretty early thoughts, but gives an outline of the approach I
> >>> prefer.
> >>>=20
> >>> So.. start with an example of a board DT including a widget socket,
> >>> which contains pins for an MMIO bus, an i2c bus and 2 interrupt lines.
> >>>=20
> >>> /dts-v1/;
> >>>=20
> >>> / {
> >>> 	compatible =3D "foo,oldboard";
> >>> 	ranges;
> >>> 	soc@... {
> >>> 		ranges;
> >>> 		mmio: mmio-bus@... {
> >>> 			#address-cells =3D <2>;
> >>> 			#size-cells =3D <2>;
> >>> 			ranges;
> >>> 		};
> >>=20
> >> MMIO busses are going the way of the dodo and we have serious problems
> >> handling them in linux in a connector (and a portable manner).
> >> While we have drivers for GPMC devices we don=E2=80=99t have an in ker=
nel framework
> >> for handling them.
> >>=20
> >> A single address range does not contain enough information to program =
a GPMC interface
> >> with all the timings and chip select options. It might be possible to =
declare a
> >> pre-define memory window on the connector, but it=E2=80=99s use on a r=
eal system might
> >> be limited.
> >=20
> > Ok.  I think the example has some value in showing how MMIO ranges and
> > mapping could be expressed even if it's only part of something more
> > complex than a simple MMIO bus.
> >=20
>=20
> Yep.
>=20
> > For example I could imagine a connector which includes PCI and some
> > irq lines.  The PCI part is probable, of course, but a PCI device
> > wired to one of the hard interrupt lines instead of a PCI interrupt
> > line would need some DT information.  Of course non-Express, non-MSI
> > PCI is pretty much extinct too, but it's not much of a stretch to
> > imagine that something which requires some portion of MMIO mapping is
> > out there or will come along.
>=20
> Yes, this is actually a real system we=E2=80=99re developing against. Non=
 PCI-E
> and non-MSI PCI is not extinct, it=E2=80=99s still kicking about, althoug=
h not
> in server/desktop class machines.
>=20
> We should be able to figure things out. =20
>=20
> >=20
> >> I think it=E2=80=99s best we focus on standard busses like i2c/spi/i2s=
/mmc and gpios and
> >> interrupts for now.
> >>=20
> >>> 		i2c: i2c@... {
> >>> 		};
> >>> 		intc: intc@... {
> >>> 			#interrupt-cells =3D <2>;
> >>> 		};
> >>> 	};
> >>>=20
> >>> 	connectors {
> >>> 		widget1 {
> >>> 			compatible =3D "foo,widget-socket";
> >>> 			w1_irqs: irqs {
> >>> 				interrupt-controller;
> >>> 				#address-cells =3D <0>;
> >>> 				#interrupt-cells =3D <1>;
> >>> 				interrupt-map-mask =3D <0xffffffff>;
> >>> 				interrupt-map =3D <
> >>> 					0 &intc 7 0
> >>> 					1 &intc 8 0
> >>> 				>;
> >>> 			};
> >>=20
> >> This is fine. We need an interrupt controller node.
> >=20
> > Actually I think we only need an interrupt nexus, not an interrupt
> > controller (in IEEE1275 terminology).  (An interrupt controller would
> > generally require it's own driver, to ack/mask irqs, whereas this just
> > demonstrates the routing to an existing interrupt controller).  Which
> > makes that example slightly incorrect (it shouldn't have the
> > interrupt-controller property).
>=20
> Hmm, as far as I can tell we only have a concept of an interrupt controll=
er
> in the kernel. An interrupt nexus is something new. We should get by with=
out
> a driver but hacking the interrupt lookup path at DT.

So, the kernel shouldn't need the concept of nexus outside the DT
parsing code.  During the DT parsing the kernel will use the
interrupt-map in the nexus to work out which interrupt controllers
each devices are ultimately wired up to.

> >> In a similar manner we need GPIOs too for every GPIO option on the
> >> connector. Could we fold this in the same node?
> >=20
> > IIRC the GPIO binding is pretty much modeled on the interrupt binding
> > and has a similar "nexus" concept.  I was expecting the same thing for
> > GPIO.  It's expressed with different properties to those for irqs,
> > obviously, so I guess it could be in the same node.  Whether it's
> > clearer to have them in the same or separate nodes I suspect would
> > depend on the specifics of the board.
>=20
> Agreed. I should note that it=E2=80=99s pretty standard for a gpio contro=
ller to
> advertise itself as an interrupt controller too.

Ok.

> >>> 			aliases =3D {
> >>> 				i2c =3D &i2c;
> >>> 				intc =3D &w1_irqs;
> >>> 				mmio =3D &mmio;
> >>> 			};
> >>> 		};
> >>> 	};
> >>> };
> >>>=20
> >>> Note that the symbols are local to the connector, and explicitly
> >>> listed, rather than including all labels in the tree.  This is to
> >>> enforce (or at the very least encourage) plugins to only access those
> >>> parts of the base tree.
> >>>=20
> >>> Note also the use of an interrupt nexus node contained within the
> >>> connector to control which irqs the socketed device can use.  I think
> >>> this needs some work to properly handle unit addresses, but hope
> >>> that's enough to give the rough idea.
> >>>=20
> >>> So, what does the thing that goes in the socket look like?  I'm
> >>> thinking some new dts syntax like this:
> >>>=20
> >>> /dts-v1/;
> >>>=20
> >>> /plugin/ foo,widget-socket {
> >>> 	compatible =3D "foo,whirligig-widget";
> >>> };
> >>>=20
> >>> &i2c {
> >>> 	whirligig-controller@... {
> >>> 		...
> >>> 		interrupt-parent =3D <&widget-irqs>;
> >>> 		interrupts =3D <0>;
> >>> 	};
> >>> };
> >>>=20
> >>=20
> >> OK, this is brand new syntax. I=E2=80=99m all for it if it makes thing=
s easier.
> >>=20
> >>> Use of the /plugin/ keyword is rather different from existing
> >>> practice, so we may want a new one instead.
> >>>=20
> >>=20
> >> It=E2=80=99s a bit weird looking and is bound to cause confusion.
> >> How about something like /expansion/ ?
> >=20
> > That could work.
> >=20
> >>> The idea is that this would be compiled to something like:
> >>>=20
> >>> /dts-v1/;
> >>>=20
> >>> / {
> >>> 	socket-type =3D "foo,widget-socket";
> >>> 	compatible =3D "foo,whirligig-widget";
> >>>=20
> >>> 	fragment@0 {
> >>> 		target-alias =3D "i2c";
> >>> 		__overlay__ {
> >>> 			whirligig-controller@... {
> >>> 				...
> >>> 				interrupt-parent =3D <0xffffffff>;
> >>> 				interrupts =3D <0>;
> >>> 			};
> >>> 		};
> >>> 	};
> >>> 	__phandle_fixups__ {
> >>> 		/* These are (path, property, offset) tuples) */
> >>> 		widget-irqs =3D
> >>> 			"/fragment@0/__overlay__/whirligig-controller@...",
> >>> 			"interrupt-parent", <0>;
> >>> 	};
> >>=20
> >> I=E2=80=99m not quite sure this is going to work for multiple use of w=
idget-irqs handle,
> >> but it=E2=80=99s a detail for now.
> >=20
> > Just concatenate all the tuples, so path, property, offset, path,
> > property, offset, etc..
> >=20
>=20
> Note that parsing that property is going to be really awkward.
>=20
> It=E2=80=99s [string] [string] [cell], =E2=80=A6
>=20
> We don=E2=80=99t have accessors for something like this.

Hm, shouldn't be that bad - I would have thought it was easier than
string parsing at any rate.  Note that going back to 1275 days there
are existing bindings which define properties with mixed string and
cell data.

But I'm not particularly attached to this format, feel free to suggest
a better one.

> >> What is the action undertaken when a bus is activated? Looks like it=
=E2=80=99s going to
> >> be similar to my patch where the target/alias bus is given a status=3D=
=E2=80=9Cokay=E2=80=9D; property
> >> and activated, after all subnodes that contain i2c devices are copied =
there.=20
> >=20
> > Erm.. what exactly do you mean by "activated"?  At the moment you
> > could put a status=3D"okay" in the plugin component, and that would be
> > applied (as long as it goes in one of the accessible attachment
> > points).
> >=20
>=20
> I mean that the bus is by default non-activated. When a portable
> connector overlay is applied and the bus is referenced then the
> board level bus must be enabled.

Ok.  I can see a couple of approaches for that.  One is for the
overlay to set a property in the bus node to mark it as active.
status=3D"okey" is the obvious one but there are other possibilities.
That does raise questions about exactly what the overlay is allowed to
overwrite, of course.

The other possibility is for the overlay to just add the child node
and make sure the driver in the kernel activates the bus or not
depending on whether there are any child devices under it.  This
approach seems like it would be reasonably good practice on the kernel
side anyway, and might have less chance for multiple plugin DTs to
conflict with each other.

> > Which does bring up a point.  I did wonder if the approach above
> > allows the plugin to do too much - e.g. overriding properties in the
> > i2c controller node, rather than just adding children.  So I did
> > wonder if we wanted a restriction that only new nodes can be added at
> > the top level of the plugin fragment.
> >=20
>=20
> My RFC patch handles those cases. A connector device declares what kind
> of properties are allowed to be copied to the board level bus node
> (i.e. clock-freq, speed etc), and whether subnodes are supposed to be
> copied there (for i2c client devices etc).

Ok, probably makes sense to merge those aspects of our two proposals
if we can.

> > Alternatively that might be achievable by (as a recommended / best
> > practice) putting a "container" subnode under each attachable bus on
> > the master dt and pointing the aliases at that instead of the actual
> > base bus controller.  With the right 'ranges' etc. that might
> > accomplish what's needed without extra semantics, but I'm not certain.
>=20
> Err, I would need an example to grok this.

=2E..
	i2c@XXX {
		/* i2c controller node */
		device@YYY {
			/* fixed on-board device */
		};
		device@ZZZ {
			/* fixed on-board device */
		};
		socket_i2c: socket-devices {
			ranges;
		};
	};
=2E..

So the idea is the connector description would reference socket_i2c,
rather than the i2c controller itself.  That means that the plugin
can't override properties on the i2c controller, but can add i2c devices.

> > Ah.. which makes me think of another point.  In this proposal the
> > aliases is used to control both where fragments can be attached, and
> > what nodes can be referenced by phandle.  But we probably want to
> > split those concepts: e.g. the plugin will need to reference the
> > interrupt controller / nexus, but probably shouldn't be allowed to
> > override its properties.
>=20
> Yep.
>=20
> >>> };
> >>>=20
> >>>=20
> >>> Suppose then there's a new version of the board.  This extends the
> >>> widget socket in a backwards compatible way, but there are now two
> >>> interchangeable sockets, and they're wired up to different irqs and
> >>> i2c lines on the baseboard:
> >>>=20
> >>> /dts-v1/;
> >>>=20
> >>> / {
> >>> 	compatible =3D "foo,newboard";
> >>> 	ranges;
> >>> 	soc@... {
> >>> 		ranges;=09
> >>> 		mmio: mmio-bus@... {
> >>> 			#address-cells =3D <2>;
> >>> 			#size-cells =3D <2>;
> >>> 			ranges;
> >>> 		};
> >>> 		i2c0: i2c@... {
> >>> 		};
> >>> 		i2c1: i2c@... {
> >>> 		};
> >>> 		intc: intc@... {
> >>> 		};
> >>> 	};
> >>>=20
> >>> 	connectors {
> >>> 		widget1 {
> >>> 			compatible =3D "foo,widget-socket-v2", "foo,widget-socket";
> >>> 			w1_irqs: irqs {
> >>> 				interrupt-controller;
> >>> 				#address-cells =3D <0>;
> >>> 				#interrupt-cells =3D <1>;
> >>> 				interrupt-map-mask =3D <0xffffffff>;
> >>> 				interrupt-map =3D <
> >>> 					0 &intc 17 0
> >>> 					1 &intc 8 0
> >>> 				>;
> >>> 			};
> >>> 			aliases =3D {
> >>> 				i2c =3D &i2c0;
> >>> 				intc =3D &w1_irqs;
> >>> 				mmio =3D &mmio;
> >>> 			};
> >>> 		};
> >>> 		widget2 {
> >>> 			compatible =3D "foo,widget-socket-v2", "foo,widget-socket";
> >>> 			w2_irqs: irqs {
> >>> 				interrupt-controller;
> >>> 				#address-cells =3D <0>;
> >>> 				#interrupt-cells =3D <1>;
> >>> 				interrupt-map-mask =3D <0xffffffff>;
> >>> 				interrupt-map =3D <
> >>> 					0 &intc 9 0
> >>> 					1 &intc 10 0
> >>> 				>;
> >>> 			};
> >>> 			aliases =3D {
> >>> 				i2c =3D &i2c1;
> >>> 				widget-irqs =3D &w2_irqs;
> >>> 				mmio =3D &mmio;
> >>> 			};
> >>> 		};
> >>> 	};
> >>> };
> >>>=20
> >>>=20
> >>> A socketed device could also have it's own connectors - the contrived
> >>> example below has a little 256 byte mmio space (maybe some sort of LPC
> >>> thingy?):
> >>>=20
> >>>=20
> >>> /dts-v1/;
> >>>=20
> >>> /plugin/ foo,widget-socket-v2 {
> >>> 	compatible =3D "foo,superduper-widget};
> >>>=20
> >>> 	connectors {
> >>> 		compatible =3D "foo,super-socket";
> >>> 		aliases {
> >>> 			superbus =3D &superbus;
> >>> 		};=09
> >>> 	};
> >>> };
> >>>=20
> >>> &mmio {
> >>> 	superbus: super-bridge@100000000 {
> >>> 		#address-cells =3D <1>;
> >>> 		#size-cells =3D <1>;
> >>> 		ranges =3D <0x0  0xabcd0000 0x12345600  0x100>;
> >>> 	};
> >>> };
> >>>=20
> >>> &i2c {
> >>> 	super-controller@... {
> >>> 		...
> >>> 	};
> >>> 	duper-controller@... {
> >>> 	};
> >>> };
> >>>=20
> >>> Thoughts?
> >>>=20
> >>=20
> >> It=E2=80=99s a step in the right direction, especially if we nail down=
 the
> >> syntax.
> >=20
> > Excellent.
> >=20
>=20
> Regards
>=20
> =E2=80=94 Pantelis
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fmvA4kSBHQVZhkR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkZciAAoJEGw4ysog2bOShk4P+waGxVvNFVIcv6eJPyRLUwmp
qT+WZMWkGjCjrOvJruY8JizgFY8IJ1+jdcRYOzYrHAONuSbOmuVAs8rxorazChGT
kVE2PJBxQTQW49dktGNG1EiucG6SPYJGDZ898+EvpaQ3LjxxwWRvxTPjRnkbBHYR
sSb4+E2AyVmvIByolP89JRwS/2hew06DlUM6Pau+et6ohK6GaGWgvnmC4ASKHAI6
B7DQqxdr+cvifZNYiDeqDLT8Z0cfAmENmPp8+WV40ecrIbUc58Hqool6+p5S9qj6
v9L+QoLk3741M8iAjEg7r76Xe5JJ6N77ol+5E1lqgsOZodlx6OMKAoS40Fgcse9I
r6gWPOfygb80MEtFCqxCR3LNUcYWQ52XstKlnpCkElIL5e5C1b1mq8lFqGJvypMi
OtuHHSnsPcXhlHzzeUAksfUXCZNL4B1XxTaYjlE3UeXjqGVKFyA7rI2zT9fB4ud5
YXHadljgkoj8wkfu+vXy6VLzMYXBo1r3MA2pPlYoHpb7xxLmnPSrMinVe/AYQPlm
e37oLRjopeVHCH0eAxD/21eaySzmO+L3IGNYfzqNpqPMLj+6aW00yr5ddIo4UTGQ
S8xLcJ/FDJxncSLuIeKzkpMG8wH7xUHadfPGtEDWFum8pKp5BGtLwyNOwKg85BI9
34w40h1ml0rcuz7lBS3k
=nTAb
-----END PGP SIGNATURE-----

--fmvA4kSBHQVZhkR6--
