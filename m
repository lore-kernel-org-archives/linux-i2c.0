From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/4] ARM: dts: armadillo800eva: Convert to named
 i2c-gpio bindings
Date: Sat, 2 Dec 2017 16:26:19 +0100
Message-ID: <CACRpkdbY=zAw-8LrqmMcGGf7cHmAaC=YvpovxqTTPwcsXPUYAA@mail.gmail.com>
References: <1512046646-15253-1-git-send-email-geert+renesas@glider.be> <1512046646-15253-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1512046646-15253-2-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 30, 2017 at 1:57 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Commits 7d29f509d2cfd807 ("dt-bindings: i2c: i2c-gpio: Add support for
> named gpios") and 05c74778858d7d99 ("i2c: gpio: Add support for named
> gpios in DT") introduced named i2c-gpio DT bindings, and deprecated the
> more error-prone unnamed variant.
>
> Switch to the new bindings, and add the missing GPIO_OPEN_DRAIN I/O
> flags, which were implicitly assumed before.
>
> The latter gets rid of the message:
>
>     gpio-208 (?): enforced open drain please flag it properly in DT/ACPI DSDT/board file
>     gpio-91 (?): enforced open drain please flag it properly in DT/ACPI DSDT/board file
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
