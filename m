From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH v2 3/3] i2c: xilinx: Use devm_* functions
Date: Fri, 04 Oct 2013 11:16:20 +0200
Message-ID: <524E8764.4030704@monstr.eu>
References: <f3fd6f38d2553e59b077edff1969f4d07f8aa811.1380550490.git.michal.simek@xilinx.com> <83ec9558211389896f21d9682e9824cd7979466c.1380550490.git.michal.simek@xilinx.com> <20131004053323.GB3194@katana>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CQ23bgmCkLFHrUg7R8N1uus0QFjqeSUE3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131004053323.GB3194@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kedareswara rao Appana <appana.durga.rao-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kedareswara rao Appana <appanad-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CQ23bgmCkLFHrUg7R8N1uus0QFjqeSUE3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/04/2013 07:33 AM, Wolfram Sang wrote:
>=20
>> +	i2c->base =3D devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(i2c->base)) {
>> +		dev_err(&pdev->dev, "Could not allocate iomem\n");
>=20
> devm_ioremap_resource already prints error messages.

you are right.

>=20
>> +	ret =3D devm_request_irq(&pdev->dev, irq, xiic_isr, 0, pdev->name, i=
2c);
>=20
> This is too early. Can you find out why?

Why do you think that it is too early?
I am looking at origin code again and I think that the code
is also problematic because in xiic_reinit() interrupts are enabled
but they are requested later.
Shouldn't be there a logic that interrupts should be enabled when
interrupts are registered by the kernel?

>> +	pdata =3D (struct xiic_i2c_platform_data *)dev_get_platdata(&pdev->d=
ev);
>=20
> Casting a void pointer?

No problem with that.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--CQ23bgmCkLFHrUg7R8N1uus0QFjqeSUE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJOh2QACgkQykllyylKDCHAngCeLEt9snMTW3A7VzADLxMZqjj5
Rd8Anivajqrb9B49vFxMHQoHMNyWnlZk
=RFUE
-----END PGP SIGNATURE-----

--CQ23bgmCkLFHrUg7R8N1uus0QFjqeSUE3--
