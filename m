From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: DT connectors, thoughts
Date: Tue, 30 Aug 2016 19:55:23 -0400
Message-ID: <20160830235523.GC1753@littlecatz>
References: <577ACE0D.9050700@gmail.com>
 <20160718142037.GS16769@voom.fritz.box>
 <CAL_JsqLkMA1VHfHpP4oCWtONWq5GeyS731r8PjjeL_DZ4u1Z_g@mail.gmail.com>
 <20160722042556.GL15941@voom.fritz.box>
 <147217552167.17958.11590706771471540284@sboyd-linaro>
 <20160829134511.GC2166@littlecatz>
 <147252286938.20899.1763773530822329216@sboyd-linaro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <147252286938.20899.1763773530822329216@sboyd-linaro>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-i2c@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2016 at 07:07:49PM -0700, Stephen Boyd wrote:
> Quoting David Gibson (2016-08-29 06:45:11)
> > On Thu, Aug 25, 2016 at 06:38:41PM -0700, Stephen Boyd wrote:
> > > Quoting David Gibson (2016-07-21 21:25:56)
> > > > On Thu, Jul 21, 2016 at 02:15:57PM -0500, Rob Herring wrote:
> > > > > On Mon, Jul 18, 2016 at 9:20 AM, David Gibson
> > > > > <david@gibson.dropbear.id.au> wrote:
> > > > >=20
> > > > > I understand how you are using i2c alias, but not the intc. It wo=
uld
> > > > > help if the same names were not used in multiple places unless th=
ey
> > > > > are the same thing.
> > > >=20
> > > > Yes, sorry.  We have both the /soc/intc node which is the base boar=
d's
> > > > master interrupt controller.  Then we have the connector local 'int=
c'
> > > > alias which describes the local interrupt space for just the
> > > > connector.
> > > >=20
> > > > > What does using aliases here buy us vs. just properties with a
> > > > > phandle?
> > > >=20
> > > > Um.. I'm not sure what you mean.
> > >=20
> > > I think Rob means drop the aliases node and just have:
> >=20
> > Oh, ok.  The reason for the aliases node is that putting the aliases
> > (or whatever you want to call them) in the top level connector node
> > limits what potential extensions we can make to the connector format.
> > The aliases can essentially have any property name, so they could
> > collide with additional "metadata" properties we might want to add.
>=20
> Agreed. Putting them into a subnode will prevent any collisions, but
> what sorts of collisions would there even be? Presumably the one making
> up the connector binding will be choosing the phandles they want to
> export with specific properties, and during that time they can also
> choose to have other properties that don't conflict?

Hmm.. I suppose.  It still seems conceptually cleaner to me to have
them in their own namespace.

> > > How would we support an expansion board that goes onto two
> > > sockets/connectors provided by the baseboard when the connectors
> > > "export" the same phandle aliases? From what I can tell with this des=
ign
> > > we'll be unable to describe a device on the expansion board that is
> > > wired to properties provided by the two connectors.
> >=20
> > Ok, so there are two parts to this.
> >=20
> > 1) Allowing a plugin to use multiple connectors.
> >=20
> > I thought a bit about this case, but didn't address it for
> > simplicity.  That would require a different syntax, so we can rethink
> > this if it's a use case we think we need.
>=20
> Yes it would be nice to design for this case as well.
>=20
> >=20
> > 2) Dealing with alias collisions between connector types
> >=20
> > This one is fairly straightforward to handle.  By default, we'll use
> > labels from connectors we plug into "as is".  However, we can add a
> > syntax that allows us to locally rename labels from a connector (for
> > those familiar with Python, think "import foo from bar as baz").
> >=20
> >=20
> > So, combining those thoughts together, I'm thinking dtc format for
> > something connecting to two different widget sockets (pretty much the
> > worst case) would look something like:
> >=20
> > /plugin/ foo,widget-socket {
> > };
> >=20
> > /plugin/ foo,widget-socket {
> >         realias {
> >                 i2c-b =3D "i2c";
> >                 intc-b =3D "intc";
> >                 mmio-b =3D "mmio";
> >         };
> > };
> >=20
> > &i2c {
> >         .. devices on the i2c from the first plug ..
> > };
> >=20
> > &i2c-b {
> >         .. devices on the i2c from the second plug ..
> > };
> >=20
> > Obviously we'd also need to devise an encoding for this to compile
> > into, since the one I proposed previously won't work in this case.
> >=20
>=20
> I suppose we can distribute the realias nodes when we compile the plugin
> into overlay fragments. The socket matching is a little vague though.
> How would we know which socket to apply to when we have two identical
> looking sockets? I'm thinking we could put some of that information into
> the fragment itself.

So, my assumption in this example was that the plugin could plug into
*any* two widget sockets.  If it needs to connect to specific ones,
then pretty much by definition, the sockets aren't really of
indistinguishable type.

