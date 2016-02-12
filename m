From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V7 4/6] i2c: qup: Add bam dma capabilities
Date: Fri, 12 Feb 2016 19:37:38 +0100
Message-ID: <20160212183737.GA1520@katana>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-5-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453197766-18976-5-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, galak@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, ntelkar@codeaurora.org, architt@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2016 at 03:32:44PM +0530, Sricharan R wrote:
> QUP cores can be attached to a BAM module, which acts as
> a dma engine for the QUP core. When DMA with BAM is enabled,
> the BAM consumer pipe transmitted data is written to the
> output FIFO and the BAM producer pipe received data is read
> from the input FIFO.
>=20
> With BAM capabilities, qup-i2c core can transfer more than
> 256 bytes, without a 'stop' which is not possible otherwise.
>=20
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> Tested-by: Archit Taneja <architt@codeaurora.org>
> Tested-by: Telkar Nagender <ntelkar@codeaurora.org>

My code checkers found some issues:

    SPARSE
drivers/i2c/busses/i2c-qup.c:555:6: warning: symbol 'qup_sg_set_buf' was no=
t declared. Should it be static?
drivers/i2c/busses/i2c-qup.c:1243:50: warning: dubious: !x & !y
    SMATCH
drivers/i2c/busses/i2c-qup.c:165 qup_sg_set_buf warn: unused return: s =3D =
sg_next()
drivers/i2c/busses/i2c-qup.c:165 qup_sg_set_buf warn: unused return: s =3D =
sg_next()
drivers/i2c/busses/i2c-qup.c:1243 qup_i2c_xfer_v2() warn: add some parenthe=
sis here?
    CPPCHECK
drivers/i2c/busses/i2c-qup.c:1243: style: Boolean result is used in bitwise=
 operation. Clarify expression with parentheses.
    SPATCH
drivers/i2c/busses/i2c-qup.c:1380:2-13: WARNING: Assignment of bool to 0/1
drivers/i2c/busses/i2c-qup.c:1481:1-13: WARNING: Assignment of bool to 0/1
  CC      drivers/i2c/busses/i2c-qup.o
drivers/i2c/busses/i2c-qup.c:555:6: warning: no previous prototype for 'qup=
_sg_set_buf' [-Wmissing-prototypes]
 void qup_sg_set_buf(struct scatterlist *sg, void *buf, struct qup_i2c_tag =
*tg,

Can you fix them and resend??

Thanks,

   Wolfram

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWviZxAAoJEBQN5MwUoCm2jLcP+gK0k2Rj4CigmQ423Q913qyG
ZbVBN0TUcIqhU3qxz+ruxL0DGYwTJjzB+0AZJ/EOOTqadDyTfjsy2lLpSAtCpWpK
mupRrCFTYmC5VBRkJwKpZeMZaoDT5vPaWRzjU7mwcpwc4+U4lc1FDLPkHwjrWmXd
8YGGH5HzO8NprITAwx9xC0ldfxwobv1mQPZ3wpKorafiHwVY0Wvmcle9P9JSIh0f
OYHWs6zgAW1RQnGjNs1/Ee/q1XG4TsVJCo1U6qaV53rcaLRiZ11N/4U5ovK9cZQT
enEYjXxz+5fGhVkL7xPxwqdH5lKpCDhBtYy9Rosi85qL/+y2eEHev7toaSLDm8GR
rDgC2LBZU/DVLP50y1kAhe41m+XCusVCUJv/BhfeIdx0ZXsWPwYnU4mxKRiZV3hk
pYnksuMwS8XVkgTZevdH9S4tNqO2470772bsv0zvLGoV8Diiep6HzXXTDsOJEa60
zEszKuO091xtK/Ogs2RvOMd/toZNNCANjtT0uTSfesj35QcpCrTAOBeU2LSVxpZ6
tDvs5cjoBFfbkHihTqLpvFqK9QpAtvlS9Ma/icCQ/1eUHD7p3fPwusCIiBby43QS
RQpEmTkIuyl80iKtGI/uPdfs+XL1udh671/nAH76LQhWvWuioe21HKbyIz/Q2XJ9
ShJ2z0uoJr8m+XTSp2Fx
=6kIE
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
