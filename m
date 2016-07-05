From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v9 1/2] i2c: i801: add support of Host Notify
Date: Wed, 6 Jul 2016 00:40:07 +0900
Message-ID: <20160705154006.GE3641@tetsubishi>
References: <1466779189-8455-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48625 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524AbcGEPk6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 5 Jul 2016 11:40:58 -0400
Content-Disposition: inline
In-Reply-To: <1466779189-8455-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jean Delvare <jdelvare@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 24, 2016 at 04:39:49PM +0200, Benjamin Tissoires wrote:
> The i801 chip can handle the Host Notify feature since ICH 3 as mentioned
> in http://www.intel.com/content/dam/doc/datasheet/82801ca-io-controller-h=
ub-3-datasheet.pdf
>=20
> Enable the functionality unconditionally and propagate the alert
> on each notification.
>=20
> With a T440s and a Synaptics touchpad that implements Host Notify, the
> payload data is always 0x0000, so I am not sure if the device actually
> sends the payload or if there is a problem regarding the implementation.
>=20
> Tested-by: Andrew Duggan <aduggan@synaptics.com>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-next, thanks!


--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXe9TVAAoJEBQN5MwUoCm2GCoP/RzRi/000YqYIm26qqxeHjnN
ESriuCzshAEyF895C4P0v3oB5jpJIDiPSbOgBJ1ZmE8K/+1scPljj83fZOrcmRxQ
UQT0zXRE1OFYYhz0ujzG0zRjVOcwrto12YyrBmXpBcuzx/2fFgTgIbEdxZGNOVSz
855er7Q1jvs5/ZAFP5D41ymK+g+tje8zEs1KIqI7l5b3TfSVwwZuvhf6DtOLaN1l
NxXFqg/JdkFd+WU28o2frKiA+1AqCoyVw3f4TWWxaKAsAN7ZT+dZ7aYB309ktHY/
U/GCujMPi/fIaEbiURkVjkat9h9dDJ/voljxASvYlAx4faT9bZsSiYnyoIzECloj
JHT6I2VcW/CrElIn6laEKHFDr/THq5x3wndauk+Qtwv/wVMcxf53AIHNxxxe1cOQ
x0DyNMGlhVM1aScfgqLS520QCa1+gXmnY6V6XKPFuzbt/Xu88rpeKOGifnlp2Wzz
EZotzI6BIWx8+BQq94+ss7KKCCa5oX8DsVyYxvMSSnxi9FoOnBa8KdZ+tqx79NkF
LuW0X/UzU9LMgMeaYxzzCn432TMhcDDIoaIdD+bZAfhTK3Pzgqjh7Hcgb+4wo2fq
wSixyzqv6RA5yFaQYV8xIpUpWSDXIsbFM19iu7ie32/6CP2JeTtUnEzXW+oBm01D
XDUs37VzsNY2NZJ9NZib
=oPxO
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
