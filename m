From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/5] i2c: i2c-stm32f7: add a new st,stm32mp15-i2c
 compatible
Date: Sat, 22 Feb 2020 13:40:01 +0100
Message-ID: <20200222124001.GH1716@kunai>
References: <1579795970-22319-1-git-send-email-alain.volmat@st.com>
 <1579795970-22319-4-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0026860469015539320=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <1579795970-22319-4-git-send-email-alain.volmat@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alain Volmat <alain.volmat@st.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, pierre-yves.mordret@st.com, robh+dt@kernel.org, linux-i2c@vger.kernel.org, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============0026860469015539320==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KscVNZbUup0vZz0f"
Content-Disposition: inline


--KscVNZbUup0vZz0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 05:12:48PM +0100, Alain Volmat wrote:
> Add a new stm32mp15 specific compatible to handle FastMode+
> registers handling which is different on the stm32mp15 compared
> to the stm32f7 or stm32h7.
> Indeed, on the stm32mp15, the FastMode+ set and clear registers
> are separated while on the other platforms (F7 or H7) the control
> is done in a unique register.
>=20
> Signed-off-by: Alain Volmat <alain.volmat@st.com>

Looks good (patch 2 as well). You'd only need to adapt the naming if you
change the naming in patch 1, obviously.


--KscVNZbUup0vZz0f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5RISEACgkQFA3kzBSg
KbaaDw//TvaXXxfk/UfcOGsDNuLxbiqLPHG3i6DtQPijfEd93ekH6LKIwE5kpDV2
pbsCUtpHku3mQvQyPScHSdgyMyqbd31mwDSB8waFOfG4SuNDDJXxqo5GltD62/8w
HSBfAAvF4TM58QMDIaDYokrUhVZm5BJ/Cofv2z4+jBx4uRBWC829pmxvuf/sHWbo
gti4PZZLQRMbBs6i9/7ShPsLmn4NffZ6+U2GDyVl11EmYdhOP0fMVFPgnbS/0Z7C
/xfuMFs5Cu3wyq1oHNF0//SurRD4b1YfENh87h+cjYElICT5EUZ+Yv65TPTE4Xpf
lWUGKKVcJ6nGoYOLCJOz1YoG/cRUtxSG+RCQXVAkwyHuoswOl8UrWyPUuuOh51xf
AvrobB4WbHE3Z0KtGryxl3q2XEnoA5XHQTl8vOKiPfJTQYsRTb300Oh1Ym25E2H1
Oj3iUlI2EL2VC+hleMywRQgXZLtGyNL2C2xphOmASWRBC2zVVGcrfr8eaA5V+5AU
LvFKZPIjVaLa8suLgoxqatPo7d52ZskkXpzOtKOLp5joFYxjaNxjJDRLmlGCaa4g
EcErYOqMz3SJQuV8jyG+zNrmzZh8/1oQx6u7hkKzU2c0XaPCJhtjv8dXpMYS0Eqf
eP6JDxzkRYh4GT2xc2GwLpEL9Ysy31G1yw2RhKurA6rRGHJpkMo=
=epcM
-----END PGP SIGNATURE-----

--KscVNZbUup0vZz0f--


--===============0026860469015539320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0026860469015539320==--
