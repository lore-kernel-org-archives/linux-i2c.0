From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: Debian Jessie on QNAP TS-112P - Reboot instead of shutdown
Date: Mon, 8 Aug 2016 09:13:56 +0200
Message-ID: <20160808071356.znfz3jwytu3iavtz@perseus.defre.kleine-koenig.org>
References: <20160717115512.GA10098@perseus.defre.kleine-koenig.org>
 <578D1EE6.1070803@gmx.com>
 <20160718192720.GA30825@perseus.defre.kleine-koenig.org>
 <578E83B8.3000009@gmx.com>
 <20160719201014.GA19250@perseus.defre.kleine-koenig.org>
 <57A6328F.4060102@gmx.com>
 <0a25e444-4103-ff2b-a1e4-9027db7c4ae3@kleine-koenig.org>
 <57A70175.6090305@gmx.com>
 <2c5a5526-2325-8683-aaa1-de067ae38d29@kleine-koenig.org>
 <57A7827D.20007@gmx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gxlj7wmh7nwy73kw"
Return-path: <bounce-debian-arm=debian-arm=m.gmane.org@lists.debian.org>
Content-Disposition: inline
In-Reply-To: <57A7827D.20007@gmx.com>
Resent-Message-ID: <-BJYGoZjv9N.A.nHC.HFDqXB@bendel>
List-URL: <https://lists.debian.org/debian-arm/>
List-Post: <mailto:debian-arm@lists.debian.org>
List-Help: <mailto:debian-arm-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-arm-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-arm-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/20160808071356.znfz3jwytu3iavtz@perseus.defre.kleine-koenig.org
To: Helge Wiemann <helge.wiemann@gmx.com>
Cc: debian-arm@lists.debian.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--gxlj7wmh7nwy73kw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Helge,

Cc: +=3D linux-i2c

On Sun, Aug 07, 2016 at 08:48:29PM +0200, Helge Wiemann wrote:
> I located the battery and removed it for 60 seconds, then booted up my NAS
> and performed your commands. My syslog and tracelog are attached.
>=20
> I think this made no difference. The date is still incorrect.

This didn't help, the bus is still stuck:

> [    2.817881] i2c i2c-0: mv64xxx_i2c_fsm: Ctlr Error -- state: 0x7, stat=
us: 0x38, addr: 0x30, flags: 0x1

This translates to:
	state: MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_DATA
	status: MV64XXX_I2C_STATUS_MAST_LOST_ARB

Not sure this is accurate though.

=46rom a quick look the mv64xxx driver doesn't support bus recovery. So
unless someone implements this the best bet is probably:

 - do it by hand, maybe from the bootloader
 - do it really by hand, by shortcutting ground and SCL up to 9 times
   until SDA goes high again.

Maybe someone from the i2c folks has a better idea.

Best regards
Uwe

--gxlj7wmh7nwy73kw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXqDEwAAoJEMH8FHityuwJJmEIAJO2xklzBlCL0EjnMetLe+N+
KPLGzR9QgtKS0HYqpQ5ScCOAGuOy7vbFNsaCNz575YF7UGac340+5Kw2YS1XdVez
uiRQfwAU6lxk2KT80y8bDi4aTkRqpNwZI1fHIvm7Lts+6D9lPoe9vmSlF8oqsgj1
zaTn7XcrI6QcgWIXk2nC+G5ko3cD1E23tmQTSaZg3rl61DLR7SXEbl8tRccWZQ3M
j4eJzL7NnFA+pVgCKOvbSrtIKvEY8hgrFN06quN+nP1lQ+Jnqi3mA/7BynKpjazS
STZQ6LI5WMVsa9Oph8/cBOdcXJipoPgR6eypU5nbdFyMq5N9B9hag21RkU3KFu4=
=+Zq0
-----END PGP SIGNATURE-----

--gxlj7wmh7nwy73kw--
