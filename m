From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v6 3/5] i2c: aspeed: added documentation for Aspeed I2C
 driver
Date: Tue, 28 Mar 2017 19:54:43 +1100
Message-ID: <1490691283.3177.112.camel@kernel.crashing.org>
References: <20170328051226.21677-1-brendanhiggins@google.com>
         <20170328051226.21677-4-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170328051226.21677-4-brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org, mouse-Pma6HLj0uuo@public.gmane.org, clg-Bxea+6Xhats@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2017-03-27 at 22:12 -0700, Brendan Higgins wrote:
> Added device tree binding documentation for Aspeed I2C busses.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

> +	i2c0: i2c-bus@40 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <1>;
> +		reg = <0x40 0x40>;
> +		compatible = "aspeed,ast2400-i2c-bus";
> +		bus = <0>;
> +		clocks = <&clk_apb>;
> +		clock-frequency = <100000>;

For busses it's more traditional to make this "bus-frequency" but
that's a nit and Linux/fdt has not respected that tradition terribly
well. If you respin, it might be work changing.

The clock-frequency tends to be the frequency of the controller itself.

> +		status = "disabled";
> +		interrupts = <0>;
> +		interrupt-parent = <&i2c_ic>;
> +	};
> +};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
