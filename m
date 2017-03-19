From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4] hwmon: ads7828 optional parameters from the device
 tree
Date: Sun, 19 Mar 2017 16:54:24 -0700
Message-ID: <18ff1fd5-5d9d-84e5-92eb-90060c223b5d@roeck-us.net>
References: <20170319193858.24981-1-kernel.development@povil.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <20170319193858.24981-1-kernel.development@povil.us>
Sender: linux-hwmon-owner@vger.kernel.org
To: Sam Povilus <kernel.development@povil.us>, wsa@the-dreams.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 03/19/2017 12:38 PM, Sam Povilus wrote:
> Adding the ability for the ads7828 and ads7830 to use the device tree to
> get their optional parameters, instead of using platform devices. This
> allows people using custom boards to also use the ads7828 in a non-default
> manner.
>
> Because we have made it easy for the user to specify an improper reference
> voltage, adding a note to the user if they misconfigure the device's
> external reference.
>
> v2: conforming to coding style
> v3: changing from "_" to "-" for device tree entries
> v4: using regulator subsystem for voltage source, renaming differential input
>     property
>
> Signed-off-by: Sam Povilus <kernel.development@povil.us>
> ---
>  .../devicetree/bindings/hwmon/ads7828.txt          | 27 ++++++++++++++++++++++
>  .../devicetree/bindings/i2c/trivial-devices.txt    |  2 --
>  drivers/hwmon/ads7828.c                            | 23 ++++++++++++++++++
>  3 files changed, 50 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ads7828.txt
>
> diff --git a/Documentation/devicetree/bindings/hwmon/ads7828.txt b/Documentation/devicetree/bindings/hwmon/ads7828.txt
> new file mode 100644
> index 000000000000..c71b4005e045
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ads7828.txt
> @@ -0,0 +1,27 @@
> +ads7828 properties
> +
> +Required properties:
> +- compatible:

compatible

> +	Should be one of
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
> +	   reg = <0x48>;
> +	   vref = <&vref>;

Shouldn't this be vref-supply ?

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
> index ee396ff167d9..4f64141b2997 100644
> --- a/drivers/hwmon/ads7828.c
> +++ b/drivers/hwmon/ads7828.c
> @@ -34,6 +34,7 @@
>  #include <linux/platform_data/ads7828.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/regulator/consumer.h>
>
>  /* The ADS7828 registers */
>  #define ADS7828_CMD_SD_SE	0x80	/* Single ended inputs */
> @@ -118,9 +119,13 @@ static int ads7828_probe(struct i2c_client *client,
>  	struct ads7828_data *data;
>  	struct device *hwmon_dev;
>  	unsigned int vref_mv = ADS7828_INT_VREF_MV;
> +	unsigned int vref_mv_tmp;
> +	unsigned int vref_uv = -1;

unsigned and -1 doesn't fit well together. Either case, the initialization is unnecessary.

>  	bool diff_input = false;
>  	bool ext_vref = false;
>  	unsigned int regval;
> +	struct regulator *reg;
> +
>
>  	data = devm_kzalloc(dev, sizeof(struct ads7828_data), GFP_KERNEL);
>  	if (!data)
> @@ -131,11 +136,29 @@ static int ads7828_probe(struct i2c_client *client,
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
> +			if (vref_uv >= 0) {

This is always >= 0 since vref_uv is defined as unsigned int.

> +				vref_mv = DIV_ROUND_CLOSEST(vref_uv, 1000);
> +				ext_vref = true;
> +			}
> +		}
>  	}
>
>  	/* Bound Vref with min/max values */
> +	vref_mv_tmp = vref_mv;
>  	vref_mv = clamp_val(vref_mv, ADS7828_EXT_VREF_MV_MIN,
>  			    ADS7828_EXT_VREF_MV_MAX);
> +	if (vref_mv_tmp != vref_mv) {
> +		pr_info("You used and invalid external reference voltage, it has"
> +			" been clamped to %u mV",

I would prefer if the devicetree code above would check the range
and return -EINVAL if it is bad. Clamping doesn't really make any sense here,
since the result is wrong. If you want an error message with that, please
use dev_err and shorten the message ("Invalid external reference voltage").

> +			vref_mv);
> +	}
>
>  	/* ADS7828 uses 12-bit samples, while ADS7830 is 8-bit */
>  	if (id->driver_data == ads7828) {
>

