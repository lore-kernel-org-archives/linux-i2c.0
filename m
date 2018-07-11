From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 07/10] i3c: master: Add driver for Cadence IP
Date: Wed, 11 Jul 2018 16:19:51 +0200
Message-ID: <CAK8P3a1D_crzMT8-2R9bMvMuq8F58=BgHUFSq2nntRHF0sZUQg@mail.gmail.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com> <20180622104930.32050-8-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180622104930.32050-8-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.or>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 22, 2018 at 12:49 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Add a driver for Cadence I3C master IP.

The driver seems very well-written and shows that the framework got that side
of the interface right. Just one thing I noticed:

> +
> +static void cdns_i3c_master_handle_ibi(struct cdns_i3c_master *master,
> +                                      u32 ibir)

> +
> +       for (i = 0; i < IBIR_XFER_BYTES(ibir); i += 4) {
> +               u32 tmp = readl(master->regs + IBI_DATA_FIFO);
> +
> +               for (j = 0; j < 4 && i + j < dev->ibi->max_payload_len; j++)
> +                       buf[i + j] = tmp >> (j * 8);
> +       }

This seems to be a rather inefficient way to open-code a readsl().
I suppose you need to handle length that is not a multiple of 4, right?

Maybe do it like

      size_t length = IBIR_XFER_BYTES(ibir);
      readsl(master->regs + IBI_DATA_FIFO, buf, length & ~3);
      if (length & 3) {
            u32 tmp = __raw_readl(master->regs + IBI_DATA_FIFO);
            memcpy(buf + length & ~3, length & 3);
      }

     Arnd
