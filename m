From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] Adding the ability for the ads7828 and ads7830 to use
 the device tree to get thier optional parameters, instead of using platform
 devices. This allows people using custom boards to also use the ads7828 in a
 non-default manner.
Date: Sat, 11 Mar 2017 21:43:00 -0800
Message-ID: <f7607ea1-9b06-94b4-bd39-0df7582a7b23@roeck-us.net>
References: <20170312033254.14799-1-kernel.development@povil.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41865 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbdCLFnP (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 12 Mar 2017 00:43:15 -0500
In-Reply-To: <20170312033254.14799-1-kernel.development@povil.us>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sam Povilus <kernel.development@povil.us>, wsa@the-dreams.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org

On 03/11/2017 07:32 PM, Sam Povilus wrote:
> Also adding a note to the user if they misconfigure the device's external
> reference.
>

Uuhhh ... ____please____ select a ___much___ shorter subject line.
It seems that you put the entire description into the subject line,
which is a really bad idea.

Also, it helps, for versioned patches, to describe the changes
from one version to another. Please read and follow the guidelines
for submitting patches (and consider running your patch through
checkpatch.pl).

Devicetree properties need to be submitted to devicetree maintainers.
In this case, while I am not an expert, I can say that the added
properties are not acceptable; devicetree property name should not
include '_'.

Guenter

> Signed-off-by: Sam Povilus <kernel.development@povil.us>
> ---
>  Documentation/devicetree/bindings/hwmon/ads7828.txt    | 18 ++++++++++++++++++
>  .../devicetree/bindings/i2c/trivial-devices.txt        |  2 --
>  drivers/hwmon/ads7828.c                                | 15 +++++++++++++++
>  3 files changed, 33 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ads7828.txt
>
> diff --git a/Documentation/devicetree/bindings/hwmon/ads7828.txt b/Documentation/devicetree/bindings/hwmon/ads7828.txt
> new file mode 100644
> index 000000000000..7cd786585b51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ads7828.txt
> @@ -0,0 +1,18 @@
> +ads7828 properties
> +
> +Required properties:
> +- compatible:
> +	Should be one of
> +	       ti,ads7828
> +	       ti,ads7830
> +- reg: I2C address
> +
> +Optional properties:
> +
> +- diff_input
> +  Set to use the device in differential mode.
> +- ext_vref
> +  Set to enable the external voltage reference on the device.
> +- vref_mv
> +  The external reference on the device is set to this as an unsigned integer in
> +  milivolts. Must use "ext_vref" for this to have any meaning.
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index cdd7b48826c3..87648909f6ce 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -163,8 +163,6 @@ st,m41t00		Serial real-time clock (RTC)
>  st,m41t62		Serial real-time clock (RTC) with alarm
>  st,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
>  taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
> -ti,ads7828		8-Channels, 12-bit ADC
> -ti,ads7830		8-Channels, 8-bit ADC
>  ti,tsc2003		I2C Touch-Screen Controller
>  ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>  ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
> diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
> index ee396ff167d9..05fc0ac06c06 100644
> --- a/drivers/hwmon/ads7828.c
> +++ b/drivers/hwmon/ads7828.c
> @@ -118,6 +118,7 @@ static int ads7828_probe(struct i2c_client *client,
>  	struct ads7828_data *data;
>  	struct device *hwmon_dev;
>  	unsigned int vref_mv = ADS7828_INT_VREF_MV;
> +	unsigned int vref_mv_tmp;
>  	bool diff_input = false;
>  	bool ext_vref = false;
>  	unsigned int regval;
> @@ -131,11 +132,25 @@ static int ads7828_probe(struct i2c_client *client,
>  		ext_vref = pdata->ext_vref;
>  		if (ext_vref && pdata->vref_mv)
>  			vref_mv = pdata->vref_mv;
> +	} else if (dev->of_node) {
> +		if (of_get_property(dev->of_node, "diff_input", NULL))
> +			diff_input = true;
> +		if (of_get_property(dev->of_node, "ext_vref", NULL))
> +			ext_vref = true;
> +		if (!of_property_read_u32(dev->of_node, "vref_mv", &vref_mv_tmp)
> +		   && ext_vref)
> +			vref_mv = vref_mv_tmp;
>  	}
>
>  	/* Bound Vref with min/max values */
> +	vref_mv_tmp = vref_mv;
>  	vref_mv = clamp_val(vref_mv, ADS7828_EXT_VREF_MV_MIN,
>  			    ADS7828_EXT_VREF_MV_MAX);
> +	if (vref_mv_tmp != vref_mv) {
> +		pr_info("You used and invalid external vref,"
> +			" it has been clamped to %u",
> +			vref_mv);
> +	}
>
>  	/* ADS7828 uses 12-bit samples, while ADS7830 is 8-bit */
>  	if (id->driver_data == ads7828) {
>
