From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: Portable Device Tree Connector -- conceptual
Date: Fri, 1 Jul 2016 11:21:58 -0700
Message-ID: <5776B4C6.4060200@gmail.com>
References: <5775B2FD.2000103@gmail.com>
 <199EAB87-47DA-4213-BE60-43C2E062AAD5@konsulko.com>
 <57769AF3.2040301@gmail.com>
 <BA83424E-093C-4D73-89E9-392BF1A1ADCB@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BA83424E-093C-4D73-89E9-392BF1A1ADCB@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Rob Herring <robh+dt@kernel.org>, David Gibson <david@gibson.dropbear.id.au>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 07/01/16 09:56, Pantelis Antoniou wrote:
> Hi Frank,
>=20
>> On Jul 1, 2016, at 19:31 , Frank Rowand <frowand.list@gmail.com> wro=
te:
>>
>> On 07/01/16 03:59, Pantelis Antoniou wrote:
>>> Hi Frank,
>>>
>>> Comments inline.
>>>
>>>> On Jul 1, 2016, at 03:02 , Frank Rowand <frowand.list@gmail.com> w=
rote:
>>>>
>>>> Hi All,
>>>>
>>>> I've been trying to wrap my head around what Pantelis and Rob have=
 written
>>>> on the subject of a device tree representation of a connector for =
a
>>>> daughter board to connect to (eg a cape or a shield) and the repre=
sentation
>>>> of the daughter board.  (Or any other physically pluggable object.=
)
>>>>
>>>> After trying to make sense of what had been written (or presented =
via slides
>>>> at a conference - thanks Pantelis!), I decided to go back to first=
 principals
>>>> of what we are trying to accomplish.  I came up with some really s=
imple bogus
>>>> examples to try to explain what my thought process is.
>>>>
>>>> To start with, assume that the device that will eventually be on a=
 daughter
>>>> board is first soldered onto the main board.  Then the device tree=
 will
>>>> look like:
>>>>
>>>> $ cat board.dts
>>>> /dts-v1/;
>>>>
>>>> / {
>>>>       #address-cells =3D < 1 >;
>>>>       #size-cells =3D < 1 >;
>>>>
>>>>       tree_1: soc@0 {
>>>>               reg =3D <0x0 0x0>;
>>>>
>>>>               spi_1: spi1 {
>>>>               };
>>>>       };
>>>>
>>>> };
>>>>
>>>> &spi_1 {
>>>>       ethernet-switch@0 {
>>>>               compatible =3D "micrel,ks8995m";
>>>>       };
>>>> };
>>>>
>>>> #include "spi_codec.dtsi"
>>>>
>>>> $ cat spi_codec.dtsi
>>>> &spi_1 {
>>>> 	codec@1 {
>>>> 		compatible =3D "ti,tlv320aic26";
>>>> 	};
>>>> };
>>>>
>>>>
>>>> #----- codec chip on cape
>>>>
>>>> Then suppose I move the codec chip to a cape.  Then I will have th=
e same
>>>> exact .dts and .dtsi and everything still works.
>>>>
>>>>
>>>> @----- codec chip on cape, overlay
>>>>
>>>> If I want to use overlays, I only have to add the version and "/pl=
ugin/",
>>>> then use the '-@' flag for dtc (both for the previous board.dts an=
d
>>>> this spi_codec_overlay.dts):
>>>>
>>>> $ cat spi_codec_overlay.dts
>>>> /dts-v1/;
>>>>
>>>> /plugin/;
>>>>
>>>> &spi_1 {
>>>> 	codec@1 {
>>>> 		compatible =3D "ti,tlv320aic26";
>>>> 	};
>>>> };
>>>>
>>>
>>> The correct form now for the /plugin/ declaration should be like
>>>
>>> /dts-v1/ /plugin/;
>>>
>>> The old method still works for backward compatibility.
>>>
>>> In fact with the new patches you don=E2=80=99t even /plugin/ since =
when
>>> compiling an overlay we can turn on the plugin flag by looking
>>> at the output type (dtbo).
>>>
>>>>
>>>> #----- codec chip on cape, overlay, connector
>>>>
>>>> Now we move into the realm of connectors.  My mental model of what=
 the
