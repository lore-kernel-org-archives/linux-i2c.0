From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] axxia-i2c: use auto cmd for last message
Date: Mon, 15 Apr 2019 14:13:23 +0200
Message-ID: <20190415121323.grku4l66bq5xsk4u@ninjato>
References: <20190328111858.GA17086@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7mxb4uywimzggudx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190328111858.GA17086@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: "Adamski, Krzysztof (Nokia - PL/Wroclaw)" <krzysztof.adamski@nokia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
List-Id: linux-i2c@vger.kernel.org


--7mxb4uywimzggudx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2019 at 11:19:45AM +0000, Adamski, Krzysztof (Nokia - PL/Wr=
oclaw) wrote:
> Some recent commits to this driver were trying to make sure the TSS
> interrupt is not generated on busy system due to 25ms timer expiring
> between commands. It can still happen, however if STOP command is not
> issued on time at the end of the transmission. If wait_for_completion in
> axxia_i2c_xfer_msg() would not return after 25ms of getting an
> interrupt, TSS will be generated and idev->err_msg will be set to
> -ETIMEDOUT which will be returned from the axxia_i2c_xfer_msg(), even
> though the transfer did actually succeed (STOP is automatically issued
> when TSS triggers).
>=20
> Fortunately, apart from already used manual and sequence commands, the
> controller also has so called auto command. It works just like manual
> mode but it but an automatic STOP is issued when either transfer length
> is met or NAK is received from slave device.
>=20
> This patch changes the axxia_i2c_xfer_msg() function so that auto
> command is used for last message in transaction letting hardware manage
> issuing STOP. TSS is disabled just after command transferring last
> message finishes. Auto command, just like sequence, ends with SS
> interrupt instead of SNS so handling of both had to be unified.
>=20
> The axxia_i2c_stop() is no longer needed as the transfer can only end
> with following conditions:
> - fully successful - then last message was send by AUTO command and STOP
>   was issued automatically
> - NAK received - STOP is issued automatically by controller
> - arbitration lost - STOP should not be issued as we don't control the
>   bus
> - IP interrupt received - this is sent when transfer length is set to 0
>   for auto/sequence command. The check for that is done before START is
>   send so no STOP is required
> - TSS received between commands - STOP is issued by the controller
>=20
> Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Changed $subject to "i2c: axxia:" and applied to for-next, thanks!


--7mxb4uywimzggudx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly0dV8ACgkQFA3kzBSg
Kbaxcw/7BbpKmWB8GVSwSy6KqHl4w1Fa4yxtsCJIAKdn2Qx/fLfAbipovVoYOk2G
rh4F15GFBo7NoJ3o/p4MEvbBsNYVBbVTgGuI5ggLOKgPFtrir9BiVO2yRMi/9fSX
Ms+uWze1Uxocqy+q1YIuDnJmNmkU/H5fy1FOMz6L11QLXJdAxdx+/Yr0yGjUMcQX
Ga91sMN8MRU22PgJiTdSeTmTuWBlXl95v/oPfdBuCIpvY/ULUt4zhbMcjzN8DhtQ
4UBRDAz8jD9nIAkKXJENB1SqH99GQbPNk3AhYlxZbQnx6SLES7OVVaPhUXyzhsIs
yu2jYtN6h8mqU2xlNFo1xZAy6k1Uq6tSUVKXfr01yMEOMMXzHEVpFuiXoJZJhf1L
M1WkyXaZX4xRw9a2/THzSOSAWfQ/XkaAt0Wa04tUYDAr8ZrqOGRf2bFpsoxmzJPR
Cz4DgOId2f5MhqflmQ31XOJRM4Na/TYMiPljPXrT72Qye3ngeU/KCFrErssLkmVE
iOOPG7kuYhjX68knNpSIfj0LfN/Zgn3qI/3XDMkDrhmESsE9kxDT8+IBEtCKy5Fz
U/WIiyodb43TYbVkkXOpH0XyJ+DZUN7gzrfJhc+30EKcUexavr7IOKs995/7hiq0
aZUz+Zo32H58IuptsnwS1W1FpuRlio4bNhrQSZD0koLsmCvMcbg=
=FdeM
-----END PGP SIGNATURE-----

--7mxb4uywimzggudx--
