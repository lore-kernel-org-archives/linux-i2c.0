From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V7 2/6] i2c: qup: Add V2 tags support
Date: Fri, 12 Feb 2016 19:37:55 +0100
Message-ID: <20160212183755.GC1520@katana>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-3-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453197766-18976-3-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, galak@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, ntelkar@codeaurora.org, architt@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2016 at 03:32:42PM +0530, Sricharan R wrote:
> QUP from version 2.1.1 onwards, supports a new format of
> i2c command tags. Tag codes instructs the controller to
> perform a operation like read/write. This new tagging version
> supports bam dma and transfers of more than 256 bytes without 'stop'
> in between. Adding the support for the same.
>=20
> For each block a data_write/read tag and data_len tag is added to
> the output fifo. For the final block of data write_stop/read_stop
> tag is used.
>=20
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Tested-by: Archit Taneja <architt@codeaurora.org>
> Tested-by: Telkar Nagender <ntelkar@codeaurora.org>

Applied to for-next, thanks!


--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWviaDAAoJEBQN5MwUoCm20DYP/jmwlHhTRltp90VA6TJCRjA8
EVjopxiIxszvzfFuX8II0LHwve5O64GkFUN1B474WkO5rwJry5uEK7HiqfDv8dEx
ppxvbLcsCBYW1k8vlo6rrCatVzlZD0yhVzX82sRg6eXrLTaQU20cn9iOrBAe20PS
Ld2+z5OqYu1EDrKFaMcXOzzQqY5nyx490Chit+Muv4e3csF5bF9RRr0vVwbhTum6
xSsy3f9HiKj5Qe64qfX9mnPoIvk1N0zz8ih3LchWz5WRXyFjaAi8+0SqICcHBwiS
vCI5x+Z+6S9d69tp/7NxWLWouR6/bFFipq+wEb9mn95pNvbCl5S5cl9H9JyuFYRW
i6mdY/goSjF2c/u1g6qctBa6401YyslwJfX7riMCo97FTg2jia5Vjh1VJnyYi5Wm
/x9ixZ4miUKNvpjGwEMq9n2pnhNSpVUv1szpXmgyS2m1HcLgsIghNk3SX68WLHUN
iTN7OBx20iJAH8+lp2NR9UUv1szBpicpnEjmf2TywbrLff9iwMHiqy5zLhxJpnOw
LLtlVATxGBcMNFxNZH/LyDRLevPvQKUu79Ao3gDN2zR5isBVlf89r/BTTsWpPq+d
GMgOfcmQU7hs73P0wORoQ4ZPm+2AsGY0OUrRp2W5Fmx0GyC3JoIb+hBQFnPnaeb9
6EJ80DA9SCK3NWLsYpV0
=f3Vr
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
