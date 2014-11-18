From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: mux: create "channel-n" symlinks for child
 segments in the mux device
Date: Tue, 18 Nov 2014 16:12:04 +0100
Message-ID: <20141118151204.GD30004@katana>
References: <1415885996-14770-1-git-send-email-wsa@the-dreams.de>
 <1415885996-14770-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415885996-14770-2-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2014 at 02:39:56PM +0100, Wolfram Sang wrote:
> From: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
>=20
> This makes the topology clearer. For instance, by adding a pca9547
> device with address 0x70 to bus i2c-0, you get:
>=20
> /sys/class/i2c-dev/i2c-0/device/0-0070/channel-0 -> i2c-1
> ...
> /sys/class/i2c-dev/i2c-0/device/0-0070/channel-7 -> i2c-8
>=20
> Signed-off-by: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
> [wsa: simplified sysfs-usage and fixed format string usage]
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Cc: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
> Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
> Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
> Cc: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>

Applied to for-next, thanks!


--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa2HEAAoJEBQN5MwUoCm2locQAJiLx+VzPAQsgbTH1ULUGleB
gw5gp/oU74BGIeQHhs1gndKMIcmnRWLuR0b3KqjcLvP4I3h2+sHHtZvVXd6F/R/T
cGp5oG4TYq6cjBxGRvIvV/SiPDjqNKM/w8ld61782WyxzcAZ5ANkiOko6JljTyQZ
D5ZFiu/+0P1PU32NxbxoMlbsqoSzarDipxUq5kqgRUVioMC2UwuCv/QsVAz3tjJG
6gBMbA2g7esMS7SyFRNyHyT8O66FXvoLcGbEofHSBDtIfsLXo8fw5ExEreNjeHcd
YsxHAAGBnPxEUQYnQLYVSA8QK3tEiaf4CC2MEs1aetb562u6BaM/lQ7hjVGK1hqp
YpQNkv9LD7MD9OlrCM/2cKViFgLjD0SFQM2s7QGWnNOJ4jZ7wMFsYfUMTE2P7OvW
cRGAog/7Cu66cDukSNqPnRI0HW9NfqJl1DU741vozD6cTztrU9/l5Hj4oPRG6yU9
pT54oUfheRMNN1Nkpv9EhzzZGBhNvw+j7zYj9jcb+YvkopsvgfonERUipwjHd+Im
4fNBUxrTdAil9MvHEs3s5G0EnKJAvjM2qV1eAO5Q58C4zvRg2L3tDNA0PCoHGCHv
EHSrstKpRGZ5vFIHMgj2AtiNt97OO8ez8NBc2QgVY41byqA+Hs5Hfag0GZ62wykQ
ay9A0zlbIkkBuPgTAqDW
=oef7
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
