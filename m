From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v3] hwmon: ads7828 optional parameters from the device
 tree
Date: Thu, 16 Mar 2017 09:55:12 -0700
Message-ID: <20170316165512.GA23010@roeck-us.net>
References: <20170312144739.13276-1-kernel.development@povil.us>
 <14108694-9690-15fc-3087-5dbd1ffd5694@roeck-us.net>
 <20170316032127.22yn62pjefcrhnw2@irascible.povil.us>
 <0540770e-6604-f224-9e00-c34e8c5c3c91@roeck-us.net>
 <20170316132811.jsu7pprl4zqeifxz@irascible.povil.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170316132811.jsu7pprl4zqeifxz-vsA/HdQuLiGu4arkomUJ35yrNiDsoR7y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sam Povilus <kernel.development-iezDrKAjiWs@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 16, 2017 at 07:28:11AM -0600, Sam Povilus wrote:
> On Wed, Mar 15, 2017 at 08:49:19PM -0700, Guenter Roeck wrote:
> > On 03/15/2017 08:21 PM, Sam Povilus wrote:
> > > On Sun, Mar 12, 2017 at 10:57:43AM -0700, Guenter Roeck wrote:
> > > > On 03/12/2017 07:47 AM, Sam Povilus wrote:
> > > > > Adding the ability for the ads7828 and ads7830 to use the device tree to
> > > > > get their optional parameters, instead of using platform devices. This
> > > > > allows people using custom boards to also use the ads7828 in a non-default
> > > > > manner.
> > > > > 
> > > > > Also adding a note to the user if they misconfigure the device's external
> > > > > reference.
> > > > > 
> > > > > v2: conforming to coding style
> > > > > v3: changing from "_" to "-" for device tree entries
> > > > > Signed-off-by: Sam Povilus <kernel.development-iezDrKAjiWs@public.gmane.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/hwmon/ads7828.txt    | 18 ++++++++++++++++++
> > > > >  .../devicetree/bindings/i2c/trivial-devices.txt        |  2 --
> > > > >  drivers/hwmon/ads7828.c                                | 15 +++++++++++++++
> > > > >  3 files changed, 33 insertions(+), 2 deletions(-)
> > > > >  create mode 100644 Documentation/devicetree/bindings/hwmon/ads7828.txt
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/hwmon/ads7828.txt b/Documentation/devicetree/bindings/hwmon/ads7828.txt
> > > > > new file mode 100644
> > > > > index 000000000000..0d37cd3fd31b
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/hwmon/ads7828.txt
> > > > > @@ -0,0 +1,18 @@
> > > > > +ads7828 properties
> > > > > +
> > > > > +Required properties:
> > > > > +- compatible:
> > > > > +	Should be one of
> > > > > +	       ti,ads7828
> > > > > +	       ti,ads7830
> > > > > +- reg: I2C address
> > > > > +
> > > > > +Optional properties:
> > > > > +
> > > > > +- diff-input
> > > > > +  Set to use the device in differential mode.
> > > > 
> > > > I'll wait for Rob to comment, but "differential-input" sounds better to me,
> > > > Also, it would have to have a "ti," prefix.
> > > > 
> > > 
> > > The platform device uses diff_input, are we going for consistancy or
> > > correctness? I am good with either.
> > > 
> > 
> > What does a platform device variable name, ie a Linux implementation detail,
> > have to do with a devicetree property name ?
> >
> 
> Isn't the device tree property name also an implementation detail?
> 

Devicetree properties are supposed to be operating system independent
properties used to describe the hardware. That is hardly an implementation
detail.

