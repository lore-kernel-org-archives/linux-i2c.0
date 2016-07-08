From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH 0/1] Portable Device Tree Connector -- conceptual
Date: Fri, 8 Jul 2016 12:22:45 -0700
Message-ID: <577FFD85.5060202@gmail.com>
References: <1467503750-31703-1-git-send-email-frowand.list@gmail.com>
 <20160707071548.GV14675@voom.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34989 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbcGHTW6 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Jul 2016 15:22:58 -0400
In-Reply-To: <20160707071548.GV14675@voom.fritz.box>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: robh+dt@kernel.org, pantelis.antoniou@konsulko.com, stephen.boyd@linaro.org, broonie@kernel.org, grant.likely@secretlab.ca, mark.rutland@arm.com, mporter@konsulko.com, koen@dominion.thruhere.net, linux@roeck-us.net, marex@denx.de, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, panto@antoniou-consulting.com

On 07/07/16 00:15, David Gibson wrote:
> On Sat, Jul 02, 2016 at 04:55:49PM -0700, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@am.sony.com>
>>
>> Hi All,
>>
>> This is version 2 of this email.
>>
>> Changes from version 1:
>>
>>   - some rewording of the text
>>   - removed new (theoretical) dtc directive "/connector/"
>>   - added compatibility between mother board and daughter board
>>   - added info on applying a single .dtbo to different connectors
>>   - attached an RFC patch showing the required kernel changes
>>   - changes to mother board .dts connector node:
>>      - removed target_path property
>>      - added connector-socket property
>>   - changes to daughter board .dts connector node:
>>      - added connector-plug property
>>
>>
>> I've been trying to wrap my head around what Pantelis and Rob have written
>> on the subject of a device tree representation of a connector for a
>> daughter board to connect to (eg a cape or a shield) and the representation
>> of the daughter board.  (Or any other physically pluggable object.)
>>
>> After trying to make sense of what had been written (or presented via slides
>> at a conference - thanks Pantelis!), I decided to go back to first principals
>> of what we are trying to accomplish.  I came up with some really simple bogus
>> examples to try to explain what my thought process is.
>>
>> This is an extremely simple example to illustrate the concepts.  It is not
>> meant to represent the complexity of a real board.
>>
>> To start with, assume that the device that will eventually be on a daughter
>> board is first soldered onto the mother board.  The mother board contains
>> two devices connected via bus spi_1.  One device is described in the .dts
>> file, the other is described in an included .dtsi file.
>> Then the device tree files will look like:
>>
>> $ cat board.dts
>> /dts-v1/;
>>
>> / {
>>         #address-cells = < 1 >;
>>         #size-cells = < 1 >;
>>
>>         tree_1: soc@0 {
>>                 reg = <0x0 0x0>;
>>
>>                 spi_1: spi1 {
>>                 };
>>         };
>>
>> };
>>
>> &spi_1 {
>>         ethernet-switch@0 {
>>                 compatible = "micrel,ks8995m";
>>         };
>> };
>>
>> #include "spi_codec.dtsi"
>>
>>
>> $ cat spi_codec.dtsi
>> &spi_1 {
>> 	codec@1 {
>> 		compatible = "ti,tlv320aic26";
>> 	};
>> };
>>
>>
>> #----- codec chip on cape
>>
>> Then suppose I move the codec chip to a cape.  Then I will have the same
>> exact .dts and .dtsi and everything still works.
>>
>>
>> @----- codec chip on cape, overlay
>>
>> If I want to use overlays, I only have to add the version and "/plugin/",
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
>> 		compatible = "ti,tlv320aic26";
>> 	};
>> };
>>
>>
>> Pantelis pointed out that the syntax has changed to be:
>>    /dts-v1/ /plugin/;
>>
>>
>> #----- codec chip on cape, overlay, connector
>>
>> Now we move into the realm of connectors.  My mental model of what the
>> hardware and driver look like has not changed.  The only thing that has
>> changed is that I want to be able to specify that the connector that
>> the cape is plugged into has some pins that are the spi bus /soc/spi1.
>>
>> The following _almost_ but not quite gets me what I want.  Note that
>> the only thing the connector node does is provide some kind of
>> pointer or reference to what node(s) are physically routed through
>> the connector.  The connector node does not need to describe the pins;
>> it only has to point to the node that describes the pins.
>>
>> This example will turn out to be not sufficient.  It is a stepping
>> stone in building my mental model.
>>
>> $ cat board_with_connector.dts
>> /dts-v1/;
>>
>> / {
>> 	#address-cells = < 1 >;
>> 	#size-cells = < 1 >;
>>
>> 	tree_1: soc@0 {
>> 		reg = <0x0 0x0>;
>>
>> 		spi_1: spi1 {
>> 		};
>> 	};
>>
>> 	connector_1: connector_1 {
>> 		spi1 {
>> 			target_phandle = <&spi_1>;
>> 		};
>> 	};
>>
>> };
>>
>> &spi_1 {
>> 	ethernet-switch@0 {
>> 		compatible = "micrel,ks8995m";
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
>> 			compatible = "ti,tlv320aic26";
>> 		};
>> 	};
>> };
>>
>>
>> The result is that the overlay fixup for spi1 on the cape will
>> relocate the spi1 node to /connector_1 in the host tree, so
>> this does not solve the connector linkage yet:
>>
>> -- chunk from the decompiled board_with_connector.dtb:
>>
>> 	__symbols__ {
>> 		connector_1 = "/connector_1";
>> 	};
>>
>> -- chunk from the decompiled spi_codec_overlay_with_connector.dtb:
>>
>> 	fragment@0 {
>> 		target = <0xffffffff>;
>> 		__overlay__ {
>> 			spi1 {
>> 				codec@1 {
>> 					compatible = "ti,tlv320aic26";
>> 				};
>> 			};
>> 		};
>> 	};
>> 	__fixups__ {
>> 		connector_1 = "/fragment@0:target:0";
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
>> 	#address-cells = < 1 >;
>> 	#size-cells = < 1 >;
>>
>> 	tree_1: soc@0 {
>> 		reg = <0x0 0x0>;
>>
>> 		spi_1: spi1 {
>> 		};
>> 	};
>>
>> 	connector_1: connector_1 {
>> 		compatible = "11-pin-accessory";
>> 		connector-socket;
> 
> I don't see any advantage to allowing connectors anywhere in the tree:
> pretty much by definition a connector is a "whole board" concept.  So
> I think instead they should all go in a new special node under the
> root, say /connectors.  With that done, you don't need the
> connector-socket tag any more.

That seems like a good idea.


> 
>> 		spi1 {
>> 			target_phandle = <&spi_1>;
>> 		};
>> 	};
>>
>> };
>>
>> &spi_1 {
>> 	ethernet-switch@0 {
>> 		compatible = "micrel,ks8995m";
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
>> 	compatible = "11-pin-accessory";
>>
>> 	spi1 {
>> 		codec@1 {
>> 			compatible = "ti,tlv320aic26";
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
>> Then, the next step is whether pinctrl and pinmux work with this method.
>> Pantelis, can you point me to a good example for
>>
>>   1) an in-tree board dts file
>>   2) an overlay file (I am assuming out of tree) that applies to the board
>>   3) an in-tree .dtsi file that would provide the same features as
>>      the overlay file if it was included by the board dts file
>>
>> It should be easier to discuss pinctrl and pinmux with an example.


> 
> Hrm.. so I think you're trying to stick too close to the existing
> overlay model.  Something I've always disliked about that model is
> that the plugin can overlay *anywhere* in the master tree, meaning it
> must have intimate knowledge of that tree.  Instead of using the
> global __symbols__, there should be a set of "symbols" local to the
> specific connector (socket), which are the *only* points which the
> plugin is allowed to overlay or reference.

That sounds like a good idea.


> Given that we're going to need new code to support this new connector
> model, I think we should also fix some of the uglies in the current
> overlay format while we're at it.

I like that way of thinking.


> I have to run now, but I'll try to send out a counter-proposal
> shortly.

-Frank
