From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH/RFC 1/3] dt-bindings: i2c: i2c-gpio: Add support for named gpios
Date: Tue, 19 Sep 2017 15:23:39 -0500
Message-ID: <CAL_JsqLagjVaPgBJmOOFS6yw5axnZaCNbBafJd=r8dtQj-E9Qw@mail.gmail.com>
References: <1503566474-5335-1-git-send-email-geert+renesas@glider.be>
 <1503566474-5335-2-git-send-email-geert+renesas@glider.be>
 <20170831175529.vuchpgvi2aigz2r5@rob-hp-laptop> <CAMuHMdXGm0XuuihG=L_JRBV_WHt2QPtZgdsMFT0PeyDH3ejsNg@mail.gmail.com>
 <CAL_JsqKS++33tOr6PVzX1Fifmn5teaZVYeY0UWeNiAfi=nHetA@mail.gmail.com> <CACRpkdZqEXJBZbOOVy0jNrDX=ayeiquAdXHyMMnNKmFqwELEuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZqEXJBZbOOVy0jNrDX=ayeiquAdXHyMMnNKmFqwELEuw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 18, 2017 at 2:45 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Sep 18, 2017 at 6:52 PM, Rob Herring <robh@kernel.org> wrote:
>
>> In theory yes, but reality is pretty much everyone follows it. There's
>> no other way to specify active high vs. low for example. Furthermore,
>> if someone wanted to do flags in their own custom way, that would
>> still work. It is still the controller (or GPIO core) that interprets
>> the flags, not the client.
>>
>> This is a new binding, so only new DT will have it and we can apply
>> new standards.
>
> I'd like to get a picture of any one-cell GPIO DTS:es and/or drivers
> still around.

$ git grep '#gpio-cells.*1'
Documentation/devicetree/bindings/gpio/gpio.txt:
#gpio-cells = <1>;
Documentation/devicetree/bindings/gpio/spear_spics.txt:  *
#gpio-cells: should be 1 and will mention chip select number
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt:
                 #gpio-cells = <1>;
Documentation/devicetree/bindings/mfd/twl6040.txt:- #gpio-cells = <1>:
twl6040 provides GPO lines.
arch/mips/boot/dts/xilfpga/nexys4ddr.dts:               #gpio-cells = <1>;

...and this one may be out of date. All other instances for Xilinx
gpio use 2 cells.

We also have to look for custom translate functions of which there are
a handful, but they all use standard flags.

>
> I would like to deal with them somehow.

Looks like we already warn in the kernel if <2. Might be worth adding
this to dtc, then I can get the warning without booting a kernel on
platforms I don't have.

> When we started the big DT migration this was one of the areas
> we made some screwups in, admittedly, but someone just has to
> go first, and that was incidentally GPIO controllers.

The move to standardize flags started before the Great ARM Conversion,
so I would have expected some old PPC DTs. But it looks like we are
good.

Rob
