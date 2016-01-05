From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v2 0/9] eeprom: at24: at24cs series serial number
 read
Date: Tue, 5 Jan 2016 19:58:53 +0100
Message-ID: <20160105185853.GB1743@katana>
References: <1449051926-21918-1-git-send-email-bgolaszewski@baylibre.com>
 <20151211120831.GA2742@katana>
 <CAMpxmJVag2E4GFSUW10vqCS32cCg0ymqkz=BOE1XS_qo655vBQ@mail.gmail.com>
 <20160102205041.GC1589@katana>
 <CAMpxmJWmgk+9oJXZnRFRzidLaasoMyuDuZmVWWrs6dwNM=+k6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMpxmJWmgk+9oJXZnRFRzidLaasoMyuDuZmVWWrs6dwNM=+k6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 04, 2016 at 03:01:54PM +0100, Bartosz Golaszewski wrote:
> 2016-01-02 21:50 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> > On Fri, Dec 11, 2015 at 02:55:10PM +0100, Bartosz Golaszewski wrote:
> >> 2015-12-11 13:08 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> >> > On Wed, Dec 02, 2015 at 11:25:17AM +0100, Bartosz Golaszewski wrote:
> >> >> Chips from the at24cs EEPROM series have an additional read-only me=
mory area
> >> >> containing a factory pre-programmed serial number. In order to acce=
ss it, a
> >> >> dummy write must be executed before reading the serial number bytes.
> >> >
> >> > Can't you instantiate a read-only EEPROM on this second address? Or a
> >> > seperate driver attaching to this address? What is the advantage of
> >> > having this in at24?
> >> >
> >>
> >> The regular memory area and serial number read-only block share the
> >> internal address pointer. We must ensure that there's no race
> >> conditions between normal EEPROM reads/writes and serial number reads.
> >
> > I don't get it. Both, regular at24 reads and the serial read, setup the
> > pointer every time by using two messages, first write to set the
> > pointer, then read. The per-adapter lock makes sure those two messages
> > will not get interrupted.
>=20
> If that's correct, then is there any need to have an additional mutex
> for at24_data?

I can't see a need, yes.

> In that case would the preferred method be to access the regular
> memory area like before - by allocating, for example, a 24c02 device -
> while allocating a second device - in that case 24cs02 - on the
> corresponding serial number address would give the user access to the
> serial number via the eeprom sysfs attribute (which for the latter
> would be read-only and 16 bytes in size)?

Yes, a seperate driver for the second address is what I meant to suggest
in the above paragraph. Only that the data should probably be exported
via the NVMEM framework, not directly via sysfs. We have patches pending
doing that for at24.

What happens if you assign another at24 instance (read-only) to the
second address? I mean, there is not only the serial number, but also a
MAC address IIRC.

Regards,

   Wolfram


--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWjBJsAAoJEBQN5MwUoCm2hC8P/1O6SLyJ3vSdgW6qKqVrz2GR
LKWohCzh4cQDYFHKtaGOJT25dFwXiO8NVmXCNbGMvrQ2VKTp/rZ6UeAhBqjXbzOZ
V2CoEHE2CH1PnGtE2FI1Et/NPZ2hnWghck3/bL4yTvlcmEYkOSCeHaFeSV3OZqUc
Ol8EqrbUW0/U6daykCeOAZIHEz03EPWQloVJGwUpGmdkCB+OQRqMEdnn5tX/rtvg
3tJBuBUsdipLQlTOkMzgHJgVyQlq76CJdVC5ur2wbqU7Bpf5hlkfNPx8jFrIY0yL
JYef3xgR9xC2naCB/5D/qJrt70TMtBtozu8mKoopH/XrCVc5tfpFzy/9Vgvv3me8
GyQVvbn7ZToUlAyUjXqbxmxNznSp6hId6VVT0FNID28GNu6m49hvjvqdGWHv9LdP
XaHOmlbyk8aSkBnbeJplPldB5xd6l3gWtPPD+mc8fcdssYqQzw0hBK9o4sHD22Kw
YxylC+Rn8J0eH+pydHFMyUFPgnitU0hupWP1jmH3cYBFtPseXLN8wzS7iEI/hneR
GMRL4rPazdxQav++SPKhGhmWoM6TthX+jQg1sGkh+hMgJOuIp/DxbQ/tXkvXBhSG
51sAhmZ9CPiVykoUkWa/+7oc3VP8SI3svG020Yqc/p+Jr3fZo2kMosTHl987dm2V
tXaI0H37dh4btUtDW3q+
=8FUE
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