> > > > > +- ext-vref
> > > > > +  Set to enable the external voltage reference on the device.
> > > > > +- vref-mv
> > > > > +  The external reference on the device is set to this as an unsigned integer in
> > > > > +  milivolts. Must use "ext_vref" for this to have any meaning.
> > > > 
> > > > ext_vref, though as suggested below I think it would be better to use a standard
> > > > property. Also, it seems to me that ext-vref is really unnecessary; the presence
> > > > of "vref" can imply that the reference voltage is external.
> > > > 
> > > 
> > > I agree, but again, the platform device seperates it. Consistancy or
> > > correctness?
> > > 
> > 
> > Same question.
> > 
> > > > > diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > > > > index cdd7b48826c3..87648909f6ce 100644
> > > > > --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > > > > +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > > > > @@ -163,8 +163,6 @@ st,m41t00		Serial real-time clock (RTC)
> > > > >  st,m41t62		Serial real-time clock (RTC) with alarm
> > > > >  st,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
> > > > >  taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
> > > > > -ti,ads7828		8-Channels, 12-bit ADC
> > > > > -ti,ads7830		8-Channels, 8-bit ADC
> > > > >  ti,tsc2003		I2C Touch-Screen Controller
> > > > >  ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
> > > > >  ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
> > > > > diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
> > > > > index ee396ff167d9..d1f7ba5d7a2b 100644
> > > > > --- a/drivers/hwmon/ads7828.c
> > > > > +++ b/drivers/hwmon/ads7828.c
> > > > > @@ -118,6 +118,7 @@ static int ads7828_probe(struct i2c_client *client,
> > > > >  	struct ads7828_data *data;
> > > > >  	struct device *hwmon_dev;
> > > > >  	unsigned int vref_mv = ADS7828_INT_VREF_MV;
> > > > > +	unsigned int vref_mv_tmp;
> > > > >  	bool diff_input = false;
> > > > >  	bool ext_vref = false;
> > > > >  	unsigned int regval;
> > > > > @@ -131,11 +132,25 @@ static int ads7828_probe(struct i2c_client *client,
> > > > >  		ext_vref = pdata->ext_vref;
> > > > >  		if (ext_vref && pdata->vref_mv)
> > > > >  			vref_mv = pdata->vref_mv;
> > > > > +	} else if (dev->of_node) {
> > > > > +		if (of_get_property(dev->of_node, "diff-input", NULL))
> > > > > +			diff_input = true;
> > > > > +		if (of_get_property(dev->of_node, "ext-vref", NULL))
> > > > > +			ext_vref = true;
> > > > > +		if (!of_property_read_u32(dev->of_node, "vref-mv", &vref_mv_tmp)
> > > > > +		   && ext_vref)
> > > > > +			vref_mv = vref_mv_tmp;
> > > > 
> > > > Please consider using devm_regulator_get_optional() and thus standard properties.
> > > > 
> > > 
> > > I'd have to disagree with this, but not strongly. In my reading of
> > > Documentation/power/regulator/overview.txt it seems like the regulator
> > > subsystem is exclusivly for regulators not for references. I would hope
> > > that most board designers would not use a regulator, and especially not
> > > a switch mode regulator for the input to a reference. Am I reading the
> > > regulator subsystem overview wrong?  or are people using it for things
> > > that it's not quite intended (I will admit it looks like a number of
> > > other adcs use it)? or is there some other explination.
> > > 
> > 
> > A reference voltage is still a voltage which can be enabled or disabled.
> > By using a regulator one leaves it open if that voltage is enabled if
> > the chip is not in use. We also don't usually tell board designers how
> > to design the hardware. Besides, it is quite convenient.
> > 
> > Can you point me to the location in above documentation which states that
> > reference voltages shall not use regulators ? I seem to be unable to find it.
> >
> 
> "reference voltages shall not use regulators" It's not a shall not it's a
> should not. Regulators are significantly more inaccurate than references,
> subject to far more noise pass-through, and treated very differently by
> the electronics design community. One could use a system wide regulated
> bus for a reference to an ADC, but that would significantly reduce the
> accuracy and precision of your measurements. In almost all cases board
> designers are going to use always on references for this application,
> something that puts them well outside the purpose of the regulator
> subsystem. 
> 

You are right in a narrow sense, by associating the term "regulator"
as used in the Linux kernel with a hardware regulator chip which may
have the properties you describe.

However, there is nothing that states that a "regulator", in the context
used in the Linux kernel, shall be implemented as (potentially noisy)
hardware regulator, or that the regulator subssystem shall not support,
say, on/off regulators (or the ability to turn battery voltages on/off),
or, for that matter, stable voltages suitable as reference voltages.
Creating such an artificial restriction would severely limit the use case
for the Linux regulator subsystem, would result in code duplication
and fragmentation all over the place, and just doesn't make sense.

As an example, have a look at drivers/regulator/fixed.c; it is a regulator
which can optionally be turned on and off using a GPIO pin (but is more
likely always on) and provides a single fixed voltage. That regulator
is used as follows in at least one devicetree file (there are more
similar uses).

	vbat: fixedregulator@0 {
		compatible = "regulator-fixed";
		regulator-name = "vbat";
		regulator-min-microvolt = <5000000>;
		regulator-max-microvolt = <5000000>;
		regulator-boot-on;
	};

It is quite unlikely that this regulator has the properties you describe.
Following your logic, such a use would not be appropriate just because
the term "regulator" is used.

Thanks,
Guenter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
