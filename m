From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 15:58:13 +0200
Message-ID: <20170801155813.4b811a4d@bbrezillon>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
        <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
        <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
        <20170731231509.77d1fba4@bbrezillon>
        <CAK8P3a0p=m-8U7TN8usG8HO-QNu_S7rSfykNzu4gm+MOaM2Kzg@mail.gmail.com>
        <20170801142936.5df48702@bbrezillon>
        <CAK8P3a0SH4kWcvXK+_iPt9LWuNnpjr+omp+ZpyTLjT=H602n+w@mail.gmail.com>
        <20170801153414.6ce34ee8@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170801153414.6ce34ee8@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Przemyslaw Sroka <psroka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Arkadiusz Golec <agolec-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alan Douglas <adouglas-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Bartosz Folta <bfolta-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Damian Kos <dkos-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alicja Jurasik-Urbaniak <alicja-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Jan Kotas <jank-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Cyprian Wronka <cwronka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Ku
List-Id: linux-i2c@vger.kernel.org

On Tue, 1 Aug 2017 15:34:14 +0200
Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> On Tue, 1 Aug 2017 15:11:44 +0200
> Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> 
> > On Tue, Aug 1, 2017 at 2:29 PM, Boris Brezillon
> > <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:  
> > > On Tue, 1 Aug 2017 14:00:05 +0200
> > > Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:    
> >   
> > >> Another argument for a combined bus would be devices that
> > >> can be attached to either i2c and i3c, depending on the host
> > >> capabilities.    
> > >
> > > Hm, that's already the case, isn't it? And you'll anyway need to
> > > develop specific code for both cases in the I2C/I3C device driver
> > > because I2C and I3C transfers are different. So I don't see how it
> > > would help to have a single bus here.
> > >    
> > >> We have discussed whether i2c and spi should be
> > >> merged into a single bus_type in the past, as a lot of devices
> > >> can be attached to either of them.    
> > >
> > > Oh, really? What's the rational behind that? I mean, I2C and SPI are
> > > quite different, and even if some devices provide both interfaces, I
> > > don't see why we should merge them. But you probably had good reasons
> > > to do so.    
> > 
> > Well, we never changed it, so at least the work required to merge
> > the two was considered too much to justify any advantages.
> > 
> > The main problem with having one driver that can operate on
> > different bus types (i2c plus either spi or i3c) is the handling for
> > the various combinations in configurations (e.g. I2C=m, SPI=y).
> > 
> > The easy case is having a module_init function that registers two
> > device drivers, but that requires having a Kconfig dependency
> > on both subsystems, and you can't use the module_i2c_driver()
> > helper.
> > 
> > The second way is to have a number of #ifdef and complex
> > Kconfig dependencies for the driver to only register the
> > device_driver objects for the buses that are enabled. This
> > is also doable, but everyone gets the logic wrong the first time.  
> 
> Hm, I understand now why you'd prefer to have a single bus. Can't we
> solve this problem with a module_i3c_i2c_driver() macro that would hide
> all this complexity from I2C/I3C drivers?

I just realized I forgot to add a "depends on I2C" in the I3C Kconfig
entry. Indeed, I'm unconditionally calling functions provided by the
I2C framework which have no dummy wrapper when I2C support is disabled.
I could of course conditionally compile some portion of the I3C
framework so that it still builds when I2C is disabled but I'm not sure
it's worth the trouble.

This "depends on I2C" should also solve the I2C+I3C driver issue, since
I2C is necessarily enabled when I3C is.

Am I missing something?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
