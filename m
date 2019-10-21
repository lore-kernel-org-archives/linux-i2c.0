From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-stm32f7: fix a race in slave mode with
 arbitration loss irq
Date: Mon, 21 Oct 2019 15:59:10 +0200
Message-ID: <20191021135910.GA26782@ninjato>
References: <1569919869-3218-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3422119733111780452=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1569919869-3218-1-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: alexandre.torgue@st.com, linux-kernel@vger.kernel.org, pierre-yves.mordret@st.com, alain.volmat@st.com, linux-i2c@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============3422119733111780452==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2019 at 10:51:09AM +0200, Fabrice Gasnier wrote:
> When in slave mode, an arbitration loss (ARLO) may be detected before the
> slave had a chance to detect the stop condition (STOPF in ISR).
> This is seen when two master + slave adapters switch their roles. It
> provokes the i2c bus to be stuck, busy as SCL line is stretched.
> - the I2C_SLAVE_STOP event is never generated due to STOPF flag is set but
>   don't generate an irq (race with ARLO irq, STOPIE is masked). STOPF flag
>   remains set until next master xfer (e.g. when STOPIE irq get unmasked).
>   In this case, completion is generated too early: immediately upon new
>   transfer request (then it doesn't send all data).
> - Some data get stuck in TXDR register. As a consequence, the controller
>   stretches the SCL line: the bus gets busy until a future master transfer
>   triggers the bus busy / recovery mechanism (this can take time... and
>   may never happen at all)
>=20
> So choice is to let the STOPF being detected by the slave isr handler,
> to properly handle this stop condition. E.g. don't mask IRQs in error
> handler, when the slave is running.
>=20
> Fixes: 60d609f30de2 ("i2c: i2c-stm32f7: Add slave support")
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Applied to for-current, thanks!


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2tuaoACgkQFA3kzBSg
KbY98A/+L5w+rU+ZlnLyPHs8O2CoyNVWD0XjDnXAYbAwpuCKQBjMjaTmom8/ucQM
JU86jNaLS9KM3yL8bhXnPiuXit/DXnq484npH49uK+GTVFK7pnVNu/QhBuLJzXPO
xvO4glb1xpFoNHAA7o16T4EQvK5YfZFmdxcbqPVxNfNOyxIHxwBkb5ZQHQwdVNvq
8izptQqmRWwm6DUQj5Cnbd3DOghf73SBMarADbzZOIJn2yIKNInWJTw18WY+sj8T
ayrS0KbcITMSbiArT5on/5Vwv0tM5uPYKilQPUR81YDSpZTidmXRblR04h5MS3or
j41iqKTldQ1xCBG/V9Z1unE4d3CWtBzGQD55UlBlzkvlV+kFsN8EjkW2Ow4HCIG9
Xn1NbcBvhidymJe94yGgu+YhUVmj5web+EjqLwZoodofg4fxZXRDWHYE8WMUdB9R
aYv6JERZJq0TSdr1kfGa2lB1FCzMAvtlyH+nnRQsskYHoVWgco5j/VSHfxnQog8+
O3Doke9VfMtAyOyYmKdogBD5jeO/iZJGLjE/LVC/jnPYVNI0psVD5ifeT1WZprqU
5JnzBK5JVMZxFrP20nT6ZBdGWFi9YygUHF7tichu6LAk+lCZddE9g9rHghVwMlwN
/RjlN9Ada2ceFOp3MzL2R4WORf1WZgAPSjrU2Tpz7CRuy0K4r3M=
=Kfp4
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--


--===============3422119733111780452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3422119733111780452==--
