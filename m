From: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Subject: Re: [RFC PATCH 0/1] Portable Device Tree Connector -- conceptual
Date: Tue, 5 Jul 2016 21:01:40 +0300
Message-ID: <FB5889C3-90B6-4D9D-9DC8-1D49215453BD@antoniou-consulting.com>
References: <1467503750-31703-1-git-send-email-frowand.list@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467503750-31703-1-git-send-email-frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Frank,

Sorry for taking a bit to reply, had to grok it well first.

> On Jul 3, 2016, at 02:55 , frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>=20
> From: Frank Rowand <frank.rowand-mEdOJwZ7QcZBDgjK7y7TUQ@public.gmane.org>
>=20
> Hi All,
>=20
> This is version 2 of this email.
>=20
> Changes from version 1:
>=20
>  - some rewording of the text
>  - removed new (theoretical) dtc directive "/connector/"
>  - added compatibility between mother board and daughter board
>  - added info on applying a single .dtbo to different connectors
>  - attached an RFC patch showing the required kernel changes
>  - changes to mother board .dts connector node:
>     - removed target_path property
>     - added connector-socket property
>  - changes to daughter board .dts connector node:
>     - added connector-plug property
>=20
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
> This is an extremely simple example to illustrate the concepts.  It i=
s not
> meant to represent the complexity of a real board.
>=20
> To start with, assume that the device that will eventually be on a da=
ughter
> board is first soldered onto the mother board.  The mother board cont=
ains
> two devices connected via bus spi_1.  One device is described in the =
=2Edts
> file, the other is described in an included .dtsi file.
> Then the device tree files will look like:
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
>=20
> Pantelis pointed out that the syntax has changed to be:
>   /dts-v1/ /plugin/;
>=20
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
> The following _almost_ but not quite gets me what I want.  Note that
> the only thing the connector node does is provide some kind of
> pointer or reference to what node(s) are physically routed through
> the connector.  The connector node does not need to describe the pins=
;
> it only has to point to the node that describes the pins.
>=20
> This example will turn out to be not sufficient.  It is a stepping
> stone in building my mental model.
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
>=20

You target connector_1. In theory multiples of the same connector
may be available.

There are complications about how they are applied. A method that=E2=80=
=99s not
referring to a single phandle/path is going to be needed.

Thinking about it a bit more maybe we can sugar it with DTC with someth=
ing like
this:

$ cat arduino_connector.dts

/dts-v1/ /plugin/ /portable/;

&arduino_connector {
	spi1 {
		codec@1 {
			compatible =3D =E2=80=9Cti,tlv320aic26=E2=80=9D;
		};
	};
};

$ cat board_with_arduino_connectors.dts
/dts-v1/;

/ {
	#address-cells =3D < 1 >;
	#size-cells =3D < 1 >;

	tree_1: soc@0 {
		reg =3D <0x0 0x0>;

		spi_1: spi1 {
		};
	};

	connector_1 {
		connector-socket;
		compatible =3D =E2=80=9Carduino_connector=E2=80=9D;
		status =3D =E2=80=9Cokay=E2=80=9D;

		spi1 {
			target_phandle =3D <&spi_1>;
		};
	};

	connector_2 {
		connector-socket;
		compatible =3D =E2=80=9Carduino_connector=E2=80=9D;
	=09
		spi2 {
			target_phandle =3D <&spi_2>;
		};
	};

};

&spi_1 {
	ethernet-switch@0 {
		compatible =3D "micrel,ks8995m";
	};
};

&spi_2 {
	ethernet-switch@0 {
		compatible =3D "micrel,ks8995m";
	};
};

The &arduino_connector construct at a portable overlay can be resolved
as follows:

fragment0 {
	target-compatible =3D =E2=80=9Carduino_connector=E2=80=9C;
	=E2=80=A6.
};

The new thing here is the =E2=80=98target-compatible=E2=80=99 option wh=
ich the
loader will use to find the target node.

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

^ See above. Not going to work cause we need to support multiple
identical connectors on the same board.
=20
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
> After applying the overlay, the codec@1 node will be at
> /connector_1/spi1/codec@1.  What I want is for that node
> to be at /spi1/codec@1.
>=20
>=20
>=20
> #----- magic new syntax
>=20
> What I really want is some way to tell dtc that I want to do one
> level of dereferencing when resolving the path of device nodes
> contained by the connector node in the overlay dts.
>=20
> Version 1 of this email suggested using dtc magic to do this extra
> level of dereferencing.  This version of the email has changed to
> have the kernel code that applies the overlay do the extra level
> of dereferencing.
>=20
> The property "connector-socket" tells the kernel overlay code
> that this is a socket.  The overlay code does not actually
> do anything special as a result of this property; it is simply
> used as a sanity check that this node really is a socket.  The
> person writing the mother board .dts must provide the
> target_phandle property, which points to a node responsible for
> some of the pins on the connector.
>=20
> The property "connector-plug" tells the kernel overlay code
> that each child node in the overlay corresponds to a node in the
> socket, and the socket will contain one property that is
> a phandle pointing to the node that is the target of that child
> node in the overlay node.
>=20
>=20
> $ cat board_with_connector_v2.dts
>=20
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
> 		compatible =3D "11-pin-accessory";
> 		connector-socket;
> 		spi1 {
> 			target_phandle =3D <&spi_1>;
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
>=20
> $ cat spi_codec_overlay_with_connector_v2.dts
>=20
> /dts-v1/;
>=20
> /plugin/;
>=20
> &connector_1 {
> 	connector-plug;

^ we won=E2=80=99t need this, nor the compatible string with the=20
version I mentioned earlier

> 	compatible =3D "11-pin-accessory";
>=20
> 	spi1 {
> 		codec@1 {
> 			compatible =3D "ti,tlv320aic26";
> 		};
> 	};
> };
>=20
>=20
> The spi_codec_overlay_with_connector_v2.dtb __fixups__ information
> is unchanged from the previous example, but the kernel overlay
> code will do the correct extra level of dereferencing when it
> detects the connector-plug property in the overlay.
>=20
> The one remaining piece that this patch does not provide is how
> the overlay manager (which does not yet exist in the mainline
> tree) can apply an overlay to two different targets.  That
> final step should be a trivial change to of_overlay_create(),
> adding a parameter that is a mapping of the target (or maybe
> even targets) in the overlay to different targets in the
> active device tree.
>=20
> This seems like a more straight forward way to handle connectors.
>=20
> First, ignoring pinctrl and pinmux, what does everyone think?
>=20
> Then, the next step is whether pinctrl and pinmux work with this meth=
od.
> Pantelis, can you point me to a good example for
>=20
>  1) an in-tree board dts file
>  2) an overlay file (I am assuming out of tree) that applies to the b=
oard
>  3) an in-tree .dtsi file that would provide the same features as
>     the overlay file if it was included by the board dts file
>=20

Looks good for a starting point. We need to figure out pinmux and
gpio/irq references for starter.

It is imperative that references do not leak out of the connector
node.

> It should be easier to discuss pinctrl and pinmux with an example.
>=20
> -Frank
> =E2=80=94

Regards

=E2=80=94 Pantelis

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
