From: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: Portable Device Tree Connector -- conceptual
Date: Fri, 1 Jul 2016 22:49:41 +0300
Message-ID: <C358BE2B-42EB-4029-ABC7-FBA9E8F8FCAF@konsulko.com>
References: <5775B2FD.2000103@gmail.com> <199EAB87-47DA-4213-BE60-43C2E062AAD5@konsulko.com> <57769AF3.2040301@gmail.com> <BA83424E-093C-4D73-89E9-392BF1A1ADCB@konsulko.com> <5776B4C6.4060200@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5776B4C6.4060200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>, Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Frank,

> On Jul 1, 2016, at 21:21 , Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
>=20
> On 07/01/16 09:56, Pantelis Antoniou wrote:
>> Hi Frank,
>>=20
>>> On Jul 1, 2016, at 19:31 , Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
>>>=20
>>> On 07/01/16 03:59, Pantelis Antoniou wrote:
>>>> Hi Frank,
>>>>=20
>>>> Comments inline.
>>>>=20
>>>>> On Jul 1, 2016, at 03:02 , Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:
>>>>>=20
>>>>> Hi All,
>>>>>=20
>>>>> I've been trying to wrap my head around what Pantelis and Rob hav=
e written
>>>>> on the subject of a device tree representation of a connector for=
 a
>>>>> daughter board to connect to (eg a cape or a shield) and the repr=
esentation
>>>>> of the daughter board.  (Or any other physically pluggable object=
=2E)
>>>>>=20
>>>>> After trying to make sense of what had been written (or presented=
 via slides
>>>>> at a conference - thanks Pantelis!), I decided to go back to firs=
t principals
>>>>> of what we are trying to accomplish.  I came up with some really =
simple bogus
>>>>> examples to try to explain what my thought process is.
>>>>>=20
>>>>> To start with, assume that the device that will eventually be on =
a daughter
>>>>> board is first soldered onto the main board.  Then the device tre=
e will
>>>>> look like:
>>>>>=20
>>>>> $ cat board.dts
>>>>> /dts-v1/;
>>>>>=20
>>>>> / {
>>>>>      #address-cells =3D < 1 >;
>>>>>      #size-cells =3D < 1 >;
>>>>>=20
>>>>>      tree_1: soc@0 {
>>>>>              reg =3D <0x0 0x0>;
>>>>>=20
>>>>>              spi_1: spi1 {
>>>>>              };
>>>>>      };
>>>>>=20
>>>>> };
>>>>>=20
>>>>> &spi_1 {
>>>>>      ethernet-switch@0 {
>>>>>              compatible =3D "micrel,ks8995m";
>>>>>      };
>>>>> };
>>>>>=20
>>>>> #include "spi_codec.dtsi"
>>>>>=20
>>>>> $ cat spi_codec.dtsi
>>>>> &spi_1 {
>>>>> 	codec@1 {
>>>>> 		compatible =3D "ti,tlv320aic26";
>>>>> 	};
>>>>> };
>>>>>=20
>>>>>=20
>>>>> #----- codec chip on cape
>>>>>=20
>>>>> Then suppose I move the codec chip to a cape.  Then I will have t=
he same
>>>>> exact .dts and .dtsi and everything still works.
>>>>>=20
>>>>>=20
>>>>> @----- codec chip on cape, overlay
>>>>>=20
>>>>> If I want to use overlays, I only have to add the version and "/p=
lugin/",
>>>>> then use the '-@' flag for dtc (both for the previous board.dts a=
nd
>>>>> this spi_codec_overlay.dts):
>>>>>=20
>>>>> $ cat spi_codec_overlay.dts
>>>>> /dts-v1/;
>>>>>=20
>>>>> /plugin/;
>>>>>=20
>>>>> &spi_1 {
>>>>> 	codec@1 {
>>>>> 		compatible =3D "ti,tlv320aic26";
>>>>> 	};
>>>>> };
>>>>>=20
>>>>=20
>>>> The correct form now for the /plugin/ declaration should be like
>>>>=20
>>>> /dts-v1/ /plugin/;
>>>>=20
>>>> The old method still works for backward compatibility.
>>>>=20
>>>> In fact with the new patches you don=E2=80=99t even /plugin/ since=
 when
