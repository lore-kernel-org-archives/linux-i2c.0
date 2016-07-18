From: David Gibson <david@gibson.dropbear.id.au>
Subject: DT connectors, thoughts
Date: Tue, 19 Jul 2016 00:20:37 +1000
Message-ID: <20160718142037.GS16769@voom.fritz.box>
References: <577ACE0D.9050700@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WVXkb2QE2eH0aWe4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:57969 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbcGROUm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 18 Jul 2016 10:20:42 -0400
Content-Disposition: inline
In-Reply-To: <577ACE0D.9050700@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Rob Herring <robh+dt@kernel.org>, stephen.boyd@linaro.org, broonie@kernel.org, grant.likely@secretlab.ca, Mark Rutland <mark.rutland@arm.com>, mporter@konsulko.com, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, marex@denx.de, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, panto@antoniou-consulting.com


--WVXkb2QE2eH0aWe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Here's some of my thoughts on how a connector format for the DT could
be done.  Sorry it's taken longer than I hoped - I've been pretty
swamped in my day job.

This is pretty early thoughts, but gives an outline of the approach I
prefer.

So.. start with an example of a board DT including a widget socket,
which contains pins for an MMIO bus, an i2c bus and 2 interrupt lines.

/dts-v1/;

/ {
	compatible =3D "foo,oldboard";
	ranges;
	soc@... {
		ranges;
		mmio: mmio-bus@... {
			#address-cells =3D <2>;
			#size-cells =3D <2>;
			ranges;
		};
		i2c: i2c@... {
		};
		intc: intc@... {
			#interrupt-cells =3D <2>;
		};
	};

	connectors {
		widget1 {
			compatible =3D "foo,widget-socket";
			w1_irqs: irqs {
				interrupt-controller;
				#address-cells =3D <0>;
				#interrupt-cells =3D <1>;
				interrupt-map-mask =3D <0xffffffff>;
				interrupt-map =3D <
					0 &intc 7 0
					1 &intc 8 0
				>;
			};
			aliases =3D {
				i2c =3D &i2c;
				intc =3D &w1_irqs;
				mmio =3D &mmio;
			};
		};
	};
};

Note that the symbols are local to the connector, and explicitly
listed, rather than including all labels in the tree.  This is to
enforce (or at the very least encourage) plugins to only access those
parts of the base tree.

Note also the use of an interrupt nexus node contained within the
connector to control which irqs the socketed device can use.  I think
this needs some work to properly handle unit addresses, but hope
that's enough to give the rough idea.

So, what does the thing that goes in the socket look like?  I'm
thinking some new dts syntax like this:

/dts-v1/;

/plugin/ foo,widget-socket {
	compatible =3D "foo,whirligig-widget";
};

&i2c {
	whirligig-controller@... {
		...
		interrupt-parent =3D <&widget-irqs>;
		interrupts =3D <0>;
	};
};

Use of the /plugin/ keyword is rather different from existing
practice, so we may want a new one instead.

The idea is that this would be compiled to something like:

/dts-v1/;

/ {
	socket-type =3D "foo,widget-socket";
	compatible =3D "foo,whirligig-widget";

	fragment@0 {
		target-alias =3D "i2c";
		__overlay__ {
			whirligig-controller@... {
				...
				interrupt-parent =3D <0xffffffff>;
				interrupts =3D <0>;
			};
		};
	};
	__phandle_fixups__ {
		/* These are (path, property, offset) tuples) */
		widget-irqs =3D
			"/fragment@0/__overlay__/whirligig-controller@...",
			"interrupt-parent", <0>;
	};
};


Suppose then there's a new version of the board.  This extends the
widget socket in a backwards compatible way, but there are now two
interchangeable sockets, and they're wired up to different irqs and
i2c lines on the baseboard:

/dts-v1/;

