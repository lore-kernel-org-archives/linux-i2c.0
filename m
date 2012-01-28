From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] at24: add kernel side usage description
Date: Sat, 28 Jan 2012 23:53:36 +0100
Message-ID: <20120128225336.GC26708@pengutronix.de>
References: <1327507871-15211-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1327507871-15211-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 25, 2012 at 05:11:11PM +0100, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org wrote:
> From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>=20
> Add EEPROM usage instructions and example for kernel side.
> dm644x-evm was taken as example.
>=20
> Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> ---
>  drivers/misc/eeprom/at24.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index ab1ad41..49494ad 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -438,6 +438,15 @@ static ssize_t at24_bin_write(struct file *filp, str=
uct kobject *kobj,
>   * This lets other kernel code access the eeprom data. For example, it
>   * might hold a board's Ethernet address, or board-specific calibration
>   * data generated on the manufacturing floor.
> + *
> + * struct at24_platform_data provides special hook .setup, that can
> + * invoke at24_macc_read()/at24_macc_write() through memory_accessor:
> + *=20
> + * void		(*setup)(struct memory_accessor *, void *context);
> + *
> + * setup hook (if provided) will be executed at the end of at24_probe().
> + *
> + * See arch/arm/mach-davinci/board-dm644x-evm.c for details.

I think a reference to some board code is not good, since the code might ch=
ange
for whatever reason. I know that I suggested to place the comment there, but
meanwhile I think at24_platform_data really needs to get proper kernel-doc
annotations, also including your suggestion. I won't force that on you and =
will
do it in the next days, unless you are eager to do it, of course :)

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8kfHAACgkQD27XaX1/VRvNgACfRFKlYon+0Y6cfbSSRIw9zF5e
UsEAnj3fulrDwJnoaop5y+/BMd/lupPz
=0WDy
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
