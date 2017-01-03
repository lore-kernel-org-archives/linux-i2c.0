From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Tue, 3 Jan 2017 10:38:43 -0800
Message-ID: <20170103183843.GA16032@dtor-ws>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <201612291517.37474@pali>
 <20161229210932.GA1254@kmp-mobile.hq.kempniu.pl>
 <201612292228.18706@pali>
 <20170103090641.GH5767@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33624 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759596AbdACSiw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 3 Jan 2017 13:38:52 -0500
Content-Disposition: inline
In-Reply-To: <20170103090641.GH5767@mail.corp.redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Tue, Jan 03, 2017 at 10:06:41AM +0100, Benjamin Tissoires wrote:
> On Dec 29 2016 or thereabouts, Pali Rohár wrote:
> > On Thursday 29 December 2016 22:09:32 Michał Kępień wrote:
> > > > On Thursday 29 December 2016 14:47:19 Michał Kępień wrote:
> > > > > > On Thursday 29 December 2016 09:29:36 Michał Kępień wrote:
> > > > > > > > Dell platform team told us that some (DMI whitelisted) Dell
> > > > > > > > Latitude machines have ST microelectronics accelerometer at
> > > > > > > > i2c address 0x29. That i2c address is not specified in DMI
> > > > > > > > or ACPI, so runtime detection without whitelist which is
> > > > > > > > below is not possible.
> > > > > > > > 
> > > > > > > > Presence of that ST microelectronics accelerometer is
> > > > > > > > verified by existence of SMO88xx ACPI device which
> > > > > > > > represent that accelerometer. Unfortunately without i2c
> > > > > > > > address.
> > > > > > > 
> > > > > > > This part of the commit message sounded a bit confusing to me
> > > > > > > at first because there is already an ACPI driver which
> > > > > > > handles SMO88xx
> > > > > > > 
> > > > > > > devices (dell-smo8800).  My understanding is that:
> > > > > > >   * the purpose of this patch is to expose a richer interface
> > > > > > >   (as
> > > > > > >   
> > > > > > >     provided by lis3lv02d) to these devices on some machines,
> > > > > > >   
> > > > > > >   * on whitelisted machines, dell-smo8800 and lis3lv02d can
> > > > > > >   work
> > > > > > >   
> > > > > > >     simultaneously (even though dell-smo8800 effectively
> > > > > > >     duplicates the work that lis3lv02d does).
> > > > > > 
> > > > > > No. dell-smo8800 reads from ACPI irq number and exports
> > > > > > /dev/freefall device which notify userspace about falls.
> > > > > > lis3lv02d is i2c driver which exports axes of accelerometer.
> > > > > > Additionaly lis3lv02d can export also /dev/freefall if
> > > > > > registerer of i2c device provides irq number -- which is not
> > > > > > case of this patch.
> > > > > > 
> > > > > > So both drivers are doing different things and both are useful.
> > > > > > 
> > > > > > IIRC both dell-smo8800 and lis3lv02d represent one HW device
> > > > > > (that ST microelectronics accelerometer) but due to
> > > > > > complicated HW abstraction and layers on Dell laptops it is
> > > > > > handled by two drivers, one ACPI and one i2c.
> > > > > > 
> > > > > > Yes, in ideal world irq number should be passed to lis3lv02d
> > > > > > driver and that would export whole device (with /dev/freefall
> > > > > > too), but due to HW abstraction it is too much complicated...
> > > > > 
> > > > > Why?  AFAICT, all that is required to pass that IRQ number all
> > > > > the way down to lis3lv02d is to set the irq field of the struct
> > > > > i2c_board_info you are passing to i2c_new_device().  And you can
> > > > > extract that IRQ number e.g. in check_acpi_smo88xx_device().
> > > > > However, you would then need to make sure dell-smo8800 does not
> > > > > attempt to request the same IRQ on whitelisted machines.  This
> > > > > got me thinking about a way to somehow incorporate your changes
> > > > > into dell-smo8800 using Wolfram's bus_notifier suggestion, but I
> > > > > do not have a working solution for now.  What is tempting about
> > > > > this approach is that you would not have to scan the ACPI
> > > > > namespace in search of SMO88xx devices, because smo8800_add() is
> > > > > automatically called for them.  However, I fear that the
> > > > > resulting solution may be more complicated than the one you
> > > > > submitted.
> > > > 
> > > > Then we need to deal with lot of problems. Order of loading .ko
> > > > modules is undefined. Binding devices to drivers registered by .ko
> > > > module is also in "random" order. At any time any of those .ko
> > > > module can be unloaded or at least device unbind (via sysfs) from
> > > > driver... And there can be some pathological situation (thanks to
> > > > adding ACPI layer as Andy pointed) that there will be more SMO88xx
> > > > devices in ACPI. Plus you can compile kernel with and without
> > > > those modules and also you can blacklist loading them (so compile
> > > > time check is not enough). And still some correct message notifier
> > > > must be used.
> > > > 
> > > > I think such solution is much much more complicated, there are lot
> > > > of combinations of kernel configuration and available dell
> > > > devices...
> > > 
> > > I tried a few more things, but ultimately failed to find a nice way
> > > to implement this.
> > > 
> > > Another issue popped up, though.  Linus' master branch contains a
> > > recent commit by Benjamin Tissoires (CC'ed), 4d5538f5882a ("i2c: use
> > > an IRQ to report Host Notify events, not alert") which breaks your
> > > patch.  The reason for that is that lis3lv02d relies on the i2c
> > > client's IRQ being 0 to detect that it should not create
> > > /dev/freefall.  Benjamin's patch causes the Host Notify IRQ to be
> > > assigned to the i2c client your patch creates, thus causing
> > > lis3lv02d to create /dev/freefall, which in turn conflicts with
> > > dell-smo8800 which is trying to create /dev/freefall itself.
> > 
> > So 4d5538f5882a is breaking lis3lv02d driver...
> 
> Apologies for that.
> 
> I could easily fix this by adding a kernel API to know whether the
> provided irq is from Host Notify or if it was coming from an actual
> declaration. However, I have no idea how many other drivers would
> require this (hopefully only this one).
> 
> One other solution would be to reserve the Host Notify IRQ and let the
> actual drivers that need it to set it, but this was not the best
> solution according to Dmitri. On my side, I am not entirely against this
> given that it's a chip feature, so the driver should be able to know
> that it's available.
> 
> Dmitri, Wolfram, Jean, any preferences?

I read this:

"IIRC both dell-smo8800 and lis3lv02d represent one HW device (that ST
microelectronics accelerometer) but due to complicated HW abstraction
and layers on Dell laptops it is handled by two drivers, one ACPI and
one i2c."

