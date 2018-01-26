From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 1/3] i2c: mv64xxx: Remove useless test before
 clk_disable_unprepare
Date: Fri, 26 Jan 2018 18:48:27 +0100
Message-ID: <20180126174827.kutntrg74avpigfr@ninjato>
References: <20180116163540.1092-1-gregory.clement@free-electrons.com>
 <20180116163540.1092-2-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2048940184645659168=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180116163540.1092-2-gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Igal Liberman <igall@marvell.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Omri Itach <omrii@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, linux-i2c@vger.kernel.org, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, Hanna Hawa <hannah@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org


--===============2048940184645659168==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3sascefbanywnwoj"
Content-Disposition: inline


--3sascefbanywnwoj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 05:35:38PM +0100, Gregory CLEMENT wrote:
> The 2 functions called from clk_disable_unprepare() already check that
> the clock pointer is valid: no need to test it before calling it.

Now I get it. 'called from' !=3D 'calling' (what I understood). But also
!=3D 'called by' (what I would have ecpected, but I am neither a native
speaker).

You mean "clk_disable_unprepare() is NULL pointer safe."

>=20
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv=
64xxx.c
> index a832c45276a4..f69066266faa 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -950,9 +950,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  exit_reset:
>  	reset_control_assert(drv_data->rstc);
>  exit_clk:
> -	/* Not all platforms have a clk */
> -	if (!IS_ERR(drv_data->clk))
> -		clk_disable_unprepare(drv_data->clk);
> +	clk_disable_unprepare(drv_data->clk);
> =20
>  	return rc;
>  }
> @@ -965,9 +963,7 @@ mv64xxx_i2c_remove(struct platform_device *dev)
>  	i2c_del_adapter(&drv_data->adapter);
>  	free_irq(drv_data->irq, drv_data);
>  	reset_control_assert(drv_data->rstc);
> -	/* Not all platforms have a clk */
> -	if (!IS_ERR(drv_data->clk))
> -		clk_disable_unprepare(drv_data->clk);
> +	clk_disable_unprepare(drv_data->clk);
> =20
>  	return 0;
>  }
> --=20
> 2.15.1
>=20

--3sascefbanywnwoj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpraesACgkQFA3kzBSg
KbafFQ/9FEtMgAfl57IJ9/6wrQCKEKRQKNvKbsp7Kw2hPqT3gCbRCJtL18fym68u
bOlqIV+QiEMp3WqpX2Fd4XdNXl0Dat8YEm/CsZKGTLmsgEi9MgCKANUgMcwt1Xyi
PJljHyDoia35319WRXQPATJoywhhf6NPfdEOTF5m+o8lMPs77MsliN3hVAKiG4X7
VoHApEnMs1M5O28jscQcVaK7deZLFRcMfAysxeBYKCjCVE/Boh6s30GASxUJzrV6
Q6NrGW2SDjy+wiGZ2QkCwgNmPzwncRqApk8Esisyb2oazh0thSUdUBFDiJCb714A
dJ6RRJwAB8lpxby2j3qXCjJjwEo4r5GPPYVcs71s7t4glGdMsj2q1Gub2n9oCEk6
sJ1Qp0DrP9gpxThI8O5Q+di4WJjK1M+R3nxd5JPrs3xUzvU+9amnTTKCeKeliQmt
hmBQYuuJVSheGCHOx3gTZnoCkU3GWDWKqv6Igca1ijES3G3fJSA88VjX2odDfdRR
TMI9Yi+Jxdn7usGXXH/3G41g9dGk/K0Y+j4qEvXU8lKRjtl6GPJngmOiIu3Y8DUN
AH8ibgXLLlbLOfGnJ9M+Hvc2oFFkfY+qGe8BE0R6TsxOLka6Q/wgRWk79bHZBsbv
xb6EW+fxL4iW303N5zGUfAdn4B5RXRwXoSzCPM+ypkaqtmKgd1c=
=XkB2
-----END PGP SIGNATURE-----

--3sascefbanywnwoj--


--===============2048940184645659168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2048940184645659168==--
