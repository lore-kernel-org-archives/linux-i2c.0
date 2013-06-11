From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: prevent signals from aborting I2C
 transfers
Date: Tue, 11 Jun 2013 20:35:03 +0200
Message-ID: <20130611183503.GC3376@katana>
References: <1369216991-13334-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1369216991-13334-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2013 at 01:03:11PM +0300, Mika Westerberg wrote:
> If a process receives signal while it is waiting for I2C transfer to
> complete, an error is returned to the caller and the transfer is aborted.
> This can cause the driver to fail subsequent transfers. Also according to
> commit d295a86eab2 (i2c: mv64xxx: work around signals causing I2C
> transactions to be aborted) I2C drivers aren't supposed to abort
> transactions on signals.
>=20
> To prevent this switch to use wait_for_completion_timeout() instead of
> wait_for_completion_interruptible_timeout() in the designware I2C driver.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to for-next, thanks!


--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRt23WAAoJEBQN5MwUoCm2NcoP/268JKibt4ys1HTORIykAIrB
CuOHwqQmcpZaEoMzB00lhC6brqDZZODTADoWKx3i0rgEUKxvPDVx3d7JBJed8zl1
xZSqN0I135LOS4sPi85fejLqJ1J6hpqW5hyhGeMgdK3AIccIM7PPCLdJhecefERa
6S9G6PUPEqwafNiuZnqYYY06tw4tqsBVkCjPSlzx/rg2VUPu95p9cDEptWcfOGBz
IPWRCVZ1+HDKBbsk7eAc6zPp+caGq4QkGZceIFW2gZYdZ/+H/fMdTEQi55QRchM9
2Yy61IVHXGm6raQqQqgLTHhAzQcpH2ekcPEpDkkSxVGPLjSaWLIkGWrT5INaZUNV
U+HmD+2O3K7gwkoar1UMj9u+GOjvOOts2PGlNjM/aE8OZ5DLVWvkHXT+YVdJUnqf
/LwXTEkeGregRMQrsp303qg9OczLQvI5bPk5jH3zevMa819ypIaN6obEM/F3me6S
Fz95NYh/LihuVW7JTI2tk0GunUunC3Cfjj/FBxDfltw+SzAhX5EH05tMf6XwEjmm
U44uvOOaaD0MIdTC+hA6DhhmL337MwflfR/dAuqq8M/w51WjHeWEhnjqiaAXp0tR
JyNM6FcuEMUsXmIB1yQ8jgTnZ+3um+k2lCJ2jAdI2vJcbpUNxfB4upJ3j6Hy4x1K
xTSYuDONtz8WJ9XAcuVv
=chgU
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
