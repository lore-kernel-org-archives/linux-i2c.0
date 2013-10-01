From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: davinci: Remove redundant of_match_ptr
Date: Wed, 2 Oct 2013 00:19:16 +0200
Message-ID: <20131001221916.GB5028@katana>
References: <1380512066-23681-1-git-send-email-sachin.kamat@linaro.org>
 <1380512066-23681-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380512066-23681-2-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2013 at 09:04:26AM +0530, Sachin Kamat wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks!


--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSS0pjAAoJEBQN5MwUoCm2mA8QALJjvrC8OL3VXAsej4SUGe8H
Ggf4Ckh3xJM1+wSmIALnSYDXDIBRQcG3pRCwJhEVs3lcfNm1h9hQ91hmidEjtctB
YFlncibBMMXcGW1CEzjs2y2looQ2S5jLsnsSF8dNaikv5yXz6tXQqeIuTAN2uwid
FuslrsyqeaO8BA9Bs19AP+I/pP3GnkO2BtKswjNihIph5x0Q/BPSLtipcSBSThbM
0ffvysztGps+A7AtqDZRa8VToM67OpRyVZ4H6fCKEImkNLKsR1c9sJ69IcrCbRo6
dZTqcbiJDfqE/vIK0OxEe5LIXmbfTU3HbNoqmo5VvhYfsNQyfYGCRjH/boPfY8sF
+JxzAF9TV2Zj6jTEAdg8tpL6kS620DU/dD3MbFHoeXPmPRL++LvkRChmk1mTOpeO
fiN76igxPi56l9Qd/Z/sjNWocroVHBp0DyG8IFXZHvcgxMHHU5CYosAZSFJa5rwg
cJBsZEMnXz2kLt8DaJJ8f1wcMwz1TBxHESDAOcwz4uYi2MiU+onlPNSZfNijkUfD
VKScOztrAoiKIn6jmLWJeMYXPj6VQniGDaOrROA53HwIgxj5esjpKiadQuUf0Var
wf7KgSwLwKE3P89NfW+bizHeKERhpQTg9xJ3J+yCkY9bAiEwBEiw4+NhUxrXltYK
QIHefOmhdyFtQg6ZHkpL
=BtPz
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
