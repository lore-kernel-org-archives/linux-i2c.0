From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Tue, 24 Jul 2018 18:25:22 +0200
Message-ID: <CAK8P3a0wcmeFKvRf7=FTNvePayc2AxniHoNkLOuzQQCt=MiLjQ@mail.gmail.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se> <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <20180720151751.242d4809@bbrezillon> <CAK8P3a14_6uf9VLYU0YnmFp0Q=DZBKc0cAesBh0opanGDZMFRA@mail.gmail.com>
 <20180724162806.318a92c6@bbrezillon> <CAK8P3a3YQbiiJMTHTVh63fOvtA1sa0J5Eb4z7xbnpBPwUDkqxg@mail.gmail.com>
 <CAMuHMdXif_iufXx0Y+UJjKs9TNLfrTONoFvUSyrpkfaT0=ydRQ@mail.gmail.com>
 <CAK8P3a0jc1k9weTNbqSJXkCSFefus9OPyU5_v5=mTFxiDd0q5Q@mail.gmail.com>
 <CAMuHMdXJ_FGXXwNx8h0ZfskJGRWES1xLuTQpD59Vw1Smp6FTRg@mail.gmail.com>
 <CAK8P3a17t=_o04GsowS2RnTwKKVxt8KuJtT36N=Ea-SOq7fTow@mail.gmail.com> <20180724181437.1d1b27a8@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724181437.1d1b27a8@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 24, 2018 at 6:14 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Tue, 24 Jul 2018 17:58:29 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Tue, Jul 24, 2018 at 5:46 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > On Tue, Jul 24, 2018 at 5:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> >> On Tue, Jul 24, 2018 at 5:15 PM, Geert Uytterhoeven
>> >> <geert@linux-m68k.org> wrote:
>> >> > On Tue, Jul 24, 2018 at 5:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> The second case is the one that started the discussion, and
>> this is where I said I'd prefer to associate each slave with at
>> most one master at boot time, while the current v6 patch
>> is prepared for having one slave be accessed alternatingly
>> by multiple masters using the master handover, though so
>> far nobody has been able to describe exactly how we'd pick
>> which master is active at what point,
>
> Even if it's not yet implemented, I have everything in place to figure
> this out (see the ->cur_master field in the i3c_bus object). Now,
> what's missing is a list of possible masters attached to an i3c device
> so that the framework can pick the most appropriate one at runtime and
> initiate mastership handover if required (if the selected master is not
> the currently active one).
>
> The selection logic should look like this:
>
>         if (active_master supports requested feature)
>                 use active master
>         else
>                 pick an inactive one that has relevant caps and initiate
>                 mastership handover (+ update bus->cur_master)

How would you deal with soft requirements like performance?
E.g. if you have one master that can do large transfers faster
through a special DMA engine, and other master that can
be faster for small transfers, but both support all capabilities
for that device, won't you need some complex logic to avoid
being stuck with a slow master indefinitely?

>> or what specific scenario
>> would require it.
>
> I think I described a scenario (masters having different
> capabilities all connected to the same bus), though I don't know how
> likely this use case is :-/.

I was looking for something more specific here. What (lack of)
capabilities could two i3c controllers have that require you to
use both of them for the same device, rather than picking
a master for each slave with the right feature set?

     Arnd
