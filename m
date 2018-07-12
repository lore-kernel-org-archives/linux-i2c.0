From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Date: Thu, 12 Jul 2018 10:46:58 +0200
Message-ID: <20180712104658.220ef8f6@bbrezillon>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180330074751.25987-2-boris.brezillon@bootlin.com>
        <CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com>
        <20180711164120.3e32fb08@bbrezillon>
        <CAK8P3a2EZB_tMS_47wv6M2Qpm79ZocxxhG5zLxXsBM_YjZgkyA@mail.gmail.com>
        <20180711191212.3855bb25@bbrezillon>
        <CAK8P3a2djk8c6STaxJC0MCkBddyOafk4WbG2LdfPf0V1EYiqmQ@mail.gmail.com>
        <20180712000932.3b04ee9d@bbrezillon>
        <CAK8P3a13GX67YEci2J8Rxn6O4FBjjD82X+w3hyGMT3TDbtFkTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a13GX67YEci2J8Rxn6O4FBjjD82X+w3hyGMT3TDbtFkTg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.or>
List-Id: linux-i2c@vger.kernel.org

On Thu, 12 Jul 2018 10:21:40 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thu, Jul 12, 2018 at 12:09 AM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Wed, 11 Jul 2018 22:10:26 +0200 Arnd Bergmann <arnd@arndb.de> wrote:  
> >> On Wed, Jul 11, 2018 at 7:12 PM, Boris Brezillon <boris.brezillon@bootlin.com> wrote:  
> >> > On Wed, 11 Jul 2018 17:39:56 +0200 Arnd Bergmann <arnd@arndb.de> wrote:  
> >> >> On Wed, Jul 11, 2018 at 4:41 PM, Boris Brezillon <boris.brezillon@bootlin.com> wrote:  
> 
> >> >> IOW, what feature would we lose if we were to declare that
> >> >> setup above invalid (and ensure you cannot represent it in DT)?  
> >> >
> >> > That's exactly the sort of discussion I wanted to trigger. Maybe we
> >> > shouldn't care and expose this use case as if it was X different I3C
> >> > buses (with all devices present on the bus being exposed X times
> >> > to the system).  
> >>
> >> That's probably fine for many slave devices (you could read a
> >> single sensor multiple times if you iterate through all i2c sensors
> >> on all buses) but might not work for others (a slave device sending
> >> an interrupt to the current master for a request that was started
> >> from the previous master).
> >> My impression however is that this is actually a corner case that
> >> we can leave to be undefined, and not prepare to handle well,
> >> as long as we can deal with the interesting examples above.  
> >
> > Mastership handover/takeover is something I already thought about.
> > Actually, that's the reason for the i3c_bus->cur_master field (so that
> > the master being asked to do a transfer on the bus can request bus
> > ownership it bus->cur_master != master->this->info.pid).
> >
> > I guess this would be replaced by something simpler if we get rid of
> > the i3c_bus object (just a bool i3c_master->owns_bus).  
> 
> If we can ignore the case of handing over between two masters that
> we both own, we end up being in just one of two states:
> 
> a) currently we are the master
> b) we are not currently the master but have asked the current
>     master to transfer ownership back to us. For this, we have to
>     know who the current master is of course.
> 
> I think that's the simplest case that would work with the specification,
> but it relies on the assumption that the master controlled by Linux
> is always more important than any other master, and that we just
> hand over ownership for as long as the others want it.
> 
> If that is not the case, we also need a third state
> 
> c) we have handed ownership to another master that is equally
>     important, but no i2c device driver is currently trying to talk
>     to a device, so we don't need ownership back until a slave driver
>     changes state.

That was the solution I was opting for.

> 
> The main difference between b) and c) that I see would be what
> happens with in-band interrupts. If I understand the specification
> correctly, only the current master receives them, so if you have
> any i2c device that uses interrupts to talk to a Linux driver, we

      ^ you mean i3c here, right?

> want to be in b) rather than c). An example of this would be
> an input device on a PC: If the user operateds the keyboard
> or pointer and we have handed off ownership to a sensor hub,
> we never get an input event, right?

Correct. I guess we could try to regain bus ownership in case we have
IBIs enabled. Or we let the secondary master give the bus back to us
when it sees IBIs it can't handle, as described in section 5.1.7:

"
Once granted control of the Bus, the Secondary Master maintains
control until another Master is granted Bus control. After the
Secondary Master transitions to the Current Master role it could
encounter Bus management activities besides the data transfers that it
itself initiates. Some examples are the In-Band Interrupt, or the
Hot-Join request. One optional possibility, shown at Section 5.1.7.2,
is that the Secondary Master performs the Current Master’s actions with
the full capabilities of the Main Master. Another optional possibility
is that the Secondary Master, while serving in the Current Master role,
could defer some actions to a more capable Master, as described in
Section 5.1.7.3.
"

> 
> >> Ok, but maybe you could you put the information about those devices
> >> on a local list on the stack rather than the controller? I suppose this
> >> would not change the logic much, but it would slightly simplify the
> >> data structures for the bus and stop others from wondering about
> >> them. ;-)  
> >
> > This has changed a bit in the v6 I'm about to send (probably next week).
> > I now have 2 different objects which do not necessarily have the same
> > lifetime:
> >
> > * i3c_dev_desc: an I3C device descriptor. This is the representation
> >   exposed to I3C master controller drivers which usually reserve one
> >   slot in the HW device table per-device on the bus. Since the same
> >   device can be re-discovered with a different address, we have a short
> >   period in time during which the controller will have 2
> >   slots/descriptors used to control the same device, except one would
> >   be inactive (any transfer to the old dynamic address would fail) and
> >   the other one would be active. The core then takes care of releasing
> >   the old descriptor/slot and attaching the new one to the i3c_device
> >   object exposed to I3C device drivers
> >
> > * i3c_device: this is the object exposed to I3C device drivers. It's
> >   lifetime is usually the same as the i3c_dev_desc it's attached to,
> >   except when the device lose its dynamic address and get a new one
> >   assigned. In this case we keep the same i3c_device object, but
> >   dynamically re-attach it to a new i3c_dev_desc before releasing the
> >   old dev desc. This way the I3C does not even see that the device
> >   address has changed and can keep doing transfers to it.
> >
> > With these 2 distinct representations, the handling on the controller
> > side is greatly simplified: the core takes care of the resource
> > migration steps, while it was up to the controller to do that my
> > previous versions (look at the ->reattach_i3c_dev() hook in the Cadence
> > driver, and I think it's even more complicated with other controllers,
> > like the HCI one).
> >  
> >> This is a really minor point though, let's work out the problem of the
> >> multiple masters first.  
> >
> > I agree. This being said, moving to a representation where the bus is
> > implicitly represented by the master_controller instance shouldn't be
> > too difficult. So, if you think we should try this approach I can do
> > the modifications in my v6.  
> 
> I'd say let's wait before you do that change, possibly add a comment
> in there now to remind us of what an alternative would be.

You mean I should keep the i3c_bus object?
