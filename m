From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: at24 driver - a possible problem
Date: Thu, 5 Nov 2009 18:25:37 +0100
Message-ID: <20091105172537.GA3332@pengutronix.de>
References: <533f29860911050810w4d939b39x2ad11c189f13c977@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <533f29860911050810w4d939b39x2ad11c189f13c977-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aleksandar Ivanov <ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Aleksandar,

thank you for your very detailed and very good bug-report. I need to do some
tests myself tomorrow, but I think your assumptions are correct. Possibly we
need a similar loop for the read case. I'll add the linux-i2c-list to cc for
more opinions.

Regards,

   Wolfram

On Thu, Nov 05, 2009 at 06:10:12PM +0200, Aleksandar Ivanov wrote:
> Hello Mr Brownell and Mr Sang,
>=20
> I've been experimenting with the at24 driver I want to make sure that
> what I encountered is not a limitation or a bug of the driver.
> The problem that I am experiencing is that a read operation
> immediately after a write.
>=20
> Here is my testing environment:
> I am using a Linux kernel 2.6.30.3 and have a board with a AT24C512 eepro=
m chip.
> I am using the linux system calls read and write. At the end of the
> e-mail is the source of the test app that I'm using, which does the
> following:
> 1. Opens the eeprom file for reading and writing.
> 2. Performs a 10 byte read.
> 3. Performs a 10 byte write.
> 4. Performs a 10 byte read.
>=20
> The final read fails with the errno seto to ENXIO (6 /* No such device
> or address */).
>=20
> I've compiled the driver with debug information so here is the log
> corresponding to the execution of the test application:
>=20
> i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x50, len=3D2
> i2c-adapter i2c-0: master_xfer[1] R, addr=3D0x50, len=3D10
> at24 0-0050: i2c read 10@0 --> 2
> i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x50, len=3D12
> at24 0-0050: write 10@10 --> 10 (597993)
> i2c-adapter i2c-0: master_xfer[0] W, addr=3D0x50, len=3D2
> i2c-adapter i2c-0: master_xfer[1] R, addr=3D0x50, len=3D10
> at24 0-0050: i2c read 10@20 --> -6
>=20
> The failure is not in 100% of the cases. What I also noted is that if
> I insert a usleep() call, or just a for loop with enough cycles, the
> final read succeeds.
> After looking carefully at your code I found that when in a write
> operation you are expecting that a previous write might still be in
> progress.
> While this is not the case in the read operation.
> Could this be the problem that I am experiencing - the final read
> fails, because the previous write operation is not finished, and the
> read does not have a timeout protection.
>=20
> If you need more information, I'll be glad to help.
> Thanks in advance for your consideration!
> Aleks
>=20
>=20
> Here is the source of the test app:
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <string.h>
> #include <errno.h>
>=20
> #define EPPROM_FILE_NAME    "/sys/class/i2c-adapter/i2c-0/0-0050/eeprom"
>=20
> int main(int argc, char *argv[])
> {
>     char            buf[10];
>     int             bytes =3D 0;
>     const unsigned  len =3D sizeof(buf);
>     int             fd =3D -1;
>=20
>     fd =3D open(EPPROM_FILE_NAME, O_RDWR | O_SYNC);
>     if (-1 =3D=3D fd)
>     {
>         printf("Error opening EEPROM file %s: %s.\n",
> EPPROM_FILE_NAME, strerror(errno));
>         return -1;
>     }
>=20
>     bytes =3D read(fd, buf, len);
>=20
>     if ((bytes > 0) &&
>         (len =3D=3D (unsigned)bytes))
>     {
>         printf("Data read.\n");
>     }
>     else
>     {
>         printf("Failed to read from %s, bytes =3D %d, errno =3D %d, %s\n",
> EPPROM_FILE_NAME, bytes, errno, strerror(errno));
>         close(fd);
>         return -1;
>     }
>=20
>     bytes =3D write(fd, buf, len);
>=20
>     if ((bytes > 0) &&
>         (len =3D=3D (unsigned)bytes))
>     {
>         printf("Data written.\n");
>     }
>     else
>     {
>         printf("Failed to write to %s, bytes =3D %d, %s\n",
> EPPROM_FILE_NAME, bytes, strerror(errno));
>         close(fd);
>         return -1;
>     }
>=20
>     bytes =3D read(fd, buf, len);         // This call fails
>=20
>     if ((bytes > 0) &&
>         (len =3D=3D (unsigned)bytes))
>     {
>         printf("Data read.\n");
>     }
>     else
>     {
>         printf("Failed to read from %s, bytes =3D %d, errno =3D %d, %s\n",
> EPPROM_FILE_NAME, bytes, errno, strerror(errno));
>         close(fd);
>         return -1;
>     }
>=20
>     close(fd);
>     return 0;
> }
>=20
>=20
> Here is the log from my test application:
> "Data read.
> Data written.
> Failed to read from /sys/class/i2c-adapter/i2c-0/0-0050/eeprom, bytes
> =3D -1, errno =3D 6, No such device or address"

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5064 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrzCpEACgkQD27XaX1/VRtMMACgt5SMbveAi9iy0pHUZF90vVdJ
GSYAnRInjLV2+YLeB9fuTtXH1CtAXJXW
=QU8U
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
