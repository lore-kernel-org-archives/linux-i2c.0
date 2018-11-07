From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
Date: Wed, 7 Nov 2018 16:34:12 +0100
Message-ID: <CAMuHMdUO5_-TsGiu3otuLqNtLNgdnw=1QdKjTzPmSxHp9QotxQ@mail.gmail.com>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
 <1540807618-13246-2-git-send-email-soares@synopsys.com> <20181029134100.GD28520@bombadil.infradead.org>
 <8a71cb94-ccf5-8ec0-446a-37a29405f585@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8a71cb94-ccf5-8ec0-446a-37a29405f585@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitor Soares <vitor.soares@synopsys.com>
Cc: Matthew Wilcox <willy@infradead.org>, Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+>
List-Id: linux-i2c@vger.kernel.org

Hi Vitor,

On Wed, Nov 7, 2018 at 4:15 PM vitor <vitor.soares@synopsys.com> wrote:
> On 29/10/18 13:41, Matthew Wilcox wrote:
> > On Mon, Oct 29, 2018 at 10:06:56AM +0000, Vitor soares wrote:
> >> +config DW_I3C_MASTER
> >> +    tristate "Synospsys DesignWare I3C master driver"
> >> +    depends on I3C
> >> +    depends on !(ALPHA || PARISC)
> > why?
>
> Please check this email thread: https://lkml.org/lkml/2018/10/8/393

Hence this deserves a comment, so we know when/what to do to drop the
dependency:

    depends on  !(ALPHA || PARISC) # needs {read,write}sl()

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
