From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 1/4] i2c-mv64xxx: Set bus frequency to 100kHz if
 clock-frequency is not provided
Date: Tue, 25 Jun 2013 23:44:47 +0200
Message-ID: <20130625214446.GA2951@katana>
References: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
 <1371821529-13791-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371821529-13791-2-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2013 at 03:32:06PM +0200, Gregory CLEMENT wrote:
> This commit adds checking whether clock-frequency property acquisition
> has succeeded. If not, the frequency is set to 100kHz by default.
>=20
> The Device Tree binding documentation is updated accordingly.
>=20
> Based on the intials patches from Zbigniew Bodek
>=20
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Signed-off-by: Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>

Applied to for-next, thanks! Rest of the series is 3.12 material.


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRyg9OAAoJEBQN5MwUoCm2EOsQAIjDvRKoOQtCRSkZGK16dXmo
2FB1gCQFKlAwgLyhyVEM7Bp03yRXhxigEYhGHFPr16jiwudqa3AuZb/TmrXo4DhC
+tFA7XMZJOUV9whx117tbyfSRUfVFEnG+mbT1zhPNeEPNBT3YvGNWopSuBLpVsTG
I98+bPp6Xc2p3IvejV+0ze5VdlfomLVN7ptO9X6i1AqB0lFFuiIflfYmHoc08ZPn
f7NxHngXAxidBVTYLiWaDpIgw1uiNS/CZhW3Blq0UJ/ZJPaxrcAV9/wsm7h3jUds
mxywLKdwqpRlW43uMx0yREiIKS6DQ5pGikasgvLviUMtijK6vbggc9oTTE/ljn4e
cJJMDVc1lD6Yh3QGjIMQsXqe6PtjEkyJW8t7vokZt2Ood5tIllp0kVIIPxDpR48M
GGKFlwFQf5SYbC6lyRyEPyN//+6VWs8aUImJychIKMWFreKfLmstoyyGvXwtHiQY
vIvT08HFEAmPmuAzwwZUgpkl6raoaP2Mn3vkRQL8vOhYWi2y7J7N1uxQHrMfpk8e
OJyAaF2CK4MOaFTC0+qS/ndSWohl8VQwaevWf+cJg2nrHTtmtIOVdHscOKqscSi7
62hFwmqHwlxwS2eJ+PoY+K+dlgaV0eitlJHtfa+cpp4EgYfXVPQOEubJbKfcZJRa
Bp/ad8V60E0ZUw/AtZut
=W1Hr
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
