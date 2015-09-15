From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Fix for Dell P57G touchpad found, need advice on patch
Date: Tue, 15 Sep 2015 18:42:14 +0200
Message-ID: <20150915164214.GD1525@katana>
References: <CAN_72e1BBk_s1BRBHJYuA7+2nbfYf1bCoD9fqatmTxRM_w=myg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAN_72e1BBk_s1BRBHJYuA7+2nbfYf1bCoD9fqatmTxRM_w=myg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Roskin <plroskin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Thu, Sep 10, 2015 at 11:11:41PM -0700, Pavel Roskin wrote:
> Hi!

Thanks for this detailed info. Adding Mika to CC who is an expert of
this driver. Mika, maybe we should add you to MAINTAINERS, too?

> I'm using Dell Inspiron 13, model P57G. It has a problem with the
> touchpad under Linux. Approximately half of the time, the touchpad is
> not working at all - the mouse cursor is not moving. In this case,
> there are error messages written to the kernel log every second:
>=20
> [   53.127339] i2c_designware INT3433:00: controller timed out
> [   54.219336] i2c_designware INT3433:00: controller timed out
> [   55.311346] i2c_designware INT3433:00: controller timed out
> [   56.403326] i2c_designware INT3433:00: controller timed out
>=20
> There is a simple fix - blacklist the driver
> (i2c_designware_platform). In this case, the touchpad words as a mouse
> and used IRQ 12. Googling for "blackist i2c_designware_platform" shows
> that I'm not the one using that approach.
>=20
> I started looking at the driver in git. A patch by Romain Baeriswyl
> applied on 2014-08-20 adds support for the "standard" mode with the
> 100kHz clock, as opposed to the 400kHz "fast" mode. Unfortunately,
> that patch only affects OpenFirmware systems, and I have ACPI. As soon
> as I set the clock to 100kHz, the touchpad started working every time.
>=20
> One fix would be to have a module parameter to force slower clock. It
> would still require users to deal with modprobe, so it's not optimal.
>=20
> I noticed that dev->get_clk_rate_khz(dev) returns 100000, but that
> would be 100000kHz =3D 100MHz. Not sure is somebody confused the units
> or it's the correct clock.
>=20
> Considering that I have no other systems to test, what would be the
> best approach? Set the clock to 100kHz for INT3433? Recognize Dell
> P57G system specifically? How? Preserve the original clock by reading
> the DW_IC_CON register and keeping some bits?

Note: The driver has been using 400kHz from its beginning. However,
100kHz is usually a better default for I2C busses. I wonder if we should
take the risk of a performance regression in favour of a sane and
working default?

Regards,

   Wolfram


--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV+EplAAoJEBQN5MwUoCm29y8P/jldgTzfG2QKtiAFw2EuqkIc
PuSthswQnVLM5Kjh4CoIQmnFRcvyETirW5FZqo3EOWvvCWsAfiQhkLVDLgjUcD00
Siqgf+qFHIHRGb2dfdON4/L9z9XfvGbz+vwzfJ8HQ5QZs+JaH4ubIA6U64pr4AMh
GKBDBPa7bNUFTHr8/AZt1t2onYS1/7RyUJIO3/TP3MQpqe4vF4a8NYgOphOXph8f
3ESI6jKqa3CVVborI5V3gwSQf1gG20WdswG0HRBxdxO1+u5kq56A1USjGSrb9RZK
WXtDw0Gx7iRIBFHVPoXoelBfoE3dLtTgFS2pNTSjgrLJ6TX6DEAyIeeIwIONU1rC
e8PBwnaFqiHnBGWFjXIJMgrydYwfx8wBLj5JjC4JJjsWdcPDB2yrWmVW0URj4ahO
doqayoGmhIEX1xnNo32yAgO6Qdab732vuSiHtfEA1lzTQ7gqcvaeVbwnYwUn+M9g
zDLF4AlssJ2JL+DIarQMkkju0XtCOLUggusYA59zey7j2CoJt1/nwUjaU/jjI/UU
6s8MSWYW9u94Z0AflGh/Lnbp9ltNSJq7ItduA7JerxB4E9Vld1Ij+0b8MENRN/9x
r/gPcdx5S+D90l9KnlMuFYnA7/HcdH8GxGYuK7UAdmyE7R9uNvEWNXPyGZVos+T5
FvnauzRexo4ocaPOpR41
=e2S8
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
