From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Mon, 12 Aug 2019 13:07:25 +0200
Message-ID: <CAMuHMdUum4Dubx8EOsSakaNfLp4-Yyzsutfkvb_+i5mqtOtkKw@mail.gmail.com>
References: <20190811043253.24938-1-max@enpas.org> <CAMuHMdVJJxjH-gPraW==smrkOOMcGYPKB8BPzrYPU4bstASX3A@mail.gmail.com>
 <fe5cf25f-1804-dc45-7010-01e602b3f3e5@enpas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fe5cf25f-1804-dc45-7010-01e602b3f3e5@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

Hi Max,

On Mon, Aug 12, 2019 at 12:43 PM Max Staudt <max@enpas.org> wrote:
> On 08/12/2019 11:37 AM, Geert Uytterhoeven wrote:
> >> +       /*
> >> +        * The 2019 a1k.org PCBs have an LTC2990 at 0x4c, so start
> >> +        * it automatically once ltc2990 is modprobed.
> >> +        *
> >> +        * in0 is the voltage of the internal 5V power supply.
> >> +        * temp1 is the temperature inside the chip.
> >> +        *
> >> +        * Configuration 0x18 enables all sensors on this PCB:
> >> +        *  # modprobe i2c-dev
> >> +        *  # i2cset 0 0x4c 1 0x18
> >
> > What's the reason for the i2cset command?
>
> It sets the sensor modes in the LTC2990 and enables the three sensors listed below. I should have clarified this.
>
> I tried to integrate this in the driver, but ltc2990 only allows reading this configuration out of a device tree. Is there a good way to fake a DT entry in the init function?

You can add platform_data support to the ltc2990 driver, and pass it
through i2c_board_info.platform_data.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
