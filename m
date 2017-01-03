From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Tue, 3 Jan 2017 22:29:34 +0100
Message-ID: <20170103212934.GK5767@mail.corp.redhat.com>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <20170103090641.GH5767@mail.corp.redhat.com>
 <20170103183843.GA16032@dtor-ws>
 <201701031950.17389@pali>
 <20170103194812.GD16032@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170103194812.GD16032@dtor-ws>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Jan 03 2017 or thereabouts, Dmitry Torokhov wrote:
> On Tue, Jan 03, 2017 at 07:50:17PM +0100, Pali Rohár wrote:
> > On Tuesday 03 January 2017 19:38:43 Dmitry Torokhov wrote:
> > > On Tue, Jan 03, 2017 at 10:06:41AM +0100, Benjamin Tissoires wrote:
> > > > On Dec 29 2016 or thereabouts, Pali Rohár wrote:
> > > > > On Thursday 29 December 2016 22:09:32 Michał Kępień wrote:
> > > > > > > On Thursday 29 December 2016 14:47:19 Michał Kępień wrote:
> > > > > > > > > On Thursday 29 December 2016 09:29:36 Michał Kępień wrote:
> > > > > > > > > > > Dell platform team told us that some (DMI
> > > > > > > > > > > whitelisted) Dell Latitude machines have ST
> > > > > > > > > > > microelectronics accelerometer at i2c address 0x29.
> > > > > > > > > > > That i2c address is not specified in DMI or ACPI, so
> > > > > > > > > > > runtime detection without whitelist which is below
> > > > > > > > > > > is not possible.
> > > > > > > > > > > 
> > > > > > > > > > > Presence of that ST microelectronics accelerometer is
> > > > > > > > > > > verified by existence of SMO88xx ACPI device which
> > > > > > > > > > > represent that accelerometer. Unfortunately without
> > > > > > > > > > > i2c address.
> > > > > > > > > > 
> > > > > > > > > > This part of the commit message sounded a bit confusing
> > > > > > > > > > to me at first because there is already an ACPI driver
> > > > > > > > > > which handles SMO88xx
> > > > > > > > > > 
> > > > > > > > > > devices (dell-smo8800).  My understanding is that:
> > > > > > > > > >   * the purpose of this patch is to expose a richer
> > > > > > > > > >   interface (as
> > > > > > > > > >   
> > > > > > > > > >     provided by lis3lv02d) to these devices on some
> > > > > > > > > >     machines,
> > > > > > > > > >   
> > > > > > > > > >   * on whitelisted machines, dell-smo8800 and lis3lv02d
> > > > > > > > > >   can work
> > > > > > > > > >   
> > > > > > > > > >     simultaneously (even though dell-smo8800
> > > > > > > > > >     effectively duplicates the work that lis3lv02d
> > > > > > > > > >     does).
> > > > > > > > > 
> > > > > > > > > No. dell-smo8800 reads from ACPI irq number and exports
> > > > > > > > > /dev/freefall device which notify userspace about falls.
> > > > > > > > > lis3lv02d is i2c driver which exports axes of
> > > > > > > > > accelerometer. Additionaly lis3lv02d can export also
> > > > > > > > > /dev/freefall if registerer of i2c device provides irq
> > > > > > > > > number -- which is not case of this patch.
> > > > > > > > > 
> > > > > > > > > So both drivers are doing different things and both are
> > > > > > > > > useful.
> > > > > > > > > 
> > > > > > > > > IIRC both dell-smo8800 and lis3lv02d represent one HW
> > > > > > > > > device (that ST microelectronics accelerometer) but due
> > > > > > > > > to complicated HW abstraction and layers on Dell laptops
> > > > > > > > > it is handled by two drivers, one ACPI and one i2c.
> > > > > > > > > 
> > > > > > > > > Yes, in ideal world irq number should be passed to
> > > > > > > > > lis3lv02d driver and that would export whole device
> > > > > > > > > (with /dev/freefall too), but due to HW abstraction it
> > > > > > > > > is too much complicated...
> > > > > > > > 
> > > > > > > > Why?  AFAICT, all that is required to pass that IRQ number
> > > > > > > > all the way down to lis3lv02d is to set the irq field of
> > > > > > > > the struct i2c_board_info you are passing to
> > > > > > > > i2c_new_device().  And you can extract that IRQ number
> > > > > > > > e.g. in check_acpi_smo88xx_device(). However, you would
> > > > > > > > then need to make sure dell-smo8800 does not attempt to
> > > > > > > > request the same IRQ on whitelisted machines.  This got me
> > > > > > > > thinking about a way to somehow incorporate your changes
> > > > > > > > into dell-smo8800 using Wolfram's bus_notifier suggestion,
> > > > > > > > but I do not have a working solution for now.  What is
> > > > > > > > tempting about this approach is that you would not have to
> > > > > > > > scan the ACPI namespace in search of SMO88xx devices,
> > > > > > > > because smo8800_add() is automatically called for them. 
> > > > > > > > However, I fear that the resulting solution may be more
> > > > > > > > complicated than the one you submitted.
> > > > > > > 
> > > > > > > Then we need to deal with lot of problems. Order of loading
> > > > > > > .ko modules is undefined. Binding devices to drivers
> > > > > > > registered by .ko module is also in "random" order. At any
> > > > > > > time any of those .ko module can be unloaded or at least
> > > > > > > device unbind (via sysfs) from driver... And there can be
> > > > > > > some pathological situation (thanks to adding ACPI layer as
> > > > > > > Andy pointed) that there will be more SMO88xx devices in
> > > > > > > ACPI. Plus you can compile kernel with and without those
> > > > > > > modules and also you can blacklist loading them (so compile
> > > > > > > time check is not enough). And still some correct message
> > > > > > > notifier must be used.
> > > > > > > 
> > > > > > > I think such solution is much much more complicated, there
> > > > > > > are lot of combinations of kernel configuration and
> > > > > > > available dell devices...
> > > > > > 
> > > > > > I tried a few more things, but ultimately failed to find a nice
> > > > > > way to implement this.
> > > > > > 
> > > > > > Another issue popped up, though.  Linus' master branch contains
> > > > > > a recent commit by Benjamin Tissoires (CC'ed), 4d5538f5882a
> > > > > > ("i2c: use an IRQ to report Host Notify events, not alert")
> > > > > > which breaks your patch.  The reason for that is that
> > > > > > lis3lv02d relies on the i2c client's IRQ being 0 to detect
> > > > > > that it should not create /dev/freefall.  Benjamin's patch
> > > > > > causes the Host Notify IRQ to be assigned to the i2c client
> > > > > > your patch creates, thus causing lis3lv02d to create
> > > > > > /dev/freefall, which in turn conflicts with dell-smo8800 which
> > > > > > is trying to create /dev/freefall itself.
> > > > > 
> > > > > So 4d5538f5882a is breaking lis3lv02d driver...
> > > > 
> > > > Apologies for that.
> > > > 
> > > > I could easily fix this by adding a kernel API to know whether the
> > > > provided irq is from Host Notify or if it was coming from an actual
> > > > declaration. However, I have no idea how many other drivers would
> > > > require this (hopefully only this one).
> > > > 
> > > > One other solution would be to reserve the Host Notify IRQ and let
> > > > the actual drivers that need it to set it, but this was not the
> > > > best solution according to Dmitri. On my side, I am not entirely
> > > > against this given that it's a chip feature, so the driver should
> > > > be able to know that it's available.
> > > > 
> > > > Dmitri, Wolfram, Jean, any preferences?
> > > 
> > > I read this:
> > > 
> > > "IIRC both dell-smo8800 and lis3lv02d represent one HW device (that
> > > ST microelectronics accelerometer) but due to complicated HW
> > > abstraction and layers on Dell laptops it is handled by two drivers,
> > > one ACPI and one i2c."
> > > 
> > > and that is the core of the issue. You have 2 drivers fighting over
> > > the same device. Fix this and it will all work.
> > 
> > With my current implementation (which I sent in this patch), they are 
> > not fighting.
> > 
> > dell-smo8800 exports /dev/freefall (and nothing more) and lis3lv02d only 
> > accelerometer device as lis3lv02d driver does not get IRQ number in 
> > platform data.
> > 
> > > As far as I can see hp_accel instantiates lis3lv02d and accesses it
> > > via ACPI methods, can the same be done for Dell?
> > 
> > No, Dell does not have any ACPI methods. And as I wrote in ACPI or DMI 
> > is even not i2c address of device, so it needs to be specified in code 
> > itself.
> > 
> > Really there is no other way... :-(
> 
> Sure there is:
> 
> 1. dell-smo8800 instantiates I2C device as "dell-smo8800-accel".
> 2. dell-smo8800 provides read/write functions for lis3lv02d that simply
>    forward requests to dell-smo8800-accel i2c client.
> 3. dell-smo8800 instantiates lis3lv02d instance like hp_accel does.
> 
> Alternatively, can lis3lv02d be tasked to create /dev/freefall?
> 
> Yet another option: can we add a new flag to i2c_board_info controlling
> whether we want to enable/disable wiring up host notify interrupt?

That should be fairly easy to implement. For now, given that only Elan
and Synaptics are the one in need for Host Notify, it could be better to
request the Host Notify IRQ instead of disabling it unconditionally
(which would make the current yet 8 years old lis3lv02d driver happy
again).

> Benjamin, is there anything "special" in RMI SMbus ACPI descriptors we
> could use?
> 

No, there is nothing special. Same situation for Elan with their latest
touchpads over PS/2. There is just a knowledge from the driver that
there is a device connected on a Host Notify capable bus on a specific
address. To give you an idea, on Windows, the Synaptics (and Elan)
driver even ships the equivalent of i2c-i801 to be sure to have one
driver for it...
So the knowledge is all in the driver.

Cheers,
Benjamin