and that is the core of the issue. You have 2 drivers fighting over the
same device. Fix this and it will all work.

As far as I can see hp_accel instantiates lis3lv02d and accesses it via
ACPI methods, can the same be done for Dell?

> 
> > 
> > > Also, just to make sure we do not overthink this, I understand that
> > > not every unit of the models from the whitelist has an
> > > accelerometer, correct?  In other words, could we perhaps skip the
> > > part where we are making sure the SMO88xx ACPI device is there?
> > 
> > Good question... At least for E6440 I'm did not thing it was possible to 
> > configure notebook without "3 axes free fall sensor".
> > 
> > But! In BIOS SETUP it is possible to disable free fall sensor. I will 
> > try to disable it there and will check what happen. My guess is that it 
> > will be disabled in ACPI.
> 
> Just adding my 2 cents regarding the whitelist and interaction between
> those 2 drivers. I find this very fragile to have only one available
> /dev/freefall node and to rely on the fairness of each driver to not bind
> one. It would have been much simpler to have /dev/freefallXX and a
> proper misc class device for it. This way, we don't even need to
> mutually exclude the drivers. But this is already 8 years old code, so I
> guess userspace expects this... (why isn't that using the input subsystem
> at all?).

I do not consider throwing a unit down an ordinary user interaction ;)
So there is no input event code for this.

Userspace should really use IIO accelerometer interface here. And kernel
could provide composite IIO->/dev/freefall bridge, like we did for
/dev/input/mice when all userspace wanted only PS/2.

Thanks.

-- 
Dmitry
