From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V3 1/2] i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is
 enabled
Date: Thu, 26 May 2016 20:48:05 +0200
Message-ID: <20160526184805.GC1614@katana>
References: <1464164212-11377-1-git-send-email-sricharan@codeaurora.org>
 <1464164212-11377-2-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464164212-11377-2-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org, nkaje@codeaurora.org, absahu@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> sg_set_buf expects that the buf parameter passed in should be from
> lowmem and a valid pageframe. This is not true for pages from
> dma_alloc_coherent which can be carveouts, hence the check fails.

OK, given you mean dma_pool_alloc here, the check fails for the
pageframe because of the pool? Is my understanding correct?

> Change allocation of sg buffers from dma_coherent memory to kzalloc
> to fix the issue.

But why can you drop the coherency?

> @@ -1268,6 +1260,8 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
>  		}
>  	}
> =20
> +	idx =3D 0;
> +

This looks like an unrelated change.


--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXR0TlAAoJEBQN5MwUoCm2Y0gP/0DIq9NN9jaHeFQUPvwB7BQ7
0vtJCAW6QHnOIGuGG70bI65/iFMsPirMhPLSMWLwfUqCO/WdWfQMF6a7akX4F0qc
q0EMVeaHpJrVhkXLcGVqjWOIEdleDV6V/PBLpihX1UECKzA5IwW4UCADCNRLKa31
GLQhTlGxIGNThwC65hCncT1+DerfHyIpOjznO0pXTY9oLFJWKGQXjSSMZgzalVqP
8PfAvuRJ1LwgRro5Gu281kFh2YnYkst+OBZppeIj5GcxP3zLCgTdxSIYMzrjwPcb
ZOA1Pg3RpTPxDqeaTcR3t+aj+QFf7DwurCDd60bm83O3IwaqAIq1j1AUuFghv61H
T603res/KNsY1VFD7iIbD7MrvY6/OUuKPDmOSauwrMXwDAf37nwP1TMEtEsG+ewL
O/tVABaelZJJemBAsW25RDtdMvk93N0SqCzxcdg4KnA4+EG1l5BbCPuIxrK0o2ZO
7sOjDRRiBQwAS569FbBJqzBnR6QlSFrGPLGioS5ftXYELMUt9VcBqVKvrmkxc18n
423BHIRGB1wvyzYFT8PhsJZQ3/anKV8l877hSxU3Vhe0gTxBBHyExlzlPh6aOIx+
+FV/kgRVG5uK8MGB6vj5nhWhpNV+KcEVxDyx5iNSFKQRaxSmD0p6Thb2q8Y+jLcS
8kUuiRMyEaqACqyJBCYg
=anYk
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
