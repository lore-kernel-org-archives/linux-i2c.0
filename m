From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv2 3/5] i2c: i2c-stm32f7: add a new st,stm32mp15-i2c
 compatible
Date: Tue, 10 Mar 2020 12:15:05 +0100
Message-ID: <20200310111505.GQ1987@ninjato>
References: <1583148796-24285-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V2tfspbppmK1TQo2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1583148796-24285-1-git-send-email-alain.volmat@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alain Volmat <alain.volmat@st.com>
Cc: pierre-yves.mordret@st.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com
List-Id: linux-i2c@vger.kernel.org


--V2tfspbppmK1TQo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2020 at 12:33:16PM +0100, Alain Volmat wrote:
> Add a new stm32mp15 specific compatible to handle FastMode+
> registers handling which is different on the stm32mp15 compared
> to the stm32f7 or stm32h7.
> Indeed, on the stm32mp15, the FastMode+ set and clear registers
> are separated while on the other platforms (F7 or H7) the control
> is done in a unique register.
>=20
> Signed-off-by: Alain Volmat <alain.volmat@st.com>
> Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ----
> v2: adapt struct stm32f7_i2c_dev fmp register variable naming (regmap_ ->=
 fmp_)
> ---

Please move the "v2" information after the "---" so our tools can cut
them off automatically. A custom "----" is not not detected.

Applied to for-next, thanks!


--V2tfspbppmK1TQo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5ndrkACgkQFA3kzBSg
KbarhxAAqcBaLCnzs4qnFRbgblz5ZqjqbO5416DrW/MoOQ+g+6VA+t/2evDb3Ww6
nz7e48UVYa0TEwRBkFLlb//9j/K8vov/uqKHmLbJHwqQRr6RUN73pVw7OF1z8CHg
GeyFW0Q1Dta3OuuDRKVCgcEcfPDH+jvkr3zUDZUi2SmwriuexWpqVAfXq8M90YiH
9iFHhrtOV9BUxlYclWllyMOZosuCFxsMTeQDabrPJgqMWovq+UZNtL9E8rv9+/Kh
KrsYUngBLRYvwLDhrCl0B4YX7dcRt+qSN+tedHPfP57pPlF/XhQctr1vzlppB+VS
GK5NqXjM1zBcMax5m0xk6IrPj50MhKlms52bVrSWNToF838iUBglxoEjM0tezPqi
1xxKvOWafWWBvMK7fiYoNDS5mwTFt2PkunVZ93xT/8nEEChLNHQCZS6uImwO8rCx
i0cKHBBSMxPAbs0TftAqz+LTvoSFKbVJ2BDonAbyjdyJqCdKwuyme5LTWcQy7FXT
K3FHDYfHJ/Kw2hbK1BVlXoXo9bqeBrW83NWsWYaxJmAcEu4TTh+/3HeoL83hdlcw
kpBmvEa2b9CQNaN/KFyI19XfR9sv4FdvlxZYQWdZ+rU6ZU9tSRPXrz3pXikly2pj
goj61CYymvTiBvTzZum4mQngiq7hmypLwQ5RxPHD4UkW633qqYc=
=q/s7
-----END PGP SIGNATURE-----

--V2tfspbppmK1TQo2--
