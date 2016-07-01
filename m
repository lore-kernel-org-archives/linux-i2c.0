From: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Portable Device Tree Connector -- conceptual
Date: Fri, 1 Jul 2016 09:31:47 -0700
Message-ID: <57769AF3.2040301@gmail.com>
References: <5775B2FD.2000103@gmail.com>
 <199EAB87-47DA-4213-BE60-43C2E062AAD5@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <199EAB87-47DA-4213-BE60-43C2E062AAD5-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>, Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 07/01/16 03:59, Pantelis Antoniou wrote:
> Hi Frank,
>=20
> Comments inline.
>=20
>> On Jul 1, 2016, at 03:02 , Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
>>
>> Hi All,
>>
>> I've been trying to wrap my head around what Pantelis and Rob have w=
ritten
>> on the subject of a device tree representation of a connector for a
>> daughter board to connect to (eg a cape or a shield) and the represe=
ntation
>> of the daughter board.  (Or any other physically pluggable object.)
>>
>> After trying to make sense of what had been written (or presented vi=
a slides
>> at a conference - thanks Pantelis!), I decided to go back to first p=
rincipals
>> of what we are trying to accomplish.  I came up with some really sim=
ple bogus
>> examples to try to explain what my thought process is.
>>
>> To start with, assume that the device that will eventually be on a d=
aughter
>> board is first soldered onto the main board.  Then the device tree w=
ill
>> look like:
>>
>> $ cat board.dts
>> /dts-v1/;
>>
>> / {
>>        #address-cells =3D < 1 >;
>>        #size-cells =3D < 1 >;
>>
>>        tree_1: soc@0 {
>>                reg =3D <0x0 0x0>;
>>
>>                spi_1: spi1 {
>>                };
>>        };
>>
>> };
>>
>> &spi_1 {
>>        ethernet-switch@0 {
>>                compatible =3D "micrel,ks8995m";
>>        };
>> };
>>
>> #include "spi_codec.dtsi"
>>
>> $ cat spi_codec.dtsi
>> &spi_1 {
>> 	codec@1 {
>> 		compatible =3D "ti,tlv320aic26";
>> 	};
>> };
>>
>>
>> #----- codec chip on cape
>>
>> Then suppose I move the codec chip to a cape.  Then I will have the =
same
>> exact .dts and .dtsi and everything still works.
>>
>>
>> @----- codec chip on cape, overlay
>>
>> If I want to use overlays, I only have to add the version and "/plug=
in/",
>> then use the '-@' flag for dtc (both for the previous board.dts and
>> this spi_codec_overlay.dts):
>>
>> $ cat spi_codec_overlay.dts
>> /dts-v1/;
>>
>> /plugin/;
>>
>> &spi_1 {
>> 	codec@1 {
>> 		compatible =3D "ti,tlv320aic26";
>> 	};
>> };
>>
>=20
> The correct form now for the /plugin/ declaration should be like
>=20
> /dts-v1/ /plugin/;
>=20
> The old method still works for backward compatibility.
>=20
> In fact with the new patches you don=E2=80=99t even /plugin/ since wh=
en
> compiling an overlay we can turn on the plugin flag by looking
> at the output type (dtbo).
> =20
>>
>> #----- codec chip on cape, overlay, connector
>>
>> Now we move into the realm of connectors.  My mental model of what t=
he
>> hardware and driver look like has not changed.  The only thing that =
has
>> changed is that I want to be able to specify that the connector that
>> the cape is plugged into has some pins that are the spi bus /soc/spi=
1.
>>
>=20
> That=E2=80=99s not nearly enough. You might have extra=20
> gpio/interrupt/dma/gpmc(memory-controller) pins.

Yes.

I was keeping the example _very_ simple.  I was trying to illustrate
the _concept_, not provide a full implementation.

In a real use, the connector node would provide a node for each of the
things routed to the connector.


> We can disregard dma and gpmc like interfaces for now but gpio and
> interrupt pins are required.
>=20
> For instance the spi device might have an extra gpio that it=E2=80=99=
s using
> to signal some kind of condition (for example low-battery) which an
> application (not just the kernel) can use to make a platform specific
> decision.
>=20
>> The following _almost_ but not quite gets me what I want.  Note that
>> the only thing the connector node does is provide some kind of
>> pointer or reference to what node(s) are physically routed through
>> the connector.  (This node will turn out to not actually work in
>> this example.)
>>
>> $ cat board_with_connector.dts
>> /dts-v1/;
>>
>> / {
>> 	#address-cells =3D < 1 >;
>> 	#size-cells =3D < 1 >;
>>
>> 	tree_1: soc@0 {
>> 		reg =3D <0x0 0x0>;
>>
>> 		spi_1: spi1 {
>> 		};
>> 	};
>>
>> 	connector_1: connector_1 {
>> 		spi1 {
>> 			target_phandle =3D <&spi_1>;
>> 			target_path =3D "/soc/spi1";
>> 		};
>> 	};
>>
>> };
>>
>> &spi_1 {
>> 	ethernet-switch@0 {
>> 		compatible =3D "micrel,ks8995m";
>> 	};
>> };
>>
>> $ cat spi_codec_overlay_with_connector.dts
>> /dts-v1/;
>>
>> /plugin/;
>>
>> &connector_1 {
>> 	spi1 {
>> 		codec@1 {
>> 			compatible =3D "ti,tlv320aic26";
>> 		};
>> 	};
>> };
>=20
> This is a subset of what=E2=80=99s supported by the patch I=E2=80=99v=
e sent out.

