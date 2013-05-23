From: Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH] i2c-piix4 - Add support for secondary SMBus on AMD
 SB800 and AMD FCH chipsets
Date: Thu, 23 May 2013 09:35:22 +0200
Message-ID: <1369294522.12648.11.camel@mattotaupa>
References: <5196B32D.7060501@assembler.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-ZQUbGVP/H7kmt7P93rgV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5196B32D.7060501-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--=-ZQUbGVP/H7kmt7P93rgV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux folks,


Am Samstag, den 18.05.2013, 00:46 +0200 schrieb Rudolf Marek:

> Attached patch adds support for secondary SMBus of AMD SB800 and new AMD =
FCH=20
> chipsets. The base address of secondary SMBus is different from SB700 and=
 it is=20
> stored on similar place as SB800 primary SMBus.
>=20
> More verbose info:
>=20
> Probing function was just modified to read the SMBus base from address 0x=
28 or=20
> from original 0x2c. The secondary bus does not provide IRQ information.
>=20
> I think the SB700 has same secondary controller, so revision/IRQ informat=
ion=20
> should not be printed too. This can be fixed in some other patch.
>=20
> Chipset datasheet can be found here:=20
> http://support.amd.com/us/Embedded_TechDocs/45482.pdf
>=20
> Tested on SB800 and FCH boards.
>=20
> Tested-by: Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ASRock E350M1 with SB800

Below are my detailed test results according to Rudolf=E2=80=99s instructio=
ns,
he kindly gave me.

> i2c-0	smbus     	SMBus PIIX4 adapter at 0b00    SMBus adapter
> i2c-9	smbus     	SMBus PIIX4 adapter at 8060    SMBus adapter
>
> I dont know if 8060 is correct, can you do please?
>
> isadump 0xcd6 0xcd7

        $ sudo isadump 0xcd6 0xcd7
        WARNING! Running this program can cause system crashes, data loss a=
nd worse!
        I will probe address register 0xcd6 and data register 0xcd7.
        Continue? [Y/n]=20
             0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
        00: 0e 00 4f 4a 00 04 00 02 34 05 04 01 06 21 43 55=20
        10: ff 0f 00 00 ff 0f 00 00 00 00 00 00 00 00 00 00=20
        20: 00 00 d1 fe 01 00 d8 fe 65 80 00 00 01 0b 00 00=20
        30: 00 00 00 00 07 00 c0 fe 00 00 00 00 00 00 00 00=20
        40: 00 00 00 00 00 00 00 80 f1 00 c0 fe 03 00 00 00=20
        50: 1f 00 d0 fe 90 00 00 97 01 ff 15 66 00 05 00 00=20
        60: 00 08 04 08 08 08 10 08 20 08 00 00 00 fe 08 00=20
        70: 00 00 00 00 17 00 00 04 ff ff 00 00 85 01 e0 a0=20
        80: 1f 1a 00 20 00 00 00 00 30 10 00 00 9e 00 80 00=20
        90: 02 05 02 0b 01 00 10 00 00 10 00 10 00 00 00 00=20
        a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
        b0: 00 00 00 00 00 0b 05 05 08 00 08 40 02 00 73 00=20
        c0: f9 0b 78 40 3c 00 00 00 0c 40 28 00 ff ff ff ff=20
        d0: 00 00 30 00 00 00 00 00 15 00 19 00 01 00 10 03=20
        e0: d8 0c 00 00 00 00 00 02 00 00 00 01 03 02 00 4f=20
        f0: 9c 03 00 00 00 00 00 21 6c 27 00 00 00 00 00 00
       =20
> Also you could now invoke
>
> i2cdetect 9
>
> To detect i2c devices on the second bus.

        $ sudo i2cdetect 9
        WARNING! This program can confuse your I2C bus, cause data loss and=
 worse!
        I will probe file /dev/i2c-9.
        I will probe address range 0x03-0x77.
        Continue? [Y/n]=20
             0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
        00:          -- -- -- -- -- -- -- -- -- -- -- -- --=20
        10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
        20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
        30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
        40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
        50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
        60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
        70: -- -- -- -- -- -- -- --
       =20
It looks like no devices on the second bus are found. Here is the output
from device i2c-0 for comparison.

        $ sudo i2cdetect 0
        WARNING! This program can confuse your I2C bus, cause data loss and=
 worse!
        I will probe file /dev/i2c-0.
        I will probe address range 0x03-0x77.
        Continue? [Y/n]=20
             0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
        00:          -- -- -- -- -- -- -- -- -- -- -- -- --=20
        10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
        20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
        30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
        40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
        50: 50 -- 52 -- -- -- -- -- -- -- -- -- -- -- -- --=20
        60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
        70: -- -- -- -- -- -- -- --


> Signed-off-by: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>

Rudolf, it looks like your patch could also update the i2c files under
`Documentation`. At least there are some patches doing that.


Thanks,

Paul

--=-ZQUbGVP/H7kmt7P93rgV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlGdxrsACgkQPX1aK2wOHVjfygCdEVMbbfxZuSt9FyhJDHl7hVMt
R7UAn0ujvREO27VOET2imZRW4oxxkm1h
=vA3y
-----END PGP SIGNATURE-----

--=-ZQUbGVP/H7kmt7P93rgV--