>>>> compiling an overlay we can turn on the plugin flag by looking
>>>> at the output type (dtbo).
>>>>=20
>>>>>=20
>>>>> #----- codec chip on cape, overlay, connector
>>>>>=20
>>>>> Now we move into the realm of connectors.  My mental model of wha=
t the
>>>>> hardware and driver look like has not changed.  The only thing th=
at has
>>>>> changed is that I want to be able to specify that the connector t=
hat
>>>>> the cape is plugged into has some pins that are the spi bus /soc/=
spi1.
>>>>>=20
>>>>=20
>>>> That=E2=80=99s not nearly enough. You might have extra=20
>>>> gpio/interrupt/dma/gpmc(memory-controller) pins.
>>>=20
>>> Yes.
>>>=20
>>> I was keeping the example _very_ simple.  I was trying to illustrat=
e
>>> the _concept_, not provide a full implementation.
>>>=20
>>> In a real use, the connector node would provide a node for each of =
the
>>> things routed to the connector.
>>>=20
>>=20
>> We need the example of how to handle pinmux cause it=E2=80=99s the t=
rickiest
>> thing of all.
>>=20
>>>=20
>>>> We can disregard dma and gpmc like interfaces for now but gpio and
>>>> interrupt pins are required.
>>>>=20
>>>> For instance the spi device might have an extra gpio that it=E2=80=
=99s using
>>>> to signal some kind of condition (for example low-battery) which a=
n
>>>> application (not just the kernel) can use to make a platform speci=
fic
>>>> decision.
>>>>=20
>>>>> The following _almost_ but not quite gets me what I want.  Note t=
hat
>>>>> the only thing the connector node does is provide some kind of
>>>>> pointer or reference to what node(s) are physically routed throug=
h
>>>>> the connector.  (This node will turn out to not actually work in
>>>>> this example.)
>>>>>=20
>>>>> $ cat board_with_connector.dts
>>>>> /dts-v1/;
>>>>>=20
>>>>> / {
>>>>> 	#address-cells =3D < 1 >;
>>>>> 	#size-cells =3D < 1 >;
>>>>>=20
>>>>> 	tree_1: soc@0 {
>>>>> 		reg =3D <0x0 0x0>;
>>>>>=20
>>>>> 		spi_1: spi1 {
>>>>> 		};
>>>>> 	};
>>>>>=20
>>>>> 	connector_1: connector_1 {
>>>>> 		spi1 {
>>>>> 			target_phandle =3D <&spi_1>;
>>>>> 			target_path =3D "/soc/spi1";
>>>>> 		};
>>>>> 	};
>>>>>=20
>>>>> };
>>>>>=20
>>>>> &spi_1 {
>>>>> 	ethernet-switch@0 {
>>>>> 		compatible =3D "micrel,ks8995m";
>>>>> 	};
>>>>> };
>>>>>=20
>>>>> $ cat spi_codec_overlay_with_connector.dts
>>>>> /dts-v1/;
>>>>>=20
>>>>> /plugin/;
>>>>>=20
>>>>> &connector_1 {
>>>>> 	spi1 {
>>>>> 		codec@1 {
>>>>> 			compatible =3D "ti,tlv320aic26";
>>>>> 		};
>>>>> 	};
>>>>> };
>>>>=20
>>>> This is a subset of what=E2=80=99s supported by the patch I=E2=80=99=
ve sent out.
>>>=20
>>> Yes.  Same comment as above.
>>>=20
>>>=20
>>>> Your example works as long as you assume that there=E2=80=99s no p=
inmuxing
>>>> related to the configuration of the spi controller when routed out
>>>> to the connector pins.
>>>=20
>>> No.  Pinmuxing is part of the host board dts.
>>>=20
>>=20
>> It is part of the host board DTS yes, but the connector must have
>> a way to set the pinmux configuration according what the detected
>> expansion board expects.
>>=20
>>> The physical connector does not change the way that pinmuxing
>>> works.  It is just the same as if there were wires physically
>>> connected (soldered) between the daughter board and the main
>>> board.
>>>=20
>>=20
>> The physical properties of the pin of the connector do not change.
>>=20
>> However the routing of functions in the SoC do change.
>>=20
>> By default most of the pins on the connector are HiZ or set to input=
 when
