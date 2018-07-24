From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Tue, 24 Jul 2018 22:21:20 +0200
Message-ID: <CAK8P3a1NWo11JzR6wEk_fcQFoJBmJwA1ynjHdCnEK8PF4Q2-=Q@mail.gmail.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se> <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <20180720151751.242d4809@bbrezillon> <CAK8P3a14_6uf9VLYU0YnmFp0Q=DZBKc0cAesBh0opanGDZMFRA@mail.gmail.com>
 <20180724162806.318a92c6@bbrezillon> <CAK8P3a3YQbiiJMTHTVh63fOvtA1sa0J5Eb4z7xbnpBPwUDkqxg@mail.gmail.com>
 <CAMuHMdXif_iufXx0Y+UJjKs9TNLfrTONoFvUSyrpkfaT0=ydRQ@mail.gmail.com>
 <CAK8P3a0jc1k9weTNbqSJXkCSFefus9OPyU5_v5=mTFxiDd0q5Q@mail.gmail.com>
 <CAMuHMdXJ_FGXXwNx8h0ZfskJGRWES1xLuTQpD59Vw1Smp6FTRg@mail.gmail.com>
 <CAK8P3a17t=_o04GsowS2RnTwKKVxt8KuJtT36N=Ea-SOq7fTow@mail.gmail.com>
 <20180724181437.1d1b27a8@bbrezillon> <CAK8P3a0wcmeFKvRf7=FTNvePayc2AxniHoNkLOuzQQCt=MiLjQ@mail.gmail.com>
 <20180724185415.6126751e@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724185415.6126751e@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 24, 2018 at 6:54 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Tue, 24 Jul 2018 18:25:22 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Tue, Jul 24, 2018 at 6:14 PM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > On Tue, 24 Jul 2018 17:58:29 +0200
>> > Arnd Bergmann <arnd@arndb.de> wrote:
>> >> or what specific scenario would require it.
>> >
>> > I think I described a scenario (masters having different
>> > capabilities all connected to the same bus), though I don't know how
>> > likely this use case is :-/.
>>
>> I was looking for something more specific here. What (lack of)
>> capabilities could two i3c controllers have that require you to
>> use both of them for the same device, rather than picking
>> a master for each slave with the right feature set?
>
> Hehe, if I had a clear answer to this question we wouldn't have this
> discussion :-). I gave you an example:
>
> - master A supporting IBIs but not HDR transactions
> - master B supporting HDR modes but not IBIs
>
> but as I said, I'm not sure how likely this example is...

I'd say for a specific example like that, the person that did the
SoC integration should find a new job outside of hardware
design ;-)

I suppose the point is really that this is only preparation for something
completely unexpected, and any specific example one could come
up with is very unlikely to occur in real hardware.

> The question is more, should we design things so that we can at some
> point implement a solution to support those funky setups, or should we
> just ignore it and risk breaking sysfs/DT ABI when/if we have to support
> that?
>
> This is really an open question. I initially went for the former, but
> have no objection switching to the latter.

For me it's mainly a feeling that the risk of something going wrong
with the current design is bigger than it actually solving problems
we will encounter later. I hope that when you do a v7 version for
comparison, I'll be able to pinpoint specific aspects that are better
rather than being that unspecific. (note: I'll be on vacation next
week and won't be able to review it until I'm back).

Let me try to summarize the points made so far:

1. If we need a way for dynamic handover between two of our
    own masters and are not prepared for it now, some hardware
    designs may end up being unusable junk. Hopefully those
    cases are rare and found early during design when the hardware
    can still be changed to something that works.

2. If we design a system that does allow that handover and we don't
    need it, the biggest risk is introducing complexity in the system
    that makes it harder to use and debug for everyone.

3. The case where we have two masters on a bus, but each
    slave is only ever driven by one master can easily be added
    later, by adding some DT description for that machine as I
    described, but no extra code or DT bindings, or reprobing
    of devices during handover.

4. Handing over between an i2c master and an i3c master cannot
    be done with the current design either way, and could only ever
    work in very limited scenarios. The same is true for i3c masters
    that can be connected to the same bus, but not at the same
    time (like the case with multiplexed i2c masters today).

5. The debug scenario that Wolfram described might be handled
    with a separate bus structure and handing over behind the
    curtains, but does not require it to be done without a reprobe.
    I can imagine several other (simpler) designs that would allow
    doing this.

        Arnd
