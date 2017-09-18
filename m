From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 7/7] i2c: gpio: Add support for named gpios in DT
Date: Mon, 18 Sep 2017 11:26:04 +0200
Message-ID: <CAMuHMdX4+e6D_AEdvVF2Ubyxs0L6-53fqwot=wDXfPatvnMGTg@mail.gmail.com>
References: <20170917093906.16325-1-linus.walleij@linaro.org> <20170917093906.16325-8-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170917093906.16325-8-linus.walleij@linaro.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>
List-Id: linux-i2c@vger.kernel.org

On Sun, Sep 17, 2017 at 11:39 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This adds support for using the "sda" and "scl" GPIOs in
> device tree instead of anonymously using index 0 and 1 of
> the "gpios" property.
>
> We add a helper function to retrieve the GPIO descriptors
> and some explicit error handling since the probe may have
> to be deferred. At least this happened to me when moving
> to using named "sda" and "scl" lines (all of a sudden this
> started to probe before the GPIO driver) so we need to
> gracefully defer probe when we ge -ENOENT in the error

get

> pointer.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
