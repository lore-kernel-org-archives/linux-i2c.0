From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH] iio: inv_mpu6050: Add support for auxiliary I2C master
Date: Thu, 21 Apr 2016 13:56:18 +0000
Message-ID: <AM4PR02MB1299B78B76BF112B2E06F20BBC6E0@AM4PR02MB1299.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: sv-SE
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Crestez Dan Leonard wrote:
> On 04/20/2016 11:31 PM, Peter Rosin wrote:
> > Crestez Dan Leonard wrote:
> >> Changes since that version:
> >> * Nest the adapter in inv_mpu6050_state instead of making it static
> >> * Explicitly forward of_node "i2c-aux-master" to allow describing aux devices
> >> via devicetree.
> >>
> >> For bypass/mux mode devicetree works automatically. The forwarding is based on
> >> the "chan_id" parameter to i2c_add_mux_adapter and is implemented here:
> >>
> >> http://lxr.free-electrons.com/source/drivers/i2c/i2c-mux.c?v=4.5#L158
> >>
> >> Perhaps it might be better for devices handled via master mode to be described
> >> via i2c@1? This would work by scanning the mpu node's children for something
> >> with reg == 1.
> > 
> > The 0 in i2c@0 (which is used by the mux mode) is the index of the mux slave
> > meaning that i2c@1 would be a second mux slave on the same mux, but this is
> > not a real mux as such, it is a gate which is piggybacking on the i2c mux infra.
> > So, this "mux" can't have a second slave which is why only 0 is valid.
> 
> This behavior is automatic in i2c mux code and seems to assume that all
> the children of mux_dev are i2c muxes. This might be obviously correct
> and useful for dedicated i2c mux devices but in my case mux_dev is just
> the i2c_client for a sensor.
> 
> From Documentation/devicetree/bindings/i2c/i2c-mux.txt:
> 
> > An i2c bus multiplexer/switch will have several child busses that are
> > numbered uniquely in a device dependent manner.  The nodes for an i2c
> > bus multiplexer/switch will have one child node for each child bus.
> 
> This seems to be written in a way that would allow me to define the
> "auxiliary i2c master" as bus "1". After all, the numbering is device
> dependent and it's not clear that all the child busses need to be
> accessible through muxing rather than indirect access through device
> registers.

You are correct that if you have devicetree children where reg does
not match the chan_id given to i2c_add_mux_adapter() those children
will be ignored by the i2c-mux code. So, the code would be happy with
a devicetree such as:

	mpu6050@68 {
		compatible = "...";
		reg = <0x68>;
		...
		i2c-aux-mux@0 {
			#address-cells = <1>;
			#size-cells = <0>;
			reg = <0>;

			foo@44 {
				compatible = "bar";
				reg = <0x44>;
				...
			}
		}
		i2c-aux-master@1 {
			#address-cells = <1>;
			#size-cells = <0>;
			reg = <1>;

			gazonk@44 {
				compatible = "baz";
				reg = <0x44>;
				...
			}
		}
	}

as long as you do only call i2c_add_mux_adapter() with chan_id = 0. And that
is what you are doing. But I think it is a bit subtle...

> >> Or maybe the two busses should be called i2c-aux-master and i2c-aux-mux? Not
> >> sure how to deal with that on the mux side.
> > 
> > Changing i2c to i2c-aux-mux would break existing device trees, that seems
> > like a bad thing, no?
> 
> That support was not documented in mpu6050's bindings and might not be
> actually used.
> 
> >> It is not clear how to properly handle this and suggestions are welcome. The
> >> way it currently works with this patch is documented immediately below.
> > 
> > I think the naming could be i2c-master0, i2c-master1 etc if it, with
> > future work, would be possible to add more than one master (you talked about
> > 5 i2c slaves..).
> 
> The device has 5 sets of registers for controlling i2c slaves but only
> one physical auxiliary i2c bus. As far as I can tell slaves 0-3 are
> intended to be used for gathering readings for slaved sensors
> periodically without external intervention. Slave 4 can generate an
> interrupt on completion and is more suitable for general-purpose
> communication with any number of devices.

Ah, ok, so all 5 sets of slave registers are about the same physical i2c
bus. So, you basically cannot sanely use this physical aux i2c bus as an
i2c-mux and an extra i2c adapter in the same hw design. Correct?

In that case, couldn't you look at the names of any devicetree children
and use that to decide if you should even attempt to call
i2c_add_mux_adapter or i2c_add_adapter?

(But please don't clobber stuff for my i2c-mux rework, or you will have
to wait even longer for that deadlock to be resolved)

Cheers,
Peter
