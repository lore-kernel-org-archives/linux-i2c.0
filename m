From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv3 1/2] i2c: cadence: Move to sensible power management
Date: Mon, 30 Nov 2015 21:10:09 +0100
Message-ID: <20151130201009.GC16446@katana>
References: <1448350317-37077-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37625 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbbK3UKM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 15:10:12 -0500
Content-Disposition: inline
In-Reply-To: <1448350317-37077-1-git-send-email-shubhraj@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-i2c@vger.kernel.org, soren.brinkmann@xilinx.com, michal.simek@xilinx.com, anirudh@xilinx.com, Shubhrajyoti Datta <shubhraj@xilinx.com>


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2015 at 01:01:56PM +0530, Shubhrajyoti Datta wrote:
> Currently the clocks are enabled at probe and disabled at remove.
> Which keeps the clocks enabled even if no transaction is going on.
> This patch enables the clocks at the start of transfer and disables
> after it.
>=20
> Also adapts to runtime pm.
>=20
> converts dev pm to const to silence a checkpatch warning.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>

Applied to for-next, thanks!


--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXK0hAAoJEBQN5MwUoCm2zZ0QAK5wjyDtnN0YIgqE4pRwFjtw
cs1zlI1FYmyrhf52HnyoFe+57a/Ns0chgxXjGVJ7i0QJZjk7w2WIX3k23VxJYwdx
+a2ruR/OyjqtqtvGnP0HiU62T11QTC4ctlygP89P2q4PxsACvYw4hOvMx+wv1OJM
PJyVNDtEthSAR7pteCkaCgbaFdbbEE5lCbYVrMoSlVhQyTaGc3v99ihKycUKjekV
o/Q7ozKFWsAm4lVit4KB9+83cqPHX0HetmdRFED4cqUwaFuvoVhQJANP0ECgVOr4
DtwMYqq648683enffS+ZodhJeWElZUYHg28RZrrV3/hq1347+1r243N/4CLWjj5I
fjyCs2I82pS+xSVfl4PCcb6UsUbR3deA05lYUDyTVgbLSQ+3R4QUVOm75JpYc4cb
z9qRVvxWzIprjQL4WB0nI0qZjdFmlBjORATg7Skbv9rmWvGGMnLFwuHSHFBMB40p
lOeT8xV9rXA2m0V8K+7eRzh4mVubq+SdB/MPnwIcRJ3YJ8i09G71Bd9kxeDEu46z
g/ExWWtrk+IS8tYdpfSEQ0FMQ7gXcozLJT3jz3Uya/E5YAei/56esQFHKhbDaajq
6q0RzpE6YCPJJ75lQzCZQJur5N589e5pWieZ/oetGFbgxrj9ndZTBdDoQkDW2bED
v6I2ts6nqnrKknoOaZ8s
=nWM9
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
