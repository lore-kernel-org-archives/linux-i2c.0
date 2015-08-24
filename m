From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC] i2c: Revert back to old device naming for ACPI enumerated
 I2C slaves
Date: Mon, 24 Aug 2015 15:26:13 +0200
Message-ID: <20150824132612.GA10078@katana>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440413522-7855-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dustin Byford <dustin-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2015 at 01:52:02PM +0300, Jarkko Nikula wrote:
> Commit 70762abb9f89 ("i2c: Use stable dev_name for ACPI enumerated I2C
> slaves") broke the lm-sensors which relies on I2C hwmon slave devices und=
er
> /sys/bus/i2c/devices/ to be named as "x-00yz". However if those hwmon
> devices are ACPI 5 enumerated their name became "i2c-INTABCD:ij" and sysfs
> code in lm-sensors does not find them anymore:
>=20
> lib/sysfs.c:665:
> if ((!subsys || !strcmp(subsys, "i2c")) &&
>     sscanf(dev_name, "%hd-%x", &entry.chip.bus.nr,
> 	   &entry.chip.addr) =3D=3D 2) {
>=20
> This patch fixes this by reverting back the old device naming in i2c-core
> but at the same avoids regression to ALSA SoC drivers that depend on stab=
le
> device binding.

This way we fix some userspace by going back. However, this name change
was effective for 18 months, so enough time for some other userspace to
adapt. We would break the latter by reverting.

I tend to create the symlinks to prevent any further breakage. I am open
for other suggestions, though. This ugly situation has surely happened
before somewhere somewhen in the kernel :/

   Wolfram

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV2xt0AAoJEBQN5MwUoCm23J0P/0YDUWsezA++Pu6BQSJCCddQ
d1hecuxEGecza0ppyHbmWSySZr2RQRvmgomafhczMGBX4BKY/NxFMSqvwU+rZK9e
M6U+ggoCk8PulO3uTSFyv7841EqI95Dwmnbo6ewtcumcxgDD2IYuwy8sEhBeVqdp
FFsR4BideDYWxawMZfwEcP4PiJrRAbnpnG0qaIk0OE1qzoEKwxKDu7IA5MM+oj1T
fyI3p7Z8nCIn+MEy14l4v48/7JLP1f28srEypMq2kHmRKJqVREH6q91bQeQtTs7V
ifRQntMzFjQCYQ3nx5MaA4lneq1YjYB/wXDmI3gzRFmZzIR6ELbRqTUv02ykMYmj
ubi/4RDuv2ci+SipWoAfxhQaizzBueVCugJ25a8VfZIZL6+qxCHsY0uD54Q4g8Xr
NJdyjJtAww2UcmbpL91xnphEk3k+G1W8lTm4m7XmntTY2E38vuqN9ulyp87Pppyu
lEUdEcdZyBMWDSlEs64JZ0OlvRdlkZ+sjhn9act7FrkeuoFfXHDL4zo5YAV16Odk
AV4f3itN96PaUw+rPDTSL1SUEOUiPYKkoup20tWBSXk3vO9Aoq5BAUtm1WsmlCkc
SFA16tLPDJ+kK5jtk6XIuwtsQLUWveYgEh1KtMp77iYPc3BcD9OWRQ81XQrReXVH
BbBb+N2mf/frtFwhsnmj
=y5uz
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
