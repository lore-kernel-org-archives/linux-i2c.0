From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 RESEND] i2c-piix4: Add Hygon Dhyana SMBus support
Date: Fri, 3 May 2019 16:48:44 +0200
Message-ID: <20190503144844.GD24385@kunai>
References: <1556554123-5894-1-git-send-email-puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556554123-5894-1-git-send-email-puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2019 at 12:08:43AM +0800, Pu Wen wrote:
> The Hygon Dhyana CPU has the SMBus device with PCI device ID 0x790b,
> which is the same as AMD CZ SMBus device. So add Hygon Dhyana support
> to the i2c-piix4 driver by using the code path of AMD.
>=20
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>

Applied to for-next, thanks!


--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlzMVMwACgkQFA3kzBSg
KbZHEBAAm8xAjCbx/jdBVaWlBiuWE57fQzmTjQ8pLUH6e0SNl90RBbCHI+7ex0ik
ugD8hcUKkLiF7OVEDmnCsyXFkp60ED/0lelHKRLIeeDHpkqmSrABfhnDr3CWoo+G
kknkicjAVO+pvFlcYYmdL1j2h7jKbUjs1eWjBBpJm9wWTWyKfDUzN8mSG12Sma2b
+N0DtNiefwTAicsM0DgSfsWyLImG9SUO+L/KVVkODfbIp/I2maHUDgoL36TXzR/8
ppPFdpFqyku4siDO9LdvSCEdWkEoYWstOC/nWm3UNy4h0tEZEIV1/kKw/r6snDCe
Ot+WG6ijg+2KcZY3E4pdNBza2tiTM/WvsJC8Dm6/LhaWilV4vavner/RjjFaiMHu
h4bnmp1kApVscOpTfEB1C3/MZnTgXgYX3THreRaHsiMo8a1FO4TLQ43oDBt/CLgm
hfscDMPOnQ5a+hyp4+5Wk+1TghM2+ejIN/U763csByKkPLRD2rwZ1MIOr9HPMMPf
8U6MAF4yVGLxO7cgSoX1+0TqRqife9+OnQngm18xG4QGvx/pMZVg44idJcyrafEA
85phXEX5+t73W8nRWw9gHdD6st/levRpqyT/Eu+VuFhKWnJ7uRKOgEt6kSKgKTUb
JHxXN5Y7oRizL9QbohCFseNz6UDICK/cyJBDtvrqmWegkxgP1iQ=
=LW73
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
