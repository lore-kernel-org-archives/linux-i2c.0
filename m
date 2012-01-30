From: Roman Mamedov <rm-pzoh41kZ4TQvJsYlp49lxw@public.gmane.org>
Subject: Re: [2.6.37 -> 2.6.38 regression] "mv64xxx: I2C bus locked, block:
 1, time_left: 0" every few seconds
Date: Tue, 31 Jan 2012 02:53:29 +0600
Message-ID: <20120131025329.30e73a3f@natsu>
References: <20120101042401.4bef017e@natsu>
	<20120101073255.GA2402@elie.hsd1.il.comcast.net>
	<20120108004502.GA20549@ericsson.com>
	<20120131024429.2affbd1c@natsu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/HHMXivSGeXY7.O3THjI8M4e"; protocol="application/pgp-signature"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120131024429.2affbd1c@natsu>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roman Mamedov <rm-pzoh41kZ4TQvJsYlp49lxw@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnaud Patard <arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Manuel Roeder <manuel_roeder-Mmb7MZpHnFY@public.gmane.org>, Michael Ott <michael-rB2af1Vdh+fddJNmlsFzeA@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Mauro Barella <mbarella-RSoB1PSltFvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--Sig_/HHMXivSGeXY7.O3THjI8M4e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Jan 2012 02:44:29 +0600
Roman Mamedov <rm-pzoh41kZ4TQvJsYlp49lxw@public.gmane.org> wrote:

> On Sat, 7 Jan 2012 16:45:02 -0800
> Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org> wrote:
>=20
> > >  - Michael Ott reported with Debian kernel 2.6.38-3 (which is closely
> > >    based on stable v2.6.38.2):
> > >=20
> > > 	syslog tell me every few seconds:
> > > 	i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> > >=20
> > >  - Manuel Roeder reported the same and found that upstream v2.6.38
> > >    triggers the problem and v2.6.37.6 does not.
> > >=20
> > >  - Roman Mamedov finds the bug present in Debian 3.1.6-1 (which
> > >    is closely based on stable v3.1.6) and Debian 2.6.37-2 (based on
> > >    stable v2.6.37.2) but not Debian 2.6.37-1 (based on mainline
> > >    v2.6.37).
> > >=20
> > > The regression range described above seems a little inconsistent to
> > > me, so maybe there's something more going on.
> > >=20
> > Points to commit eda6bee6c7e67b5bd17bdbced0926f5687f686d5 (i2c-mv64xxx:=
 send repeated START
> > between messages in xfer). Maybe you can back it out and see if it make=
s a difference.
>=20
> Hello,
>=20
> I have just confirmed that the problem still occurs in the current
> 3.2.2, and is indeed solved by rolling-back the referred commit.
>=20
> Should be noted that beside the "I2C bus locked" messages in dmesg, the d=
escribed problem
> manifested itself in the inability to read the temperature sensor value o=
r adjust the fan
> speed on the D-Link DNS-323. On all problematic kernels the built-in fan =
of DNS-323 does not
> rotate and this risks overheating the device and disks installed in it.

Also if anyone decides to further debug this, I should note that once a
'problematic' kernel has booted once on the device, a full power-off seems =
to
be required, before a 'good' kernel can work properly. Without this, even a
working kernel will manifest the same problem, it looks like something in t=
he
hardware gets locked-up hard and stays that way even across reboots. If
someone's unaware of this, it can completely foil any attempt at git bisect=
ing.

--=20
With respect,
Roman

~~~~~~~~~~~~~~~~~~~~~~~~~~~
"Stallman had a printer,
with code he could not see.
So he began to tinker,
and set the software free."

--Sig_/HHMXivSGeXY7.O3THjI8M4e
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8nA0kACgkQTLKSvz+PZwiwrACfVeXUL5wCGm2XsiOYC5DstB2c
ftAAn2Y4QFlNEYc5rRl9NF+I/XrkdNIn
=YJ91
-----END PGP SIGNATURE-----

--Sig_/HHMXivSGeXY7.O3THjI8M4e--
