From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: DT connectors, thoughts
Date: Thu, 8 Sep 2016 10:26:11 +1000
Message-ID: <20160908002611.GA3883@voom.fritz.box>
References: <577ACE0D.9050700@gmail.com>
 <20160718142037.GS16769@voom.fritz.box>
 <CAL_JsqLkMA1VHfHpP4oCWtONWq5GeyS731r8PjjeL_DZ4u1Z_g@mail.gmail.com>
 <20160722042556.GL15941@voom.fritz.box>
 <147217552167.17958.11590706771471540284@sboyd-linaro>
 <20160829134511.GC2166@littlecatz>
 <147252286938.20899.1763773530822329216@sboyd-linaro>
 <20160830235523.GC1753@littlecatz>
 <147329189889.27412.12053595745294007737@sboyd-linaro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:44852 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752395AbcIHA0X (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 7 Sep 2016 20:26:23 -0400
Content-Disposition: inline
In-Reply-To: <147329189889.27412.12053595745294007737@sboyd-linaro>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Pantelis Antoniou <panto@antoniou-consulting.com>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2016 at 04:44:58PM -0700, Stephen Boyd wrote:
> Quoting David Gibson (2016-08-30 16:55:23)
> > On Mon, Aug 29, 2016 at 07:07:49PM -0700, Stephen Boyd wrote:
> > > Quoting David Gibson (2016-08-29 06:45:11)
> > > > So, combining those thoughts together, I'm thinking dtc format for
> > > > something connecting to two different widget sockets (pretty much t=
he
> > > > worst case) would look something like:
> > > >=20
> > > > /plugin/ foo,widget-socket {
> > > > };
> > > >=20
> > > > /plugin/ foo,widget-socket {
> > > >         realias {
> > > >                 i2c-b =3D "i2c";
> > > >                 intc-b =3D "intc";
> > > >                 mmio-b =3D "mmio";
> > > >         };
> > > > };
> > > >=20
> > > > &i2c {
> > > >         .. devices on the i2c from the first plug ..
> > > > };
> > > >=20
> > > > &i2c-b {
> > > >         .. devices on the i2c from the second plug ..
> > > > };
> > > >=20
> > > > Obviously we'd also need to devise an encoding for this to compile
> > > > into, since the one I proposed previously won't work in this case.
> > > >=20
> > >=20
> > > I suppose we can distribute the realias nodes when we compile the plu=
gin
> > > into overlay fragments. The socket matching is a little vague though.
> > > How would we know which socket to apply to when we have two identical
> > > looking sockets? I'm thinking we could put some of that information i=
nto
> > > the fragment itself.
> >=20
> > So, my assumption in this example was that the plugin could plug into
> > *any* two widget sockets.  If it needs to connect to specific ones,
> > then pretty much by definition, the sockets aren't really of
> > indistinguishable type.
>=20
> Ah ok. It wasn't clear on how we target where the extension board
> connects into the full tree. It sounds like the decision of where to
> plug in the extension board falls to the overlay manager then?

Yes.  The whole point of connectors is that they're interchangeable,
so neither the "plug" side nor the "socket" side should specify which
instance of the other part they're connected to.

So to resolve the whole tree in this case, extra information would be
needed.  Ideally it would come from probing (even something ad-hoc
like an ID register), failing that it would need to be admin
configured.

> > > /{
> > >       compatible =3D "foo,whirlgig-widget";
> > >=20
> > >       fragment@0 { /* corresponds to i2c in example above */
> > >               target-socket =3D "foo,widget-socket-a";
> > >               target-alias =3D "i2c";
> > >               __overlay__ {
> > >                       ....
> > >               };
> > >       };
> > >=20
> > >       fragment@1 { /* corresponds to i2c-b in example above */
> > >               target-socket =3D "foo,widget-socket-b";
> > >               target-alias =3D "i2c";
> > >               __overlay__ {
> > >                       ...
> > >               };
> > >       };
> > > };
> >=20
> > We don't need any new construct here.  In this case the sockets aren't
> > 100% compatible, which we can notate with
> >         compatible =3D "widget-socket-a", "widget-socket";
> > In the base board.
> >=20
> > Devices which can plug into any widget socket will use target-socket =3D
> > "widget-socket", those which require a specific one (including
> > requiring both) can specifically list "widget-socket-a" and/or
> > "widget-socket-b".
>=20
> Agreed. How do we express the realias node in the overlay format though?
> I was trying to come up with some way to make that work by
> redistributing the alias to the fragments but that doesn't work so
> well.

So, I'm thinking of the overlay dt info in 3 pieces

1) Global metadata

  Not much here yet, but it seems like it could be useful.

2) Per-connector metadata

  This specifies what sort of "socket" each "plug" on the overlay
  needs to connect to, and any other information we need that's
  specific to a particular "plug"

3) DT fragments

  The actual device info applied once we've resolved all the aliases
  and whatnot.

The realias information would need to be in part (2)

How we encode those pieces into the final overlay dt is pretty close
to an arbitrary choice.

