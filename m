From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: cadence: Remove .owner field for driver
Date: Mon, 22 Sep 2014 11:36:53 +0200
Message-ID: <541FEDB5.7050305@monstr.eu>
References: <c076984af7e65c433fdfd3a3b0f8d20da2c18013.1407931005.git.michal.simek@xilinx.com> <20140920091106.GB1612@katana>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="aauvXf1ma3JD5wabEldwhj6hfVluxGjfV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140920091106.GB1612@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aauvXf1ma3JD5wabEldwhj6hfVluxGjfV
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/20/2014 11:11 AM, Wolfram Sang wrote:
> On Wed, Aug 13, 2014 at 01:56:51PM +0200, Michal Simek wrote:
>> There is no need to init .owner field.
>>
>> Based on the patch from Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> "mmc: remove .owner field for drivers using module_platform_driver"
								     ^
this shouldn't be there.

>>
>> This patch removes the superflous .owner field for drivers which
>=20
> It says drivers, but does only one...

I have c&p this from Peter's description that's why there are just driver=
s.

>=20
>> use the module_platform_driver API, as this is overriden in
>> platform_driver_register anyway."
>=20
> ... so: any interest in doing this for the whole subsystem? Basically
> good catch, though.

Mark was also interested about doing this for spi. Doing this for the who=
le
kernel will be the best. coccinelle script
is good option I have never played with it.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--aauvXf1ma3JD5wabEldwhj6hfVluxGjfV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlQf7bkACgkQykllyylKDCH8PACfaBXvXrmdurvKJ+74hpno1DCq
8eoAn201AIu82uVuVaL62q/jr0Nu1z+s
=bpbI
-----END PGP SIGNATURE-----

--aauvXf1ma3JD5wabEldwhj6hfVluxGjfV--
