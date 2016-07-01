From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: Portable Device Tree Connector -- conceptual
Date: Fri, 1 Jul 2016 13:59:58 +0300
Message-ID: <199EAB87-47DA-4213-BE60-43C2E062AAD5@konsulko.com>
References: <5775B2FD.2000103@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5775B2FD.2000103@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, David Gibson <david@gibson.dropbear.id.au>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Frank,

Comments inline.

> On Jul 1, 2016, at 03:02 , Frank Rowand <frowand.list@gmail.com> wrot=
e:
>=20
> Hi All,
>=20
> I've been trying to wrap my head around what Pantelis and Rob have wr=
itten
> on the subject of a device tree representation of a connector for a
> daughter board to connect to (eg a cape or a shield) and the represen=
tation
> of the daughter board.  (Or any other physically pluggable object.)
>=20
> After trying to make sense of what had been written (or presented via=
 slides
> at a conference - thanks Pantelis!), I decided to go back to first pr=
incipals
> of what we are trying to accomplish.  I came up with some really simp=
le bogus
> examples to try to explain what my thought process is.
>=20
> To start with, assume that the device that will eventually be on a da=
ughter
> board is first soldered onto the main board.  Then the device tree wi=
ll
> look like:
>=20
> $ cat board.dts
> /dts-v1/;
>=20
> / {
>        #address-cells =3D < 1 >;
>        #size-cells =3D < 1 >;
>=20
>        tree_1: soc@0 {
>                reg =3D <0x0 0x0>;
>=20
>                spi_1: spi1 {
>                };
>        };
>=20
> };
>=20
> &spi_1 {
>        ethernet-switch@0 {
>                compatible =3D "micrel,ks8995m";
>        };
> };
>=20
> #include "spi_codec.dtsi"
>=20
> $ cat spi_codec.dtsi
> &spi_1 {
> 	codec@1 {
> 		compatible =3D "ti,tlv320aic26";
> 	};
> };
>=20
>=20
> #----- codec chip on cape
>=20
> Then suppose I move the codec chip to a cape.  Then I will have the s=
ame
> exact .dts and .dtsi and everything still works.
>=20
>=20
> @----- codec chip on cape, overlay
>=20
> If I want to use overlays, I only have to add the version and "/plugi=
n/",
> then use the '-@' flag for dtc (both for the previous board.dts and
> this spi_codec_overlay.dts):
>=20
> $ cat spi_codec_overlay.dts
> /dts-v1/;
>=20
> /plugin/;
>=20
> &spi_1 {
> 	codec@1 {
> 		compatible =3D "ti,tlv320aic26";
> 	};
> };
>=20

The correct form now for the /plugin/ declaration should be like

/dts-v1/ /plugin/;

The old method still works for backward compatibility.

In fact with the new patches you don=E2=80=99t even /plugin/ since when
compiling an overlay we can turn on the plugin flag by looking
at the output type (dtbo).
=20
>=20
> #----- codec chip on cape, overlay, connector
>=20
> Now we move into the realm of connectors.  My mental model of what th=
e
> hardware and driver look like has not changed.  The only thing that h=
as
> changed is that I want to be able to specify that the connector that
> the cape is plugged into has some pins that are the spi bus /soc/spi1=
=2E
>=20

That=E2=80=99s not nearly enough. You might have extra=20
gpio/interrupt/dma/gpmc(memory-controller) pins.

We can disregard dma and gpmc like interfaces for now but gpio and
interrupt pins are required.

=46or instance the spi device might have an extra gpio that it=E2=80=99=
s using
to signal some kind of condition (for example low-battery) which an
application (not just the kernel) can use to make a platform specific
decision.

> The following _almost_ but not quite gets me what I want.  Note that
> the only thing the connector node does is provide some kind of
> pointer or reference to what node(s) are physically routed through
> the connector.  (This node will turn out to not actually work in
> this example.)
>=20
> $ cat board_with_connector.dts
> /dts-v1/;
>=20
> / {
> 	#address-cells =3D < 1 >;
> 	#size-cells =3D < 1 >;
>=20
> 	tree_1: soc@0 {
> 		reg =3D <0x0 0x0>;
>=20
> 		spi_1: spi1 {
> 		};
> 	};
>=20
> 	connector_1: connector_1 {
> 		spi1 {
> 			target_phandle =3D <&spi_1>;
> 			target_path =3D "/soc/spi1";
> 		};
> 	};
>=20
> };
>=20
> &spi_1 {
> 	ethernet-switch@0 {
> 		compatible =3D "micrel,ks8995m";
> 	};
> };
>=20
> $ cat spi_codec_overlay_with_connector.dts
> /dts-v1/;
>=20
> /plugin/;
>=20
> &connector_1 {
> 	spi1 {
> 		codec@1 {
> 			compatible =3D "ti,tlv320aic26";
> 		};
> 	};
> };

