From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 01/10] i3c: Add core I3C infrastructure
Date: Wed, 11 Jul 2018 16:05:58 +0200
Message-ID: <CAK8P3a2Z_oiAKDsawZn_R=V-HPy1pPYsd6Jquh6bVUEfuQ+Eug@mail.gmail.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com> <20180622104930.32050-2-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180622104930.32050-2-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.or>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 22, 2018 at 12:49 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Add core infrastructure to support I3C in Linux and document it.
>
> This infrastructure is not complete yet and will be extended over
> time.
>
> There are a few design choices that are worth mentioning because they
> impact the way I3C device drivers can interact with their devices..

I just realized I replied to the wrong version when I reviewed v4 of this
patch. I think most of my comments still apply, so please see

https://lore.kernel.org/lkml/CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com/T/#u

and ignore anything that has changed in the meantime.

     Arnd
