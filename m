From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 20/28] dt-bindings: phy: Convert phy-mmp3-usb to
 json-schema
Date: Fri, 27 Mar 2020 13:09:42 -0600
Message-ID: <20200327190942.GA6703@bogus>
References: <20200317093922.20785-1-lkundrak@v3.sk>
 <20200317093922.20785-21-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200317093922.20785-21-lkundrak@v3.sk>
Sender: linux-gpio-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kerne
List-Id: linux-i2c@vger.kernel.org

On Tue, 17 Mar 2020 10:39:14 +0100, Lubomir Rintel wrote:
> A rather straightforward conversion of the phy-mmp3-usb binding to DT
> schema format using json-schema.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../bindings/phy/marvell,mmp3-usb-phy.yaml    | 40 +++++++++++++++++++
>  .../devicetree/bindings/phy/phy-mmp3-usb.txt  | 13 ------
>  2 files changed, 40 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/marvell,mmp3-usb-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-mmp3-usb.txt
> 

Applied, thanks.

Rob
