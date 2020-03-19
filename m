From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 13/28] dt-bindings: serial: move Marvell compatible string
 to 8250 binding doc
Date: Thu, 19 Mar 2020 10:09:18 -0600
Message-ID: <CAL_JsqJZbk29iq5QargTK-VMBoR359dvfQ=VuBkKHFdMfJEU9w@mail.gmail.com>
References: <20200317093922.20785-1-lkundrak@v3.sk> <20200317093922.20785-14-lkundrak@v3.sk>
 <20200317134805.GO24270@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgCSQJb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 19 Mar 2020 12:09:31 -0400
In-Reply-To: <20200317134805.GO24270@lunn.ch>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lubomir Rintel <lkundrak@v3.sk>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Gregory Clement <gregory.clement@bootlin.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.ke

On Tue, Mar 17, 2020 at 7:48 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Mar 17, 2020 at 10:39:07AM +0100, Lubomir Rintel wrote:
> > These ports are compatible with NS8250 and handled by the same driver.
> > Get rid of the extra document that fails to document the properties that
> > are actually supported.
>
> Hi Lubmir
>
> This is needs a bit closer examination. By the PXA maintainers. It
> appears there are two serial drivers, the 8250 and a PXA specific
> driver.

Yes, but that is independent of the binding.

The PXA driver (serial/pxa.c) is already deprecated in favor of
8250_pxa.c. That was 3.5 years ago now, so maybe time to remove the
old one.

Rob