>> no expansion board is connected. The only fixed function pins that a=
re
>> known and configured by the host board dts are those that are used b=
y
>> the host board=E2=80=99s identification scheme (i.e. I2C EEPROM, set=
 of GPIO inputs
>> etc).=20
>>=20
>> When an expansion board is connected upon boot and probing of the th=
e expansion
>> board manager device it will use a method that is using the configur=
ed detection
>> pins to identify it.
>>=20
>> After getting the ID it is going to find a corresponding overlay to =
apply.
>>=20
>> This overlay will have to configure each pin accordingly.
>>=20
>> It is perfectly for a pin on a connector to be a GPIO output for exp=
ansion
>> board A, I2C bus SDA for board B, etc...
>>=20
>> So there has to be a way to get the pinmux configuration according t=
o the
>> required connection function on each pin in use.
>=20
> Again, this is exactly the same concept as if the daughter board was =
soldered
> directly to the host board with no connector involved.  The pinmux
> configuration has nothing to do with the physical connector, it is al=
ready
> described by the pinmux information in the host board .dtb.  The conn=
ector
> node in the host .dtb does not need to duplicate any of that informat=
ion.
>=20
> There already is a pinmux mechanism in place to choose which of the
> possible alternative uses of a set of pins is in use at any point
> in time.  The choice of active functionality can be changed at
> any time.
>=20
> The pinmux configuration is already in place in the host board .dtb.
> The host board .dtb connector node only provides a mapping to what
> other nodes have hardware blocks that have signals that are routed
> to the physical connector.  There is no need for the connector node
> to be concerned with any of the details of those other nodes -- the
> other nodes already specify the details.
>=20

The mechanism to choose which of the possible alternative uses is
geared to select between a different set of configuration settings
for the same device. I.e. =E2=80=9Cdefault=E2=80=9D -> working configur=
ation, =E2=80=9Cpowersave=E2=80=9D ->
put the pins in power save mode, etc.

I get what you=E2=80=99re saying but the details about pinmuxing are th=
e killer.

Can you please spend some time and come up with an example which we can
use as a basis for discussion?

