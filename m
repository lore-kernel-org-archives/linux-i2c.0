From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-designware-pci: Index Haswell ULT bus names from
 0
Date: Thu, 14 Nov 2013 19:05:38 +0100
Message-ID: <20131114180538.GK11022@katana>
References: <1382326010-4554-1-git-send-email-bleung@chromium.org>
 <1382326010-4554-3-git-send-email-bleung@chromium.org>
 <20131021065804.GX3521@intel.com>
 <CANLzEksGqD30Cefh3r2urH-ToxWzkxAnTJZiY07yX2Py58FQPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwbb4r/vLufKlfJs"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANLzEksGqD30Cefh3r2urH-ToxWzkxAnTJZiY07yX2Py58FQPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Duncan Laurie <dlaurie-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--rwbb4r/vLufKlfJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> In the chromeos_laptop driver, I do by-name matching of i2c busses to
> find busses and instantiate devices, so there is value to have each
> named something predictable.

Any why don't you use fixed bus numbers which you can attach the devices
to?


--rwbb4r/vLufKlfJs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJShRDyAAoJEBQN5MwUoCm2CBwP/0a1exmWGyB60VLyp8W6+dLa
XZKZfPfx8ogv0LfCjrfOiyxs0nzmKH2l9nd7ab6PbDdJgbvzYZ+IvmRh+J9wH/A4
kOFnAGSwF3xOIx+RLil+e/J6MZ7auaNYIhMKD0orBAkoVoIv0xP3rL68MibQ6N52
W0CJTWFCaj3XhzOLOtu0FakkPzhzAF1ZoP/B/sBgjs0TVWVn43MbfdtklpOEEtJK
APvgb/oG7cCTTPF17IrquEVRFIWbewvsNJHxt/wr9CSKvWPobKvIsloQ5u5B0Ys7
n4rhiI+rjckUW3YWIeiqe1+SHdMFpbypWjWXXRi30YQTIF3mWjiNBxYTODzvAyu3
pzU+cmTovS6csbXRWLlh5Y2OMGkoQbJeQk/DuezNEkfCxZQbZLfBFu/n5MC0n/mT
rinu8ddHSG89UDI7EatISGYxfMEgg5l3DLQrUbMlovCMCxxP+n7GXwx8H0scoS86
zKedbQy/Rfh4lxLXVksgiNyJbe8oUtZ5rPFT60ew1dxWtWFHTjIB2G4YrvRQjpEd
IFahtezYutzzzB3xuhtY+lEqxevKlRROZcH/1pdT/rvs8wXgZL/R2B42AqFtg+Up
oq7QitIepFGovD4dz62JWDQWan0QJf7i+7WY4hLxUm0hTpgHV+57INGkLIpQF2xm
6vCDDlU2H4ij5QP3dcc/
=yv6l
-----END PGP SIGNATURE-----

--rwbb4r/vLufKlfJs--
