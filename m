From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 21/28] dt-bindings: gpio: Convert mrvl-gpio to json-schema
Date: Fri, 27 Mar 2020 11:04:00 +0100
Message-ID: <CACRpkdaEnODObC7emg2M7Ayn_JkeLuc3HpV4VhJcwaZ+=sDLcg@mail.gmail.com>
References: <20200317093922.20785-1-lkundrak@v3.sk> <20200317093922.20785-22-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20200317093922.20785-22-lkundrak@v3.sk>
Sender: linux-media-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Rob Herring <robh+dt@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicet>
List-Id: linux-i2c@vger.kernel.org

Hi Lubomir!

Excellent work! Just nitpicks:

On Tue, Mar 17, 2020 at 10:40 AM Lubomir Rintel <lkundrak@v3.sk> wrote:

> +++ b/Documentation/devicetree/bindings/gpio/mrvl-gpio.yaml
> @@ -0,0 +1,173 @@
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/mrvl-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell PXA GPIO controller

This binding is lacking a license. Please use the dual GPL+BSD license
tag.

> +maintainers:
> +  - devicetree@vger.kernel.org

I don't know if Robert Jarzmik is in on maintaining this, would you accept
it Robert?

Yours,
Linus Walleij
