From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH/RFC 1/3] dt-bindings: i2c: i2c-gpio: Add support for named gpios
Date: Mon, 18 Sep 2017 21:45:29 +0200
Message-ID: <CACRpkdZqEXJBZbOOVy0jNrDX=ayeiquAdXHyMMnNKmFqwELEuw@mail.gmail.com>
References: <1503566474-5335-1-git-send-email-geert+renesas@glider.be>
 <1503566474-5335-2-git-send-email-geert+renesas@glider.be>
 <20170831175529.vuchpgvi2aigz2r5@rob-hp-laptop> <CAMuHMdXGm0XuuihG=L_JRBV_WHt2QPtZgdsMFT0PeyDH3ejsNg@mail.gmail.com>
 <CAL_JsqKS++33tOr6PVzX1Fifmn5teaZVYeY0UWeNiAfi=nHetA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKS++33tOr6PVzX1Fifmn5teaZVYeY0UWeNiAfi=nHetA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 18, 2017 at 6:52 PM, Rob Herring <robh@kernel.org> wrote:

> In theory yes, but reality is pretty much everyone follows it. There's
> no other way to specify active high vs. low for example. Furthermore,
> if someone wanted to do flags in their own custom way, that would
> still work. It is still the controller (or GPIO core) that interprets
> the flags, not the client.
>
> This is a new binding, so only new DT will have it and we can apply
> new standards.

I'd like to get a picture of any one-cell GPIO DTS:es and/or drivers
still around.

I would like to deal with them somehow.

When we started the big DT migration this was one of the areas
we made some screwups in, admittedly, but someone just has to
go first, and that was incidentally GPIO controllers.

At this time people were even playing around with DT bindings in
BNF form, which is why the GPIO binding is a bit .. esoteric
at times. I guess I should fix that.

Yours,
Linus Walleij
