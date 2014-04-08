From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: fix Kconfig dependency
Date: Tue, 08 Apr 2014 10:33:19 +0200
Message-ID: <5343B44F.2070407@monstr.eu>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de> <20140407063100.GN29751@pengutronix.de> <5342481B.6020600@monstr.eu> <20140407065651.GA2609@katana>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="G5iiHHb33rEa0rC3O1V14R7UwjvId8eoJ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140407065651.GA2609@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G5iiHHb33rEa0rC3O1V14R7UwjvId8eoJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/07/2014 08:56 AM, Wolfram Sang wrote:
>=20
>> I would suggest to add relaxed IO helper function to asm-generic/io.h
>> to be available for all archs. Then we can avoid this type of errors.
>=20
> I favour this, too. For the cadence driver, I needed a quick solution
> before linux-next breaks, though.
>=20

FYI: Here is the patch
http://www.spinics.net/lists/kernel/msg1718606.html

Thanks,
Michal
--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--G5iiHHb33rEa0rC3O1V14R7UwjvId8eoJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNDtE8ACgkQykllyylKDCG4ggCghEvEV+gSfTyHpvICcqTflkmj
hPkAn1j2liATzdlt8gCIO6MClg9MMe3i
=4+5Y
-----END PGP SIGNATURE-----

--G5iiHHb33rEa0rC3O1V14R7UwjvId8eoJ--