>=20
> /{
> 	compatible =3D "foo,whirlgig-widget";
>=20
> 	fragment@0 { /* corresponds to i2c in example above */
> 		target-socket =3D "foo,widget-socket-a";
> 		target-alias =3D "i2c";
> 		__overlay__ {
> 			....
> 		};
> 	};
>=20
> 	fragment@1 { /* corresponds to i2c-b in example above */
> 		target-socket =3D "foo,widget-socket-b";
> 		target-alias =3D "i2c";
> 		__overlay__ {
> 			...
> 		};
> 	};
> };

We don't need any new construct here.  In this case the sockets aren't
100% compatible, which we can notate with
	compatible =3D "widget-socket-a", "widget-socket";
In the base board.

Devices which can plug into any widget socket will use target-socket =3D
"widget-socket", those which require a specific one (including
requiring both) can specifically list "widget-socket-a" and/or
"widget-socket-b".

> If we have two identical connectors maybe we'll have to enforce that the
> connectors have some more specific unique compatible string so that we
> can match up the right socket. But I don't see how we can require that
> the overlays know this detail if they only care about one socket and
> could go into either one of them. In that case we should have the loader
> ask the user which socket they connected this extension board to?
>=20
> I was also thinking it would be better to leave the gpio-map and
> interrupt-map properties at the connector level. For example:
>=20
> 	widget1 {
> 		compatible =3D "foo,widget-socket";
> 		interrupt-map-mask =3D <0xffffffff>;
> 		interrupt-map =3D <0 &intc 7 0>,
> 				<1 &intc 8 0>;
> 	};

That could work - but we should (and implicitly, do) support either
way.  Using subnodes might be useful for particularly complex irq or
gpio mappings.

> and then we could put a label on the plugin/expansion syntax so we can
> reference the connector as a whole:
>=20
> 	/plugin/ connector: foo,widget-socket {
> 		compatible =3D "foo,whirlgig-widget";
> 	};
>=20
> 	&i2c {
> 		device@40 {
> 			interrupt-parent =3D <&connector>;
> 			interrupts =3D <1>;
> 		};
> 	};
>=20
> I also thought about making another alias inside the connector node to
> point to itself, but that fails when you get into the situation of two
> connectors and collisions, unless you rename them of course. It felt
> better to leave that choice to the overlay though.
>=20
> In conclusion, I see a few topics/patterns emerging:
>=20
> 1) Expose phandles through the connectors in some way that allows us to
>    limit what the plugin/expansion boards can modify or use

Yes, I definitely think we want that.

> 2) Have some flexible syntax to remap cell sizes from the baseboard
>    through the connector to provide a consistent connector size (i.e.
>    remap interrupts and gpios from multiple sources, etc. into a fixed
>    number of cells)

I don't think we need any new constructs here.  If there are
mismatches we can put dummy bridges with appropriate ranges properties
on one side or the other.

The only thing I see that might want some help is that the connector
type should certainly imply a specific set of cell widths for all the
included buses.  So possibly we should supply some stuff to help
enforce that.

> 3) Allow plugin/expansion boards to use multiple connectors from the
>    baseboard in a consistent way

Seems reasonable.

> 4) Attempt to maintain almost all of the current overlay syntax with
>    syntactic sugar

I'm not really sure what you mean by that.

> 5) Connectors on expansion boards should be supported

Again, seems like a good goal to me.

>=20
> Is there anything else we should add to this list?
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJXxhzqAAoJEGw4ysog2bOSytQQAL3jvtKjbZH+xfGhtgC62Yyo
3sQN5BNxIAqgzrrhpL6UmwTC+5SSTh/KJGSBOVLB+ktnBleHejX40kfKP4Ad2RMW
Vxq1O9SXa6V8YVzOE67x+pZjyMPHHvxkOrengOsL2HsFU7Sw6y3epn2ClGJOMpQ8
AQTVHCsU2u1PuszD6e373JidQfEzgX13QkN4VXUEvHj+BK0DOBkG4INAlzICz3E8
3oygQqhyA0ECNLzWY08PdGqMyogg5D3wGQYqZ8xaT40CcBpl87KLQjVTQJ4yFOuY
3nmRGaFAL5w5sgMozmwFoZeYQifudSUEodNAFT6zCUe7/e6oWaypDzBzFGbeduTk
skuy+x0FKpBR9EsApjaZGrjkbUHMVEhPzqzLBGHrzi3StnNnzKZjw2FCdG1F5KEH
r5whCUHJsYQP+0rasZH2GJeLIlcReMO6aPJGhySxba6UPu/VZMd45Xezo/sXtf3K
so8cBnr7k+rpo/1e0/rPiUg9xmP10B4q1IvSWqBjr/JdISF+TE+d7SaxEtU3tJWC
4BBz4BZ0jhp6lUEmY24ZWsELYoKC6dyVzTPRuWOmTslpItJm5ZTaQR0GYB0eR9uI
rDdX76WEUtqLmNb2vHK0Q8A8VdYztuI1y9q6yN2/mfGfkaBJNiHnBMnAn8d0kkdt
gv3jy/27yDJJd+ida2KG
=CdZ7
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
