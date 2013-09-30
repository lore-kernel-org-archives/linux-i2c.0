From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: xilinx: Fix i2c sparse warnings
Date: Mon, 30 Sep 2013 15:24:30 +0200
Message-ID: <52497B8E.1030009@monstr.eu>
References: <c122ad49b27406ee495ef0d6cac191968d64f09f.1380532113.git.michal.simek@xilinx.com> <20130930102342.GC3222@katana>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kA5gnpWEu1sUigpwhUtMH0dPSvtsxXlvi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130930102342.GC3222@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kedareswara rao Appana <appana.durga.rao-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kedareswara rao Appana <appanad-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kA5gnpWEu1sUigpwhUtMH0dPSvtsxXlvi
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/30/2013 12:23 PM, Wolfram Sang wrote:
> On Mon, Sep 30, 2013 at 11:08:50AM +0200, Michal Simek wrote:
>> From: Kedareswara rao Appana <appana.durga.rao-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>>
>> code changes to fix sparse warnings
>=20
> Would be nice to either have them listed here or at least shortly
> described.

I will send v2. I see that Kedar wrote sparse warning but they are
checkpatch warnings.
I will fix that.

Thanks,
Michal



--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--kA5gnpWEu1sUigpwhUtMH0dPSvtsxXlvi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJJe44ACgkQykllyylKDCGoDQCfQUAvRKEr67tf56kYV5ivz5hP
O2cAn08VoPb2DFW7btZI5gvOtlK0md08
=ML9D
-----END PGP SIGNATURE-----

--kA5gnpWEu1sUigpwhUtMH0dPSvtsxXlvi--
