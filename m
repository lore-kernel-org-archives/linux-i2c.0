From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: Re: DT connectors, thoughts
Date: Thu, 25 Aug 2016 18:38:41 -0700
Message-ID: <147217552167.17958.11590706771471540284@sboyd-linaro>
References: <577ACE0D.9050700@gmail.com> <20160718142037.GS16769@voom.fritz.box>
 <CAL_JsqLkMA1VHfHpP4oCWtONWq5GeyS731r8PjjeL_DZ4u1Z_g@mail.gmail.com>
 <20160722042556.GL15941@voom.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160722042556.GL15941@voom.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>, Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-i2c@vger.kernel.org

Quoting David Gibson (2016-07-21 21:25:56)
> On Thu, Jul 21, 2016 at 02:15:57PM -0500, Rob Herring wrote:
> > On Mon, Jul 18, 2016 at 9:20 AM, David Gibson
> > <david@gibson.dropbear.id.au> wrote:
> > =

> > I understand how you are using i2c alias, but not the intc. It would
> > help if the same names were not used in multiple places unless they
> > are the same thing.
> =

> Yes, sorry.  We have both the /soc/intc node which is the base board's
> master interrupt controller.  Then we have the connector local 'intc'
> alias which describes the local interrupt space for just the
> connector.
> =

> > What does using aliases here buy us vs. just properties with a
> > phandle?
> =

> Um.. I'm not sure what you mean.

I think Rob means drop the aliases node and just have:

	property =3D &phandle;

In this example:

	i2c =3D &i2c;
	intc =3D &w1_irqs;
	mmio =3D &mmio;

or perhaps to have a list of phandles and names that map to them?

	targets =3D <&i2c>, <&w1_irqs>, <&mmio>;
	target-names =3D "i2c", "intc", "mmio";

?

> =

> > >                                 mmio =3D &mmio;
> > >                         };
> > >                 };
> > >         };
> > > };
> > >
> > > Note that the symbols are local to the connector, and explicitly
> > > listed, rather than including all labels in the tree.  This is to
> > > enforce (or at the very least encourage) plugins to only access those
> > > parts of the base tree.
> > >
> > > Note also the use of an interrupt nexus node contained within the
> > > connector to control which irqs the socketed device can use.  I think
> > > this needs some work to properly handle unit addresses, but hope
> > > that's enough to give the rough idea.
> > >
> > > So, what does the thing that goes in the socket look like?  I'm
> > > thinking some new dts syntax like this:
> > >
> > > /dts-v1/;
> > >
> > > /plugin/ foo,widget-socket {
> > >         compatible =3D "foo,whirligig-widget";
> > > };
> > >
> > > &i2c {
> > >         whirligig-controller@... {
> > >                 ...
> > >                 interrupt-parent =3D <&widget-irqs>;
> > >                 interrupts =3D <0>;
> > >         };
> > > };

How would we support an expansion board that goes onto two
sockets/connectors provided by the baseboard when the connectors
"export" the same phandle aliases? From what I can tell with this design
we'll be unable to describe a device on the expansion board that is
wired to properties provided by the two connectors.