>>>> hardware and driver look like has not changed.  The only thing tha=
t has
>>>> changed is that I want to be able to specify that the connector th=
at
>>>> the cape is plugged into has some pins that are the spi bus /soc/s=
pi1.
>>>>
>>>
>>> That=E2=80=99s not nearly enough. You might have extra=20
>>> gpio/interrupt/dma/gpmc(memory-controller) pins.
>>
>> Yes.
>>
>> I was keeping the example _very_ simple.  I was trying to illustrate
>> the _concept_, not provide a full implementation.
>>
>> In a real use, the connector node would provide a node for each of t=
he
>> things routed to the connector.
>>
>=20
> We need the example of how to handle pinmux cause it=E2=80=99s the tr=
ickiest
> thing of all.
>=20
>>
>>> We can disregard dma and gpmc like interfaces for now but gpio and
>>> interrupt pins are required.
>>>
>>> For instance the spi device might have an extra gpio that it=E2=80=99=
s using
>>> to signal some kind of condition (for example low-battery) which an
>>> application (not just the kernel) can use to make a platform specif=
ic
>>> decision.
>>>
>>>> The following _almost_ but not quite gets me what I want.  Note th=
at
>>>> the only thing the connector node does is provide some kind of
>>>> pointer or reference to what node(s) are physically routed through
>>>> the connector.  (This node will turn out to not actually work in
>>>> this example.)
>>>>
>>>> $ cat board_with_connector.dts
>>>> /dts-v1/;
>>>>
>>>> / {
>>>> 	#address-cells =3D < 1 >;
>>>> 	#size-cells =3D < 1 >;
>>>>
>>>> 	tree_1: soc@0 {
>>>> 		reg =3D <0x0 0x0>;
>>>>
>>>> 		spi_1: spi1 {
>>>> 		};
>>>> 	};
>>>>
>>>> 	connector_1: connector_1 {
>>>> 		spi1 {
>>>> 			target_phandle =3D <&spi_1>;
>>>> 			target_path =3D "/soc/spi1";
>>>> 		};
>>>> 	};
>>>>
>>>> };
>>>>
>>>> &spi_1 {
>>>> 	ethernet-switch@0 {
>>>> 		compatible =3D "micrel,ks8995m";
>>>> 	};
>>>> };
>>>>
>>>> $ cat spi_codec_overlay_with_connector.dts
>>>> /dts-v1/;
>>>>
>>>> /plugin/;
>>>>
>>>> &connector_1 {
>>>> 	spi1 {
>>>> 		codec@1 {
>>>> 			compatible =3D "ti,tlv320aic26";
>>>> 		};
>>>> 	};
>>>> };
>>>
>>> This is a subset of what=E2=80=99s supported by the patch I=E2=80=99=
ve sent out.
>>
>> Yes.  Same comment as above.
>>
>>
>>> Your example works as long as you assume that there=E2=80=99s no pi=
nmuxing
>>> related to the configuration of the spi controller when routed out
>>> to the connector pins.
>>
>> No.  Pinmuxing is part of the host board dts.
>>
>=20
> It is part of the host board DTS yes, but the connector must have
> a way to set the pinmux configuration according what the detected
> expansion board expects.
>=20
>> The physical connector does not change the way that pinmuxing
>> works.  It is just the same as if there were wires physically
>> connected (soldered) between the daughter board and the main
>> board.
>>
>=20
> The physical properties of the pin of the connector do not change.
>=20
> However the routing of functions in the SoC do change.
>=20
> By default most of the pins on the connector are HiZ or set to input =
when
> no expansion board is connected. The only fixed function pins that ar=
e
> known and configured by the host board dts are those that are used by
> the host board=E2=80=99s identification scheme (i.e. I2C EEPROM, set =
of GPIO inputs
> etc).=20
>=20
> When an expansion board is connected upon boot and probing of the the=
 expansion
> board manager device it will use a method that is using the configure=
d detection
> pins to identify it.
>=20
> After getting the ID it is going to find a corresponding overlay to a=
pply.
>=20
> This overlay will have to configure each pin accordingly.
>=20
> It is perfectly for a pin on a connector to be a GPIO output for expa=
nsion
> board A, I2C bus SDA for board B, etc...
>=20
> So there has to be a way to get the pinmux configuration according to=
 the
> required connection function on each pin in use.

Again, this is exactly the same concept as if the daughter board was so=
ldered
directly to the host board with no connector involved.  The pinmux
configuration has nothing to do with the physical connector, it is alre=
ady
described by the pinmux information in the host board .dtb.  The connec=
tor
node in the host .dtb does not need to duplicate any of that informatio=
n.

There already is a pinmux mechanism in place to choose which of the
possible alternative uses of a set of pins is in use at any point
in time.  The choice of active functionality can be changed at
any time.

The pinmux configuration is already in place in the host board .dtb.
The host board .dtb connector node only provides a mapping to what
other nodes have hardware blocks that have signals that are routed
to the physical connector.  There is no need for the connector node
to be concerned with any of the details of those other nodes -- the
other nodes already specify the details.

