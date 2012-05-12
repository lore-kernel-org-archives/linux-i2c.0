From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V1 2/2] i2c: tegra: notify transfer-complete after
 clearing status.
Date: Sat, 12 May 2012 15:07:56 +0200
Message-ID: <20120512130756.GI20673@pengutronix.de>
References: <1336373179-12739-1-git-send-email-ldewangan@nvidia.com>
 <1336373179-12739-3-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wjoFZxbW4tu+iR6v"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336373179-12739-3-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--wjoFZxbW4tu+iR6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2012 at 12:16:19PM +0530, Laxman Dewangan wrote:
> The notification of the transfer complete by calling complete()
> should be done after clearing all interrupt status.
> This may avoid the race condition of misconfigure the i2c controller
> in multi-core environment.

"may avoid" or "does avoid"? I.e. does it fix any bug that really
occured? Then I'd add a stable tag.

So far, applied to next.

>  	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
>  		BUG_ON(i2c_dev->msg_buf_remaining);
>  		complete(&i2c_dev->msg_complete);
>  	}

Side note: If you see a way to handle the BUG invocations more
gracefully, that would be appreciated.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--wjoFZxbW4tu+iR6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+uYKwACgkQD27XaX1/VRsVBgCguFJmH6yHRVL2H34Zc0S0G5Xe
kIoAn3OmV02dJOiu/S0rBej/Wiz3nLTV
=34To
-----END PGP SIGNATURE-----

--wjoFZxbW4tu+iR6v--
