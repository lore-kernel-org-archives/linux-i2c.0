From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 1/3] i2c: cadence: Document device tree bindings
Date: Fri, 4 Apr 2014 13:57:44 -0700
Message-ID: <27b560ed-5b34-4b1a-b741-0e5bf6cbb992@VA3EHSMHS010.ehs.local>
References: <1396547967-19260-1-git-send-email-soren.brinkmann@xilinx.com>
 <20140404191757.GR11339@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140404191757.GR11339-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2014-04-04 at 09:17PM +0200, Gerhard Sittig wrote:
> On Thu, 2014-04-03 at 10:59 -0700, Soren Brinkmann wrote:
> >=20
> > Add device tree binding documentation for the Cadence I2C controlle=
r.
> >=20
> > [ ... ]
> >=20
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
> > @@ -0,0 +1,21 @@
> > +Binding for the Cadence I2C controller
> > +
> > +Required properties:
> > +  compatible: Compatibility string. Must be 'cdns,i2c-r1p10'.
> > +  clocks: From common clock bindings. Phandle to input clock.
>=20
> the usual complaint:  'clocks' items are not just phandles (your
> example even suggests this); either adjust the description to
> something correct, or just refer to the common clock bindings to
> not duplicate their description

I'll figure out something.

>=20
> but I guess the I2C controller's binding should explicitly state
> which clocks are required, and you might want to consider
> 'clock-names', too

There is only one clock input. There is no need to overcomplicate thing=
s
by adding clock-names.

>=20
> > +
> > +Optional properties:
> > +  clock-frequency: Desired operating frequency, in Hz, of the bus =
(actual may
> > +		   be lower). Defaults to 400000 if not specified.
>=20
> is the value default a feature of the Linux implementation, or
> consciously designed to be in the binding spec?  and I agree that
> the default should be the standard I2C speed instead of fast mode

I remove the note regarding the default. It's implementation.

>=20
> > +
> > +Example:
> > +
> > +	i2c@e0004000 {
> > +		compatible =3D "cdns,i2c-r1p10";
> > +		clocks =3D <&clkc 38>;
> > +		interrupts =3D <0 25 4>;
> > +		reg =3D <0xE0004000 0x1000>;
> > +		clock-frequency =3D <400000>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +	};
>=20
> use lower case hex digits, consider symbolic identifiers for
> clocks and interrupt flags

I don't care about the case of those hex digits, but where does it say
that they have to be lower case? Will somebody complain about usage of
lower case chars next?

>=20
> the example has many more properties than the binding describes,
> the additional items aren't even optional -- you might want to
> refer to a few more common or general bindings

Well, this is common across binding documentation. Can we please get
consistency in this? I see plenty of binding docs that are documented
this way, not mentioning much regarding such common properties.

	S=C3=B6ren
