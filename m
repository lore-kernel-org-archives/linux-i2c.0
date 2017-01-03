From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on Dell machines
Date: Tue, 3 Jan 2017 19:50:17 +0100
Message-ID: <201701031950.17389@pali>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com> <20170103090641.GH5767@mail.corp.redhat.com> <20170103183843.GA16032@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1664973.WTD7DvgqBD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34855 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753228AbdACSuU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 3 Jan 2017 13:50:20 -0500
In-Reply-To: <20170103183843.GA16032@dtor-ws>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?utf-8?q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org

--nextPart1664973.WTD7DvgqBD
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 January 2017 19:38:43 Dmitry Torokhov wrote:
> On Tue, Jan 03, 2017 at 10:06:41AM +0100, Benjamin Tissoires wrote:
> > On Dec 29 2016 or thereabouts, Pali Roh=C3=A1r wrote:
> > > On Thursday 29 December 2016 22:09:32 Micha=C5=82 K=C4=99pie=C5=84 wr=
ote:
> > > > > On Thursday 29 December 2016 14:47:19 Micha=C5=82 K=C4=99pie=C5=
=84 wrote:
> > > > > > > On Thursday 29 December 2016 09:29:36 Micha=C5=82 K=C4=99pie=
=C5=84 wrote:
> > > > > > > > > Dell platform team told us that some (DMI
> > > > > > > > > whitelisted) Dell Latitude machines have ST
> > > > > > > > > microelectronics accelerometer at i2c address 0x29.
> > > > > > > > > That i2c address is not specified in DMI or ACPI, so
> > > > > > > > > runtime detection without whitelist which is below
> > > > > > > > > is not possible.
> > > > > > > > >=20
> > > > > > > > > Presence of that ST microelectronics accelerometer is
> > > > > > > > > verified by existence of SMO88xx ACPI device which
> > > > > > > > > represent that accelerometer. Unfortunately without
> > > > > > > > > i2c address.
> > > > > > > >=20
> > > > > > > > This part of the commit message sounded a bit confusing
> > > > > > > > to me at first because there is already an ACPI driver
> > > > > > > > which handles SMO88xx
> > > > > > > >=20
> > > > > > > > devices (dell-smo8800).  My understanding is that:
> > > > > > > >   * the purpose of this patch is to expose a richer
> > > > > > > >   interface (as
> > > > > > > >  =20
> > > > > > > >     provided by lis3lv02d) to these devices on some
> > > > > > > >     machines,
> > > > > > > >  =20
> > > > > > > >   * on whitelisted machines, dell-smo8800 and lis3lv02d
> > > > > > > >   can work
> > > > > > > >  =20
> > > > > > > >     simultaneously (even though dell-smo8800
> > > > > > > >     effectively duplicates the work that lis3lv02d
> > > > > > > >     does).
> > > > > > >=20
> > > > > > > No. dell-smo8800 reads from ACPI irq number and exports
> > > > > > > /dev/freefall device which notify userspace about falls.
> > > > > > > lis3lv02d is i2c driver which exports axes of
> > > > > > > accelerometer. Additionaly lis3lv02d can export also
> > > > > > > /dev/freefall if registerer of i2c device provides irq
> > > > > > > number -- which is not case of this patch.
> > > > > > >=20
> > > > > > > So both drivers are doing different things and both are
> > > > > > > useful.
> > > > > > >=20
> > > > > > > IIRC both dell-smo8800 and lis3lv02d represent one HW
> > > > > > > device (that ST microelectronics accelerometer) but due
> > > > > > > to complicated HW abstraction and layers on Dell laptops
> > > > > > > it is handled by two drivers, one ACPI and one i2c.
> > > > > > >=20
> > > > > > > Yes, in ideal world irq number should be passed to
> > > > > > > lis3lv02d driver and that would export whole device
> > > > > > > (with /dev/freefall too), but due to HW abstraction it
> > > > > > > is too much complicated...
> > > > > >=20
> > > > > > Why?  AFAICT, all that is required to pass that IRQ number
> > > > > > all the way down to lis3lv02d is to set the irq field of
> > > > > > the struct i2c_board_info you are passing to
> > > > > > i2c_new_device().  And you can extract that IRQ number
> > > > > > e.g. in check_acpi_smo88xx_device(). However, you would
> > > > > > then need to make sure dell-smo8800 does not attempt to
> > > > > > request the same IRQ on whitelisted machines.  This got me
> > > > > > thinking about a way to somehow incorporate your changes
> > > > > > into dell-smo8800 using Wolfram's bus_notifier suggestion,
> > > > > > but I do not have a working solution for now.  What is
> > > > > > tempting about this approach is that you would not have to
> > > > > > scan the ACPI namespace in search of SMO88xx devices,
> > > > > > because smo8800_add() is automatically called for them.=20
> > > > > > However, I fear that the resulting solution may be more
> > > > > > complicated than the one you submitted.
> > > > >=20
> > > > > Then we need to deal with lot of problems. Order of loading
> > > > > .ko modules is undefined. Binding devices to drivers
> > > > > registered by .ko module is also in "random" order. At any
> > > > > time any of those .ko module can be unloaded or at least
> > > > > device unbind (via sysfs) from driver... And there can be
> > > > > some pathological situation (thanks to adding ACPI layer as
> > > > > Andy pointed) that there will be more SMO88xx devices in
> > > > > ACPI. Plus you can compile kernel with and without those
> > > > > modules and also you can blacklist loading them (so compile
> > > > > time check is not enough). And still some correct message
> > > > > notifier must be used.
> > > > >=20
> > > > > I think such solution is much much more complicated, there
> > > > > are lot of combinations of kernel configuration and
> > > > > available dell devices...
> > > >=20
> > > > I tried a few more things, but ultimately failed to find a nice
> > > > way to implement this.
> > > >=20
> > > > Another issue popped up, though.  Linus' master branch contains
> > > > a recent commit by Benjamin Tissoires (CC'ed), 4d5538f5882a
> > > > ("i2c: use an IRQ to report Host Notify events, not alert")
> > > > which breaks your patch.  The reason for that is that
> > > > lis3lv02d relies on the i2c client's IRQ being 0 to detect
> > > > that it should not create /dev/freefall.  Benjamin's patch
> > > > causes the Host Notify IRQ to be assigned to the i2c client
> > > > your patch creates, thus causing lis3lv02d to create
> > > > /dev/freefall, which in turn conflicts with dell-smo8800 which
> > > > is trying to create /dev/freefall itself.
> > >=20
> > > So 4d5538f5882a is breaking lis3lv02d driver...
> >=20
> > Apologies for that.
> >=20
> > I could easily fix this by adding a kernel API to know whether the
> > provided irq is from Host Notify or if it was coming from an actual
> > declaration. However, I have no idea how many other drivers would
> > require this (hopefully only this one).
> >=20
> > One other solution would be to reserve the Host Notify IRQ and let
> > the actual drivers that need it to set it, but this was not the
> > best solution according to Dmitri. On my side, I am not entirely
> > against this given that it's a chip feature, so the driver should
> > be able to know that it's available.
> >=20
> > Dmitri, Wolfram, Jean, any preferences?
>=20
> I read this:
>=20
> "IIRC both dell-smo8800 and lis3lv02d represent one HW device (that
> ST microelectronics accelerometer) but due to complicated HW
> abstraction and layers on Dell laptops it is handled by two drivers,
> one ACPI and one i2c."
>=20
> and that is the core of the issue. You have 2 drivers fighting over
> the same device. Fix this and it will all work.

