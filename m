From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5] hwmon: ads7828 optional parameters from the device
 tree
Date: Fri, 24 Mar 2017 11:12:58 -0500
Message-ID: <20170324161258.m5wech6u6g7ezx7d@rob-hp-laptop>
References: <20170321032434.9268-1-kernel.development@povil.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170321032434.9268-1-kernel.development@povil.us>
Sender: linux-hwmon-owner@vger.kernel.org
To: Sam Povilus <kernel.development@povil.us>
Cc: wsa@the-dreams.de, jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 20, 2017 at 09:24:34PM -0600, Sam Povilus wrote:
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
> Signed-off-by: Sam Povilus <kernel.development@povil.us>
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

What does this point to?

Should be vref-supply?

> +  The external reference on the device is set to this regulators output. If it
> +  does not exists the internal reference will be used and output by the ads78xx
> +  on the "external vref" pin.
> +
> +  Example ADS7828 node:
> +
> +  ads7828: ads@48 {

adc@...

> +  	   comatible = "ti,ads7828";
> +	   reg = <0x48>;
> +	   vref = <&vref>;

Add a vref node to the example.

> +	   ti,differential-input;
> +  };
> +
