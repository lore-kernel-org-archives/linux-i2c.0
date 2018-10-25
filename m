From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 6/9] i3c: master: Add driver for Cadence IP
Date: Thu, 25 Oct 2018 18:13:51 +0200
Message-ID: <CAK8P3a02ELWiMB_pe0bzbsMfdqYOG1G0bFnSHzGu3ZbQHatH2w@mail.gmail.com>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
 <20181022133404.2061-7-boris.brezillon@bootlin.com> <20181024202048.7e3534f7@bbrezillon>
 <CAK8P3a2DBgfvXs-9KzoDvbQpV+VN96xb7xHG-5=NDDgnt7ViVQ@mail.gmail.com> <20181025180720.1790f6a1@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025180720.1790f6a1@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@he>
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 25, 2018 at 6:07 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Thu, 25 Oct 2018 17:30:26 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > On 10/24/18, Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > > Hi Arnd,
> > >
> > > On Mon, 22 Oct 2018 15:34:01 +0200
> > > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > >
> > >
> > >> +
> > >> +static void cdns_i3c_master_rd_from_rx_fifo(struct cdns_i3c_master
> > >> *master,
> > >> +                                      u8 *bytes, int nbytes)
> > >> +{
> > >> +  readsl(master->regs + RX_FIFO, bytes, nbytes / 4);
> > >
> > > Vitor reported a problem with readsl(): this function expects the 2nd
> > > argument to be aligned on 32-bit, which is not guaranteed here. Unless
> > > you see a better solution, I'll switch back to a loop doing:
> > >
> > >     for (i = 0; i < nbytes; i += 4) {
> > >             u32 tmp = __raw_readl(...);
> > >             memcpy(bytes + i, &tmp,
> > >                    nbytes - i  > 4 ? 4 : nbytes - i);
> > >     }
> >
> > Could we maybe mandate that the buffer itself must be aligned here?
> > What would be a reason why we see an unaligned target buffer?
>
> Well, the buffers we pass to i3c_send_ccc_cmd() are not necessarily
> aligned because they're not dynamically allocated (allocated on the
> stack) and are not naturally aligned on 32-bits (either because they
> are smaller than 32bits or because the struct is declared __packed).
>
> I guess I could dynamically allocate the payload, but that requires
> going over all users of i3c_send_ccc_cmd() to patch them.

This reminds me that Wolfram mentioned in his ELC talk that the
buffers on i3c should all be DMA capable to make life easier for
i3c master drivers that want to implement DMA transfers.

If we have buffers here that are not aligned to cache lines
(or even just 32 bit words), doesn't that also mean that the
same buffers are not DMA capable either?

        Arnd