This is a subset of what=E2=80=99s supported by the patch I=E2=80=99ve =
sent out.

Your example works as long as you assume that there=E2=80=99s no pinmux=
ing
related to the configuration of the spi controller when routed out
to the connector pins.

In reality there are may be many possible option of the same
hardware block (spi/i2c) to be routed to different pins on the
connector.

You might get by if you have a number of selectable pre-canned
spi configuration that are selected.

=46or instance if there are two spi controllers each of which have
two different pinout options on the connector you would address
each as a different spi controller on the connector, but then
you=E2=80=99d end up with

spi_connector_0 -> spi_0_mux_0
spi_connector_1 -> spi_0_mux_1
spi_connector_2 -> spi_1_mux_0
spi_connector_3 -> spi_1_mux_1

It gets hairy though pretty fast with modern SoCs with extensive=20
muxing options.
=20
>=20
> The result is that the overlay fixup for spi1 on the cape will
> relocate the spi1 node to /connector_1 in the host tree, so
> this does not solve the connector linkage yet:
>=20
> -- chunk from the decompiled board_with_connector.dtb:
>=20
> 	__symbols__ {
> 		connector_1 =3D "/connector_1";
> 	};
>=20
> -- chunk from the decompiled spi_codec_overlay_with_connector.dtb:
>=20
> 	fragment@0 {
> 		target =3D <0xffffffff>;
> 		__overlay__ {
> 			spi1 {
> 				codec@1 {
> 					compatible =3D "ti,tlv320aic26";
> 				};
> 			};
> 		};
> 	};
> 	__fixups__ {
> 		connector_1 =3D "/fragment@0:target:0";
> 	};
>=20
>=20
> #----- magic new dtc syntax
>=20
> What I really want is some way to tell dtc that I want to do one
> level of dereferencing when resolving the path of device nodes
> contained by the connector node in the overlay dts.
>=20
> The exact syntax does not matter here, I am just trying to get the
> concept.  I will add the not yet implemented dtc feature of
> "/connector/" to the connector node in both the tree dts and the
> overlay dts, and show how the output of dtc would change.  The
> "/connector/" directive tells dtc that for a base dts (hand
> waving how it knows base vs overlay dts file) to look into
> each node at that level and determine what other node it
> maps to (again, hand waving, in this example just to
> show the linkage, I have hard coded both the path and the
> phandle of the target node that the connector child node
> maps to).  The "/connector/" directive tells dtc that for
> an overlay dts (again hand waving) to provide a fixup for
> each child node.
>=20
> $ cat board_with_connector_v2.dts
> /dts-v1/;
>=20
> / {
> 	#address-cells =3D < 1 >;
> 	#size-cells =3D < 1 >;
>=20
> 	tree_1: soc@0 {
> 		reg =3D <0x0 0x0>;
>=20
> 		spi_1: spi1 {
> 		};
> 	};
>=20
> 	connector_1: connector_1 {
> 		/connector/;
> 		spi1 {
> 			target_phandle =3D <&spi_1>;
> 			target_path =3D "/soc/spi1";
> 		};
> 	};
>=20
> };
>=20
> &spi_1 {
> 	ethernet-switch@0 {
> 		compatible =3D "micrel,ks8995m";
> 	};
> };
>=20
> $ cat spi_codec_overlay_with_connector_v2.dts
>=20
> /dts-v1/;
>=20
> /plugin/;
>=20
> &connector_1 {
> 	/connector/;
> 	spi1 {
> 		codec@1 {
> 			compatible =3D "ti,tlv320aic26";
> 		};
> 	};
> };
>=20
> -- chunk from the decompiled board_with_connector_v2.dtb:
>=20
> 	__symbols__ {
>                connector_1 {
>                        spi1 =3D "/soc@0/spi1";
>                };
>        };
>=20
> -- chunk from the decompiled spi_codec_overlay_with_connector_v2.dtb:
>=20
> / {
>=20
> 	fragment@0 {
> 		target =3D <0xffffffff>;
> 		__overlay__ {
> 			spi1 {
> 				codec@1 {
> 					compatible =3D "ti,tlv320aic26";
> 				};
> 			};
> 		};
> 	};
> 	__fixups__ {
>                connector_1 {
> 		        spi1 =3D "/fragment@0/__overlay__:spi1:0";
>                };
> 	};
>=20
> Of course the overlay loader will also have to be modified to underst=
and
> the new information.
>=20
> Exact format of the __symbols__ and __fixups__ are implementation
> details, I am just trying to present the model.
>=20
> Ignoring device tree source syntax and dtc implementation issues, doe=
s
> this conceptual model look more straight forward and a better directi=
on
> for how to represent connectors?
>=20

We could use dtc sugar to get to something more elegant, I need some ti=
me
to think about this a bit longer.

> -Frank

Regards

=E2=80=94 Pantelis
