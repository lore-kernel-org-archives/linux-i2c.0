From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 1/2] i2c: mux: create symlink to actual mux device
Date: Tue, 18 Nov 2014 16:11:58 +0100
Message-ID: <20141118151157.GC30004@katana>
References: <1415885996-14770-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415885996-14770-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2014 at 02:39:55PM +0100, Wolfram Sang wrote:
> The current implementation creates muxed i2c-<n> busses as immediate
> children of their i2c-<n> parent bus. In case of multiple muxes on one
> bus, it is impossible to determine which muxed bus comes from which mux.
>=20
> It could be argued that the parent device should be changed from the
> parent adapter to the mux device. This has pros and cons. To improve the
> topology, simply add a "muxed_device" symlink pointing to the actual
> muxing device, so we can distinguish muxed busses. Doing it this way, we
> don't break the ABI.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Cc: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
> Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
> Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> Cc: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
> Cc: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>

Applied to for-next, thanks!


--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa2G9AAoJEBQN5MwUoCm2fG0QAKdE9HBYcx/VtuCyD7KhgSxe
RprLQLc/xUL4MaKUY3Uc/7ceU/jv3bNftiov9hwe+nmcWcXr5b22Vir4GrLESvZr
wCu/2H1xJFBQdT4QGiU+bBMkMlgFBgmDPLg7NctRYNh0IJ9tmVo00YOS+HanjiX6
o8lJRtF5R/GJsoIRRl0qbAcZ22COUuXXhYqaPVIoSn62XJcFM+APQdpHYg9XBNK5
OKoxvlkmBYfobvquaxpaQ7gffKAHpwjij0C3Xs8b8/sVYJtIP5ySMipJP3S6coE1
cSLNnjXPggx5i7C5054xd27dM+y8y9J6jnx/YgB/xKBnL1SjKZ128aYm+gNdst5W
0C6bXlTMo8KU/iZ0n3ZoK9j1vQOBuTnhEnaIA0XUI5fsLziYPp8EnV+klwObw0YI
Q9QVlT451vWTzzN81H+cMp/ftoig30s4Y5eOB9FgDI5Alxkhp+jGcj6PPblC+ZCb
h320Vqf2UQudpDAALqOhSI0ZCdtQRyvqMRt2P41QO+wjT0ay19SMBaf8NrygNhOd
F2XydzMxNoPIJjTK9Efzs4D+PuTiQhYLdlqigW54xqmNHU9Y1teJW/utgZeqEOgN
LE+cHftr4iFserat3I/FkLBmfmoTmVzjsc3qg5HYDvCEs4Jl2YtaH9qgu1RkiKiJ
bX9SdPtzF1bb87rDAKju
=OiBg
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
