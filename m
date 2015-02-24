From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: sunxi: Add Reduced Serial Bus
 (RSB) DT bindings documentation
Date: Tue, 24 Feb 2015 11:37:36 +0100
Message-ID: <9851276.8ZCd3XfZle@wuerfel>
References: <1424773744-15106-1-git-send-email-wens@csie.org> <1424773744-15106-3-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDEKVJM7XAHRB7NIWGTQKGQECQVTSHQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1424773744-15106-3-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 24 February 2015 18:29:02 Chen-Yu Tsai wrote:
> 
> +       rsb@01f03400 {
> +               compatible = "allwinner,sun8i-a23-rsb";
> +               reg = <0x01f03400 0x400>;
> +               interrupts = <0 39 4>;
> +               clocks = <&apb0_gates 3>;
> +               clock-frequency = <3000000>;
> +               resets = <&apb0_rst 3>;
> +
> +               axp223: pmic@2d {
> +                       compatible = "x-powers,axp223", "x-powers,axp221";
> +                       reg = <0x2d>;
> +                       allwinner,rsb-hw-addr = <0x3e3>;
> +
> +                       /* ... */
> +               };
> +       };

The child node cannot have a 'reg' property if the parent does not
have #address-cells/#size-cells. You should add these as mandatory
properties in the list.

I don't really understand the need for having two addresses (runtime
and hardware). Could the runtime address be configured at runtime?
Alternatively, could you use #address-cells=<2> and put both into
'reg'?

	Arnd
