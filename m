From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v7 01/10] i3c: Add core I3C infrastructure
Date: Thu, 6 Sep 2018 16:00:48 +0200
Message-ID: <20180906160048.2f585e2b@bbrezillon>
References: <20180905154108.20770-1-boris.brezillon@bootlin.com>
        <20180905154108.20770-2-boris.brezillon@bootlin.com>
        <CAK8P3a3EkwAXin=s1bak7V7xM7zqip_Q6GMpxB-b1BD931G6cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3EkwAXin=s1bak7V7xM7zqip_Q6GMpxB-b1BD931G6cA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@he>
List-Id: linux-i2c@vger.kernel.org

On Thu, 6 Sep 2018 15:38:49 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Sep 5, 2018 at 5:41 PM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> 
> > ---
> > Changes in v7:
> > - Stop representing the I3C master as a device under the I3C bus
> > - Enforce a 1:1 relationship between i3c_bus and i3c_master_controller
> >   objects  
> 
> Thanks for implementing those changes. What is your feeling so far
> about the difference? Has it gotten much simpler as I was hoping?

Hm, to be honest I don't see a big difference in term of simplicity,
but that's probably because I kept the bus/master concepts separated
(even if the 1:1 relationship is enforced).

> 
> I definitely like this version much better. I have found a couple of
> things that I point out below that could be improved (or me being
> proven wrong on them), but overall I think it looks great and I don't
> see major issues.
> 
> Great work!

Thanks, I'm glad you think these changes go in the right direction. Will
try to address your new comments.

> 
> > +struct i3c_bus *i3c_bus_create(struct i3c_master_controller *master)
> > +{
> > +       struct i3c_bus *i3cbus;
> > +       int ret;
> > +
> > +       i3cbus = kzalloc(sizeof(*i3cbus), GFP_KERNEL);
> > +       if (!i3cbus)
> > +               return ERR_PTR(-ENOMEM);  
> 
> I find it a bit confusing to have separate i3c_master_controller
> and i3c_bus structures with this version. Why not merge the
> two structures into one now and move the bus management
> into master.c?

Yes, I considered this approach. Not sure it would make the whole code a
lot simpler though, and it was definitely more work on my side, so I
decided to delay that and wait for someone to explicitly request this
change ;-).

I also like the bus/master separation in that it allows one to clearly
identify the properties that are bus (speed, mode, ...) related and
those that are master controller oriented (PID, DCR, ...).

> 
> > +static int i3c_master_attach_i3c_dev(struct i3c_master_controller *master,
> > +                                    struct i3c_dev_desc *dev)
> > +{
> > +       int ret;
> > +
> > +       /*
> > +        * We don't attach devices to the controller until they are
> > +        * addressable on the bus.
> > +  
> 
> Apparently the new gmail version decided to cut off the second half of your
> email after this line when I hit reply, which makes it much harder for me
> to continue a proper review. I fear I'll have to get a real email client
> again :(
> 
> > + * The I3C bus is represented with its own object and not implicitly described
> > + * by the I3C master to cope with the multi-master functionality, where one bus
> > + * can be shared amongst several masters, each of them requesting bus ownership
> > + * when they need to.  
> 
> This comment is now stale, even without merging the structures, right?

Yep, it is. I'll drop it.

> 
> > +struct i3c_master_controller {
> > +       struct device *parent;
> > +       struct i3c_dev_desc *this;
> > +       struct i2c_adapter i2c;  
> 
> I think the 'parent' pointer is better omitted, it should always be
> the same as master->dev->parent, right?

Absolutely.

> 
> Since it contains an i2c_adapter, maybe a good name for the
> combined i3c_master_controller+i3c_bus structure would
> be 'i3c_adapter'?

Hm, I'd really like to keep the name master and not adapter, just
because that's how it's named in the spec.

> 
> +#define i3c_bus_for_each_i2cdev(bus, dev)                              \
> +       list_for_each_entry(dev, &(bus)->devs.i2c, common.node)
> +
> +#define i3c_bus_for_each_i3cdev(bus, dev)                              \
> +       list_for_each_entry(dev, &(bus)->devs.i3c, common.node)
> 
> I wonder if it would simplify things to drop the i2c and i3c
> device lists and instead implement these for_each loops
> based on device_for_each_child() with a check of the
> bus_type==&i2c_bus/&i3c_bus.

We don't store i3c/i3c_device objects in those lists, but
i3c/i2c_dev_desc objects, so device_for_each_child() won't work.
Remember that i3c devs can be present but not registered yet, and we
need to have those representations somehow attached to the master/bus.

Regarding the possibility of merging those 2 lists together, we could
do it, but I find it simpler to have them separated.

> That might help with locking
> and keeping the two lists synchronized, which may or
> may not be a problem here.

Regarding the locking aspects. Anything touching those lists is either
init code (which should be serialized) or DAA related, which requires
the bus lock to be held in write mode (exclusive access mode). Do you
see any other possible race?

Thanks,

Boris
