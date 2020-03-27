From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 16/28] dt-bindings: Add "mrvl", a legacy vendor prefix
 for Marvell
Date: Fri, 27 Mar 2020 13:06:38 -0600
Message-ID: <20200327190638.GA1762@bogus>
References: <20200317093922.20785-1-lkundrak@v3.sk>
 <20200317093922.20785-17-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200317093922.20785-17-lkundrak@v3.sk>
Sender: linux-serial-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kerne
List-Id: linux-i2c@vger.kernel.org

On Tue, 17 Mar 2020 10:39:10 +0100, Lubomir Rintel wrote:
> While the preferred vendor prefix is "marvell", "mrvl" is used by many
> older bindings already. Add it, while also marking it deprecated.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks.

Rob
