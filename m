From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 11/11] dt-bindings: gpio: Add bindings for Cadence I3C
 gpio expander
Date: Mon, 26 Mar 2018 13:35:53 +0200
Message-ID: <CAMuHMdWXb+eSTG28eKRzfP3mq=KLXikOt94MGNaS+MYeiVdr3w@mail.gmail.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
 <20180323110020.19080-12-boris.brezillon@bootlin.com> <CAMuHMdX3TLmaN14gM4fTgzXwy1dgsMxCFBs_3wCFWM8rX=+8vA@mail.gmail.com>
 <20180326132526.1634946e@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180326132526.1634946e@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian
List-Id: linux-i2c@vger.kernel.org

Hi Boris,

On Mon, Mar 26, 2018 at 1:25 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Mon, 26 Mar 2018 12:12:54 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Fri, Mar 23, 2018 at 12:00 PM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > Document the Cadence I3C gpio expander bindings.
>> >
>> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>>
>> Thanks for your patch!
>>
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
>>
>> > +- #interrupt-cells : Should be 2.  The first cell is the GPIO number.
>> > +  The second cell bits[3:0] is used to specify trigger type and level flags:
>> > +      1 = low-to-high edge triggered.
>> > +      2 = high-to-low edge triggered.
>> > +      3 = triggered on both edges.
>> > +      4 = active high level-sensitive.
>> > +      8 = active low level-sensitive.
>>
>> These are identical to the values in <dt-bindings/interrupt-controller/irq.h>.
>> Perhaps you can refer to those definitions?
>
> Well, I'm not sure this is allowed since DT bindings docs are
> supposed to be OS-agnostic and macros defined in
> <dt-bindings/interrupt-controller/irq.h> are, AFAIK, only available to
> Linux.

If they're under include/dt-bindings/, they're part of the DT bindings.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
