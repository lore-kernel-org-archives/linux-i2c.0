From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Date: Thu, 12 Jul 2018 10:08:05 +0200
Message-ID: <CAK8P3a2oMDw2zHzE5vFFHDqzKVKEzOga6v0ExdYVawnMtcdbrQ@mail.gmail.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-2-boris.brezillon@bootlin.com> <CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com>
 <20180711164120.3e32fb08@bbrezillon> <CAK8P3a2EZB_tMS_47wv6M2Qpm79ZocxxhG5zLxXsBM_YjZgkyA@mail.gmail.com>
 <20180711191212.3855bb25@bbrezillon> <a31dc625-56bf-7a59-d9a3-2841360b864e@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a31dc625-56bf-7a59-d9a3-2841360b864e@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@ar>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 12, 2018 at 6:41 AM, Peter Rosin <peda@axentia.se> wrote:
> On 2018-07-11 19:12, Boris Brezillon wrote:
>> On Wed, 11 Jul 2018 17:39:56 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> That's exactly the sort of discussion I wanted to trigger. Maybe we
>> shouldn't care and expose this use case as if it was X different I3C
>> buses (with all devices present on the bus being exposed X times to the
>> system).
>
> For I2C, this multiple masters for one bus case was retrofitted in
> the i2c-demux-pinctrl driver. It's a huge kludge with a number of
> undesirable quirks. I don't know if the circumstances for adding
> this I2C driver also applies for I3C, but it might be an argument
> in favor of the proposed extra bus object...

>From reading the documentation and git history on that driver,
it seems to be used only for static configuration, i.e. you use
one driver or the other, but don't flip between them at runtime,
right?

I'm guessing that even with i3c we may have to support something
like that, as a likely scenario might be that the i3c controller is
multiplexed with a traditional i2c controller and/or gpios, but you
would not be able to perform the i3c standard secondary master
transition with the latter two because they are (by definition) not
i3c compatible.

       Arnd
