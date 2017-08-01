From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Tue, 1 Aug 2017 14:00:05 +0200
Message-ID: <CAK8P3a0p=m-8U7TN8usG8HO-QNu_S7rSfykNzu4gm+MOaM2Kzg@mail.gmail.com>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
 <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com> <20170731231509.77d1fba4@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170731231509.77d1fba4@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Przemyslaw Sroka <psroka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Arkadiusz Golec <agolec-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alan Douglas <adouglas-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Bartosz Folta <bfolta-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Damian Kos <dkos-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alicja Jurasik-Urbaniak <alicja-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Jan Kotas <jank-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Cyprian Wronka <cwronka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Ku
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 31, 2017 at 11:15 PM, Boris Brezillon
<boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Hi Arnd,
>
> Le Mon, 31 Jul 2017 22:16:42 +0200,
> Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> a =C3=A9crit :
>
>> On Mon, Jul 31, 2017 at 6:24 PM, Boris Brezillon
>> <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> > Add core infrastructure to support I3C in Linux and document it.
>>
>> > - I2C backward compatibility has been designed to be transparent to I2=
C
>> >   drivers and the I2C subsystem. The I3C master just registers an I2C
>> >   adapter which creates a new I2C bus. I'd say that, from a
>> >   representation PoV it's not ideal because what should appear as a
>> >   single I3C bus exposing I3C and I2C devices here appears as 2
>> >   different busses connected to each other through the parenting (the
>> >   I3C master is the parent of the I2C and I3C busses).
>> >   On the other hand, I don't see a better solution if we want somethin=
g
>> >   that is not invasive.
>>
>> Can you describe the reasons for making i3c a separate subsystem then,
>> rather than extending the i2c subsystem to handle both i2c devices as
>> before and also i3c devices and hosts?
>
> Actually, that's the first option I considered, but I3C and I2C are
> really different. I'm not talking about the physical layer here, but
> the way the bus has to be handled by the software layer. Actually, I
> thing the I3C bus is philosophically closer to auto-discoverable busses
> like USB than I2C or SPI.
>
> Indeed, all I3C devices can be discovered and do not need to be
> described at the board level (using DT, board files, ACPI or whatever).
> Also, some I3C devices are hotpluggable, and most importantly, all I3C
> devices describe themselves during the discovery procedure (called DAA
> in the I3C world).

Side note: please make sure you define a way to describe them
in DT anyway. We ended up needing additional DT properties
as well as power sequencing for most discoverable buses (pci,
usb, mmc, ...), I'm sure this one won't be an exception even though
the standard says you don't need it and most devices will work
without it.

> There is some kind of "device class" concept. In the I3C world it's
> called DCR (Device Characteristic Register), but it plays the same role:
> it's a set of generic interfaces devices have to comply with when they
> declare themselves as being compatible with a DCR ID (like
> accelerometer, gyroscope, or whatever). See this table of normalized
> DCR for more information [1].
>
> Devices also expose a 48-bit Provisional ID which is made of
> sub-fields. Two of them are particularly interesting: the manufacturer
> ID and the part ID, which are comparable to the vendor and product ID in
> the USB world.
>
> These three information (DCR, ManufacturerID and PartID) can be used to
> match drivers instead of the compatible string or driver-name used for
> I2C devices

The matching would be fairly easy to accomodate: the i2c bus already
handles two distinct ways: of_device_id tables and matching by
name, so we could easily add another method here.

> So, as you can imagine, dealing with an I3C bus is really different
> from dealing with an I2C bus, and I found the "expose an i2c_adapter
> object for each i3c_master" way simpler (and less invasive) than
> extending the I2C framework to support I3C devices.
>
> Of course, I can move all the code in drivers/i2c/, but that won't
> change the fact that I3C and I2C busses are completely different
> with little to share between them.
>
> To me, the I2C backward compatibility is just a nice feature that was
> added to help people smoothly transition from mixed I3C busses with
> both I2C and I3C devices connected to it (I2C devices being here
> when no (affordable) equivalent exist in the I3C world) to pure I3C
> busses with only I3C devices connected to it.
>
> This being said, I'd be happy if you prove me wrong and propose a
> solution that allows us to extend the I2C framework to support I3C
> without to much pain ;-).

I think the question is not whether it can be done or not, but whether
it is a good idea. Obviously we can create some frankenstein bus
design that combines arbitrary different device types by just containing
the superset of the required information, and sprinking the code
with if()/else() to call one or the other function.

If there is very little shared code between the i2c and i3c
implementations, then the added complexity of having a combined
subsystem is clearly a strong argument against it.

On the other hand, there is value in representing the physical
bus hierarchy in the software model, and if i2c and i3c devices can
be attached to the same host bus, a good abstraction should
show them under the same parent. This is true for both the
kernel representation (in sysfs and the data structures) as well
as the device tree binding (assuming we will need to represent
i3c devices at all). The two don't have to use the same model,
but it's easier if they do.

Another argument for a combined bus would be devices that
can be attached to either i2c and i3c, depending on the host
capabilities. We have discussed whether i2c and spi should be
merged into a single bus_type in the past, as a lot of devices
can be attached to either of them. If it's common enough for i3c
devices to support an i2c fallback mode, having a common
bus_type might noticeably simplify device drivers by only requiring
a single i2c_driver structure. Simplifying many drivers a little
bit can in turn offset the added complexity in the subsystem.

       Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
