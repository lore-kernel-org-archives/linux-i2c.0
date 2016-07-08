From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC PATCH 0/1] Portable Device Tree Connector -- conceptual
Date: Fri, 8 Jul 2016 17:43:26 +1000
Message-ID: <20160708074326.GR14675@voom.fritz.box>
References: <1467503750-31703-1-git-send-email-frowand.list@gmail.com>
 <20160707071548.GV14675@voom.fritz.box>
 <2D8CFA9A-C317-4C02-9893-169B4B77E01E@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dx1O6sYEs5STvSrm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:46591 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbcGHHll (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 8 Jul 2016 03:41:41 -0400
Content-Disposition: inline
In-Reply-To: <2D8CFA9A-C317-4C02-9893-169B4B77E01E@konsulko.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: frowand.list@gmail.com, robh+dt@kernel.org, stephen.boyd@linaro.org, broonie@kernel.org, Grant Likely <grant.likely@secretlab.ca>, mark.rutland@arm.com, Matt Porter <mporter@konsulko.com>, koen@dominion.thruhere.net, linux@roeck-us.net, marex@denx.de, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--Dx1O6sYEs5STvSrm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 08, 2016 at 10:26:15AM +0300, Pantelis Antoniou wrote:
> Hi David,
>=20
> > On Jul 7, 2016, at 10:15 , David Gibson <david@gibson.dropbear.id.au> w=
rote:
> >=20
> > On Sat, Jul 02, 2016 at 04:55:49PM -0700, frowand.list@gmail.com wrote:
> >> From: Frank Rowand <frank.rowand@am.sony.com>
> >>=20
> >> Hi All,
> >>=20
> >> This is version 2 of this email.
> >>=20
> >> Changes from version 1:
> >>=20
> >>  - some rewording of the text
> >>  - removed new (theoretical) dtc directive "/connector/"
> >>  - added compatibility between mother board and daughter board
> >>  - added info on applying a single .dtbo to different connectors
> >>  - attached an RFC patch showing the required kernel changes
> >>  - changes to mother board .dts connector node:
> >>     - removed target_path property
> >>     - added connector-socket property
> >>  - changes to daughter board .dts connector node:
> >>     - added connector-plug property
> >>=20
> >>=20
> >> I've been trying to wrap my head around what Pantelis and Rob have wri=
tten
> >> on the subject of a device tree representation of a connector for a
> >> daughter board to connect to (eg a cape or a shield) and the represent=
ation
> >> of the daughter board.  (Or any other physically pluggable object.)
> >>=20
> >> After trying to make sense of what had been written (or presented via =
slides
> >> at a conference - thanks Pantelis!), I decided to go back to first pri=
ncipals
> >> of what we are trying to accomplish.  I came up with some really simpl=
e bogus
> >> examples to try to explain what my thought process is.
> >>=20
> >> This is an extremely simple example to illustrate the concepts.  It is=
 not
> >> meant to represent the complexity of a real board.
> >>=20
> >> To start with, assume that the device that will eventually be on a dau=
ghter
> >> board is first soldered onto the mother board.  The mother board conta=
ins
> >> two devices connected via bus spi_1.  One device is described in the .=
dts
> >> file, the other is described in an included .dtsi file.
> >> Then the device tree files will look like:
> >>=20
> >> $ cat board.dts
> >> /dts-v1/;
> >>=20
> >> / {
> >>        #address-cells =3D < 1 >;
> >>        #size-cells =3D < 1 >;
> >>=20
> >>        tree_1: soc@0 {
> >>                reg =3D <0x0 0x0>;
> >>=20
> >>                spi_1: spi1 {
> >>                };
> >>        };
> >>=20
> >> };
> >>=20
> >> &spi_1 {
> >>        ethernet-switch@0 {
> >>                compatible =3D "micrel,ks8995m";
> >>        };
> >> };
> >>=20
> >> #include "spi_codec.dtsi"
> >>=20
> >>=20
> >> $ cat spi_codec.dtsi
> >> &spi_1 {
> >> 	codec@1 {
> >> 		compatible =3D "ti,tlv320aic26";
> >> 	};
> >> };
> >>=20
> >>=20
> >> #----- codec chip on cape
> >>=20
> >> Then suppose I move the codec chip to a cape.  Then I will have the sa=
me
> >> exact .dts and .dtsi and everything still works.
> >>=20
> >>=20
> >> @----- codec chip on cape, overlay
> >>=20
> >> If I want to use overlays, I only have to add the version and "/plugin=
/",
> >> then use the '-@' flag for dtc (both for the previous board.dts and
> >> this spi_codec_overlay.dts):
> >>=20
> >> $ cat spi_codec_overlay.dts
> >> /dts-v1/;
> >>=20
> >> /plugin/;
> >>=20
> >> &spi_1 {
> >> 	codec@1 {
> >> 		compatible =3D "ti,tlv320aic26";
> >> 	};
> >> };
> >>=20
> >>=20
> >> Pantelis pointed out that the syntax has changed to be:
> >>   /dts-v1/ /plugin/;
> >>=20
> >>=20
> >> #----- codec chip on cape, overlay, connector
> >>=20
> >> Now we move into the realm of connectors.  My mental model of what the
> >> hardware and driver look like has not changed.  The only thing that has
> >> changed is that I want to be able to specify that the connector that
> >> the cape is plugged into has some pins that are the spi bus /soc/spi1.
> >>=20
> >> The following _almost_ but not quite gets me what I want.  Note that
> >> the only thing the connector node does is provide some kind of
> >> pointer or reference to what node(s) are physically routed through
> >> the connector.  The connector node does not need to describe the pins;
> >> it only has to point to the node that describes the pins.
> >>=20
> >> This example will turn out to be not sufficient.  It is a stepping
> >> stone in building my mental model.
> >>=20
> >> $ cat board_with_connector.dts
> >> /dts-v1/;
> >>=20
> >> / {
> >> 	#address-cells =3D < 1 >;
> >> 	#size-cells =3D < 1 >;
> >>=20
> >> 	tree_1: soc@0 {
> >> 		reg =3D <0x0 0x0>;
> >>=20
> >> 		spi_1: spi1 {
> >> 		};
> >> 	};
> >>=20
> >> 	connector_1: connector_1 {
> >> 		spi1 {
> >> 			target_phandle =3D <&spi_1>;
> >> 		};
> >> 	};
> >>=20
> >> };
> >>=20
> >> &spi_1 {
> >> 	ethernet-switch@0 {
> >> 		compatible =3D "micrel,ks8995m";
> >> 	};
> >> };
> >>=20
> >>=20
> >> $ cat spi_codec_overlay_with_connector.dts
> >> /dts-v1/;
> >>=20
> >> /plugin/;
> >>=20
> >> &connector_1 {
> >> 	spi1 {
> >> 		codec@1 {
> >> 			compatible =3D "ti,tlv320aic26";
> >> 		};
> >> 	};
> >> };
> >>=20
> >>=20
> >> The result is that the overlay fixup for spi1 on the cape will
> >> relocate the spi1 node to /connector_1 in the host tree, so
> >> this does not solve the connector linkage yet:
> >>=20
> >> -- chunk from the decompiled board_with_connector.dtb:
> >>=20
> >> 	__symbols__ {
> >> 		connector_1 =3D "/connector_1";
> >> 	};
> >>=20
> >> -- chunk from the decompiled spi_codec_overlay_with_connector.dtb:
> >>=20
> >> 	fragment@0 {
> >> 		target =3D <0xffffffff>;
> >> 		__overlay__ {
> >> 			spi1 {
> >> 				codec@1 {
> >> 					compatible =3D "ti,tlv320aic26";
> >> 				};
> >> 			};
> >> 		};
> >> 	};
> >> 	__fixups__ {
> >> 		connector_1 =3D "/fragment@0:target:0";
> >> 	};
> >>=20
> >>=20
> >> After applying the overlay, the codec@1 node will be at
> >> /connector_1/spi1/codec@1.  What I want is for that node
> >> to be at /spi1/codec@1.
> >>=20
> >>=20
> >>=20
> >> #----- magic new syntax
> >>=20
> >> What I really want is some way to tell dtc that I want to do one
> >> level of dereferencing when resolving the path of device nodes
> >> contained by the connector node in the overlay dts.
> >>=20
> >> Version 1 of this email suggested using dtc magic to do this extra
> >> level of dereferencing.  This version of the email has changed to
> >> have the kernel code that applies the overlay do the extra level
> >> of dereferencing.
> >>=20
> >> The property "connector-socket" tells the kernel overlay code
> >> that this is a socket.  The overlay code does not actually
> >> do anything special as a result of this property; it is simply
> >> used as a sanity check that this node really is a socket.  The
> >> person writing the mother board .dts must provide the
> >> target_phandle property, which points to a node responsible for
> >> some of the pins on the connector.
> >>=20
> >> The property "connector-plug" tells the kernel overlay code
> >> that each child node in the overlay corresponds to a node in the
> >> socket, and the socket will contain one property that is
> >> a phandle pointing to the node that is the target of that child
> >> node in the overlay node.
> >>=20
> >>=20
> >> $ cat board_with_connector_v2.dts
> >>=20
> >> /dts-v1/;
> >>=20
> >> / {
> >> 	#address-cells =3D < 1 >;
> >> 	#size-cells =3D < 1 >;
> >>=20
> >> 	tree_1: soc@0 {
> >> 		reg =3D <0x0 0x0>;
> >>=20
> >> 		spi_1: spi1 {
> >> 		};
> >> 	};
> >>=20
> >> 	connector_1: connector_1 {
> >> 		compatible =3D "11-pin-accessory";
> >> 		connector-socket;
> >=20
> > I don't see any advantage to allowing connectors anywhere in the tree:
> > pretty much by definition a connector is a "whole board" concept.  So
> > I think instead they should all go in a new special node under the
> > root, say /connectors.  With that done, you don't need the
> > connector-socket tag any more.
> >=20
>=20
> I=E2=80=99m fine with that. But only for the portable connector case.

Ok.

> >> 		spi1 {
> >> 			target_phandle =3D <&spi_1>;
> >> 		};
> >> 	};
> >>=20
> >> };
> >>=20
> >> &spi_1 {
> >> 	ethernet-switch@0 {
> >> 		compatible =3D "micrel,ks8995m";
> >> 	};
> >> };
> >>=20
> >>=20
> >> $ cat spi_codec_overlay_with_connector_v2.dts
> >>=20
> >> /dts-v1/;
> >>=20
> >> /plugin/;
> >>=20
> >> &connector_1 {
> >> 	connector-plug;
> >> 	compatible =3D "11-pin-accessory";
> >>=20
> >> 	spi1 {
> >> 		codec@1 {
> >> 			compatible =3D "ti,tlv320aic26";
> >> 		};
> >> 	};
> >> };
> >>=20
> >>=20
> >> The spi_codec_overlay_with_connector_v2.dtb __fixups__ information
> >> is unchanged from the previous example, but the kernel overlay
> >> code will do the correct extra level of dereferencing when it
> >> detects the connector-plug property in the overlay.
> >>=20
> >> The one remaining piece that this patch does not provide is how
> >> the overlay manager (which does not yet exist in the mainline
> >> tree) can apply an overlay to two different targets.  That
> >> final step should be a trivial change to of_overlay_create(),
> >> adding a parameter that is a mapping of the target (or maybe
> >> even targets) in the overlay to different targets in the
> >> active device tree.
> >>=20
> >> This seems like a more straight forward way to handle connectors.
> >>=20
> >> First, ignoring pinctrl and pinmux, what does everyone think?
> >>=20
> >> Then, the next step is whether pinctrl and pinmux work with this metho=
d.
> >> Pantelis, can you point me to a good example for
> >>=20
> >>  1) an in-tree board dts file
> >>  2) an overlay file (I am assuming out of tree) that applies to the bo=
ard
> >>  3) an in-tree .dtsi file that would provide the same features as
> >>     the overlay file if it was included by the board dts file
> >>=20
> >> It should be easier to discuss pinctrl and pinmux with an example.
> >=20
> > Hrm.. so I think you're trying to stick too close to the existing
> > overlay model.  Something I've always disliked about that model is
> > that the plugin can overlay *anywhere* in the master tree, meaning it
> > must have intimate knowledge of that tree.  Instead of using the
> > global __symbols__, there should be a set of "symbols" local to the
> > specific connector (socket), which are the *only* points which the
> > plugin is allowed to overlay or reference.
> >=20
>=20
> This is about the portable connector case.

