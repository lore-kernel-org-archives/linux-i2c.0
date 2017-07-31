From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Mon, 31 Jul 2017 23:15:09 +0200
Message-ID: <20170731231509.77d1fba4@bbrezillon>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
        <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
        <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Przemyslaw Sroka <psroka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Arkadiusz Golec <agolec-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alan Douglas <adouglas-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Bartosz Folta <bfolta-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Damian Kos <dkos-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alicja Jurasik-Urbaniak <alicja-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Jan Kotas <jank-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Cyprian Wronka <cwronka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Ku
List-Id: linux-i2c@vger.kernel.org

Hi Arnd,

Le Mon, 31 Jul 2017 22:16:42 +0200,
Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> a écrit :

> On Mon, Jul 31, 2017 at 6:24 PM, Boris Brezillon
> <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > Add core infrastructure to support I3C in Linux and document it.  
> 
> > - I2C backward compatibility has been designed to be transparent to I2C
> >   drivers and the I2C subsystem. The I3C master just registers an I2C
> >   adapter which creates a new I2C bus. I'd say that, from a
> >   representation PoV it's not ideal because what should appear as a
> >   single I3C bus exposing I3C and I2C devices here appears as 2
> >   different busses connected to each other through the parenting (the
> >   I3C master is the parent of the I2C and I3C busses).
> >   On the other hand, I don't see a better solution if we want something
> >   that is not invasive.  
> 
> Can you describe the reasons for making i3c a separate subsystem then,
> rather than extending the i2c subsystem to handle both i2c devices as
> before and also i3c devices and hosts?

Actually, that's the first option I considered, but I3C and I2C are
really different. I'm not talking about the physical layer here, but
the way the bus has to be handled by the software layer. Actually, I
thing the I3C bus is philosophically closer to auto-discoverable busses
like USB than I2C or SPI.

Indeed, all I3C devices can be discovered and do not need to be
described at the board level (using DT, board files, ACPI or whatever).
Also, some I3C devices are hotpluggable, and most importantly, all I3C
devices describe themselves during the discovery procedure (called DAA
in the I3C world).

There is some kind of "device class" concept. In the I3C world it's
called DCR (Device Characteristic Register), but it plays the same role:
it's a set of generic interfaces devices have to comply with when they
declare themselves as being compatible with a DCR ID (like
accelerometer, gyroscope, or whatever). See this table of normalized
DCR for more information [1].

Devices also expose a 48-bit Provisional ID which is made of
sub-fields. Two of them are particularly interesting: the manufacturer
ID and the part ID, which are comparable to the vendor and product ID in
the USB world.

These three information (DCR, ManufacturerID and PartID) can be used to
match drivers instead of the compatible string or driver-name used for
I2C devices

So, as you can imagine, dealing with an I3C bus is really different
from dealing with an I2C bus, and I found the "expose an i2c_adapter
object for each i3c_master" way simpler (and less invasive) than
extending the I2C framework to support I3C devices.

Of course, I can move all the code in drivers/i2c/, but that won't
change the fact that I3C and I2C busses are completely different
with little to share between them.

To me, the I2C backward compatibility is just a nice feature that was
added to help people smoothly transition from mixed I3C busses with
both I2C and I3C devices connected to it (I2C devices being here
when no (affordable) equivalent exist in the I3C world) to pure I3C
busses with only I3C devices connected to it.

This being said, I'd be happy if you prove me wrong and propose a
solution that allows us to extend the I2C framework to support I3C
without to much pain ;-).

Thanks,

Boris

[1]https://www.mipi.org/MIPI_I3C_device_characteristics_register
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
