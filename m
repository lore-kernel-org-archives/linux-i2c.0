From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv2] i2c: i2c-stm32f7: allow controller to be wakeup-source
Date: Sat, 22 Feb 2020 13:34:00 +0100
Message-ID: <20200222123400.GF1716@kunai>
References: <1580752328-26009-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1580752328-26009-1-git-send-email-alain.volmat@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alain Volmat <alain.volmat@st.com>
Cc: pierre-yves.mordret@st.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com
List-Id: linux-i2c@vger.kernel.org


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 06:52:08PM +0100, Alain Volmat wrote:
> Allow the i2c-stm32f7 controller to become a wakeup-source
> of the system. In such case, when a slave is registered to the
> I2C controller, receiving a I2C message targeting that registered
> slave address wakes up the suspended system.
>=20
> In order to be able to wake-up, the I2C controller DT node
> must have the property wakeup-source defined and a slave
> must be registered.
>=20
> Signed-off-by: Alain Volmat <alain.volmat@st.com>

Applied to for-next, thanks!


--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5RH7QACgkQFA3kzBSg
KbbVzBAAqGtkUF4TZxt4ODn2bDGGVNG9F6i9rjjyI5ug25RWTB+ROjLWYiY/bhb5
aD74gBZY53Ec+Oux/YKTbTXPLdDZDWJch34GZSa/qGJzgOjWOOp0CzNN0pX+pxBW
VBhyTL9JP0UIMXypSoTc/1toTIrw6GBmT7j+/l1egUQWERrqzyEnkO0AG9hsSdy+
9NWnRmF4E4BqvBvguJWv5LxKut+fk4cimN1r09kc8Fu/D+2O0rsOwk6h2PWPEtWw
jxBQDQm6j7tChzipyzmUOQmNv9uG2fNxoIqdgl77y9b3bpRPRi6zjHlEpYU4Q9PP
frijrpx432VHOdR83b9Als8S6XV6rK0MffKtiw6dBwnljkwPsPmnrKAePHwBFW6j
mftKGaSEBFaiA1NfUJQJFvQovtUhJtHnQ4FafWoAv9UdfJEs/P/styAj7xMQ6Z/i
0q2c57ntHfCoXxBNTRGuiG+jw35avYfWH5yfvjQhUr2H6bDXWU5SLcnuhPraWSWV
3JqQuz8eGCig/FP96ZUsb3o1PIsNsQjFIZT81H9Gqc8FvS6wf1SEqvUHClVMvz1w
XY/hFcwAifYIOVKTIjoEYB7xdyV9Pql9d2gKeCwCzMVIQ02ULc+QDdgWJa0Cffjl
L57oZYPgRksiZPh0hS7QdyMaf2WA1vFNLIA8+sJ80xHBtEGop+A=
=+Wcg
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
