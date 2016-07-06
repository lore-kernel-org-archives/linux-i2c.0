From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH 0/1] Portable Device Tree Connector -- conceptual
Date: Wed, 6 Jul 2016 10:40:00 -0700
Message-ID: <577D4270.5040308@gmail.com>
References: <1467503750-31703-1-git-send-email-frowand.list@gmail.com>
 <FB5889C3-90B6-4D9D-9DC8-1D49215453BD@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32992 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbcGFRkM (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Jul 2016 13:40:12 -0400
In-Reply-To: <FB5889C3-90B6-4D9D-9DC8-1D49215453BD@antoniou-consulting.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: robh+dt@kernel.org, David Gibson <david@gibson.dropbear.id.au>, stephen.boyd@linaro.org, broonie@kernel.org, Grant Likely <grant.likely@secretlab.ca>, mark.rutland@arm.com, Matt Porter <mporter@konsulko.com>, koen@dominion.thruhere.net, linux@roeck-us.net, marex@denx.de, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

On 07/05/16 11:01, Pantelis Antoniou wrote:
> Hi Frank,
>=20
> Sorry for taking a bit to reply, had to grok it well first.
>=20
>> On Jul 3, 2016, at 02:55 , frowand.list@gmail.com wrote:
>>
>> From: Frank Rowand <frank.rowand@am.sony.com>
>>
>> Hi All,
>>
>> This is version 2 of this email.
>>
>> Changes from version 1:
>>
>>  - some rewording of the text
>>  - removed new (theoretical) dtc directive "/connector/"
>>  - added compatibility between mother board and daughter board
>>  - added info on applying a single .dtbo to different connectors
>>  - attached an RFC patch showing the required kernel changes
>>  - changes to mother board .dts connector node:
>>     - removed target_path property
>>     - added connector-socket property
>>  - changes to daughter board .dts connector node:
>>     - added connector-plug property
>>
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
>> This is an extremely simple example to illustrate the concepts.  It =
is not
>> meant to represent the complexity of a real board.
>>
>> To start with, assume that the device that will eventually be on a d=
aughter
>> board is first soldered onto the mother board.  The mother board con=
tains
>> two devices connected via bus spi_1.  One device is described in the=
 .dts
>> file, the other is described in an included .dtsi file.
>> Then the device tree files will look like:
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
>>
>> Pantelis pointed out that the syntax has changed to be:
>>   /dts-v1/ /plugin/;
>>
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
>> The following _almost_ but not quite gets me what I want.  Note that
>> the only thing the connector node does is provide some kind of
>> pointer or reference to what node(s) are physically routed through
>> the connector.  The connector node does not need to describe the pin=
s;
>> it only has to point to the node that describes the pins.
>>


>> This example will turn out to be not sufficient.  It is a stepping
>> stone in building my mental model.

  ^^^^^^^^^^^^^^^^^^^^^^

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
>>

There is an "off by one" here.  The above method was a mental stepping
stone.  You are correct that it does not work.

The stuff below "#----- magic new syntax" is what you need to look
at.  That was where I resolved the problem that remains at this step.


>=20
> You target connector_1. In theory multiples of the same connector
> may be available.
>=20
> There are complications about how they are applied. A method that=E2=80=
=99s not
> referring to a single phandle/path is going to be needed.

Yes.

I addressed that near the end of the original email.  I'll copy that
paragraph up here:

   The one remaining piece that this patch does not provide is how
   the overlay manager (which does not yet exist in the mainline
   tree) can apply an overlay to two different targets.  That
   final step should be a trivial change to of_overlay_create(),
   adding a parameter that is a mapping of the target (or maybe
   even targets) in the overlay to different targets in the
   active device tree.


> Thinking about it a bit more maybe we can sugar it with DTC with some=
thing like
> this:
>=20
> $ cat arduino_connector.dts
>=20
> /dts-v1/ /plugin/ /portable/;
>=20
> &arduino_connector {
> 	spi1 {
> 		codec@1 {
> 			compatible =3D =E2=80=9Cti,tlv320aic26=E2=80=9D;
> 		};
> 	};
> };
>=20
> $ cat board_with_arduino_connectors.dts
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
> 	connector_1 {
> 		connector-socket;
> 		compatible =3D =E2=80=9Carduino_connector=E2=80=9D;
> 		status =3D =E2=80=9Cokay=E2=80=9D;
>=20
> 		spi1 {
> 			target_phandle =3D <&spi_1>;
> 		};
> 	};
>=20
> 	connector_2 {
> 		connector-socket;
> 		compatible =3D =E2=80=9Carduino_connector=E2=80=9D;
> 	=09
> 		spi2 {
> 			target_phandle =3D <&spi_2>;
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
> &spi_2 {
> 	ethernet-switch@0 {
> 		compatible =3D "micrel,ks8995m";
> 	};
> };
>=20
> The &arduino_connector construct at a portable overlay can be resolve=
d
> as follows:
>=20
> fragment0 {
> 	target-compatible =3D =E2=80=9Carduino_connector=E2=80=9C;
> 	=E2=80=A6.
> };
>=20
> The new thing here is the =E2=80=98target-compatible=E2=80=99 option =
which the
> loader will use to find the target node.

I'm with Rob.  I would prefer to not add more ways a target property
can be specified.

I also do not like putting the target in the overlay .dtbo because
it should be possible to use the same exact .dtbo for two different
identical daughter boards plugged into two different connectors.

The .dtbo should be describing the daughter board.  It should not
be describing the mother board.

The method of specifying which connector a .dtbo applies to should
not be contained in the .dtbo.  It should be given to the overlay
manager as a separate piece of information.

But I do accept that the .dtbo needs to specify that a node on the
daughter board has a target on the motherboard, and I am willing
to specify a single default target on the motherboard.  In the
case of a single connector, the default target should just work.
That seems like a pragmatic useful result despite my philosophical
dislike of specifying a specific target in the .dtbo.


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
>=20
> ^ See above. Not going to work cause we need to support multiple
> identical connectors on the same board.
> =20
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
>> After applying the overlay, the codec@1 node will be at
>> /connector_1/spi1/codec@1.  What I want is for that node
>> to be at /spi1/codec@1.
>>
>>
>>
>> #----- magic new syntax
>>
>> What I really want is some way to tell dtc that I want to do one
>> level of dereferencing when resolving the path of device nodes
>> contained by the connector node in the overlay dts.
>>
>> Version 1 of this email suggested using dtc magic to do this extra
>> level of dereferencing.  This version of the email has changed to
>> have the kernel code that applies the overlay do the extra level
>> of dereferencing.
>>
>> The property "connector-socket" tells the kernel overlay code
>> that this is a socket.  The overlay code does not actually
>> do anything special as a result of this property; it is simply
>> used as a sanity check that this node really is a socket.  The
>> person writing the mother board .dts must provide the
>> target_phandle property, which points to a node responsible for
>> some of the pins on the connector.
>>
>> The property "connector-plug" tells the kernel overlay code
>> that each child node in the overlay corresponds to a node in the
>> socket, and the socket will contain one property that is
>> a phandle pointing to the node that is the target of that child
>> node in the overlay node.
>>
>>
>> $ cat board_with_connector_v2.dts
>>
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
>> 		compatible =3D "11-pin-accessory";
>> 		connector-socket;
>> 		spi1 {
>> 			target_phandle =3D <&spi_1>;
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
>>
>> $ cat spi_codec_overlay_with_connector_v2.dts
>>
>> /dts-v1/;
>>
>> /plugin/;
>>
>> &connector_1 {
>> 	connector-plug;
>=20
> ^ we won=E2=80=99t need this, nor the compatible string with the=20
> version I mentioned earlier
>=20
>> 	compatible =3D "11-pin-accessory";
>>
>> 	spi1 {
>> 		codec@1 {
>> 			compatible =3D "ti,tlv320aic26";
>> 		};
>> 	};
>> };
>>
>>
>> The spi_codec_overlay_with_connector_v2.dtb __fixups__ information
>> is unchanged from the previous example, but the kernel overlay
>> code will do the correct extra level of dereferencing when it
>> detects the connector-plug property in the overlay.
>>
>> The one remaining piece that this patch does not provide is how
>> the overlay manager (which does not yet exist in the mainline
>> tree) can apply an overlay to two different targets.  That
>> final step should be a trivial change to of_overlay_create(),
>> adding a parameter that is a mapping of the target (or maybe
>> even targets) in the overlay to different targets in the
>> active device tree.
>>
>> This seems like a more straight forward way to handle connectors.
>>
>> First, ignoring pinctrl and pinmux, what does everyone think?
>>
>> Then, the next step is whether pinctrl and pinmux work with this met=
hod.
>> Pantelis, can you point me to a good example for
>>
>>  1) an in-tree board dts file
>>  2) an overlay file (I am assuming out of tree) that applies to the =
board
>>  3) an in-tree .dtsi file that would provide the same features as
>>     the overlay file if it was included by the board dts file
>>
>=20
> Looks good for a starting point. We need to figure out pinmux and
> gpio/irq references for starter.

Yes.  But I would like to understand the problem space before
continuing on looking at solutions to the problem.

>=20
> It is imperative that references do not leak out of the connector
> node.

Yes.  I would include that in a list of design constraints.


>=20
>> It should be easier to discuss pinctrl and pinmux with an example.
>>
>> -Frank
>> =E2=80=94
>=20
> Regards
>=20
> =E2=80=94 Pantelis
>=20
>=20