> > > If we have two identical connectors maybe we'll have to enforce that =
the
> > > connectors have some more specific unique compatible string so that we
> > > can match up the right socket. But I don't see how we can require that
> > > the overlays know this detail if they only care about one socket and
> > > could go into either one of them. In that case we should have the loa=
der
> > > ask the user which socket they connected this extension board to?
> > >=20
> > > I was also thinking it would be better to leave the gpio-map and
> > > interrupt-map properties at the connector level. For example:
> > >=20
> > >       widget1 {
> > >               compatible =3D "foo,widget-socket";
> > >               interrupt-map-mask =3D <0xffffffff>;
> > >               interrupt-map =3D <0 &intc 7 0>,
> > >                               <1 &intc 8 0>;
> > >       };
> >=20
> > That could work - but we should (and implicitly, do) support either
> > way.  Using subnodes might be useful for particularly complex irq or
> > gpio mappings.
>=20
> Sounds good.
>=20
> >=20
> > > and then we could put a label on the plugin/expansion syntax so we can
> > > reference the connector as a whole:
> > >=20
> > >       /plugin/ connector: foo,widget-socket {
> > >               compatible =3D "foo,whirlgig-widget";
> > >       };
> > >=20
> > >       &i2c {
> > >               device@40 {
> > >                       interrupt-parent =3D <&connector>;
> > >                       interrupts =3D <1>;
> > >               };
> > >       };
> > >=20
> > > I also thought about making another alias inside the connector node to
> > > point to itself, but that fails when you get into the situation of two
> > > connectors and collisions, unless you rename them of course. It felt
> > > better to leave that choice to the overlay though.
> > >=20
> > > In conclusion, I see a few topics/patterns emerging:
> > >=20
> > > 1) Expose phandles through the connectors in some way that allows us =
to
> > >    limit what the plugin/expansion boards can modify or use
> >=20
> > Yes, I definitely think we want that.
> >=20
> > > 2) Have some flexible syntax to remap cell sizes from the baseboard
> > >    through the connector to provide a consistent connector size (i.e.
> > >    remap interrupts and gpios from multiple sources, etc. into a fixed
> > >    number of cells)
> >=20
> > I don't think we need any new constructs here.  If there are
> > mismatches we can put dummy bridges with appropriate ranges properties
> > on one side or the other.
> >=20
> > The only thing I see that might want some help is that the connector
> > type should certainly imply a specific set of cell widths for all the
> > included buses.  So possibly we should supply some stuff to help
> > enforce that.
>=20
> I'm specifically thinking that anything that has a #<name>-cells
> associated with it (#gpio-cells, #clock-cells, #power-domain-cells,
> etc.) would need to have an associated <name>-map property and
> associated parsing code so that we can make a consistent cell width for
> the connector. If we have existing ways to make this work, e.g.
> interrupt-map or ranges, then we don't need.

Yes, I agree.  All the "interrupt tree like" things need interrupt
tree like nexus nodes, with a map and map-mask.

However, we also need some way of ensuring that the #address-cells and
#size-cells for any buses we expose match properly.

Or maybe we need to invent something like a cross between 'ranges' and
'interrupt-map' that can remap ranges on one address space to the
address space attached to a different node.

>=20
> >=20
> > > 3) Allow plugin/expansion boards to use multiple connectors from the
> > >    baseboard in a consistent way
> >=20
> > Seems reasonable.
> >=20
> > > 4) Attempt to maintain almost all of the current overlay syntax with
> > >    syntactic sugar
> >=20
> > I'm not really sure what you mean by that.
> >=20
>=20
> I mean that we're not really trying to change the general structure of
> the DT overlay syntax. At least from what I can tell we're planning to
> convert this /plugin/ format into a DT overlay that gets compiled into
> binary all inside DTC.

Roughly speaking, yes.  However I think we should take the opportunity
to address design flaws in the current overlay encoding as they come
up (e.g. the fact that it uses phandles which *always* have to be
resolved - better to directly use an alias / symbol / label).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJX0LAjAAoJEGw4ysog2bOSR3sP/1+fBltI/5c53DhVFUUgamiC
R0obUNG1D+HGWWTTJB3WB9FuvZYtQZobdUxV32Ts2g1CYM+479nozN0cxPXnmDfX
VTkAfPmuXCpzVrVtuqCbLY0l57OuQ3IMb8QEw2NsWzfF2CYUXlFXIKL2/CddQ+B6
GfBKLD1Jvf2xda1iNuoG2XXuHm+shkCBvKH3IKkvN/XqHQka4YaTjjXBuNDwFIP0
sJchPJcZqOz4uAgM5O81L2AcUNBYTp2PbtIeZbXf7PAKTkaJVuEZMOQO6A4adF5z
goABgbffz/wzP3NnpqIxBXhp+9MC45deg0oWBHGZn9D60aQ0uQyJQEm2mcx4GPAb
XrWHEyN9Iu6rS7lZ1yLwVXxmiF+d+MLePZMuPzNa31qT2ehMYhdH3ah3YM6/fmSM
IQniKdVdOXXMo/3m8F7HGsLI41Q9zKwQwpuWa/fe6nrzvdMpiahaVBQqQVuNLbBF
fnRtjBLMPSZZ/GNcal8B76Nzd9Km0SSkCzLqmO17iCLTlGaYw3Mv5qhL6VSCz1ac
xWMbNhJIBPzqrmn/I5P/osnIJ0Ra85tmbTR8gIL+lr2ewzSVwzumlv34ncjoZqVJ
kEMdD+QPKRNIQ+5KGhFKchMuCjRgjpwBCmhNzAdTrIhVpnugJrRApyLzYIGE47wo
R8H+DZgiNMbd2KQtkmt5
=HyFd
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
