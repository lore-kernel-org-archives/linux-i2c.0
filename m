From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC v2 2/4] dt-bindings: i2c: mux: demux-pinctrl: add bindings
Date: Wed, 6 Jan 2016 15:30:39 +0100
Message-ID: <CAMuHMdUdxk6yjYAr3i7sjdMa-WJxrbOhsEz3JidY9aZVhaoURw@mail.gmail.com>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
	<1452088285-6427-3-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1452088285-6427-3-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, Jan 6, 2016 at 2:51 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> These bindings allow an I2C bus to switch between multiple masters. This
> is not hot-swichting because connected I2C slaves will be
> re-instantiated. It is meant to select the best I2C core at runtime once
> the task is known. Example: Prefer i2c-gpio over another I2C core
> because of HW errata affetcing your use case.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
> @@ -0,0 +1,155 @@

> +Here is a snipplet for a bus to be demuxed. It contains various i2c clients for

snippet

> +HDMI, so the bus is named "i2c-hdmi":
> +
> +       i2chdmi: i2c@8 {

Would it make sense to call the node "i2c-bus@8"?
> +
> +               compatible = "i2c-demux-pinctrl";
> +               i2c-parent = <&gpioi2c>, <&iic2>, <&i2c2>;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