>>> In reality there are may be many possible option of the same
>>> hardware block (spi/i2c) to be routed to different pins on the
>>> connector.
>>>
>>> You might get by if you have a number of selectable pre-canned
>>> spi configuration that are selected.
>>
>> Again, just the same as if the connector did not exist and
>> everything is hardwired.
>>
>> The connector node for the host board would contain a node for
>> each of the alternative uses of the pins.
>>
>=20
> Right.
>=20
>>
>>> For instance if there are two spi controllers each of which have
>>> two different pinout options on the connector you would address
>>> each as a different spi controller on the connector, but then
>>> you=E2=80=99d end up with
>>>
>>> spi_connector_0 -> spi_0_mux_0
>>> spi_connector_1 -> spi_0_mux_1
>>> spi_connector_2 -> spi_1_mux_0
>>> spi_connector_3 -> spi_1_mux_1
>>
>> Yes.  But again, exactly the same as if the daughter board was
>> hard wired with no intervening physical connector.
>>
>=20
> Yes.
>=20
>>
>>> It gets hairy though pretty fast with modern SoCs with extensive=20
>>> muxing options.
>>>
>>>>
>>>> The result is that the overlay fixup for spi1 on the cape will
>>>> relocate the spi1 node to /connector_1 in the host tree, so
>>>> this does not solve the connector linkage yet:
>>>>
>>>> -- chunk from the decompiled board_with_connector.dtb:
>>>>
>>>> 	__symbols__ {
>>>> 		connector_1 =3D "/connector_1";
>>>> 	};
>>>>
>>>> -- chunk from the decompiled spi_codec_overlay_with_connector.dtb:
>>>>
>>>> 	fragment@0 {
>>>> 		target =3D <0xffffffff>;
>>>> 		__overlay__ {
>>>> 			spi1 {
>>>> 				codec@1 {
>>>> 					compatible =3D "ti,tlv320aic26";
>>>> 				};
>>>> 			};
>>>> 		};
>>>> 	};
>>>> 	__fixups__ {
>>>> 		connector_1 =3D "/fragment@0:target:0";
>>>> 	};
>>>>
>>>>
>>>> #----- magic new dtc syntax
>>>>
>>>> What I really want is some way to tell dtc that I want to do one
>>>> level of dereferencing when resolving the path of device nodes
>>>> contained by the connector node in the overlay dts.
>>>>
>>>> The exact syntax does not matter here, I am just trying to get the
>>>> concept.  I will add the not yet implemented dtc feature of
>>>> "/connector/" to the connector node in both the tree dts and the
>>>> overlay dts, and show how the output of dtc would change.  The
>>>> "/connector/" directive tells dtc that for a base dts (hand
>>>> waving how it knows base vs overlay dts file) to look into
>>>> each node at that level and determine what other node it
>>>> maps to (again, hand waving, in this example just to
>>>> show the linkage, I have hard coded both the path and the
>>>> phandle of the target node that the connector child node
>>>> maps to).  The "/connector/" directive tells dtc that for
>>>> an overlay dts (again hand waving) to provide a fixup for
>>>> each child node.
>>>>
>>>> $ cat board_with_connector_v2.dts
>>>> /dts-v1/;
>>>>
>>>> / {
>>>> 	#address-cells =3D < 1 >;
>>>> 	#size-cells =3D < 1 >;
>>>>
>>>> 	tree_1: soc@0 {
>>>> 		reg =3D <0x0 0x0>;
>>>>
>>>> 		spi_1: spi1 {
>>>> 		};
>>>> 	};
>>>>
>>>> 	connector_1: connector_1 {
>>>> 		/connector/;
>>>> 		spi1 {
>>>> 			target_phandle =3D <&spi_1>;
>>>> 			target_path =3D "/soc/spi1";
>>>> 		};
>>>> 	};
>>>>
>>>> };
>>>>
>>>> &spi_1 {
>>>> 	ethernet-switch@0 {
>>>> 		compatible =3D "micrel,ks8995m";
>>>> 	};
>>>> };
>>>>
>>>> $ cat spi_codec_overlay_with_connector_v2.dts
>>>>
>>>> /dts-v1/;
>>>>
>>>> /plugin/;
>>>>
>>>> &connector_1 {
>>>> 	/connector/;
>>>> 	spi1 {
>>>> 		codec@1 {
>>>> 			compatible =3D "ti,tlv320aic26";
>>>> 		};
>>>> 	};
>>>> };
>>>>
>>>> -- chunk from the decompiled board_with_connector_v2.dtb:
>>>>
>>>> 	__symbols__ {
>>>>               connector_1 {
>>>>                       spi1 =3D "/soc@0/spi1";
>>>>               };
>>>>       };
>>>>
>>>> -- chunk from the decompiled spi_codec_overlay_with_connector_v2.d=
tb:
>>>>
>>>> / {
>>>>
>>>> 	fragment@0 {
>>>> 		target =3D <0xffffffff>;
>>>> 		__overlay__ {
>>>> 			spi1 {
>>>> 				codec@1 {
>>>> 					compatible =3D "ti,tlv320aic26";
>>>> 				};
>>>> 			};
>>>> 		};
>>>> 	};
>>>> 	__fixups__ {
>>>>               connector_1 {
>>>> 		        spi1 =3D "/fragment@0/__overlay__:spi1:0";
>>>>               };
>>>> 	};
>>>>
>>>> Of course the overlay loader will also have to be modified to unde=
rstand
>>>> the new information.
>>>>
>>>> Exact format of the __symbols__ and __fixups__ are implementation
>>>> details, I am just trying to present the model.
>>>>
>>>> Ignoring device tree source syntax and dtc implementation issues, =
does
>>>> this conceptual model look more straight forward and a better dire=
ction
>>>> for how to represent connectors?
>>>>
>>>
>>> We could use dtc sugar to get to something more elegant, I need som=
e time
>>> to think about this a bit longer.
>>>
>>>> -Frank
>>>
>>> Regards
>>>
>>> =E2=80=94 Pantelis
>=20
> Regards
>=20
> =E2=80=94 Pantelis
>=20
>=20
