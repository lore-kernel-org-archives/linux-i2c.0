From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 18/28] dt-bindings: mmc: Fix node name in an example
Date: Thu, 26 Mar 2020 15:28:17 +0100
Message-ID: <CAPDyKFrcrgMrd9Nv425XuzssBhd+GvSUu29hXoVShwS0GNyjtQ@mail.gmail.com>
References: <20200317093922.20785-1-lkundrak@v3.sk> <20200317093922.20785-19-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20200317093922.20785-19-lkundrak@v3.sk>
Sender: linux-serial-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, DTML <devicetree@vger.ker>
List-Id: linux-i2c@vger.kernel.org

On Tue, 17 Mar 2020 at 10:40, Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> The $nodename allows only "mmc@*" whereas the example node is named
> "sdhci".
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index c9384ed685b8f..c03fe268c29a0 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -351,7 +351,7 @@ dependencies:
>
>  examples:
>    - |
> -    sdhci@ab000000 {
> +    mmc@ab000000 {
>          compatible = "sdhci";
>          reg = <0xab000000 0x200>;
>          interrupts = <23>;
> --
> 2.25.1
>
