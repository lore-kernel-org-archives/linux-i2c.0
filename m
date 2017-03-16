From: Sam Povilus <kernel.development@povil.us>
Subject: Re: [PATCH v3] hwmon: ads7828 optional parameters from the device
 tree
Date: Wed, 15 Mar 2017 21:21:28 -0600
Message-ID: <20170316032127.22yn62pjefcrhnw2@irascible.povil.us>
References: <20170312144739.13276-1-kernel.development@povil.us>
 <14108694-9690-15fc-3087-5dbd1ffd5694@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:34232 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdCPDXG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 15 Mar 2017 23:23:06 -0400
Received: by mail-io0-f196.google.com with SMTP id n76so4904445ioe.1
        for <linux-i2c@vger.kernel.org>; Wed, 15 Mar 2017 20:21:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <14108694-9690-15fc-3087-5dbd1ffd5694@roeck-us.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: wsa@the-dreams.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com

On Sun, Mar 12, 2017 at 10:57:43AM -0700, Guenter Roeck wrote:
> On 03/12/2017 07:47 AM, Sam Povilus wrote:
> > Adding the ability for the ads7828 and ads7830 to use the device tree to
> > get their optional parameters, instead of using platform devices. This
> > allows people using custom boards to also use the ads7828 in a non-default
> > manner.
> > 
> > Also adding a note to the user if they misconfigure the device's external
> > reference.
> > 
> > v2: conforming to coding style
> > v3: changing from "_" to "-" for device tree entries
> > Signed-off-by: Sam Povilus <kernel.development@povil.us>
> > ---
> >  Documentation/devicetree/bindings/hwmon/ads7828.txt    | 18 ++++++++++++++++++
> >  .../devicetree/bindings/i2c/trivial-devices.txt        |  2 --
> >  drivers/hwmon/ads7828.c                                | 15 +++++++++++++++
> >  3 files changed, 33 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/ads7828.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/ads7828.txt b/Documentation/devicetree/bindings/hwmon/ads7828.txt
> > new file mode 100644
> > index 000000000000..0d37cd3fd31b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/ads7828.txt
> > @@ -0,0 +1,18 @@
> > +ads7828 properties
> > +
> > +Required properties:
> > +- compatible:
> > +	Should be one of
> > +	       ti,ads7828
> > +	       ti,ads7830
> > +- reg: I2C address
> > +
> > +Optional properties:
> > +
> > +- diff-input
> > +  Set to use the device in differential mode.
> 
> I'll wait for Rob to comment, but "differential-input" sounds better to me,
> Also, it would have to have a "ti," prefix.
> 

The platform device uses diff_input, are we going for consistancy or
correctness? I am good with either.

> > +- ext-vref
> > +  Set to enable the external voltage reference on the device.
> > +- vref-mv
> > +  The external reference on the device is set to this as an unsigned integer in
> > +  milivolts. Must use "ext_vref" for this to have any meaning.
> 
> ext_vref, though as suggested below I think it would be better to use a standard
> property. Also, it seems to me that ext-vref is really unnecessary; the presence
> of "vref" can imply that the reference voltage is external.
>

I agree, but again, the platform device seperates it. Consistancy or
correctness?

> > diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > index cdd7b48826c3..87648909f6ce 100644
> > --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > @@ -163,8 +163,6 @@ st,m41t00		Serial real-time clock (RTC)
> >  st,m41t62		Serial real-time clock (RTC) with alarm
> >  st,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
> >  taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
> > -ti,ads7828		8-Channels, 12-bit ADC
> > -ti,ads7830		8-Channels, 8-bit ADC
> >  ti,tsc2003		I2C Touch-Screen Controller
> >  ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
> >  ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
> > diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
> > index ee396ff167d9..d1f7ba5d7a2b 100644
> > --- a/drivers/hwmon/ads7828.c
> > +++ b/drivers/hwmon/ads7828.c
> > @@ -118,6 +118,7 @@ static int ads7828_probe(struct i2c_client *client,
> >  	struct ads7828_data *data;
> >  	struct device *hwmon_dev;
> >  	unsigned int vref_mv = ADS7828_INT_VREF_MV;
> > +	unsigned int vref_mv_tmp;
> >  	bool diff_input = false;
> >  	bool ext_vref = false;
> >  	unsigned int regval;
> > @@ -131,11 +132,25 @@ static int ads7828_probe(struct i2c_client *client,
> >  		ext_vref = pdata->ext_vref;
> >  		if (ext_vref && pdata->vref_mv)
> >  			vref_mv = pdata->vref_mv;
> > +	} else if (dev->of_node) {
> > +		if (of_get_property(dev->of_node, "diff-input", NULL))
> > +			diff_input = true;
> > +		if (of_get_property(dev->of_node, "ext-vref", NULL))
> > +			ext_vref = true;
> > +		if (!of_property_read_u32(dev->of_node, "vref-mv", &vref_mv_tmp)
> > +		   && ext_vref)
> > +			vref_mv = vref_mv_tmp;
> 
> Please consider using devm_regulator_get_optional() and thus standard properties.
>

I'd have to disagree with this, but not strongly. In my reading of
Documentation/power/regulator/overview.txt it seems like the regulator
subsystem is exclusivly for regulators not for references. I would hope
that most board designers would not use a regulator, and especially not
a switch mode regulator for the input to a reference. Am I reading the
regulator subsystem overview wrong?  or are people using it for things
that it's not quite intended (I will admit it looks like a number of
other adcs use it)? or is there some other explination.

> >  	}
> > 
> >  	/* Bound Vref with min/max values */
> > +	vref_mv_tmp = vref_mv;
> >  	vref_mv = clamp_val(vref_mv, ADS7828_EXT_VREF_MV_MIN,
> >  			    ADS7828_EXT_VREF_MV_MAX);
> > +	if (vref_mv_tmp != vref_mv) {
> > +		pr_info("You used and invalid external vref,"
> > +			" it has been clamped to %u",
> > +			vref_mv);
> > +	}
> 
> This is an unrelated change.
> 
> > 
> >  	/* ADS7828 uses 12-bit samples, while ADS7830 is 8-bit */
> >  	if (id->driver_data == ads7828) {
> > 
> 
