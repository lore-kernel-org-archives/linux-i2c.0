From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: Portable Device Tree Connector -- conceptual
Date: Fri, 1 Jul 2016 09:44:44 -0700
Message-ID: <57769DFC.3050503@gmail.com>
References: <5775B2FD.2000103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5775B2FD.2000103@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, David Gibson <david@gibson.dropbear.id.au>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>
Cc: Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, linux@roeck-us.net, Marek Vasut <marex@denx.de>, wsa@the-dreams.de, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-i2c@vger.kernel.org

On 06/30/16 17:02, Frank Rowand wrote:
> Hi All,
> 
> I've been trying to wrap my head around what Pantelis and Rob have written
> on the subject of a device tree representation of a connector for a
> daughter board to connect to (eg a cape or a shield) and the representation
> of the daughter board.  (Or any other physically pluggable object.)
> 
> After trying to make sense of what had been written (or presented via slides
> at a conference - thanks Pantelis!), I decided to go back to first principals
> of what we are trying to accomplish.  I came up with some really simple bogus
> examples to try to explain what my thought process is.

I was trying to keep the example as simple as possible because I wanted to
focus on the concept.  I was trying to avoid getting into a big discussion
about implementation details until getting feedback on the concepts.

Secondly, thinking through the whole thing was complex enough for me that
I missed some obvious answers to my hand waving.

So in this reply, I will add the obvious fix to my hand waving, and add
some complexity with one more important implementation detail.


