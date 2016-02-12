From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V7 3/6] i2c: qup: Transfer each i2c_msg in i2c_msgs
 without a stop bit
Date: Fri, 12 Feb 2016 19:38:15 +0100
Message-ID: <20160212183815.GD1520@katana>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-4-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453197766-18976-4-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, galak@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, ntelkar@codeaurora.org, architt@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2016 at 03:32:43PM +0530, Sricharan R wrote:
> The definition of i2c_msg says that
>=20
> "If this is the last message in a group, it is followed by a STOP.
> Otherwise it is followed by the next @i2c_msg transaction segment,
> beginning with a (repeated) START"
>=20
> So the expectation is that there is no 'STOP' bit inbetween individual
> i2c_msg segments with repeated 'START'. The QUP i2c hardware has no way
> to inform that there should not be a 'STOP' at the end of transaction.
> The only way to implement this is to coalesce all the i2c_msg in i2c_msgs
> in to one transaction and transfer them. Adding the support for the same.
>=20
> This is required for some clients like touchscreen which keeps
> incrementing counts across individual transfers and 'STOP' bit inbetween
> resets the counter, which is not required.
>=20
> This patch adds the support in non-dma mode.
>=20
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> Tested-by: Archit Taneja <architt@codeaurora.org>
> Tested-by: Telkar Nagender <ntelkar@codeaurora.org>

Shortened the commit message and applied to for-next, thanks!


--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWviaXAAoJEBQN5MwUoCm2o6MQAKrTYAiNu2v1CSUzvnyqDrkm
k8eraTz/m2zmv8xxYX/8IGTVhh+ymkGqzuvy8JJa6grTcSWHO7Cp2MdnwW44bCS5
kRTq07fvTak2jU1QFoyWvUcDLv+d5qYm1B61+oQhDIPz6skZFeE05VgMmWBQwOUp
92BOg2iinVjMipW5OVeIQtLrBsujEQOuht68Ol4QZp8axjaqFJXiXyRrbhl5Z/43
rLiMvLCmmh5U893okaXGMnTxhy0x5ppVLkG8PViAIUGL5KA3T58HEoY9+b8l5he4
13YHWT+FBUmXKwnsCixsA9YXzz1K13aidI221YlRT4L5exvsyPDfDabm2Gro9ZQ9
eMVCVCSQxieaKQjxi+SaJpaK6h4PSj96HmFtU9+vMep4JcA5Tqacm8lgJx1XWtAz
R5KKH5gvzzORuUtjZPbsFwRIadbijZYlhUAeUBbRBb8mtqnnb0ttUAV/4TGFFz0d
CxAoUq6pqprjqS6AJUb969PXU4VX3e48mCtM70UWp0pyev1meORBTZ5s+uNp4SBg
QpWwmL28rRGonoedJrSzcqPMSDe8bRyWIP0ODbXlUxhCONFBnHhAu4jQIKPgg6IN
hcjyZd6dMNEfJhhaHBvDxIkqytb1TN/AkP+oudQRHPvzJpsoAxU+dCLsCKnalmQY
NeH1SqLHLQ2eamAYn2V2
=n7N4
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