/ {
	compatible =3D "foo,newboard";
	ranges;
	soc@... {
		ranges;=09
		mmio: mmio-bus@... {
			#address-cells =3D <2>;
			#size-cells =3D <2>;
			ranges;
		};
		i2c0: i2c@... {
		};
		i2c1: i2c@... {
		};
		intc: intc@... {
		};
	};

	connectors {
		widget1 {
			compatible =3D "foo,widget-socket-v2", "foo,widget-socket";
			w1_irqs: irqs {
				interrupt-controller;
				#address-cells =3D <0>;
				#interrupt-cells =3D <1>;
				interrupt-map-mask =3D <0xffffffff>;
				interrupt-map =3D <
					0 &intc 17 0
					1 &intc 8 0
				>;
			};
			aliases =3D {
				i2c =3D &i2c0;
				intc =3D &w1_irqs;
				mmio =3D &mmio;
			};
		};
		widget2 {
			compatible =3D "foo,widget-socket-v2", "foo,widget-socket";
			w2_irqs: irqs {
				interrupt-controller;
				#address-cells =3D <0>;
				#interrupt-cells =3D <1>;
				interrupt-map-mask =3D <0xffffffff>;
				interrupt-map =3D <
					0 &intc 9 0
					1 &intc 10 0
				>;
			};
			aliases =3D {
				i2c =3D &i2c1;
				widget-irqs =3D &w2_irqs;
				mmio =3D &mmio;
			};
		};
	};
};


A socketed device could also have it's own connectors - the contrived
example below has a little 256 byte mmio space (maybe some sort of LPC
thingy?):


/dts-v1/;

/plugin/ foo,widget-socket-v2 {
	compatible =3D "foo,superduper-widget};

	connectors {
		compatible =3D "foo,super-socket";
		aliases {
			superbus =3D &superbus;
		};=09
	};
};

&mmio {
	superbus: super-bridge@100000000 {
		#address-cells =3D <1>;
		#size-cells =3D <1>;
		ranges =3D <0x0  0xabcd0000 0x12345600  0x100>;
	};
};

&i2c {
	super-controller@... {
		...
	};
	duper-controller@... {
	};
};

Thoughts?


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WVXkb2QE2eH0aWe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXjOW1AAoJEGw4ysog2bOS/nkP/2BkWMNiRsid7BTqhPoAL6Pj
wPUl1SgeTxUgeos05gsn52atl5RrdilJ1P7c5DGXnguISmi+/rA2g8WCxRTR/bae
NZ2SdSakwYXfquwJ4/6q9LtraCNNr5W0t+e8CMynRCgWUKmDW6Uw8k+aOcHt77pF
vKDug+bXQKHGmmUBoVOjczXFZYrD9HUvlTRUYETYFEagIfqOqzgN/OvxlQVPTsvP
lbDHpTGcIAFLJ+nvAh4JpMO83PGFwlt+yqmpwbAtm5Pvp2a3u2/fMB+6SsF+AmeI
mBHwRc7LrRuSVHZvEgoDURd+00zBpfcr363YKAI4KXQfjJinjKdO8AgkASF8uTni
mJHiNizQcEfbT4s985WRq6J/FKBRnt+MvB5ubdC3VD9OB7XkZwrpUsHFgVDVsfg2
RCLFWYHTgfniz46FQ4UPrJALAhWR33CMFKwYup6I5IxxBSnzwZoRJ+po0zgBX5XA
TM48iH3NccIexrzdzgjKwVLn2/XE8RA8M0R7j6fhomfVk71lFRi8AMp2xsltbZm1
+a8OPCDPXbF8BCFLiIhBgaZbd/WGSvscSwnXsg9e9Z4UxkbKleTJq8oTLYYVm7zf
1iSMrOqwiISqdlQfC6oaEw+Snu7ixDvrcuhKy2Lp1mV3cSrvcyiQKrLV+dRlr1LI
4S2cu5CjbtlzIWCLIt2f
=cY8a
-----END PGP SIGNATURE-----

--WVXkb2QE2eH0aWe4--
