From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [RFC,v2 3/6] media: dt-bindings: add DS90UB954-Q1 video
 deserializer
Date: Tue, 10 Sep 2019 12:43:27 +0300
Message-ID: <20190910094327.GG5781@paasikivi.fi.intel.com>
References: <20190723203723.11730-1-luca@lucaceresoli.net>
 <20190723203723.11730-4-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190723203723.11730-4-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-media@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>, Vladimir Zapolskiy <vz@mleia.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

Hi Luca,

On Tue, Jul 23, 2019 at 10:37:20PM +0200, Luca Ceresoli wrote:

...

> +Device node example
> +-------------------
> +
> +&i2c0 {
> +	deser: deser@3d {
> +		compatible = "ti,ds90ub954-q1";
> +		reg-names = "main", "rxport0", "rxport1", "ser0", "ser1";
> +		reg       = <0x3d>,  <0x40>,    <0x41>,   <0x44>, <0x45>;
> +		clocks = <&clk_25M>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <3 1 IRQ_TYPE_LEVEL_HIGH>;
> +		reset-gpios = <&gpio_ctl 4 GPIO_ACTIVE_LOW>;
> +
> +		i2c-alias-pool = /bits/ 16 <0x4a 0x4b 0x4c 0x4d 0x4e 0x4f>;
> +
> +		gpio-controller;
> +		#gpio-cells = <3>; /* rxport, remote gpio num, flags */
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				ds90ub954_fpd3_in0: endpoint {
> +					remote-endpoint = <&sensor_0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				ds90ub954_fpd3_in1: endpoint {
> +					remote-endpoint = <&sensor_1_out>;
> +				};
> +			};
> +
> +			port@2 {
> +				reg = <2>;
> +				ds90ub954_mipi_out0: endpoint {
> +					data-lanes = <1 2 3 4>;
> +					/* Actually a REFCLK multiplier */
> +					data-rate = <1600000000>;

What is data-rate used for? Is it documented somewhere? Could you use
link-frequencies property instead? It's defined in video-interfaces.txt.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
