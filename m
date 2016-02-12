From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V7 1/6] i2c: qup: Change qup_wait_writeready function to
 use for all timeouts
Date: Fri, 12 Feb 2016 19:37:47 +0100
Message-ID: <20160212183747.GB1520@katana>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-2-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453197766-18976-2-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, galak@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, ntelkar@codeaurora.org, architt@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2016 at 03:32:41PM +0530, Sricharan R wrote:
> qup_wait_writeready waits only on a output fifo empty event.
> Change the same function to accept the event and data length
> to wait as parameters. This way the same function can be used for
> timeouts in other places as well.
>=20
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> Tested-by: Archit Taneja <architt@codeaurora.org>
> Tested-by: Telkar Nagender <ntelkar@codeaurora.org>

Applied to for-next, thanks!


--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWviZ7AAoJEBQN5MwUoCm2zf0P/RHoxESQOoaGZa0m4mEZZ7Ft
9Jgxig6CdLKrljQNVzLs+Ej74YfZRhIwgm+LK/aIegi+iT7PcKQDypzs5/Ae1+cY
+9ceOPLmuD0yuXX2sQ/xSROG1xycnh+Cnbt6HSjZ8HqtKv7HhNC9TCLtcns0L0WC
B4cLBnlGWxLstIPmHVTQQ5hCNTmNsNpfwKwE3jT0g05apVw/NKnhxp26V9UPnIsy
W+rTUuN9p9pyQ8taEXtHAutBM2pXHQqlJTdc44M4mnoQxcUSMUsxcKcIno4mpYki
O9iaPwQo0QnV3R+VBt6cPNjVwH1ldzOVbJKV15BDxewRFQsJxiOrlYnE7bBXPJ11
pG1vEKTBI4QFHzMKL2+ZHT4LKsnxqhtkI+8lexcumQ/neyEEs7ZHMy7iC03oJasI
4Xsc/53dF8mmSlg664ObM/sFzFL8Qw0ZpSq5g+tfPWwU/R9HfAB1hLQF1NvH4ME0
FCVPstoNdQt1VzxN4rRfvyWEnyszXgkAfL+rbZ+TctzOkGLksKje1h5wc9ToVIGN
1xRJd2haxhaAxh5L4lG6cdqPqqyH9X2+y8kzPkCkXZJrzild/hCE9kML0DPteroL
RKDWjVIy1vV7CIcmYdZI7WwQreV3mc84A6aD9TDwmGIlVWm0fq+827+UXQ6+iVv4
LhAvnOh4hOG3xT/B+ToY
=V8Q2
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