>>>> In reality there are may be many possible option of the same
>>>> hardware block (spi/i2c) to be routed to different pins on the
>>>> connector.
>>>>=20
>>>> You might get by if you have a number of selectable pre-canned
>>>> spi configuration that are selected.
>>>=20
>>> Again, just the same as if the connector did not exist and
>>> everything is hardwired.
>>>=20
>>> The connector node for the host board would contain a node for
>>> each of the alternative uses of the pins.
>>>=20
>>=20
>> Right.
>>=20
>>>=20
>>>> For instance if there are two spi controllers each of which have
>>>> two different pinout options on the connector you would address
>>>> each as a different spi controller on the connector, but then
>>>> you=E2=80=99d end up with
>>>>=20
>>>> spi_connector_0 -> spi_0_mux_0
>>>> spi_connector_1 -> spi_0_mux_1
>>>> spi_connector_2 -> spi_1_mux_0
>>>> spi_connector_3 -> spi_1_mux_1
>>>=20
>>> Yes.  But again, exactly the same as if the daughter board was
>>> hard wired with no intervening physical connector.
>>>=20
>>=20
>> Yes.
>>=20
>>>=20
>>>> It gets hairy though pretty fast with modern SoCs with extensive=20
>>>> muxing options.
>>>>=20
>>>>>=20
>>>>> The result is that the overlay fixup for spi1 on the cape will
>>>>> relocate the spi1 node to /connector_1 in the host tree, so
>>>>> this does not solve the connector linkage yet:
>>>>>=20
>>>>> -- chunk from the decompiled board_with_connector.dtb:
>>>>>=20
>>>>> 	__symbols__ {
>>>>> 		connector_1 =3D "/connector_1";
>>>>> 	};
>>>>>=20
>>>>> -- chunk from the decompiled spi_codec_overlay_with_connector.dtb=
:
>>>>>=20
>>>>> 	fragment@0 {
>>>>> 		target =3D <0xffffffff>;
>>>>> 		__overlay__ {
>>>>> 			spi1 {
>>>>> 				codec@1 {
>>>>> 					compatible =3D "ti,tlv320aic26";
>>>>> 				};
>>>>> 			};
>>>>> 		};
>>>>> 	};
>>>>> 	__fixups__ {
>>>>> 		connector_1 =3D "/fragment@0:target:0";
>>>>> 	};
>>>>>=20
>>>>>=20
>>>>> #----- magic new dtc syntax
>>>>>=20
>>>>> What I really want is some way to tell dtc that I want to do one
>>>>> level of dereferencing when resolving the path of device nodes
>>>>> contained by the connector node in the overlay dts.
>>>>>=20
>>>>> The exact syntax does not matter here, I am just trying to get th=
e
>>>>> concept.  I will add the not yet implemented dtc feature of
>>>>> "/connector/" to the connector node in both the tree dts and the
>>>>> overlay dts, and show how the output of dtc would change.  The
>>>>> "/connector/" directive tells dtc that for a base dts (hand
>>>>> waving how it knows base vs overlay dts file) to look into
>>>>> each node at that level and determine what other node it
>>>>> maps to (again, hand waving, in this example just to
>>>>> show the linkage, I have hard coded both the path and the
>>>>> phandle of the target node that the connector child node
>>>>> maps to).  The "/connector/" directive tells dtc that for
>>>>> an overlay dts (again hand waving) to provide a fixup for
>>>>> each child node.
>>>>>=20
>>>>> $ cat board_with_connector_v2.dts
>>>>> /dts-v1/;
>>>>>=20
>>>>> / {
>>>>> 	#address-cells =3D < 1 >;
>>>>> 	#size-cells =3D < 1 >;
>>>>>=20
>>>>> 	tree_1: soc@0 {
>>>>> 		reg =3D <0x0 0x0>;
>>>>>=20
>>>>> 		spi_1: spi1 {
>>>>> 		};
>>>>> 	};
>>>>>=20
>>>>> 	connector_1: connector_1 {
>>>>> 		/connector/;
>>>>> 		spi1 {
>>>>> 			target_phandle =3D <&spi_1>;
>>>>> 			target_path =3D "/soc/spi1";
>>>>> 		};
>>>>> 	};
>>>>>=20
>>>>> };
>>>>>=20
>>>>> &spi_1 {
>>>>> 	ethernet-switch@0 {
>>>>> 		compatible =3D "micrel,ks8995m";
>>>>> 	};
>>>>> };
>>>>>=20
>>>>> $ cat spi_codec_overlay_with_connector_v2.dts
>>>>>=20
>>>>> /dts-v1/;
>>>>>=20
>>>>> /plugin/;
>>>>>=20
>>>>> &connector_1 {
>>>>> 	/connector/;
>>>>> 	spi1 {
>>>>> 		codec@1 {
>>>>> 			compatible =3D "ti,tlv320aic26";
>>>>> 		};
>>>>> 	};
>>>>> };
>>>>>=20
>>>>> -- chunk from the decompiled board_with_connector_v2.dtb:
>>>>>=20
>>>>> 	__symbols__ {
>>>>>              connector_1 {
>>>>>                      spi1 =3D "/soc@0/spi1";
>>>>>              };
>>>>>      };
>>>>>=20
>>>>> -- chunk from the decompiled spi_codec_overlay_with_connector_v2.=
dtb:
>>>>>=20
>>>>> / {
>>>>>=20
>>>>> 	fragment@0 {
>>>>> 		target =3D <0xffffffff>;
>>>>> 		__overlay__ {
>>>>> 			spi1 {
>>>>> 				codec@1 {
>>>>> 					compatible =3D "ti,tlv320aic26";
>>>>> 				};
>>>>> 			};
>>>>> 		};
>>>>> 	};
>>>>> 	__fixups__ {
>>>>>              connector_1 {
>>>>> 		        spi1 =3D "/fragment@0/__overlay__:spi1:0";
>>>>>              };
>>>>> 	};
>>>>>=20
>>>>> Of course the overlay loader will also have to be modified to und=
erstand
>>>>> the new information.
>>>>>=20
>>>>> Exact format of the __symbols__ and __fixups__ are implementation
>>>>> details, I am just trying to present the model.
>>>>>=20
>>>>> Ignoring device tree source syntax and dtc implementation issues,=
 does
>>>>> this conceptual model look more straight forward and a better dir=
ection
>>>>> for how to represent connectors?
>>>>>=20
>>>>=20
>>>> We could use dtc sugar to get to something more elegant, I need so=
me time
>>>> to think about this a bit longer.
>>>>=20
>>>>> -Frank
>>>>=20
>>>> Regards
>>>>=20
>>>> =E2=80=94 Pantelis
>>=20
>> Regards
>>=20
>> =E2=80=94 Pantelis

Regards

=E2=80=94 Pantelis

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
