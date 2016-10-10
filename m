From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 06/10] i2c: i2c-mux-ptxpmb-cpld: Add device tree bindings
Date: Mon, 10 Oct 2016 12:45:17 -0500
Message-ID: <20161010174517.GA18097@rob-hp-laptop>
References: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1475853451-22121-7-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1475853451-22121-7-git-send-email-pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Debjit Ghosh <dghosh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, Georgi Vlaev <gvlaev-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, JawaharBalaji Thirumalaisamy <jawaharb-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, Rajat Jain <rajatjain-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.orglinux
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 07, 2016 at 06:17:27PM +0300, Pantelis Antoniou wrote:
> From: Georgi Vlaev <gvlaev-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
> 
> Add binding document for the i2c driver of PTXPMB CPLD.
> 
> Signed-off-by: Georgi Vlaev <gvlaev-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
> [Ported from Juniper kernel]
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> ---
>  .../bindings/i2c/jnx,i2c-mux-ptxpmb-cpld.txt       | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/jnx,i2c-mux-ptxpmb-cpld.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/jnx,i2c-mux-ptxpmb-cpld.txt b/Documentation/devicetree/bindings/i2c/jnx,i2c-mux-ptxpmb-cpld.txt
> new file mode 100644
> index 0000000..3b201f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/jnx,i2c-mux-ptxpmb-cpld.txt
> @@ -0,0 +1,50 @@
> +* Juniper PTXPMB CPLD I2C Mux
> +
> +I2C mux on the PTXPMB CPLD on Juniper series of routers.
> +
> +Required properties:
> +
> +  - compatible: Must contain one of the following.
> +    "jnx,i2c-mux-ptxpmb-cpld", "jnx,i2c-mux-ngpmb-bcpld"
> +  - num-enable: Number of muxes to enable.

No. Use status property.

> +
> +  The following required properties are defined externally:
> +
> +  - Standard I2C mux properties. See i2c-mux.txt in this directory.
> +  - I2C child bus nodes. See i2c-mux.txt in this directory.
> +
> +Optional Properties:
> +
> +  - num-channels: Number of channels. If not present the default is 8.

What's a channel?

> +  - base-bus-num: Base bus number. If not present it is 0.

No. Linuxism and why do you care?

> +  - use-force: Use the force method of the controller.
> +
> +
> +Example:
> +
> +cpld-i2c-mux {

mux {

> +	compatible = "jnx,i2c-mux-ptxpmb-cpld";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	i2c-parent = <&i2c1>;
> +
> +	num-enable = <1>;
> +
> +	i2c@0 {
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* PMB devices are accessed through FPC */
> +
> +		temp-sensor@1a { /* FPC */
> +			compatible = "maxim,max6697";
> +			reg = <0x1a>;
> +			smbus-timeout-disable;
> +			resistance-cancellation;
> +			alert-mask = <0xff>;
> +			over-temperature-mask = <0xff>;
> +		};
> +	};
> +};
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
