From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 14/28] dt-bindings: arm: l2x0: Tauros 3 is PL310
 compatible
Date: Fri, 27 Mar 2020 13:03:04 -0600
Message-ID: <20200327190304.GA27639@bogus>
References: <20200317093922.20785-1-lkundrak@v3.sk>
 <20200317093922.20785-15-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:42399 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgC0TDJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 27 Mar 2020 15:03:09 -0400
Content-Disposition: inline
In-Reply-To: <20200317093922.20785-15-lkundrak@v3.sk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kerne

On Tue, Mar 17, 2020 at 10:39:08AM +0100, Lubomir Rintel wrote:
> The validation is unhappy about mmp3-dell-ariel declaring its
> marvell,tauros3-cache node to be compatible with arm,pl310-cache:
> 
>   mmp3-dell-ariel.dt.yaml: cache-controller@d0020000: compatible:
>        Additional items are not allowed ('arm,pl310-cache' was unexpected)
>   mmp3-dell-ariel.dt.yaml: cache-controller@d0020000: compatible:
>        ['marvell,tauros3-cache', 'arm,pl310-cache'] is too long
> 
> Let's allow this -- Tauros 3 is designed to be compatible with PL310.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../devicetree/bindings/arm/l2c2x0.yaml       | 45 ++++++++++---------
>  1 file changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.yaml b/Documentation/devicetree/bindings/arm/l2c2x0.yaml
> index 913a8cd8b2c00..7e39088a9bed2 100644
> --- a/Documentation/devicetree/bindings/arm/l2c2x0.yaml
> +++ b/Documentation/devicetree/bindings/arm/l2c2x0.yaml
> @@ -29,27 +29,30 @@ allOf:
>  
>  properties:
>    compatible:
> -    enum:
> -      - arm,pl310-cache
> -      - arm,l220-cache
> -      - arm,l210-cache
> -        # DEPRECATED by "brcm,bcm11351-a2-pl310-cache"
> -      - bcm,bcm11351-a2-pl310-cache
> -        # For Broadcom bcm11351 chipset where an
> -        # offset needs to be added to the address before passing down to the L2
> -        # cache controller
> -      - brcm,bcm11351-a2-pl310-cache
> -        # Marvell Controller designed to be
> -        # compatible with the ARM one, with system cache mode (meaning
> -        # maintenance operations on L1 are broadcasted to the L2 and L2
> -        # performs the same operation).
> -      - marvell,aurora-system-cache
> -        # Marvell Controller designed to be
> -        # compatible with the ARM one with outer cache mode.
> -      - marvell,aurora-outer-cache
> -        # Marvell Tauros3 cache controller, compatible
> -        # with arm,pl310-cache controller.
> -      - marvell,tauros3-cache
> +    oneOf:
> +      - enum:
> +        - arm,pl310-cache

The list should be indented 2 more spaces. I'll fixup when applying.

> +        - arm,l220-cache
> +        - arm,l210-cache
> +          # DEPRECATED by "brcm,bcm11351-a2-pl310-cache"
> +        - bcm,bcm11351-a2-pl310-cache
> +          # For Broadcom bcm11351 chipset where an
> +          # offset needs to be added to the address before passing down to the L2
> +          # cache controller
> +        - brcm,bcm11351-a2-pl310-cache
> +          # Marvell Controller designed to be
> +          # compatible with the ARM one, with system cache mode (meaning
> +          # maintenance operations on L1 are broadcasted to the L2 and L2
> +          # performs the same operation).
> +        - marvell,aurora-system-cache
> +          # Marvell Controller designed to be
> +          # compatible with the ARM one with outer cache mode.
> +        - marvell,aurora-outer-cache
> +      - items:
> +         # Marvell Tauros3 cache controller, compatible
> +         # with arm,pl310-cache controller.
> +        - const: marvell,tauros3-cache
> +        - const: arm,pl310-cache
>  
>    cache-level:
>      const: 2
> -- 
> 2.25.1
> 
