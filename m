From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on Dell machines
Date: Tue, 3 Jan 2017 21:39:13 +0100
Message-ID: <201701032139.13061@pali>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com> <201701032105.51144@pali> <20170103202418.GE16032@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9835505.soFofF0CNB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170103202418.GE16032@dtor-ws>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?utf-8?q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

--nextPart9835505.soFofF0CNB
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 January 2017 21:24:18 Dmitry Torokhov wrote:
> On Tue, Jan 03, 2017 at 09:05:51PM +0100, Pali Roh=C3=A1r wrote:
> > On Tuesday 03 January 2017 20:48:12 Dmitry Torokhov wrote:
> > > On Tue, Jan 03, 2017 at 07:50:17PM +0100, Pali Roh=C3=A1r wrote:
> > > > On Tuesday 03 January 2017 19:38:43 Dmitry Torokhov wrote:
> > > > > On Tue, Jan 03, 2017 at 10:06:41AM +0100, Benjamin Tissoires
> > > > >=20
> > > > > wrote:
> > > > > > On Dec 29 2016 or thereabouts, Pali Roh=C3=A1r wrote:
> > > > > > > On Thursday 29 December 2016 22:09:32 Micha=C5=82 K=C4=99pie=
=C5=84 wrote:
> > > > > > > > > On Thursday 29 December 2016 14:47:19 Micha=C5=82 K=C4=99=
pie=C5=84
> > > > > > > > > wrote:
> > > > > > > > > > > On Thursday 29 December 2016 09:29:36 Micha=C5=82
> > > > > > > > > > > K=C4=99pie=C5=84
> > > > > > > > > > >=20
> > > > > > > > > > > wrote:
> > > > > > > > > > > > > Dell platform team told us that some (DMI
> > > > > > > > > > > > > whitelisted) Dell Latitude machines have ST
> > > > > > > > > > > > > microelectronics accelerometer at i2c address
> > > > > > > > > > > > > 0x29. That i2c address is not specified in
> > > > > > > > > > > > > DMI or ACPI, so runtime detection without
> > > > > > > > > > > > > whitelist which is below is not possible.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Presence of that ST microelectronics
> > > > > > > > > > > > > accelerometer is verified by existence of
> > > > > > > > > > > > > SMO88xx ACPI device which represent that
> > > > > > > > > > > > > accelerometer. Unfortunately without i2c
> > > > > > > > > > > > > address.
> > > > > > > > > > > >=20
> > > > > > > > > > > > This part of the commit message sounded a bit
> > > > > > > > > > > > confusing to me at first because there is
> > > > > > > > > > > > already an ACPI driver which handles SMO88xx
> > > > > > > > > > > >=20
> > > > > > > > > > > > devices (dell-smo8800).  My understanding is
> > > > > > > > > > > > that:
> > > > > > > > > > > >   * the purpose of this patch is to expose a
> > > > > > > > > > > >   richer interface (as
> > > > > > > > > > > >  =20
> > > > > > > > > > > >     provided by lis3lv02d) to these devices on
> > > > > > > > > > > >     some machines,
> > > > > > > > > > > >  =20
> > > > > > > > > > > >   * on whitelisted machines, dell-smo8800 and
> > > > > > > > > > > >   lis3lv02d can work
> > > > > > > > > > > >  =20
> > > > > > > > > > > >     simultaneously (even though dell-smo8800
> > > > > > > > > > > >     effectively duplicates the work that
> > > > > > > > > > > >     lis3lv02d does).
> > > > > > > > > > >=20
> > > > > > > > > > > No. dell-smo8800 reads from ACPI irq number and
> > > > > > > > > > > exports /dev/freefall device which notify
> > > > > > > > > > > userspace about falls. lis3lv02d is i2c driver
> > > > > > > > > > > which exports axes of accelerometer. Additionaly
> > > > > > > > > > > lis3lv02d can export also /dev/freefall if
> > > > > > > > > > > registerer of i2c device provides irq number --
> > > > > > > > > > > which is not case of this patch.
> > > > > > > > > > >=20
> > > > > > > > > > > So both drivers are doing different things and
> > > > > > > > > > > both are useful.
> > > > > > > > > > >=20
> > > > > > > > > > > IIRC both dell-smo8800 and lis3lv02d represent
> > > > > > > > > > > one HW device (that ST microelectronics
> > > > > > > > > > > accelerometer) but due to complicated HW
> > > > > > > > > > > abstraction and layers on Dell laptops it is
> > > > > > > > > > > handled by two drivers, one ACPI and one i2c.
> > > > > > > > > > >=20
> > > > > > > > > > > Yes, in ideal world irq number should be passed
> > > > > > > > > > > to lis3lv02d driver and that would export whole
> > > > > > > > > > > device (with /dev/freefall too), but due to HW
> > > > > > > > > > > abstraction it is too much complicated...
> > > > > > > > > >=20
> > > > > > > > > > Why?  AFAICT, all that is required to pass that IRQ
> > > > > > > > > > number all the way down to lis3lv02d is to set the
> > > > > > > > > > irq field of the struct i2c_board_info you are
> > > > > > > > > > passing to i2c_new_device().  And you can extract
> > > > > > > > > > that IRQ number e.g. in
> > > > > > > > > > check_acpi_smo88xx_device(). However, you would
> > > > > > > > > > then need to make sure dell-smo8800 does not
> > > > > > > > > > attempt to request the same IRQ on whitelisted
> > > > > > > > > > machines.  This got me thinking about a way to
> > > > > > > > > > somehow incorporate your changes into dell-smo8800
> > > > > > > > > > using Wolfram's bus_notifier suggestion, but I do
> > > > > > > > > > not have a working solution for now.  What is
> > > > > > > > > > tempting about this approach is that you would not
> > > > > > > > > > have to scan the ACPI namespace in search of
> > > > > > > > > > SMO88xx devices, because smo8800_add() is
> > > > > > > > > > automatically called for them. However, I fear that
> > > > > > > > > > the resulting solution may be more complicated than
> > > > > > > > > > the one you submitted.
> > > > > > > > >=20
> > > > > > > > > Then we need to deal with lot of problems. Order of
> > > > > > > > > loading .ko modules is undefined. Binding devices to
> > > > > > > > > drivers registered by .ko module is also in "random"
> > > > > > > > > order. At any time any of those .ko module can be
> > > > > > > > > unloaded or at least device unbind (via sysfs) from
> > > > > > > > > driver... And there can be some pathological
> > > > > > > > > situation (thanks to adding ACPI layer as Andy
> > > > > > > > > pointed) that there will be more SMO88xx devices in
> > > > > > > > > ACPI. Plus you can compile kernel with and without
> > > > > > > > > those modules and also you can blacklist loading
> > > > > > > > > them (so compile time check is not enough). And
> > > > > > > > > still some correct message notifier must be used.
> > > > > > > > >=20
> > > > > > > > > I think such solution is much much more complicated,
> > > > > > > > > there are lot of combinations of kernel configuration
> > > > > > > > > and available dell devices...
> > > > > > > >=20
> > > > > > > > I tried a few more things, but ultimately failed to
> > > > > > > > find a nice way to implement this.
> > > > > > > >=20
> > > > > > > > Another issue popped up, though.  Linus' master branch
> > > > > > > > contains a recent commit by Benjamin Tissoires (CC'ed),
> > > > > > > > 4d5538f5882a ("i2c: use an IRQ to report Host Notify
> > > > > > > > events, not alert") which breaks your patch.  The
> > > > > > > > reason for that is that lis3lv02d relies on the i2c
> > > > > > > > client's IRQ being 0 to detect that it should not
> > > > > > > > create /dev/freefall.
> > > > > > > >=20
> > > > > > > >  Benjamin's patch causes the Host Notify IRQ to be
> > > > > > > >=20
> > > > > > > > assigned to the i2c client your patch creates, thus
> > > > > > > > causing lis3lv02d to create /dev/freefall, which in
> > > > > > > > turn conflicts with dell-smo8800 which is trying to
> > > > > > > > create /dev/freefall itself.
> > > > > > >=20
> > > > > > > So 4d5538f5882a is breaking lis3lv02d driver...
> > > > > >=20
> > > > > > Apologies for that.
> > > > > >=20
> > > > > > I could easily fix this by adding a kernel API to know
> > > > > > whether the provided irq is from Host Notify or if it was
> > > > > > coming from an actual declaration. However, I have no idea
> > > > > > how many other drivers would require this (hopefully only
> > > > > > this one).
> > > > > >=20
> > > > > > One other solution would be to reserve the Host Notify IRQ
> > > > > > and let the actual drivers that need it to set it, but
> > > > > > this was not the best solution according to Dmitri. On my
> > > > > > side, I am not entirely against this given that it's a
> > > > > > chip feature, so the driver should be able to know that
> > > > > > it's available.
> > > > > >=20
> > > > > > Dmitri, Wolfram, Jean, any preferences?
> > > > >=20
> > > > > I read this:
> > > > >=20
> > > > > "IIRC both dell-smo8800 and lis3lv02d represent one HW device
> > > > > (that ST microelectronics accelerometer) but due to
> > > > > complicated HW abstraction and layers on Dell laptops it is
> > > > > handled by two drivers, one ACPI and one i2c."
> > > > >=20
> > > > > and that is the core of the issue. You have 2 drivers
> > > > > fighting over the same device. Fix this and it will all
> > > > > work.
> > > >=20
> > > > With my current implementation (which I sent in this patch),
> > > > they are not fighting.
> > > >=20
> > > > dell-smo8800 exports /dev/freefall (and nothing more) and
> > > > lis3lv02d only accelerometer device as lis3lv02d driver does
> > > > not get IRQ number in platform data.
> > > >=20
> > > > > As far as I can see hp_accel instantiates lis3lv02d and
> > > > > accesses it via ACPI methods, can the same be done for Dell?
> > > >=20
> > > > No, Dell does not have any ACPI methods. And as I wrote in ACPI
> > > > or DMI is even not i2c address of device, so it needs to be
> > > > specified in code itself.
> > > >=20
> > > > Really there is no other way... :-(
> > >=20
> > > Sure there is:
> > >=20
> > > 1. dell-smo8800 instantiates I2C device as "dell-smo8800-accel".
> > > 2. dell-smo8800 provides read/write functions for lis3lv02d that
> > > simply forward requests to dell-smo8800-accel i2c client.
> > > 3. dell-smo8800 instantiates lis3lv02d instance like hp_accel
> > > does.
> >=20
> > Sorry, but I do not understand how you mean it... Why to provides
> > new read/write i2c functions which are already implemented by
> > i2c-i801 bus and lis3lv02d i2c driver?
>=20
> Because that would allow you to avoid clashes with i2c creating
> interrupt mapping for client residing on host-notify-capable
> controller.
>=20
> > > Alternatively, can lis3lv02d be tasked to create /dev/freefall?
> >=20
> > If i2c_board_info contains IRQ then lis3lv02d create /dev/freefall
> > device.
> >=20
> > But... what is problem with current implementation? Accelerometer
> > HW provides two functions:
> >=20
> > 1) 3 axes reports
> > 2) Disk freefall detection
> >=20
> > And 1) is handled by i2c driver lis3lv02d and 2) is by
> > dell-smo8800. Both functions are independent here.
> >=20
> > I think you just trying to complicate this situation even more to
> > be more complicated as currently is.
>=20
> Because this apparently does not work for you, does it?

