From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v5] hwmon: ads7828 optional parameters from the device
 tree
Date: Mon, 20 Mar 2017 22:59:18 -0700
Message-ID: <5e81eb5c-63b1-5c14-b3e3-32d9db9380b1@roeck-us.net>
References: <20170321032434.9268-1-kernel.development@povil.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170321032434.9268-1-kernel.development-iezDrKAjiWs@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sam Povilus <kernel.development-iezDrKAjiWs@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 03/20/2017 08:24 PM, Sam Povilus wrote:
> Adding the ability for the ads7828 and ads7830 to use the device tree to
> get their optional parameters, instead of using platform devices. This
> allows people using custom boards to also use the ads7828 in a non-default
> manner.
>
> v2: conforming to coding style
> v3: changing from "_" to "-" for device tree entries
> v4: using regulator subsystem for voltage source, renaming differential
>     input property
> v5: checking for invalid vref values sooner and returning error if they are
>     bad, not warning user.
>
> Signed-off-by: Sam Povilus <kernel.development-iezDrKAjiWs@public.gmane.org>
> ---
>  .../devicetree/bindings/hwmon/ads7828.txt          | 26 ++++++++++++++++++++++
>  .../devicetree/bindings/i2c/trivial-devices.txt    |  2 --
>  drivers/hwmon/ads7828.c                            | 21 +++++++++++++++++
>  3 files changed, 47 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ads7828.txt
>
> diff --git a/Documentation/devicetree/bindings/hwmon/ads7828.txt b/Documentation/devicetree/bindings/hwmon/ads7828.txt
> new file mode 100644
> index 000000000000..5a0c4a7c6144
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ads7828.txt
> @@ -0,0 +1,26 @@
> +ads7828 properties
> +
> +Required properties:
> +- compatible: Should be one of
> +	       ti,ads7828
> +	       ti,ads7830
> +- reg: I2C address
> +
> +Optional properties:
> +
> +- ti,differential-input
> +  Set to use the device in differential mode.
> +- vref
> +  The external reference on the device is set to this regulators output. If it
> +  does not exists the internal reference will be used and output by the ads78xx
> +  on the "external vref" pin.
> +
> +  Example ADS7828 node:
> +
> +  ads7828: ads@48 {
> +  	   comatible = "ti,ads7828";

s/comatible/compatible/

> +	   reg = <0x48>;
> +	   vref = <&vref>;

Looking into the source of of_get_regulator(), either this has to be vref-supply
or I am missing something.

Didn't I mention all this before ?

> +	   ti,differential-input;
> +  };
> +
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
> index ee396ff167d9..0be4804a9e59 100644
> --- a/drivers/hwmon/ads7828.c
> +++ b/drivers/hwmon/ads7828.c
> @@ -34,6 +34,9 @@
>  #include <linux/platform_data/ads7828.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/regulator/consumer.h>

alphabetic order please

> +
> +#define MV_TO_UV 1000
>
>  /* The ADS7828 registers */
>  #define ADS7828_CMD_SD_SE	0x80	/* Single ended inputs */
> @@ -118,9 +121,12 @@ static int ads7828_probe(struct i2c_client *client,
>  	struct ads7828_data *data;
>  	struct device *hwmon_dev;
>  	unsigned int vref_mv = ADS7828_INT_VREF_MV;
> +	unsigned int vref_uv;
>  	bool diff_input = false;
>  	bool ext_vref = false;
>  	unsigned int regval;
> +	struct regulator *reg;
> +
>

Please no double empty lines.

>  	data = devm_kzalloc(dev, sizeof(struct ads7828_data), GFP_KERNEL);
>  	if (!data)
> @@ -131,6 +137,21 @@ static int ads7828_probe(struct i2c_client *client,
>  		ext_vref = pdata->ext_vref;
>  		if (ext_vref && pdata->vref_mv)
>  			vref_mv = pdata->vref_mv;
> +	} else if (dev->of_node) {
> +		if (of_get_property(dev->of_node, "ti,differential-input",
> +				    NULL))
> +			diff_input = true;
> +		reg = devm_regulator_get_optional(dev, "vref");
> +		if (!IS_ERR(reg)) {
> +			vref_uv = regulator_get_voltage(reg);
> +			if ((vref_uv >= ADS7828_EXT_VREF_MV_MIN * MV_TO_UV) &&
> +			    (vref_uv <= ADS7828_EXT_VREF_MV_MAX * MV_TO_UV)) {
> +				vref_mv = DIV_ROUND_CLOSEST(vref_uv, MV_TO_UV);
> +				ext_vref = true;
> +			} else {
> +				return  -EINVAL;
> +			}

Easier would be
			vref_mv = DIV_ROUND_CLOSEST(vref_uv, 1000);
			if (vref_mv < ADS7828_EXT_VREF_MV_MIN ||
			    vref_mv > ADS7828_EXT_VREF_MV_MAX)
				return -EINVAL;
			ext_vref = true;

I don't think we need the MV_TO_UV define.

> +		}
>  	}
>
>  	/* Bound Vref with min/max values */
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
