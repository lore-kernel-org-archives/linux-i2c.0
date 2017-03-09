From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: add missing of_node_put in i2c_mux_del_adapters
Date: Thu, 9 Mar 2017 15:40:33 +0100
Message-ID: <20170309144032.2rsd5qeg2gbhwf6x@ninjato>
References: <1488527831-53733-1-git-send-email-qi.hou@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="63ls3hj3hv6ny5n7"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488527831-53733-1-git-send-email-qi.hou@windriver.com>
Sender: stable-owner@vger.kernel.org
To: Qi Hou <qi.hou@windriver.com>
Cc: peda@axentia.se, stable@vger.kernel.org, robh@kernel.org, linux-i2c@vger.kernel.org, leif.lindholm@linaro.org, pantelis.antoniou@konsulko.com, grant.likely@linaro.org, bruce.ashfield@windriver.com, paul.gortmaker@windriver.com, xiao.zhang@windriver.com
List-Id: linux-i2c@vger.kernel.org


--63ls3hj3hv6ny5n7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2017 at 03:57:11PM +0800, Qi Hou wrote:
> Refcount of of_node is increased with of_node_get() in i2c_mux_add_adapte=
r().
> It must be decreased with of_node_put() in i2c_mux_del_adapters().
>=20
> Signe-off-by: Qi Hou <qi.hou@windriver.com>
> Reviewed-by: Zhang Xiao <xiao.zhang@windriver.com>
> Acked-by: Peter Rosin <peda@axentia.se>

Applied to for-current, thanks!


--63ls3hj3hv6ny5n7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljBaWAACgkQFA3kzBSg
KbbzuxAAhd4oCXEBIETMUzEzPZPxb3ILUlvvYfKrvAq2aBCbBlnU2p7zEjZtKSFL
qwiT0txwSC4OOa/YwjkWtxt+lJbe2TqD7iBoUN3qQdlfrYvJN/YQVM7vvvGbPzPw
EzJBMAihso37VXwTLITGlHIFAXtbys094m+2cpJvQjpe6+/0ZheaM9F2YCLkTrzJ
/X97PVUwpU/YCUHVHyfGnNFIq7K5FG1+Tcet92vVNc3w48r8wLJOJfUvl0mD2xjq
MQMis2IrgDQLBCXBw6RJVez/2pa2BehXPcWTfzZDlyI+I6vwIS2MSifSPucyxkbl
DbRuBIVDnqI1OlVVguW6RxpLCjOucIJF4Xay0aNLiH/poNyT4K+jvTrXpEGNpXvg
+g8M6xMqMEXE9dGwQAEvQrK1nrlCZvhKMM0ZrGBaBy602npv6YQ7VIKXm2c8kFtT
tbTfHmqhOMSCn5HIfjVdQ7X0L0mPvG0Z03ycuzzLV7M2qTsP/Swk8sK2Y/8R3VDh
Q/JgyY1EeikGaEtdTn1UKHWzzXYa92OgGFVDoEJcCpw5aAfmtzxV1n+8eAhKmqDu
HNp9n643G8JdGho7m0+MOu0UdyZEijJSRljsJ1TKmwxA0Yi+X4bphtfyXsXy++1t
2oy6HbdrY9AmOLRzACjonHhzeqXgxENlYHT0m50awwzlrQD62/0=
=KlPL
-----END PGP SIGNATURE-----

--63ls3hj3hv6ny5n7--