> To start with, assume that the device that will eventually be on a daughter
> board is first soldered onto the main board.  Then the device tree will
> look like:
> 
> $ cat board.dts
> /dts-v1/;
> 
> / {
>         #address-cells = < 1 >;
>         #size-cells = < 1 >;
> 
>         tree_1: soc@0 {
>                 reg = <0x0 0x0>;
> 
>                 spi_1: spi1 {
>                 };
>         };
> 
> };
> 
> &spi_1 {
>         ethernet-switch@0 {
>                 compatible = "micrel,ks8995m";
>         };
> };
> 
> #include "spi_codec.dtsi"
> 
> $ cat spi_codec.dtsi
> &spi_1 {
> 	codec@1 {
> 		compatible = "ti,tlv320aic26";
> 	};
> };
> 
> 
> #----- codec chip on cape
> 
> Then suppose I move the codec chip to a cape.  Then I will have the same
> exact .dts and .dtsi and everything still works.
> 
> 
> @----- codec chip on cape, overlay
> 
> If I want to use overlays, I only have to add the version and "/plugin/",
> then use the '-@' flag for dtc (both for the previous board.dts and
> this spi_codec_overlay.dts):
> 
> $ cat spi_codec_overlay.dts
> /dts-v1/;
> 
> /plugin/;
> 
> &spi_1 {
> 	codec@1 {
> 		compatible = "ti,tlv320aic26";
> 	};
> };
> 
> 
> #----- codec chip on cape, overlay, connector
> 
> Now we move into the realm of connectors.  My mental model of what the
> hardware and driver look like has not changed.  The only thing that has
> changed is that I want to be able to specify that the connector that
> the cape is plugged into has some pins that are the spi bus /soc/spi1.
> 
> The following _almost_ but not quite gets me what I want.  Note that
> the only thing the connector node does is provide some kind of
> pointer or reference to what node(s) are physically routed through
> the connector.  (This node will turn out to not actually work in
> this example.)
> 
> $ cat board_with_connector.dts
> /dts-v1/;
> 
> / {
> 	#address-cells = < 1 >;
> 	#size-cells = < 1 >;
> 
> 	tree_1: soc@0 {
> 		reg = <0x0 0x0>;
> 
> 		spi_1: spi1 {
> 		};
> 	};
> 
> 	connector_1: connector_1 {
> 		spi1 {
> 			target_phandle = <&spi_1>;
> 			target_path = "/soc/spi1";
> 		};
> 	};
> 
> };
> 
> &spi_1 {
> 	ethernet-switch@0 {
> 		compatible = "micrel,ks8995m";
> 	};
> };
> 
> $ cat spi_codec_overlay_with_connector.dts
> /dts-v1/;
> 
> /plugin/;
> 
> &connector_1 {
> 	spi1 {
> 		codec@1 {
> 			compatible = "ti,tlv320aic26";
> 		};
> 	};
> };
> 
> The result is that the overlay fixup for spi1 on the cape will
> relocate the spi1 node to /connector_1 in the host tree, so
> this does not solve the connector linkage yet:
> 
> -- chunk from the decompiled board_with_connector.dtb:
> 
> 	__symbols__ {
> 		connector_1 = "/connector_1";
> 	};
> 
> -- chunk from the decompiled spi_codec_overlay_with_connector.dtb:
> 
> 	fragment@0 {
> 		target = <0xffffffff>;
> 		__overlay__ {
> 			spi1 {
> 				codec@1 {
> 					compatible = "ti,tlv320aic26";
> 				};
> 			};
> 		};
> 	};
> 	__fixups__ {
> 		connector_1 = "/fragment@0:target:0";
> 	};
> 
> 
> #----- magic new dtc syntax
> 
> What I really want is some way to tell dtc that I want to do one
> level of dereferencing when resolving the path of device nodes
> contained by the connector node in the overlay dts.
> 
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
> 
> $ cat board_with_connector_v2.dts
> /dts-v1/;
> 
> / {
> 	#address-cells = < 1 >;
> 	#size-cells = < 1 >;
> 
> 	tree_1: soc@0 {
> 		reg = <0x0 0x0>;
> 
> 		spi_1: spi1 {
> 		};
> 	};
> 
> 	connector_1: connector_1 {
> 		/connector/;

Fix some hand waving by changing "/connector/" to "/socket/"
to indicate this is the host board.


> 		spi1 {
> 			target_phandle = <&spi_1>;
> 			target_path = "/soc/spi1";
> 		};
> 	};
> 
> };
> 
> &spi_1 {
> 	ethernet-switch@0 {
> 		compatible = "micrel,ks8995m";
> 	};
> };
> 
> $ cat spi_codec_overlay_with_connector_v2.dts
> 
> /dts-v1/;
> 
> /plugin/;
> 
> &connector_1 {
> 	/connector/;

Fix some more hand waving by changing "/connector/" to "/plug/"
to indicate this is the daughter board, or item plugged into
the receptacle.


> 	spi1 {
> 		codec@1 {
> 			compatible = "ti,tlv320aic26";
> 		};
> 	};
> };
> 
> -- chunk from the decompiled board_with_connector_v2.dtb:
> 
> 	__symbols__ {
>                 connector_1 {
>                         spi1 = "/soc@0/spi1";
>                 };
>         };
> 
> -- chunk from the decompiled spi_codec_overlay_with_connector_v2.dtb:
> 
> / {
> 
> 	fragment@0 {
> 		target = <0xffffffff>;
> 		__overlay__ {
> 			spi1 {
> 				codec@1 {
> 					compatible = "ti,tlv320aic26";
> 				};
> 			};
> 		};
> 	};
> 	__fixups__ {
>                 connector_1 {
> 		        spi1 = "/fragment@0/__overlay__:spi1:0";
>                 };
> 	};
> 
> Of course the overlay loader will also have to be modified to understand
> the new information.
> 
> Exact format of the __symbols__ and __fixups__ are implementation
> details, I am just trying to present the model.
> 
> Ignoring device tree source syntax and dtc implementation issues, does
> this conceptual model look more straight forward and a better direction
> for how to represent connectors?
> 
> -Frank
> 

One more detail is how to ensure that a host board connector and a
daughter board connector match (pin meaning, electrical characteristics,
etc).  Both the host board connector .dtb node and the daughter board
connector .dtbo node would have a compatible property that was specific
to a connector specification.  For instance, there could be a
"96boards,40-pin-connector" and a "96boards,60-pin-connector".  If a
new incompatible version of the connector spec was created, a new
compatible would have to be created, for example "96boards,40-pin-connector-gen2".

-Frank
