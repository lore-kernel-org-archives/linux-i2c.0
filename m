From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: DT connectors, thoughts
Date: Mon, 29 Aug 2016 09:45:11 -0400
Message-ID: <20160829134511.GC2166@littlecatz>
References: <577ACE0D.9050700@gmail.com>
 <20160718142037.GS16769@voom.fritz.box>
 <CAL_JsqLkMA1VHfHpP4oCWtONWq5GeyS731r8PjjeL_DZ4u1Z_g@mail.gmail.com>
 <20160722042556.GL15941@voom.fritz.box>
 <147217552167.17958.11590706771471540284@sboyd-linaro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <147217552167.17958.11590706771471540284@sboyd-linaro>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-i2c@vger.kernel.org


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2016 at 06:38:41PM -0700, Stephen Boyd wrote:
> Quoting David Gibson (2016-07-21 21:25:56)
> > On Thu, Jul 21, 2016 at 02:15:57PM -0500, Rob Herring wrote:
> > > On Mon, Jul 18, 2016 at 9:20 AM, David Gibson
> > > <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > I understand how you are using i2c alias, but not the intc. It would
> > > help if the same names were not used in multiple places unless they
> > > are the same thing.
> >=20
> > Yes, sorry.  We have both the /soc/intc node which is the base board's
> > master interrupt controller.  Then we have the connector local 'intc'
> > alias which describes the local interrupt space for just the
> > connector.
> >=20
> > > What does using aliases here buy us vs. just properties with a
> > > phandle?
> >=20
> > Um.. I'm not sure what you mean.
>=20
> I think Rob means drop the aliases node and just have:

Oh, ok.  The reason for the aliases node is that putting the aliases
(or whatever you want to call them) in the top level connector node
limits what potential extensions we can make to the connector format.
The aliases can essentially have any property name, so they could
collide with additional "metadata" properties we might want to add.

> 	property =3D &phandle;

Note that the example above is misleading.  Without the < >, the label
reference will expand to a path string, not a phandle.

> In this example:
>=20
> 	i2c =3D &i2c;
> 	intc =3D &w1_irqs;
> 	mmio =3D &mmio;
>=20
> or perhaps to have a list of phandles and names that map to them?
>=20
> 	targets =3D <&i2c>, <&w1_irqs>, <&mmio>;
> 	target-names =3D "i2c", "intc", "mmio";

That would work, but a) using phandles instead of paths introduces an
additional lookup for no particular benegit and b) it seems harder to
parse.  In addition the aliases format suggested matches the global
aliases property already defined by IEEE1275, so it seems a good place
to start.

>=20
> ?
>=20
> >=20
> > > >                                 mmio =3D &mmio;
> > > >                         };
> > > >                 };
> > > >         };
> > > > };
> > > >
> > > > Note that the symbols are local to the connector, and explicitly
> > > > listed, rather than including all labels in the tree.  This is to
> > > > enforce (or at the very least encourage) plugins to only access tho=
se
> > > > parts of the base tree.
> > > >
> > > > Note also the use of an interrupt nexus node contained within the
> > > > connector to control which irqs the socketed device can use.  I thi=
nk
> > > > this needs some work to properly handle unit addresses, but hope
> > > > that's enough to give the rough idea.
> > > >
> > > > So, what does the thing that goes in the socket look like?  I'm
> > > > thinking some new dts syntax like this:
> > > >
> > > > /dts-v1/;
> > > >
> > > > /plugin/ foo,widget-socket {
> > > >         compatible =3D "foo,whirligig-widget";
> > > > };
> > > >
> > > > &i2c {
> > > >         whirligig-controller@... {
> > > >                 ...
> > > >                 interrupt-parent =3D <&widget-irqs>;
> > > >                 interrupts =3D <0>;
> > > >         };
> > > > };
>=20
> How would we support an expansion board that goes onto two
> sockets/connectors provided by the baseboard when the connectors
> "export" the same phandle aliases? From what I can tell with this design
> we'll be unable to describe a device on the expansion board that is
> wired to properties provided by the two connectors.

Ok, so there are two parts to this.

1) Allowing a plugin to use multiple connectors.

I thought a bit about this case, but didn't address it for
simplicity.  That would require a different syntax, so we can rethink
this if it's a use case we think we need.

2) Dealing with alias collisions between connector types

This one is fairly straightforward to handle.  By default, we'll use
labels from connectors we plug into "as is".  However, we can add a
syntax that allows us to locally rename labels from a connector (for
those familiar with Python, think "import foo from bar as baz").


So, combining those thoughts together, I'm thinking dtc format for
something connecting to two different widget sockets (pretty much the
worst case) would look something like:

/plugin/ foo,widget-socket {
};

/plugin/ foo,widget-socket {
	realias {
		i2c-b =3D "i2c";
		intc-b =3D "intc";
		mmio-b =3D "mmio";
	};
};

&i2c {
	.. devices on the i2c from the first plug ..
};

&i2c-b {
	.. devices on the i2c from the second plug ..
};

Obviously we'd also need to devise an encoding for this to compile
into, since the one I proposed previously won't work in this case.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJXxDxnAAoJEGw4ysog2bOSbbYP/RAMCJ345JO1SPcWlw4/t8G/
4Zg+guc4RfVqbbgxrWWiw4U238DJLqr0Yf3i0JXU7QFZxUTcqfpVTs05DEUchwkX
YXLZWBhtrcbt2L3jlzv/xSMiCIux4YshwbWLzDwJInAyO1J61m+AdjTqPDxY94Ei
ULCBAzhSPXN/XGGHvqOntounsAZtXt/ky73tr6LXYtp9jDupaBvJzUsUhH8MG4zI
16g7E8ROCObyo6ReG6RKHMzkHl4ogwUv6EhMM62YlmRKFW3Ljbl6+pMYA1bzllgi
ci17KkvA3+kawzc1CZBZoRTkGFlR4z0O5SL8cbzw4xogMTP9lLRuqSAv58sIL/lo
LEEzdK2UeQqPnFQGwFTNHc4cZek7nsXfc6nYtsxRudnqo2vu6g2RIjjxsdIzMKV+
ezfUroZcfZtrneRx/ETlpMZ6lzKo8mEWW/ixVwzPDa4XgoGUhvr4KTtDvSlDgvLv
3mSf6F8KlYyTUQEekY+wFMGh3oeARlb62qKP61kbrhkpxa68SURZn/SkUkK21gWi
WNgPAtgVnKeuB4YKFE0LN9IwzEEKPZ6mlROFT2LeVaK9F/Jix3iwgKKR82yeuIv3
ZyXcP1MbPdO22PGGqaFZ7FvoZvlPxxb9NAexOD/e/LFzfcaC6nkn6KBh+8vL5Ufv
KG02Twxz4cYHUjmSQjfI
=DOFp
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
