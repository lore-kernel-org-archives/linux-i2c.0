From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: mux: Add dt support to i2c-mux-gpio driver
Date: Thu, 18 Oct 2012 16:36:49 -0600
Message-ID: <50808481.6040501@wwwdotorg.org>
References: <1350569623-4699-1-git-send-email-maxime.ripard@free-electrons.com> <1350569623-4699-2-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350569623-4699-2-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10/18/2012 08:13 AM, Maxime Ripard wrote:
> Allow the i2c-mux-gpio to be used by a device tree enabled device. The
> bindings are inspired by the one found in the i2c-mux-pinctrl driver.

> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt

> +Optional properties:
> +- idle-state: value to set to the muxer when idle. When no value is
> +  given, it defaults to the first value in the array.

That's inconsistent with the following text that appears later (and
describes what the driver actually does):

> +If an idle state is defined, using the idle-state (optional) property,
> +whenever an access is not being made to a device on a child bus, the
> +idle value will be programmed into the GPIOs.
> +
> +If an idle state is not defined, the most recently used value will be
> +left programmed into hardware whenever no access is being made of a
> +device on a child bus.