Right, if I understand you correctly, that's the only case I'm
discussing here.

> We can figure out some way for local symbols for the portable
> case to work, but the global symbols for board specific overlays must
> be able to work.
>=20
> There are different use cases that call for both non-portable and portable
> overlays.

Right, I assumed that.  I'm suggesting this connector format in
addition to the existing overlay format (although I think the
connector format should be preferred when possible).

> > Given that we're going to need new code to support this new connector
> > model, I think we should also fix some of the uglies in the current
> > overlay format while we're at it.
> >=20
>=20
> We need to keep compatibility with the old format. There are 5 million
> RPIs sold, half a million beaglebones and C.H.I.P. is coming out too.
> They all use overlays in one form or another.
>=20
> That=E2=80=99s not counting all the custom boards that actively use them.
>=20
> We have a user base now.

Sorry, I wasn't clear.  I'm not suggesting we abolish the existing
overlay format, or alter it.  Despite its flaws it has a userbase, as
you say.

But I'm saying if we're creating a new format for portable connectors,
we shouldn't inherit those flaws when we don't have to.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Dx1O6sYEs5STvSrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXf1meAAoJEGw4ysog2bOSX70QANrXN9E/5Y6wDS9hjsdpkrQO
rp//YTb9rM+/fGb0ijPAndahXsy9FkBqIQVyRGtT2aoARnEqFnqGQ+3znd7Q6hGj
ZaLwUww9Rxd8h1BK9oFpzPRFg2r1dUM5TDW3W8TwpwTUJdXykeYGf3gNqzCibbM7
JrjkZ7JZ6556NfIHExUTJTLsyGBpYMtCQRljNM2p7WJ6c34rNxhxJ+NF7e4R6Gls
q9zPSN2oAP8uSVhf5KoeYWMd1U7F5nTbjTNoKUAArdUZuUEGATjXP+eEBZtbZKIq
DwF9wpl2eM3eL10TLwzg26X97WpULqMTPVxuBMO6vIV3tyhU7GyCMimBqVvoW4ow
AxgUKTuzV13bkMXTILhJz1jPJGsCZt95iEzwQ7RiIz0BSkvoKMPY+i2R156G2gDM
TVP7hhMLg/yeRCPrMTXf25OpOO/067hNfOumeAvx3ZKgk6l6m9jiW2Z/XhFFD2t/
G1Pc19FB6Svit7wfqxyY1w7YhvMudQNL9bbi9ob2/PKk7tiz/C1VOmf4mh4tEnJg
0OBOA33glT3RR2+Ghzh2xWu8VGHWxZBBWXvZRM9xaht7QnGXFqEkUg2tn+OR0Sv9
gXFhUbXaCCwvCQaKCG3Gi3iiq/qZa+EeaT9Q8zntbSjG0a1QtY7CTfdJskhh8W7P
X0ZYdDYhSzvLQNDQyTPx
=dcWH
-----END PGP SIGNATURE-----

--Dx1O6sYEs5STvSrm--
