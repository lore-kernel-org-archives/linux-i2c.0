From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 7/8] ARM: dts: dove: Add internal i2c multiplexer node
Date: Mon, 23 Feb 2015 16:07:26 +0100
Message-ID: <54EB422E.6030502@free-electrons.com>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com> <1424199129-22099-8-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424199129-22099-8-git-send-email-sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gabriel Dobato <dobatog-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Sebastian,

On 17/02/2015 19:52, Sebastian Hesselbarth wrote:
> This adds a i2c-mux-pinctrl node to dove.dtsi for the internal i2c
> mux found on Dove SoCs. Up to now, we had no board using any of the
> two additional i2c busses, so make sure the change does not break
> any existing boards.
> 
> Therefore, we rename the i2c-controller node label to "i2c" and
> enable it by default. Also, the dedicated sub-bus (now "i2c0") is
> enabled by default. The two optional sub-busses require additional
> external pin-muxing, so disable them by default.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>


Thanks,

Gregory

> ---
> Wolfram,
> 
> Actually, I was hoping that default pin hog mechanism
> (pinctrl-names = "default") could also be used from i2c mux nodes
> and devices. Anyway, I had a look at i2c-core/mux code and failed
> how to achieve that easily. Instead I decided, it would also be ok
> to put the pin hog into the i2c controller node where pins will be
> bound by standard platform device code.
> 
> Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
> Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> Cc: Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Gabriel Dobato <dobatog-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  arch/arm/boot/dts/dove.dtsi | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 9ad829523a13..b3340e862b0e 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -28,6 +28,42 @@
>  		};
>  	};
>  
> +	i2c-mux {
> +		compatible = "i2c-mux-pinctrl";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c-parent = <&i2c>;
> +
> +		pinctrl-names = "i2c0", "i2c1", "i2c2";
> +		pinctrl-0 = <&pmx_i2cmux_0>;
> +		pinctrl-1 = <&pmx_i2cmux_1>;
> +		pinctrl-2 = <&pmx_i2cmux_2>;
> +
> +		i2c0: i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "okay";
> +		};
> +
> +		i2c1: i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			/* Requires pmx_i2c1 on i2c controller node */
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			/* Requires pmx_i2c2 on i2c controller node */
> +			status = "disabled";
> +		};
> +	};
> +
>  	l2: l2-cache {
>  		compatible = "marvell,tauros2-cache";
>  		marvell,tauros2-cache-features = <0>;
> @@ -123,7 +159,7 @@
>  				status = "disabled";
>  			};
>  
> -			i2c0: i2c-ctrl@11000 {
> +			i2c: i2c-ctrl@11000 {
>  				compatible = "marvell,mv64xxx-i2c";
>  				reg = <0x11000 0x20>;
>  				#address-cells = <1>;
> @@ -132,7 +168,7 @@
>  				clock-frequency = <400000>;
>  				timeout-ms = <1000>;
>  				clocks = <&core_clk 0>;
> -				status = "disabled";
> +				status = "okay";
>  			};
>  
>  			uart0: serial@12000 {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
