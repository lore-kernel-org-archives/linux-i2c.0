From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Fri, 20 Jul 2018 13:13:49 +0200
Message-ID: <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
 <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetr>
List-Id: linux-i2c@vger.kernel.org

On 2018-07-20 12:57, Arnd Bergmann wrote:
> * What I understand from reading i2c-demux-pinctrl.c, a slave device
>   will only ever be observable from one master at a time, when you
>   switch over, all children get removed on one master and added to
>   the other one, to be probed again by their respective drivers.
>   I can see this as a useful feature on i3c as well, in particular to
>   deal with the situation where we have i2c slaves connected to a
>   pinmux that can switch them between an i3c master and an
>   i2c-only master (possibly a gpio based one). That particular use
>   case however doesn't seem to fix well in the current code, which
>   is structure around i3c buses.

It's pretty easy to come up with examples where this reprobing is
not desirable at all. E.g. if one of the involved I2C devices is
a HDMI encoder (I have a TDA19988 here) sitting in the middle of the
graphics pipeline. Blink-blink on the screen because some *other*
unrelated device needed to be accessed by an alternative master. Not
pretty.

(No, I don't suffer from this since I don't need the demuxer. Which is
fortunate. This was just an example, I'm sure there are others.)

Cheers,
Peter
