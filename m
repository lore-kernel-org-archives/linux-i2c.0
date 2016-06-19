From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: pca-isa: Utilize the module_isa_driver macro
Date: Sun, 19 Jun 2016 19:48:17 +0200
Message-ID: <20160619174817.GJ2933@tetsubishi>
References: <20160531162223.GA17106@sophia>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AXxEqdD4tcVTjWte"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59211 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbcFSRsW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 19 Jun 2016 13:48:22 -0400
Content-Disposition: inline
In-Reply-To: <20160531162223.GA17106@sophia>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--AXxEqdD4tcVTjWte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2016 at 12:22:34PM -0400, William Breathitt Gray wrote:
> This driver does not do anything special in module init/exit. This patch
> eliminates the module init/exit boilerplate code by utilizing the
> module_isa_driver macro.
>=20
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Applied to for-next, thanks!


--AXxEqdD4tcVTjWte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZtrgAAoJEBQN5MwUoCm2wUQP/iCkwAWyDMgY+azMMUpclS/s
M7bOQZ5gSmM64XBXrlCPistufgPf4j2j1Mdn99hwXxRTOkDm6rvZP9O2jEX4kBa8
HN+dWFJfoSbnhBCw8dT2R+3+x46HWb4isKioZJrQGH1pu+z5KGqv+ES8KDeIJ4HG
1ZZgXq35q2Gag0bB1Qtrqg5RE1HaR+tgsAjRG7wXPlozn3XTEK7zoUaU0BMuhZW+
wCEsONj8ZMgKT7yXAcQypCGEwK+0YkP/CGfsBIbtUo6lIqc3LKUK67k3hApUktLk
uTyk1KOkTAkHMUpmBEPQDjCuSVerZ4NiEz8Jzp5/U/V4gVOV4jNT//Ri/ZnOPk9l
7Cd5oPexkg2cksylNWvkgWYyE2biZVw5Csg5SaT8VFs8qveW4PRBUnbQv84gTPgZ
quB+nCdaXVwMaGT2g1k0udMTpBeRmmdxqBCFixUA+/CEVm0Ze4zXVUlm9OzPAP4B
xvHyPPmBPFC3UWqIOO56h3Xgg52/bSa2lkTnjqaEvc9CXu2IOtjXzIfXjN7fzlpK
Aitd5trdDU+tXa79fgqXvn1YUkFxPY26fr3aRnPooBq5hqCP4fNdEuLDCbIdvGAn
H0penxacVShTL58BxakLcOS0zTUWypJs7+X0nY42kQ8ZhETz0lIWRne6P9x9AKLT
Bx4K0vYtufI0tU/dP3aX
=nSU1
-----END PGP SIGNATURE-----

--AXxEqdD4tcVTjWte--
