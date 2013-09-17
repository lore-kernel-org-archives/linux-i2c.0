From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: qup: Add device tree bindings information
Date: Tue, 17 Sep 2013 17:50:49 +0300
Message-ID: <1379429449.26712.4.camel@iivanov-dev.int.mm-sol.com>
References: <1377782873-31931-1-git-send-email-iivanov@mm-sol.com>
	 <20130912162840.GE22013@e106331-lin.cambridge.arm.com>
	 <1379063595.16481.19.camel@iivanov-dev.int.mm-sol.com>
	 <20130916133226.GD30650@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130916133226.GD30650-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org" <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, "rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org" <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "gavidov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <gavidov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TZUIDd8j+nm9g@public.gmane.org" <linux-kernel-u79uwXL29TZUIDd8j+nm9g@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


Hi Mark, 

On Mon, 2013-09-16 at 14:32 +0100, Mark Rutland wrote: 
> On Fri, Sep 13, 2013 at 10:13:15AM +0100, Ivan T. Ivanov wrote:
> > Hi Mark, 
> > 
> > On Thu, 2013-09-12 at 17:28 +0100, Mark Rutland wrote: 
> > > On Thu, Aug 29, 2013 at 02:27:52PM +0100, Ivan T. Ivanov wrote:
> > > > From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> > > > 
> > > > The Qualcomm Universal Peripherial (QUP) wraps I2C mini-core and
> > > > provide input and output FIFO's for it. I2C controller can operate
> > > > as master with supported bus speeds of 100Kbps and 400Kbps.
> > > > 
> > > > Signed-off-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/i2c/i2c-qup.txt |   99 +++++++++++++++++++++
> > > >  1 file changed, 99 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-qup.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/i2c/i2c-qup.txt b/Documentation/devicetree/bindings/i2c/i2c-qup.txt
> > > > new file mode 100644
> > > > index 0000000..c682726
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/i2c/i2c-qup.txt
> > > > @@ -0,0 +1,99 @@
> > > > +Qualcomm Universal Periferial (QUP) I2C controller
> 
> s/Periferial/Peripheral/ ?

Thanks.

> 
> > > > +
> > > > +Required properties:
> > > > + - compatible : should be "qcom,i2c-qup"
> > > > + - reg : Offset and length of the register region for the device
> > > > + - interrupts : core interrupt
> > > 
> > > How about the following:
> > > 
> > > - interrupts: interrupt-specifier for the core interrupt.
> > 
> > Ok.
> > 
> > > 
> > > > +
> > > > + - pinctrl-names: Should contain only one value - "default".
> > > > + - pinctrl-0: Should specify pin control group used for this controller.
> > > > +
> > > > + - clocks : phandles to clock instances of the device tree nodes
> > > 
> > > Clocks aren't just phandles, they have a clock-specifier component. This
> > > should probably be something like:
> > > 
> > >  - clocks: a list of phandle + clock-specifier pairs for each entry in
> > >            clock-names
> > 
> > Right now MSM clocks [1] are just phandles, I should add #clock-cells = <0>.
> 
> I see no reason to strongly tie the binding to a particular set of
> clocks when it's easy to make it generic. What if a new platform uses
> QUP, but its clocks have a number of clock-cells? As clock-specifiers
> may be zero cells, describing this as a phandle + clock-specifier pair
> means this will work with any clock provider following the common clock
> bindings.

I doubt that any other platform will use Qualcomm specific peripheral, 
but I see you point. Will change this.

> 
> > 
> > > 
> > > > + - clock-names :
> > > > +		"core" : Allow access to FIFO buffers and registers
> > > 
> > > Huh? That description doesn't seem to descripe the hardware.
> > 
> > How about: Allow access to I2C core FIFO buffers and registers.
> 
> My only concern here is the words "allow access", as that seems odd in
> the context of a hardware description.
> 
> It seems most bindings don't describe what the clocks do as that's
> defined in the manual for a piece of hardware anyway, so unfortunately I
> don't have a good example.
> 
> I think something like the below would be more in keeping with what's
> expected:
> 
> 		"core": Clock controlling the FIFO buffers and registers

Ok, thanks will reword.

> 
> > 
> > > 
> > > > +		"iface" : Clock used by QUP interface
> > > 
> > > Which interface? The slave interface the CPUs access, or the interface
> > > to the I2C devices?
> > 
> > 
> > My understanding for this is that QUP is wrapping I2C core. QUP is
> > interface to I2C core.
> 
> Ok.
> 
> > 
> > > 
> > > Are these the only clock inputs to the device?
> > 
> > Yep.
> 
> Ok.
> 
> > 
> > > 
> > > Is there a regulator input that might need to be specified?
> > > 
> > 
> > No. Power management is done via clock gating.
> 
> Ok.
> 
> > 
> > > > +
> > > > + - #address-cells : should be <1> Address cells for I2C device address
> > > > + - #size-cells : should be <0> I2C addresses have no size component.
> > > > +
> > > > +Optional properties :
> > > > + - Child nodes conforming to i2c bus binding
> > > > + - clock-frequency : Desired I2C bus clock frequency in Hz. If
> > > > +		not set thedefault frequency is 100kHz
> > > 
> > > Why is this necessary?
> > 
> > This is how I2C bus frequency could be specified. It is standard
> > I2C property. Not sure that I get the question.
> 
> Not all i2c bindings have this, but I see many do. Never mind.
> 
> > 
> > > 
> > > > + - qcom,src-freq : Frequency of the source clocking this bus in Hz.
> > > > +		Divider value is set based on soruce-frequency and
> > > > +		desired I2C bus frequency. If this value is not
> > > > +		provided, the source clock is assumed to be running
> > > > +		at 19.2 MHz.
> > > 
> > > This looks like it should be a clock input.
> > 
> > Thanks, I will change it.
> 
> Great!


Regards,
Ivan

> 
> Cheers,
> Mark.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
