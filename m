From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Fwd: [PATCH 2/3] I2C: at24: add kernel interface for
	reading/writing EEPROM
Date: Thu, 28 Aug 2008 18:53:04 -0400
Message-ID: <9e4733910808281553q42c2e3dak79ac0f983d39c0d9@mail.gmail.com>
References: <200808251941.54964.david-b@pacbell.net>
	<200808270019.12987.david-b@pacbell.net>
	<9e4733910808270640h2e5fb88fn46548d3630b7f45d@mail.gmail.com>
	<200808281419.47519.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200808281419.47519.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 8/28/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Wednesday 27 August 2008, Jon Smirl wrote:
>  > On 8/27/08, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
>  > > On Tuesday 26 August 2008, Trent Piepho wrote:
>  > >  > Lots of tv cards have eeproms with configuration information.  They use an
>  > >  > I2C driver called tveeprom that exports this:
>  > >  >
>  > >  > int tveeprom_read(struct i2c_client *c, unsigned char *eedata, int len)
>  > >
>  > >
>  > > That presumes the driver somehow has access to that I2C client.
>  >
>  > How about using bus_find_device? PowerPC uses it to locate the i2c
>  > device using pointers in the device tree.
>
>
> Still making too many assumptions for my taste ... like using
>  I2C, and in this case also OF.  What I want is an approach that
>  can work with all the drivers with EEPROM and NVRAM support
>  that I've happenened on so far:
>
>
>         drivers/i2c/chips/at24.c
>
>         drivers/spi/chips/at25.c
>         drivers/rtc/rtc-cmos.c
>         drivers/rtc/rtc-ds1305.c
>         drivers/rtc/rtc-ds1307.c
>         drivers/rtc/rtc-ds1511.c
>         drivers/rtc/rtc-ds1553.c
>         drivers/rtc/rtc-ds1742.c
>         drivers/rtc/rtc-m48t59.c
>         drivers/rtc/rtc-stk17ta8.c
>
>  All those could easily export a (renamed) "struct at24_iface *" so
>  their persistent (and updatable) memory could be exported to kernel
>  code using the very same (simple) interface.
>
>  Discussion about how to use a different interface than what's shown
>  in the $SUBJECT patch seems to want to promote (a) each of those ten
>  drivers having a *different* interface exposed by EXPORT_SYMBOL(),
>  or else don't support in-kernel access at all, and (b) a bunch of
>  extra glue code to support it, like the OF-specific bits you showed
>  below and then going to the code that knows to use those bits to
>  get which device, and how to ask those devices for their data.
>
>  Moreover, IMO the basic question is still whether there is a good
>  reason not to build on the $SUBJECT patch.  (So far:  no.)
>
>  Sure it *could* be done differently -- especially if think (a) is
>  good but being able to reuse interfaces is bad -- but it's like
>  spending so much time choosing what color to paint the bikeshed
>  that the bikeshed itself never gets built...


There are two parts to the puzzle.
1) A common way to export the interface. That can be addressed by
applying the technique in the initial patch.

2) How do the drivers find each other. Device trees already have a way
for drivers to find each other. This is an example of a audio codec
that lives on both the i2c and i2s bus. The codec-handle is used to
retrieve the tas0 node pointer. of_find_i2c_device_by_node then
searches the archdata for that pointer.

struct i2c_client *of_find_i2c_device_by_node(struct device_node
*node) could be generalized by having it search multiple buses for the
device. dev->archdata.of_node is just a cookie, it is only used to
match against. The pointer could be a void*.

I didn't like setup call part of the proposal. It is building another
way for drivers to find each other. How can you generate an equivalent
to the archdata.of_node cookie for other platforms? Another problem
with the setup callback, how do you tell identical devices apart?

		i2s@2200 { /* PSC2 in i2s mode */
			compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
			cell-index = <1>;
			reg = <0x2200 0x100>;
			interrupts = <0x2 0x2 0x0>;
			interrupt-parent = <&mpc5200_pic>;
			codec-handle = <&tas0>;
		};

		i2c@3d00 {
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
			cell-index = <0>;
			reg = <0x3d00 0x40>;
			interrupts = <0x2 0xf 0x0>;
			interrupt-parent = <&mpc5200_pic>;
			fsl5200-clocking;

			tas0:codec@1b {
				compatible = "ti,tas5504";
				reg = <0x1b>;
			};
			clock0:clock@68 {
				compatible = "maxim,max9485";
				reg = <0x68>;
			};
		};




>
>  - Dave
>
>  p.s. The only nontrivial technical issue I have with $PATCH is that
>      "struct at24_iface" needs to cope better with "rmmod at24".
>      An optional teardown(...) call would suffice.
>
>
>
>  > +static int of_dev_node_match(struct device *dev, void *data)
>  > +{
>  > +        return dev->archdata.of_node == data;
>  > +}
>  > +
>  > +struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
>  > +{
>  > +       struct device *dev;
>  > +
>  > +       dev = bus_find_device(&i2c_bus_type, NULL, node,
>  > +                                        of_dev_node_match);
>  > +       if (!dev)
>  > +               return NULL;
>  > +
>  > +       return to_i2c_client(dev);
>  > +}
>  > +EXPORT_SYMBOL(of_find_i2c_device_by_node);
>  > +
>
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
