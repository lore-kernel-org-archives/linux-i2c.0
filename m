From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] i2c: meson: use generic compatible
Date: Tue, 17 Oct 2017 16:19:13 -0500
Message-ID: <20171017211913.gvspqwmts3aqz5tv@rob-hp-laptop>
References: <20171013082206.31632-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:50562 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756023AbdJQVTP (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 17 Oct 2017 17:19:15 -0400
Content-Disposition: inline
In-Reply-To: <20171013082206.31632-1-jbrunet@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Oct 13, 2017 at 10:22:06AM +0200, Jerome Brunet wrote:
> The meson i2c driver seems to be compatible with more SoCs than
> initially thought. Let's use the most generic compatible he have in
> DT instead of the gxbb specific one
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-meson.txt | 2 +-
>  drivers/i2c/busses/i2c-meson.c                      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
> index 611b934c7e10..e6a563443e26 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
> @@ -1,7 +1,7 @@
>  Amlogic Meson I2C controller
>  
>  Required properties:
> - - compatible: must be "amlogic,meson6-i2c" or "amlogic,meson-gxbb-i2c"
> + - compatible: must be "amlogic,meson6-i2c" or "amlogic,meson-gx-i2c"

Seems like a pointless, not backwards compatible change.

>   - reg: physical address and length of the device registers
>   - interrupts: a single interrupt specifier
>   - clocks: clock for the device
> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
> index 88d15b92ec35..7b238d8c19af 100644
> --- a/drivers/i2c/busses/i2c-meson.c
> +++ b/drivers/i2c/busses/i2c-meson.c
> @@ -442,7 +442,7 @@ static int meson_i2c_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id meson_i2c_match[] = {
>  	{ .compatible = "amlogic,meson6-i2c" },
> -	{ .compatible = "amlogic,meson-gxbb-i2c" },
> +	{ .compatible = "amlogic,meson-gx-i2c" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, meson_i2c_match);
> -- 
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