It is working fine. I do not see any problem.

> In general,
> if you want the same hardware be handled by 2 different drivers you
> are going to have bad time.

Yes, but in this case half of device is ACPI based and other half i2c=20
based. This is problem of ACPI and Dell design.

> It seems to be that /dev/freefall in dell-smo8800 and lis3lv02d are
> the same, right?

Yes. I understand that clean solution is to have one driver which=20
provides everything.

But because half of data are ACPI and half i2c, you still needs to=20
create two drivers (one ACPI and one i2c). You can put both drivers into=20
one .ko module, but still these will be two drivers due to how ACPI and=20
i2c linux abstractions are different.

> So, instead of having 2 drivers split the
> functionality, can you forego registering smo8800 ACPI driver on
> your whitelisted boxes and instead instantiate full i2c client
> device with properly assigned both address and IRQ and let lis3lv02d
> handle it (providing both accelerometer data and /dev/freefall)?

With Micha=C5=82 we already discussed about it, see emails. Basically you c=
an=20
enable/disable kernel modules at compile time or blacklist at runtime=20
(or even chose what will be compiled into vmlinux and what as external=20
=2Eko module). Some distributions blacklist i2c-i801.ko module... And=20
there can be also problem with initialization of i2c-i801 driver (fix is=20
in commit a7ae81952cda, but does not have to work at every time!). So=20
that move on whitelisted machines can potentially cause disappearance of=20
/dev/freefall and users will not have hdd protection which is currently=20
working.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart9835505.soFofF0CNB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhsC/EACgkQi/DJPQPkQ1KSRwCeKpPqZsmM55VIjW60MXRwBiAL
qFIAnRs62wCv64tQEdLw9Zznm68a1jmV
=nFk7
-----END PGP SIGNATURE-----

--nextPart9835505.soFofF0CNB--
