From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Thu, 3 Aug 2017 10:03:34 +0200
Message-ID: <20170803100334.64988a66@bbrezillon>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
        <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
        <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
        <20170731231509.77d1fba4@bbrezillon>
        <CAK8P3a0p=m-8U7TN8usG8HO-QNu_S7rSfykNzu4gm+MOaM2Kzg@mail.gmail.com>
        <20170801142936.5df48702@bbrezillon>
        <CAK8P3a0SH4kWcvXK+_iPt9LWuNnpjr+omp+ZpyTLjT=H602n+w@mail.gmail.com>
        <20170801153414.6ce34ee8@bbrezillon>
        <20170801141218.GA1450@katana>
        <20170801164826.423183ff@bbrezillon>
        <20170801150108.GC1450@katana>
        <20170801172041.30aaac2e@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170801172041.30aaac2e@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Przemyslaw Sroka <psroka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Arkadiusz Golec <agolec-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alan Douglas <adouglas-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Bartosz Folta <bfolta-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Damian Kos <dkos-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alicja Jurasik-Urbaniak <alicja-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Jan Kotas <jank-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Cyprian Wronka <cwronka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar
List-Id: linux-i2c@vger.kernel.org

On Tue, 1 Aug 2017 17:20:41 +0200
Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> On Tue, 1 Aug 2017 17:01:08 +0200
> Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> 
> > > I do not know of any real devices as of today (all my tests have been
> > > done with a dummy/fake I3C slaves emulated with a slave IP),    
> > 
> > I see.
> >   
> > > spec clearly describe what legacy/static addresses are for and one of
> > > their use case is to connect an I3C device on an I2C bus and let it act
> > > as an I2C device.    
> > 
> > OK. That makes it more likely.
> >   
> > > Unless you want your device (likely a sensor) to be compatible with both
> > > I3C and I2C so that you can target even more people.    
> > 
> > Right. My question was if this is a realistic or more academic scenario.
> >   
> > > I'm perfectly fine with the I3C / I2C framework separation. The only
> > > minor problem I had with that was the inaccuracy of the
> > > sysfs/device-model representation: we don't have one i2c and one i3c
> > > bus, we just have one i3c bus with a mix of i2c and i3c devices.    
> > 
> > I understand that. What if I2C had the same seperation between the "bus"
> > and the "master"?
> >   
> 
> Yep, it might work if we can register an i2c_adapter and pass it an
> existing bus object. We'd still need a common base for i2c and i3c
> busses, unless we consider the bus as an opaque "struct device *"
> object.

I tried to envision how this could be implemented but realized
separating the bus and master concepts in I2C wouldn't solve all
problems.

Each device is attached a bus_type which defines how to match devices
and drivers, uevent format, ... But it also defines where the device
appears in sysfs (/sys/bus/<bus-name>/devices).

First question: where should an I2C device connected on an I3C bus
appear? /sys/bus/i3c/devices/ or /sys/bus/i2c/devices/? I'd say both
(with one of them being a symlink to the other) but I'm not sure.

Also, if we go for a 'single bus per master' representation but still
want i3c and i2c to be differentiated, that means when one adds an
i2c_driver we'll have to duplicate this driver object and register one
instance to the i2c framework and the other one to the i3c framework,
because device <-> driver matching is done per bus_type.

One solution would be to go for Arnd suggestion to extend i2c_bus_type
with I3C support, but then i3c related kojects would be exposed
under /sys/bus/i2c/ which can be disturbing for people who are used to
look at /sys/bus/<bus-name> to find devices connected on a specific bus
type.

Honestly, I don't know what's the best solution here. Every solution has
its pros and cons:

1/ The "one i2c bus and one i3c bus per i3c master" I proposed in this
   RFC is non-invasive but the resulting sysfs/device-model
   representation is not accurate.
2/ Separating the I3C and I2C framework with a thin layer between them
   to propagate i2c drivers registration to the i3c framework and make
   sure i2c devices are exposed in both worlds is much more complicated
   to implement but should provide an accurate bus <-> device
   representation.
3/ Extending i2c_bus_type (and more generally the I2C framework) to
   support I3C devices/busses is invasive and we still have a
   non-accurate representation (i2c busses are mixed with i3c busses
   and all exposed under /sys/bus/i2c/). One advantage with this
   solution compared to #2 is that we don't need to duplicate
   i2c_driver objects in order to register them to both i2c and i3c bus
   types.

Any advice is welcome.

Thanks,

Boris
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
