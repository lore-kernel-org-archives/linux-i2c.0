From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Fix for Dell P57G touchpad found, need advice on patch
Date: Tue, 15 Sep 2015 19:11:51 +0200
Message-ID: <20150915171151.GF1525@katana>
References: <CAN_72e1BBk_s1BRBHJYuA7+2nbfYf1bCoD9fqatmTxRM_w=myg@mail.gmail.com>
 <20150915164214.GD1525@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150915164214.GD1525@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Roskin <plroskin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2015 at 06:42:14PM +0200, Wolfram Sang wrote:
> Hi Pavel,
>=20
> On Thu, Sep 10, 2015 at 11:11:41PM -0700, Pavel Roskin wrote:
> > Hi!
>=20
> Thanks for this detailed info. Adding Mika to CC who is an expert of
> this driver. Mika, maybe we should add you to MAINTAINERS, too?
>=20

And forgot to add Mika :)

> > I'm using Dell Inspiron 13, model P57G. It has a problem with the
> > touchpad under Linux. Approximately half of the time, the touchpad is
> > not working at all - the mouse cursor is not moving. In this case,
> > there are error messages written to the kernel log every second:
> >=20
> > [   53.127339] i2c_designware INT3433:00: controller timed out
> > [   54.219336] i2c_designware INT3433:00: controller timed out
> > [   55.311346] i2c_designware INT3433:00: controller timed out
> > [   56.403326] i2c_designware INT3433:00: controller timed out
> >=20
> > There is a simple fix - blacklist the driver
> > (i2c_designware_platform). In this case, the touchpad words as a mouse
> > and used IRQ 12. Googling for "blackist i2c_designware_platform" shows
> > that I'm not the one using that approach.
> >=20
> > I started looking at the driver in git. A patch by Romain Baeriswyl
> > applied on 2014-08-20 adds support for the "standard" mode with the
> > 100kHz clock, as opposed to the 400kHz "fast" mode. Unfortunately,
> > that patch only affects OpenFirmware systems, and I have ACPI. As soon
> > as I set the clock to 100kHz, the touchpad started working every time.
> >=20
> > One fix would be to have a module parameter to force slower clock. It
> > would still require users to deal with modprobe, so it's not optimal.
> >=20
> > I noticed that dev->get_clk_rate_khz(dev) returns 100000, but that
> > would be 100000kHz =3D 100MHz. Not sure is somebody confused the units
> > or it's the correct clock.
> >=20
> > Considering that I have no other systems to test, what would be the
> > best approach? Set the clock to 100kHz for INT3433? Recognize Dell
> > P57G system specifically? How? Preserve the original clock by reading
> > the DW_IC_CON register and keeping some bits?
>=20
> Note: The driver has been using 400kHz from its beginning. However,
> 100kHz is usually a better default for I2C busses. I wonder if we should
> take the risk of a performance regression in favour of a sane and
> working default?
>=20
> Regards,
>=20
>    Wolfram
>=20



--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV+FFXAAoJEBQN5MwUoCm2lksP/0OuP6FmkRl31W78Bo4Bvl+Q
3XX0FZ0V3yNZQv6wQlmJvIEMSd0xzJb5DwWOq8BxAhBGcio0orUcA7m++xy4wvLu
pyG7SGoeemvLDktGJdjwhl66KFCgDoqVxKcU5YtbEspdL4Lv2lV8TuDudYHNXxT1
YefqxF4QuZZ0tEKleJ04dQaCkUwa8MmQO9AGh5w64rfYE+n/ck2tCTSIIwRwRRoh
Aq0L1yRYyIRorr57DTUF9mjJ05/Ubx8EhyASaFgQfrIHQ3WvGG8WtEi8eLZFGL+6
lRDGzIQ1sAyMjmPClqOP5FzpAJW0GGchwaJyve2m+rOK1ll+EI/81NGxrWr7NrU6
vvJWAMO+EJzOxj16PucwHJHmO+3q4+XIam0sp7PBP/McilVEx8OkaxvSFXIR8/cY
bM0Z+uGAt2JLEeWA6+3QfTGfuX+K7t1xLSr2aPyNkIlOXJVf30gdbJ7ocW0I2r8i
HXU3Fd4wGYk5UoT+Ku+32CESBgriaO8PhYzGxqal+6uBhn0haoTf14ShpVAp1rTh
CMgRNNi4AdQt3F5p+zbhex4Qk2cRVlwEH02DzWegU1EQeppRt2NS03szp9pizqv0
z5BPkaLqH6VSlMQpNoBuznciCNowwcJ79MpK6SUjuDUzJ5Tr0SWyZiFLpWgSNFed
cqkl68xKxAirGdTPB4YS
=nB4D
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
