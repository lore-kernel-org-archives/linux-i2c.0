From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 21/28] dt-bindings: gpio: Convert mrvl-gpio to json-schema
Date: Fri, 27 Mar 2020 13:29:59 -0600
Message-ID: <20200327192959.GB8577@bogus>
References: <20200317093922.20785-1-lkundrak@v3.sk>
 <20200317093922.20785-22-lkundrak@v3.sk>
 <CACRpkdaEnODObC7emg2M7Ayn_JkeLuc3HpV4VhJcwaZ+=sDLcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaEnODObC7emg2M7Ayn_JkeLuc3HpV4VhJcwaZ+=sDLcg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lubomir Rintel <lkundrak@v3.sk>, Robert Jarzmik <robert.jarzmik@free.fr>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, open list:OPEN FIRMWARE AND F
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 27, 2020 at 11:04:00AM +0100, Linus Walleij wrote:
> Hi Lubomir!
> 
> Excellent work! Just nitpicks:
> 
> On Tue, Mar 17, 2020 at 10:40 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> 
> > +++ b/Documentation/devicetree/bindings/gpio/mrvl-gpio.yaml
> > @@ -0,0 +1,173 @@
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpio/mrvl-gpio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Marvell PXA GPIO controller
> 
> This binding is lacking a license. Please use the dual GPL+BSD license
> tag.

That is preferred, but should only be dual if you have rights on the old 
binding file or get relicensing permissions.

> 
> > +maintainers:
> > +  - devicetree@vger.kernel.org
> 
> I don't know if Robert Jarzmik is in on maintaining this, would you accept
> it Robert?
> 
> Yours,
> Linus Walleij
