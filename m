From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 14/28] dt-bindings: arm: l2x0: Tauros 3 is PL310
 compatible
Date: Fri, 27 Mar 2020 13:04:41 -0600
Message-ID: <20200327190441.GA31060@bogus>
References: <20200317093922.20785-1-lkundrak@v3.sk>
 <20200317093922.20785-15-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-il1-f195.google.com ([209.85.166.195]:38117 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgC0TEp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 27 Mar 2020 15:04:45 -0400
Content-Disposition: inline
In-Reply-To: <20200317093922.20785-15-lkundrak@v3.sk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kerne

On Tue, 17 Mar 2020 10:39:08 +0100, Lubomir Rintel wrote:
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

Applied, thanks.

Rob
