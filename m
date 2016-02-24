From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH V7 4/6] i2c: qup: Add bam dma capabilities
Date: Wed, 24 Feb 2016 11:19:49 +0100
Message-ID: <20160224101949.GB1391@katana>
References: <1456142895-32646-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456142895-32646-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, galak@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, ntelkar@codeaurora.org, architt@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2016 at 05:38:15PM +0530, Sricharan R wrote:
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

Applied to for-next, thanks!


--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWzYPFAAoJEBQN5MwUoCm2n/oP/2CyTwrIUXLmQdG6+EVCGIrf
fJ4Ta2a7NCksPjzcopHsYEEpvpUll78A9dKIkZmTwMCZ9lr1Ic44fqDtMvC7nnm/
7rp1T1EO9wx3cCg+6wMav/rNEjSdjajRZnDhOOjQTTJ7FE2zJsKcZSQz8d6Yd0QN
M+nAQGmXbsganXqpooDMqTloSpOglYzZxqupqMXG+kYqicds7yt4Oa4GKNtrt3JU
O5dgtr8ZHjZUNVP+004sptMLpdWBfvR1CrIw+vkNjD/0OadqiMg4d7nMzvHH4MzZ
4Tf87n/x4V1rcslOk8scpdt9kw7jA5dkjcTOc1q/r4EtABfXRuWG+EiqePWj4hg/
CjkRWAJKNysMXnN67iAqmJ/yxcyIrhmD72qcDQLEgrCA0ZiN4SGwCJEjBdcnJf1N
JBqrkK7dcXDMW1eEAmCmJMOSXVhQsVBEoX91O9APN6R7P0vCcdKY6PMaN62VAB3r
H61IwEe0LImMFlJp5qGGIsAd0wh5gS351VKT+l7SeAXud7VFPoewPVNAaYv+jcjD
mGyqUa4qCc6KEdMf0GVyR16FpU/pYS+Fzy2QFZkwbd9ZV/GnzTkX7Wz1yxf52xsd
q4Yrs8SplSm0kb/bpaBH3CCk5kUlx3N/eyk+IkgfIMRdccr9+M7ktgFhCpH9IPST
QNJ+weWr+iH0h3Cc/HpH
=hfPU
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
