From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Wed, 4 Jan 2017 11:32:33 +0100
Message-ID: <20170104103233.GT5767@mail.corp.redhat.com>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <201701032105.51144@pali>
 <20170103202418.GE16032@dtor-ws>
 <201701032139.13061@pali>
 <20170103205937.GA2289@dtor-ws>
 <20170104081804.GA3499@pali>
 <20170104090522.GN5767@mail.corp.redhat.com>
 <20170104091845.GB3499@pali>
 <20170104101306.GR5767@mail.corp.redhat.com>
 <20170104102118.GD3499@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170104102118.GD3499@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Jan 04 2017 or thereabouts, Pali Rohár wrote:
> On Wednesday 04 January 2017 11:13:06 Benjamin Tissoires wrote:
> > On Jan 04 2017 or thereabouts, Pali Rohár wrote:
> > > On Wednesday 04 January 2017 10:05:22 Benjamin Tissoires wrote:
> > > > On Jan 04 2017 or thereabouts, Pali Rohár wrote:
> > > > > On Tuesday 03 January 2017 12:59:37 Dmitry Torokhov wrote:
> > > > > > On Tue, Jan 03, 2017 at 09:39:13PM +0100, Pali Rohár wrote:
> > > > > > > On Tuesday 03 January 2017 21:24:18 Dmitry Torokhov wrote:
> > > > > > > > On Tue, Jan 03, 2017 at 09:05:51PM +0100, Pali Rohár wrote:
> > > > > > > > > On Tuesday 03 January 2017 20:48:12 Dmitry Torokhov wrote:
> > > > > > > > > > On Tue, Jan 03, 2017 at 07:50:17PM +0100, Pali Rohár wrote:
> > > > > > > > > > > On Tuesday 03 January 2017 19:38:43 Dmitry Torokhov wrote:
> > > > > > > > > > > > On Tue, Jan 03, 2017 at 10:06:41AM +0100, Benjamin Tissoires
> > > > > > > > > > > > 
> > > > > > > > > > > > wrote:
> > > > > > > > > > > > > On Dec 29 2016 or thereabouts, Pali Rohár wrote:
> > > > > > > > > > > > > > On Thursday 29 December 2016 22:09:32 Michał Kępień wrote:
> > > > > > > > > > > > > > > > On Thursday 29 December 2016 14:47:19 Michał Kępień
> > > > > > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > > > > > On Thursday 29 December 2016 09:29:36 Michał
> > > > > > > > > > > > > > > > > > Kępień
> > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > wrote:
> > > > > > > > > > > > > > > > > > > > Dell platform team told us that some (DMI
> > > > > > > > > > > > > > > > > > > > whitelisted) Dell Latitude machines have ST
> > > > > > > > > > > > > > > > > > > > microelectronics accelerometer at i2c address
> > > > > > > > > > > > > > > > > > > > 0x29. That i2c address is not specified in
> > > > > > > > > > > > > > > > > > > > DMI or ACPI, so runtime detection without
> > > > > > > > > > > > > > > > > > > > whitelist which is below is not possible.
> > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > Presence of that ST microelectronics
> > > > > > > > > > > > > > > > > > > > accelerometer is verified by existence of
> > > > > > > > > > > > > > > > > > > > SMO88xx ACPI device which represent that
> > > > > > > > > > > > > > > > > > > > accelerometer. Unfortunately without i2c
> > > > > > > > > > > > > > > > > > > > address.
> > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > This part of the commit message sounded a bit
> > > > > > > > > > > > > > > > > > > confusing to me at first because there is
> > > > > > > > > > > > > > > > > > > already an ACPI driver which handles SMO88xx
> > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > devices (dell-smo8800).  My understanding is
> > > > > > > > > > > > > > > > > > > that:
> > > > > > > > > > > > > > > > > > >   * the purpose of this patch is to expose a
> > > > > > > > > > > > > > > > > > >   richer interface (as
> > > > > > > > > > > > > > > > > > >   
> > > > > > > > > > > > > > > > > > >     provided by lis3lv02d) to these devices on
> > > > > > > > > > > > > > > > > > >     some machines,
> > > > > > > > > > > > > > > > > > >   
> > > > > > > > > > > > > > > > > > >   * on whitelisted machines, dell-smo8800 and
> > > > > > > > > > > > > > > > > > >   lis3lv02d can work
> > > > > > > > > > > > > > > > > > >   
> > > > > > > > > > > > > > > > > > >     simultaneously (even though dell-smo8800
> > > > > > > > > > > > > > > > > > >     effectively duplicates the work that
> > > > > > > > > > > > > > > > > > >     lis3lv02d does).
> > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > No. dell-smo8800 reads from ACPI irq number and
> > > > > > > > > > > > > > > > > > exports /dev/freefall device which notify
> > > > > > > > > > > > > > > > > > userspace about falls. lis3lv02d is i2c driver
> > > > > > > > > > > > > > > > > > which exports axes of accelerometer. Additionaly
> > > > > > > > > > > > > > > > > > lis3lv02d can export also /dev/freefall if
> > > > > > > > > > > > > > > > > > registerer of i2c device provides irq number --
> > > > > > > > > > > > > > > > > > which is not case of this patch.
> > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > So both drivers are doing different things and
> > > > > > > > > > > > > > > > > > both are useful.
> > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > IIRC both dell-smo8800 and lis3lv02d represent
> > > > > > > > > > > > > > > > > > one HW device (that ST microelectronics
> > > > > > > > > > > > > > > > > > accelerometer) but due to complicated HW
> > > > > > > > > > > > > > > > > > abstraction and layers on Dell laptops it is
> > > > > > > > > > > > > > > > > > handled by two drivers, one ACPI and one i2c.
> > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > Yes, in ideal world irq number should be passed
> > > > > > > > > > > > > > > > > > to lis3lv02d driver and that would export whole
> > > > > > > > > > > > > > > > > > device (with /dev/freefall too), but due to HW
> > > > > > > > > > > > > > > > > > abstraction it is too much complicated...
> > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > Why?  AFAICT, all that is required to pass that IRQ
> > > > > > > > > > > > > > > > > number all the way down to lis3lv02d is to set the
> > > > > > > > > > > > > > > > > irq field of the struct i2c_board_info you are
> > > > > > > > > > > > > > > > > passing to i2c_new_device().  And you can extract
> > > > > > > > > > > > > > > > > that IRQ number e.g. in
> > > > > > > > > > > > > > > > > check_acpi_smo88xx_device(). However, you would
> > > > > > > > > > > > > > > > > then need to make sure dell-smo8800 does not
> > > > > > > > > > > > > > > > > attempt to request the same IRQ on whitelisted
> > > > > > > > > > > > > > > > > machines.  This got me thinking about a way to
> > > > > > > > > > > > > > > > > somehow incorporate your changes into dell-smo8800
> > > > > > > > > > > > > > > > > using Wolfram's bus_notifier suggestion, but I do
> > > > > > > > > > > > > > > > > not have a working solution for now.  What is
> > > > > > > > > > > > > > > > > tempting about this approach is that you would not
> > > > > > > > > > > > > > > > > have to scan the ACPI namespace in search of
> > > > > > > > > > > > > > > > > SMO88xx devices, because smo8800_add() is
> > > > > > > > > > > > > > > > > automatically called for them. However, I fear that
> > > > > > > > > > > > > > > > > the resulting solution may be more complicated than
> > > > > > > > > > > > > > > > > the one you submitted.
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > Then we need to deal with lot of problems. Order of
> > > > > > > > > > > > > > > > loading .ko modules is undefined. Binding devices to
> > > > > > > > > > > > > > > > drivers registered by .ko module is also in "random"
> > > > > > > > > > > > > > > > order. At any time any of those .ko module can be
> > > > > > > > > > > > > > > > unloaded or at least device unbind (via sysfs) from
> > > > > > > > > > > > > > > > driver... And there can be some pathological
> > > > > > > > > > > > > > > > situation (thanks to adding ACPI layer as Andy
> > > > > > > > > > > > > > > > pointed) that there will be more SMO88xx devices in
> > > > > > > > > > > > > > > > ACPI. Plus you can compile kernel with and without
> > > > > > > > > > > > > > > > those modules and also you can blacklist loading
> > > > > > > > > > > > > > > > them (so compile time check is not enough). And
> > > > > > > > > > > > > > > > still some correct message notifier must be used.
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > I think such solution is much much more complicated,
> > > > > > > > > > > > > > > > there are lot of combinations of kernel configuration
> > > > > > > > > > > > > > > > and available dell devices...
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > I tried a few more things, but ultimately failed to
> > > > > > > > > > > > > > > find a nice way to implement this.
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > Another issue popped up, though.  Linus' master branch
> > > > > > > > > > > > > > > contains a recent commit by Benjamin Tissoires (CC'ed),
> > > > > > > > > > > > > > > 4d5538f5882a ("i2c: use an IRQ to report Host Notify
> > > > > > > > > > > > > > > events, not alert") which breaks your patch.  The
> > > > > > > > > > > > > > > reason for that is that lis3lv02d relies on the i2c
> > > > > > > > > > > > > > > client's IRQ being 0 to detect that it should not
> > > > > > > > > > > > > > > create /dev/freefall.
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > >  Benjamin's patch causes the Host Notify IRQ to be
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > assigned to the i2c client your patch creates, thus
> > > > > > > > > > > > > > > causing lis3lv02d to create /dev/freefall, which in
> > > > > > > > > > > > > > > turn conflicts with dell-smo8800 which is trying to
> > > > > > > > > > > > > > > create /dev/freefall itself.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > So 4d5538f5882a is breaking lis3lv02d driver...
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Apologies for that.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > I could easily fix this by adding a kernel API to know
> > > > > > > > > > > > > whether the provided irq is from Host Notify or if it was
> > > > > > > > > > > > > coming from an actual declaration. However, I have no idea
> > > > > > > > > > > > > how many other drivers would require this (hopefully only
> > > > > > > > > > > > > this one).
> > > > > > > > > > > > > 
> > > > > > > > > > > > > One other solution would be to reserve the Host Notify IRQ
> > > > > > > > > > > > > and let the actual drivers that need it to set it, but
> > > > > > > > > > > > > this was not the best solution according to Dmitri. On my
> > > > > > > > > > > > > side, I am not entirely against this given that it's a
> > > > > > > > > > > > > chip feature, so the driver should be able to know that
> > > > > > > > > > > > > it's available.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Dmitri, Wolfram, Jean, any preferences?
> > > > > > > > > > > > 
> > > > > > > > > > > > I read this:
> > > > > > > > > > > > 
> > > > > > > > > > > > "IIRC both dell-smo8800 and lis3lv02d represent one HW device
> > > > > > > > > > > > (that ST microelectronics accelerometer) but due to
> > > > > > > > > > > > complicated HW abstraction and layers on Dell laptops it is
> > > > > > > > > > > > handled by two drivers, one ACPI and one i2c."
> > > > > > > > > > > > 
> > > > > > > > > > > > and that is the core of the issue. You have 2 drivers
> > > > > > > > > > > > fighting over the same device. Fix this and it will all
> > > > > > > > > > > > work.
> > > > > > > > > > > 
> > > > > > > > > > > With my current implementation (which I sent in this patch),
> > > > > > > > > > > they are not fighting.
> > > > > > > > > > > 
> > > > > > > > > > > dell-smo8800 exports /dev/freefall (and nothing more) and
> > > > > > > > > > > lis3lv02d only accelerometer device as lis3lv02d driver does
> > > > > > > > > > > not get IRQ number in platform data.
> > > > > > > > > > > 
> > > > > > > > > > > > As far as I can see hp_accel instantiates lis3lv02d and
> > > > > > > > > > > > accesses it via ACPI methods, can the same be done for Dell?
> > > > > > > > > > > 
> > > > > > > > > > > No, Dell does not have any ACPI methods. And as I wrote in ACPI
> > > > > > > > > > > or DMI is even not i2c address of device, so it needs to be
> > > > > > > > > > > specified in code itself.
> > > > > > > > > > > 
> > > > > > > > > > > Really there is no other way... :-(
> > > > > > > > > > 
> > > > > > > > > > Sure there is:
> > > > > > > > > > 
> > > > > > > > > > 1. dell-smo8800 instantiates I2C device as "dell-smo8800-accel".
> > > > > > > > > > 2. dell-smo8800 provides read/write functions for lis3lv02d that
> > > > > > > > > > simply forward requests to dell-smo8800-accel i2c client.
> > > > > > > > > > 3. dell-smo8800 instantiates lis3lv02d instance like hp_accel
> > > > > > > > > > does.
> > > > > > > > > 
> > > > > > > > > Sorry, but I do not understand how you mean it... Why to provides
> > > > > > > > > new read/write i2c functions which are already implemented by
> > > > > > > > > i2c-i801 bus and lis3lv02d i2c driver?
> > > > > > > > 
> > > > > > > > Because that would allow you to avoid clashes with i2c creating
> > > > > > > > interrupt mapping for client residing on host-notify-capable
> > > > > > > > controller.
> > > > > > > > 
> > > > > > > > > > Alternatively, can lis3lv02d be tasked to create /dev/freefall?
> > > > > > > > > 
> > > > > > > > > If i2c_board_info contains IRQ then lis3lv02d create /dev/freefall
> > > > > > > > > device.
> > > > > > > > > 
> > > > > > > > > But... what is problem with current implementation? Accelerometer
> > > > > > > > > HW provides two functions:
> > > > > > > > > 
> > > > > > > > > 1) 3 axes reports
> > > > > > > > > 2) Disk freefall detection
> > > > > > > > > 
> > > > > > > > > And 1) is handled by i2c driver lis3lv02d and 2) is by
> > > > > > > > > dell-smo8800. Both functions are independent here.
> > > > > > > > > 
> > > > > > > > > I think you just trying to complicate this situation even more to
> > > > > > > > > be more complicated as currently is.
> > > > > > > > 
> > > > > > > > Because this apparently does not work for you, does it?
> > > > > > > 
> > > > > > > It is working fine. I do not see any problem.
> > > > > > > 
> > > > > > > > In general,
> > > > > > > > if you want the same hardware be handled by 2 different drivers you
> > > > > > > > are going to have bad time.
> > > > > > > 
> > > > > > > Yes, but in this case half of device is ACPI based and other half i2c 
> > > > > > > based. This is problem of ACPI and Dell design.
> > > > > > > 
> > > > > > > > It seems to be that /dev/freefall in dell-smo8800 and lis3lv02d are
> > > > > > > > the same, right?
> > > > > > > 
> > > > > > > Yes. I understand that clean solution is to have one driver which 
> > > > > > > provides everything.
> > > > > > > 
> > > > > > > But because half of data are ACPI and half i2c, you still needs to 
> > > > > > > create two drivers (one ACPI and one i2c). You can put both drivers into 
> > > > > > > one .ko module, but still these will be two drivers due to how ACPI and 
> > > > > > > i2c linux abstractions are different.
> > > > > > > 
> > > > > > > > So, instead of having 2 drivers split the
> > > > > > > > functionality, can you forego registering smo8800 ACPI driver on
> > > > > > > > your whitelisted boxes and instead instantiate full i2c client
> > > > > > > > device with properly assigned both address and IRQ and let lis3lv02d
> > > > > > > > handle it (providing both accelerometer data and /dev/freefall)?
> > > > > > > 
> > > > > > > With Michał we already discussed about it, see emails. Basically you can 
> > > > > > > enable/disable kernel modules at compile time or blacklist at runtime 
> > > > > > > (or even chose what will be compiled into vmlinux and what as external 
> > > > > > > .ko module).
> > > > > > 
> > > > > > This can be solved with a bit of Kconfig/IS_ENABLED() code.
> > > > > > 
> > > > > > > Some distributions blacklist i2c-i801.ko module... And 
> > > > > > 
> > > > > > Any particular reason for that?
> > > > > > 
> > > > > > > there can be also problem with initialization of i2c-i801 driver (fix is 
> > > > > > > in commit a7ae81952cda, but does not have to work at every time!). So 
> > > > > > > that move on whitelisted machines can potentially cause disappearance of 
> > > > > > > /dev/freefall and users will not have hdd protection which is currently 
> > > > > > > working.
> > > > > > 
> > > > > > Well, I gave you 2 possible solutions (roll your own i2c read/write,
> > > > > > forward them to i2c client) or have faith in your implementation and let
> > > > > > lis3lv02d handle it.
> > > > > > 
> > > > > > The 3rd one is to possibly add a flag to disable host notify to IRQ
> > > > > > mapping for given client (if Wolfram/Jean OK with it).
> > > > > > 
> > > > > > Oh, the 4th one: change the irq in lis3lv02d.h to be "int" and change
> > > > > > the check in lis3lv02d.c to be "lis->irq <= 0" and instantiate your
> > > > > > i2c_client with board_info->irq = -1.
> > > > > > 
> > > > > > Pick whichever you prefer.
> > > > > > 
> > > > > > By the way, what do you need accelerometer for on these devices? They
> > > > > > don't appear to be tablets that could use one... 
> > > > > 
> > > > > Ah, you are talking about problem that after 4d5538f5882a lis3lv02d will
> > > > > not work... I thought that discussion is about different mechanism how
> > > > > to implement bus registration notification to smo8800 driver (or
> > > > > different solution to not have registration in i801).
> > > > > 
> > > > 
> > > > Just because I am not sure I got everything right, could you confirm
> > > > that:
> > > > - in the current upstream tree, the dell-smo8800 driver is now broken
> > > >   after 4d5538f5882a (i2c: use an IRQ to report Host Notify events, not
> > > >   alert)
> > > 
> > > No, dell-smo8800 it is working fine. It is fully independent from i2c
> > > and lis3lv02d. It is pure ACPI driver which does not share anything with
> > > i2c.
> > > 
> > > > - this series adds an extra lis3lv02d on some machines and you have
> > > >   problem fighting for the irq (but this is not upstream yet).
> > > 
> > > Yes, this series (not merged yet) adds extra lis3lv02d device but is not
> > > working because of 4d5538f5882a.
> > > 
> > > > The extra lis3lv02d node is added from dell-smo8800
> > > 
> > > No, dell-smo8800 does not add new node in this patch.
> > > 
> > > > If the first point is not correct (by default, dell-smo8800 will not be
> > > > loaded at the same time than lis3lv02d), then it's a design issue with
> > > > the interactions between those 2 drivers.
> > > 
> > > No, there is no interactions between these two drivers (dell-smo8800 and
> > > lis3lv02d). dell-smo8800 is pure ACPI driver and exports just
> > > /dev/freefall device based on IRQ (and nothing more).
> > > 
> > > And lis3lv02d in *current* configuration in this patch exports only
> > > accelerometer input device, not /dev/freefall. It does not use IRQ.
> > > (Just there is problem with 4d5538f5882a which tells lis3lv02d IRQ
> > > number which is not freefall report, therefore lis3lv02d does not work).
> > > 
> > > To make it clear, ST Accelerometer provides two operations:
> > > * report free fall
> > > * report 3 axes
> > > 
> > > Free fall is reported by IRQ, state of 3 axes via i2c bus. Free fall IRQ
> > > is handled by dell-smo8800, state of 3 axes via i2c lis3lv02d driver.
> > > 
> > > lis3lv02d can handle also free fall IRQ is platform i2c data provides
> > > IRQ number for it -- but this is not case in our Dell configuration. But
> > > commit 4d5538f5882a inject some IRQ number to lis3lv02d driver which is
> > > not free fall detection and so is breaking lis3lv02 driver. In our Dell
> > > configuration (by this patch) there should be no IRQ number.
> > > 
> > > It is clear now?
> > 
> > I think I am starting to understand the problem.
> > 
> > Currently (upstream tree), 4d5538f5882a doesn't break anything.
> 
> I cannot prove it... lis3lv02d i2c driver itself uses this IRQ logic
> (missing = no freefall) and there could be already hardware/boards which
> register lis3lv02d i2c device without IRQ number. And definitions could
> be also in device tree and so outside of kernel sources...
> 
> So there can be potentially break. But at least not case of Dell.
> 
> > On the
> > mentioned Dell platforms, the dell-smo8800 gets loaded and provides
> > /dev/freefall. lis3lv02d is not loaded so everything just works.
> 
> Yes.
> 
> > The problem comes from this patch which doesn't set the irq in
> > i2c_board_info and so i2c_core sets the IRQ to Host Notify. I think
> > Dmitri already gave you the solution: set the irq to -1 (or -ENOENT)
> > in i2c_board_info in your patch and only forward it to
> > lis3lv02d_init_device() only if it is positive (valid).
> 
> Now I understood that Dmitri means. For this Dell platforms it is OK,
> but we have a problem for device tree platforms. Normally in device tree
> if device does not support something you just do not specify it. But
> with this approach you need to explicitly specify IRQ to -1 in device
> tree. And I think this is really not a clean solution.
> 

No. DT platforms won't have an issue: they don't change anything, and
there will be a new /dev/freefall misc device for the platforms that
don't have the irq set *and* if the device is on a Host Notify capable
adapter, currently only i2c-i801. But given that they are DT and not
ACPI, this won't conflict with dell-smo8800, so there won't be any
errors, just a dangling unused device node.

This approach is IMO the best if you want to have this in the kernel.

Cheers,
Benjamin
