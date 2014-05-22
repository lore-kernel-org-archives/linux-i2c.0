From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: fix Kconfig dependency
Date: Thu, 22 May 2014 06:58:43 +0200
Message-ID: <537D8403.60400@monstr.eu>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de> <1396852656.682914397@f273.i.mail.ru> <20140407065657.GO29751@pengutronix.de> <1396854155.872298456@f287.i.mail.ru> <4c4d2ba5-f5f6-4589-8a48-6a88d1c16098@VA3EHSMHS046.ehs.local> <20140521082917.GG2708@katana> <78a702ca-5001-444a-b2df-a64de17ffcb6@BY2FFO11FD039.protection.gbl>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="MQ7pQEtSHDibWm42NCMV9XBoLtJfatvGV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <78a702ca-5001-444a-b2df-a64de17ffcb6-neA4ZlFjCT0GPAd83OwqBWYJ4DzVTqeXkX/xN29GLwg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MQ7pQEtSHDibWm42NCMV9XBoLtJfatvGV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/21/2014 06:00 PM, S=C3=B6ren Brinkmann wrote:
> Hi Wolfram,
>=20
> On Wed, 2014-05-21 at 10:29AM +0200, Wolfram Sang wrote:
>>> I'd propose the below fix. The relaxed IO helpers are currently
>>> available on ARM only and the clock notifier used, depends on
>>> COMMON_CLK. I2C-related dependencies should be okay due to the locati=
on in
>>> Kconfig of this option.
>>
>> If somebody thinks an update is still needed, please resend against
>> latest i2c-next. Thanks.
>>
>=20
> I think we're fine for now. Once the *_relaxed IO helpers are available=

> on all archs it makes sense to revisit the COMPILE_TEST option. Until
> then we are restricted to ARM anyway and the additional Zynq restrictio=
n
> doesn't make a big difference, IMHO.
>=20
> @Michal: Do you have an update on the IO helpers?

My patch was replaced by Will's one but I can't see it in linux-next
that's why we should ask directly Will.
Will: What's the status on it?

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--MQ7pQEtSHDibWm42NCMV9XBoLtJfatvGV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlN9hAQACgkQykllyylKDCHYSACfTllddHzMsdZNwXDfBnYDtY8G
eVAAnitFpGXTLSkn5wvU2mXImI5Kq5K+
=9LIr
-----END PGP SIGNATURE-----

--MQ7pQEtSHDibWm42NCMV9XBoLtJfatvGV--
