From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/4] i2c: cadence: Fix error printing in case of defer
Date: Thu, 30 Jan 2020 09:14:54 +0100
Message-ID: <20200130081453.GC2208@ninjato>
References: <1575888052-20447-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1575888052-20447-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shubhrajyoti.datta@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, michal.simek@xilinx.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-i2c@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2019 at 04:10:49PM +0530, shubhrajyoti.datta@gmail.com wrot=
e:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>=20
> Do not print error in case of EPROBE_DEFER.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Applied to for-next, thanks!


--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4ykH0ACgkQFA3kzBSg
KbYDUQ//fQrdsBmL0LVrRcQg2si9EbiSvbSWxrZY2OMFmCzZuRTKUS4rQFqiiK7l
6x1S95EnWv7/Yk5NlCWxy/4wxQPlDiQ7sarZamQQU9UerdNlYyJwfge5Z+HSjitE
cWmB1M9ZhcuzFw1kdzEjOPTRN9KUTa/F625joffJ76fEsuw42RPStkC9GcSUlSs5
RaXXlsZoHFWE9ZXw7HnYteXf2qo4PIhTyk6knMGJJAVYevvJQN2IqenO/S/MKN++
NTJujW2ajYGXRrRcv+dTKNQqVf5hU20IRRlUJxmgseej7BobYyelJVXUTg6CMiLV
OBIYAupxf6FEwpxUq00i7XSArI5Z+wl1LMLJNcDEM1dFaQ3qTlbXz87w367/n/ZJ
1jtSwoF4yNAwmB4rG/dpo4rwU/B8oeoED7TljERShaBX3A3ICpRKPwghGwfbkqkY
ee1u54+EeabELVH53+lfuBtATNSQhpZFYGVuH0rclhIqhnBWfdn6iRoPN3jVeeNd
bG+p8Oe1aTiEmuKEK5D2ZXBQBMQ5wlmIapHgK82ULk/3TeUca89x0uwupe2zYN8t
2haMbmKMeA9KVIy/gE/q33XQfuwpKM5Lbo2wtKlWvkg852XP2e2MLvQv/YF1IA2O
Zn8lH3k+Uhea6MUhlMGlzDpKsk6J6jeb9k9UOaY5bNhytLRuEG0=
=wwDA
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
