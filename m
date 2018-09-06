From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 01/10] i3c: Add core I3C infrastructure
Date: Thu, 6 Sep 2018 17:15:16 +0200
Message-ID: <CAK8P3a1OV_w5br=fkQjY-xOUa_u3j+8P2=9MRLzpQqLfWpSaBA@mail.gmail.com>
References: <20180905154108.20770-1-boris.brezillon@bootlin.com>
 <20180905154108.20770-2-boris.brezillon@bootlin.com> <CAK8P3a3EkwAXin=s1bak7V7xM7zqip_Q6GMpxB-b1BD931G6cA@mail.gmail.com>
 <20180906160048.2f585e2b@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906160048.2f585e2b@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@he>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 6, 2018 at 4:01 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Thu, 6 Sep 2018 15:38:49 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Sep 5, 2018 at 5:41 PM Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> >
> > > +struct i3c_bus *i3c_bus_create(struct i3c_master_controller *master)
> > > +{
> > > +       struct i3c_bus *i3cbus;
> > > +       int ret;
> > > +
> > > +       i3cbus = kzalloc(sizeof(*i3cbus), GFP_KERNEL);
> > > +       if (!i3cbus)
> > > +               return ERR_PTR(-ENOMEM);
> >
> > I find it a bit confusing to have separate i3c_master_controller
> > and i3c_bus structures with this version. Why not merge the
> > two structures into one now and move the bus management
> > into master.c?
>
> Yes, I considered this approach. Not sure it would make the whole code a
> lot simpler though, and it was definitely more work on my side, so I
> decided to delay that and wait for someone to explicitly request this
> change ;-).
>
> I also like the bus/master separation in that it allows one to clearly
> identify the properties that are bus (speed, mode, ...) related and
> those that are master controller oriented (PID, DCR, ...).

Maybe you could make the bus a member of the master rather
than a pointer from it?

That would still let us avoid the separate dynamic allocations,
and not having to worry about separate lifetime rules for the
two, but also group the bus properties together a bit more
as you said. It can also have code deal with the the bus object
without including the structure definition of the master (if that
is desirable).

> > Since it contains an i2c_adapter, maybe a good name for the
> > combined i3c_master_controller+i3c_bus structure would
> > be 'i3c_adapter'?
>
> Hm, I'd really like to keep the name master and not adapter, just
> because that's how it's named in the spec.

Fair enough.

> We don't store i3c/i3c_device objects in those lists, but
> i3c/i2c_dev_desc objects, so device_for_each_child() won't work.
> Remember that i3c devs can be present but not registered yet, and we
> need to have those representations somehow attached to the master/bus.

Ah right, I remember you explained that before.

> Regarding the possibility of merging those 2 lists together, we could
> do it, but I find it simpler to have them separated.

Agreed. It would only make sense if we had the combined list already.

> > That might help with locking
> > and keeping the two lists synchronized, which may or
> > may not be a problem here.
>
> Regarding the locking aspects. Anything touching those lists is either
> init code (which should be serialized) or DAA related, which requires
> the bus lock to be held in write mode (exclusive access mode). Do you
> see any other possible race?

No, nothing specific, it was just a general feeling.

        Arnd