With my current implementation (which I sent in this patch), they are=20
not fighting.

dell-smo8800 exports /dev/freefall (and nothing more) and lis3lv02d only=20
accelerometer device as lis3lv02d driver does not get IRQ number in=20
platform data.

> As far as I can see hp_accel instantiates lis3lv02d and accesses it
> via ACPI methods, can the same be done for Dell?

No, Dell does not have any ACPI methods. And as I wrote in ACPI or DMI=20
is even not i2c address of device, so it needs to be specified in code=20
itself.

Really there is no other way... :-(

> > > > Also, just to make sure we do not overthink this, I understand
> > > > that not every unit of the models from the whitelist has an
> > > > accelerometer, correct?  In other words, could we perhaps skip
> > > > the part where we are making sure the SMO88xx ACPI device is
> > > > there?
> > >=20
> > > Good question... At least for E6440 I'm did not thing it was
> > > possible to configure notebook without "3 axes free fall
> > > sensor".
> > >=20
> > > But! In BIOS SETUP it is possible to disable free fall sensor. I
> > > will try to disable it there and will check what happen. My
> > > guess is that it will be disabled in ACPI.
> >=20
> > Just adding my 2 cents regarding the whitelist and interaction
> > between those 2 drivers. I find this very fragile to have only one
> > available /dev/freefall node and to rely on the fairness of each
> > driver to not bind one. It would have been much simpler to have
> > /dev/freefallXX and a proper misc class device for it. This way,
> > we don't even need to mutually exclude the drivers. But this is
> > already 8 years old code, so I guess userspace expects this...
> > (why isn't that using the input subsystem at all?).
>=20
> I do not consider throwing a unit down an ordinary user interaction
> ;) So there is no input event code for this.
>=20
> Userspace should really use IIO accelerometer interface here. And
> kernel could provide composite IIO->/dev/freefall bridge, like we

Such "generic" bridge is probably not possible, as /dev/freefall is=20
connected to specific lis3lv02d IRQ.

> did for /dev/input/mice when all userspace wanted only PS/2.
>=20
> Thanks.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1664973.WTD7DvgqBD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhr8mkACgkQi/DJPQPkQ1KylwCguh1Le6yw4zKANHAqPivUG5SE
4kgAoMDlBsLoqp3zen6dOgOXR/kOANRz
=cSq/
-----END PGP SIGNATURE-----

--nextPart1664973.WTD7DvgqBD--
