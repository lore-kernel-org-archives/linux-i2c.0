From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [v6,2/2] i2c: qup: support SMBus block read
Date: Tue, 29 Nov 2016 22:46:26 +0100
Message-ID: <20161129214626.GA23072@katana>
References: <1476203277-6893-3-git-send-email-austinwc@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0433359196975759621=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476203277-6893-3-git-send-email-austinwc@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Austin Christ <austinwc@codeaurora.org>
Cc: wsa@the-dreams.de, linux-arm-msm@vger.kernel.org, timur@codeaurora.org, linux-kernel@vger.kernel.org, rruigrok@codeaurora.org, nkaje@codeaurora.org, linux-i2c@vger.kernel.org, sricharan@codeaurora.org, linux-arm-kernel@lists.infradead.org, cov@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--===============0433359196975759621==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11, 2016 at 10:27:57AM -0600, Austin Christ wrote:
> From: Naveen Kaje <nkaje@codeaurora.org>
>=20
> I2C QUP driver relies on SMBus emulation support from the framework.
> To handle SMBus block reads, the driver should check I2C_M_RECV_LEN
> flag and should read the first byte received as the message length.
>=20
> The driver configures the QUP hardware to read one byte. Once the
> message length is known from this byte, the QUP hardware is configured
> to read the rest.
>=20
> Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
> Signed-off-by: Austin Christ <austinwc@codeaurora.org>
> Reviewed-by: Sricharan R <sricharan@codeaurora.org>

Applied to for-next, thanks!


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPfcyAAoJEBQN5MwUoCm2aTsQAIs/I8H3xG1OzSDbOWb0cMMy
qZukvnseCg+WnwDoHCNe3wHQowmTAmKchr9Vi+i/J6JI/6/OR0ZZjxqBt5LYUA5l
nD4OqSlkjhVKX4RqA2LmNpj9dOrPEtl98ZikeBQu9AjRbv26Ivi8OVjvV53mGFsd
TO+avzoD0aGNL+YWBWtwcZVFH2pzbur5MIf5+9f2mZIRIxl6cZE7UoBoDNTxqu25
kJC3qbjeilbrEUA82FmNP2pQVTLkXh42IMx9YK0VgWHA8nB+OvUaoTiTgFuMoCHY
EYGSu2BWr523uLo4bM57tmm4zcIrk9kY3PFA9HTH6nBY6ChaqAomyK4ajywypS0o
QOjwQ7drSlQ6ZLp/+Xn3AtmI3egsIBRE4/1TLSx1mnjRK/YjBKW7P5igwyWcDbqO
qcdH0VjLXXLcxACGCEBEe6OjJ7N7HZQENBY3VobKf+KJUwlzyeF+FCsFEXTQZ/CB
ca3ytuJKADepm1MA1KwlXSHOB/xS6wGcBLMoO1NPSF54cr1AhfjbJuqbAkfDOM5K
E8UnuAFtSZaPiaeA30uzksbTU7xCPsRJf1apk4QqQmGJC+aE+SR/VKjRGqFIMP6H
X/+xdVNXgh70GW60M/VEmetgi6whjAcIYipP7J9kP7DtfCAzyNMEXdRmGk3bRfV6
3HbXJynrBem+0DJS0N1g
=pmVj
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--


--===============0433359196975759621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0433359196975759621==--