Yes.  Same comment as above.


> Your example works as long as you assume that there=E2=80=99s no pinm=
uxing
> related to the configuration of the spi controller when routed out
> to the connector pins.

No.  Pinmuxing is part of the host board dts.

The physical connector does not change the way that pinmuxing
works.  It is just the same as if there were wires physically
connected (soldered) between the daughter board and the main
board.


> In reality there are may be many possible option of the same
> hardware block (spi/i2c) to be routed to different pins on the
> connector.
>=20
> You might get by if you have a number of selectable pre-canned
> spi configuration that are selected.

Again, just the same as if the connector did not exist and
everything is hardwired.

The connector node for the host board would contain a node for
each of the alternative uses of the pins.


> For instance if there are two spi controllers each of which have
> two different pinout options on the connector you would address
> each as a different spi controller on the connector, but then
> you=E2=80=99d end up with
>=20
> spi_connector_0 -> spi_0_mux_0
> spi_connector_1 -> spi_0_mux_1
> spi_connector_2 -> spi_1_mux_0
> spi_connector_3 -> spi_1_mux_1

Yes.  But again, exactly the same as if the daughter board was
hard wired with no intervening physical connector.


> It gets hairy though pretty fast with modern SoCs with extensive=20
> muxing options.
> =20
>>
>> The result is that the overlay fixup for spi1 on the cape will
>> relocate the spi1 node to /connector_1 in the host tree, so
>> this does not solve the connector linkage yet:
>>
>> -- chunk from the decompiled board_with_connector.dtb:
>>
>> 	__symbols__ {
>> 		connector_1 =3D "/connector_1";
>> 	};
>>
>> -- chunk from the decompiled spi_codec_overlay_with_connector.dtb:
>>
>> 	fragment@0 {
>> 		target =3D <0xffffffff>;
>> 		__overlay__ {
>> 			spi1 {
>> 				codec@1 {
>> 					compatible =3D "ti,tlv320aic26";
>> 				};
>> 			};
>> 		};
>> 	};
>> 	__fixups__ {
>> 		connector_1 =3D "/fragment@0:target:0";
>> 	};
>>
>>
>> #----- magic new dtc syntax
>>
>> What I really want is some way to tell dtc that I want to do one
>> level of dereferencing when resolving the path of device nodes
>> contained by the connector node in the overlay dts.
>>
>> The exact syntax does not matter here, I am just trying to get the
>> concept.  I will add the not yet implemented dtc feature of
>> "/connector/" to the connector node in both the tree dts and the
>> overlay dts, and show how the output of dtc would change.  The
>> "/connector/" directive tells dtc that for a base dts (hand
>> waving how it knows base vs overlay dts file) to look into
>> each node at that level and determine what other node it
>> maps to (again, hand waving, in this example just to
>> show the linkage, I have hard coded both the path and the
>> phandle of the target node that the connector child node
>> maps to).  The "/connector/" directive tells dtc that for
>> an overlay dts (again hand waving) to provide a fixup for
>> each child node.
>>
>> $ cat board_with_connector_v2.dts
>> /dts-v1/;
>>
>> / {
>> 	#address-cells =3D < 1 >;
>> 	#size-cells =3D < 1 >;
>>
>> 	tree_1: soc@0 {
>> 		reg =3D <0x0 0x0>;
>>
>> 		spi_1: spi1 {
>> 		};
>> 	};
>>
>> 	connector_1: connector_1 {
>> 		/connector/;
>> 		spi1 {
>> 			target_phandle =3D <&spi_1>;
>> 			target_path =3D "/soc/spi1";
>> 		};
>> 	};
>>
>> };
>>
>> &spi_1 {
>> 	ethernet-switch@0 {
>> 		compatible =3D "micrel,ks8995m";
>> 	};
>> };
>>
>> $ cat spi_codec_overlay_with_connector_v2.dts
>>
>> /dts-v1/;
>>
>> /plugin/;
>>
>> &connector_1 {
>> 	/connector/;
>> 	spi1 {
>> 		codec@1 {
>> 			compatible =3D "ti,tlv320aic26";
>> 		};
>> 	};
>> };
>>
>> -- chunk from the decompiled board_with_connector_v2.dtb:
>>
>> 	__symbols__ {
>>                connector_1 {
>>                        spi1 =3D "/soc@0/spi1";
>>                };
>>        };
>>
>> -- chunk from the decompiled spi_codec_overlay_with_connector_v2.dtb=
:
>>
>> / {
>>
>> 	fragment@0 {
>> 		target =3D <0xffffffff>;
>> 		__overlay__ {
>> 			spi1 {
>> 				codec@1 {
>> 					compatible =3D "ti,tlv320aic26";
>> 				};
>> 			};
>> 		};
>> 	};
>> 	__fixups__ {
>>                connector_1 {
>> 		        spi1 =3D "/fragment@0/__overlay__:spi1:0";
>>                };
>> 	};
>>
>> Of course the overlay loader will also have to be modified to unders=
tand
>> the new information.
>>
>> Exact format of the __symbols__ and __fixups__ are implementation
>> details, I am just trying to present the model.
>>
>> Ignoring device tree source syntax and dtc implementation issues, do=
es
>> this conceptual model look more straight forward and a better direct=
ion
>> for how to represent connectors?
>>
>=20
> We could use dtc sugar to get to something more elegant, I need some =
time
> to think about this a bit longer.
>=20
>> -Frank
>=20
> Regards
>=20
> =E2=80=94 Pantelis
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
