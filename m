From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Date: Thu, 12 Jul 2018 12:03:05 +0200
Message-ID: <CAK8P3a3raE9rmyvgxR0YVmYSCN4tumYS1TCexCuTEUXjy_9kSw@mail.gmail.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-2-boris.brezillon@bootlin.com> <CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com>
 <20180711164120.3e32fb08@bbrezillon> <CAK8P3a2EZB_tMS_47wv6M2Qpm79ZocxxhG5zLxXsBM_YjZgkyA@mail.gmail.com>
 <20180711191212.3855bb25@bbrezillon> <CAK8P3a2djk8c6STaxJC0MCkBddyOafk4WbG2LdfPf0V1EYiqmQ@mail.gmail.com>
 <20180712000932.3b04ee9d@bbrezillon> <CAK8P3a13GX67YEci2J8Rxn6O4FBjjD82X+w3hyGMT3TDbtFkTg@mail.gmail.com>
 <20180712104658.220ef8f6@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712104658.220ef8f6@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.or>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 12, 2018 at 10:46 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Thu, 12 Jul 2018 10:21:40 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Jul 12, 2018 at 12:09 AM, Boris Brezillon <boris.brezillon@bootl=
in.com> wrote:
>> > On Wed, 11 Jul 2018 22:10:26 +0200 Arnd Bergmann <arnd@arndb.de> wrote=
:
>> >> On Wed, Jul 11, 2018 at 7:12 PM, Boris Brezillon <boris.brezillon@boo=
tlin.com> wrote:
>> >> > On Wed, 11 Jul 2018 17:39:56 +0200 Arnd Bergmann <arnd@arndb.de> wr=
ote:
>> >> >> On Wed, Jul 11, 2018 at 4:41 PM, Boris Brezillon <boris.brezillon@=
bootlin.com> wrote:
>>
>> If we can ignore the case of handing over between two masters that
>> we both own, we end up being in just one of two states:
>>
>> a) currently we are the master
>> b) we are not currently the master but have asked the current
>>     master to transfer ownership back to us. For this, we have to
>>     know who the current master is of course.
>>
>> I think that's the simplest case that would work with the specification,
>> but it relies on the assumption that the master controlled by Linux
>> is always more important than any other master, and that we just
>> hand over ownership for as long as the others want it.
>>
>> If that is not the case, we also need a third state
>>
>> c) we have handed ownership to another master that is equally
>>     important, but no i2c device driver is currently trying to talk
>>     to a device, so we don't need ownership back until a slave driver
>>     changes state.
>
> That was the solution I was opting for.
>
>>
>> The main difference between b) and c) that I see would be what
>> happens with in-band interrupts. If I understand the specification
>> correctly, only the current master receives them, so if you have
>> any i2c device that uses interrupts to talk to a Linux driver, we
>
>       ^ you mean i3c here, right?

sure

>> want to be in b) rather than c). An example of this would be
>> an input device on a PC: If the user operateds the keyboard
>> or pointer and we have handed off ownership to a sensor hub,
>> we never get an input event, right?
>
> Correct. I guess we could try to regain bus ownership in case we have
> IBIs enabled. Or we let the secondary master give the bus back to us
> when it sees IBIs it can't handle, as described in section 5.1.7:
>
> "
> Once granted control of the Bus, the Secondary Master maintains
> control until another Master is granted Bus control. After the
> Secondary Master transitions to the Current Master role it could
> encounter Bus management activities besides the data transfers that it
> itself initiates. Some examples are the In-Band Interrupt, or the
> Hot-Join request. One optional possibility, shown at Section 5.1.7.2,
> is that the Secondary Master performs the Current Master=E2=80=99s action=
s with
> the full capabilities of the Main Master. Another optional possibility
> is that the Secondary Master, while serving in the Current Master role,
> could defer some actions to a more capable Master, as described in
> Section 5.1.7.3.
> "

Ah, so the current master can ask a secondary master to take over
again even if  the secondary master has not requested to be come the
current master?

>> > I agree. This being said, moving to a representation where the bus is
>> > implicitly represented by the master_controller instance shouldn't be
>> > too difficult. So, if you think we should try this approach I can do
>> > the modifications in my v6.
>>
>> I'd say let's wait before you do that change, possibly add a comment
>> in there now to remind us of what an alternative would be.
>
> You mean I should keep the i3c_bus object?

I mean the ongoing discussion shouldn't stop you from posting a v6.

        Arnd
