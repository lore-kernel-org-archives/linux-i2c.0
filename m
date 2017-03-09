From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: add missing of_node_put in i2c_mux_del_adapters
Date: Thu, 9 Mar 2017 16:38:53 +0100
Message-ID: <20170309153853.xwiihogiub5yxdl4@ninjato>
References: <1488527831-53733-1-git-send-email-qi.hou@windriver.com>
 <20170309144032.2rsd5qeg2gbhwf6x@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f3bu7gnjt2ijwpbq"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46421 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754648AbdCIPkJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Mar 2017 10:40:09 -0500
Content-Disposition: inline
In-Reply-To: <20170309144032.2rsd5qeg2gbhwf6x@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Qi Hou <qi.hou@windriver.com>
Cc: peda@axentia.se, stable@vger.kernel.org, robh@kernel.org, linux-i2c@vger.kernel.org, leif.lindholm@linaro.org, pantelis.antoniou@konsulko.com, grant.likely@linaro.org, bruce.ashfield@windriver.com, paul.gortmaker@windriver.com, xiao.zhang@windriver.com


--f3bu7gnjt2ijwpbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2017 at 03:40:33PM +0100, Wolfram Sang wrote:
> On Fri, Mar 03, 2017 at 03:57:11PM +0800, Qi Hou wrote:
> > Refcount of of_node is increased with of_node_get() in i2c_mux_add_adap=
ter().
> > It must be decreased with of_node_put() in i2c_mux_del_adapters().
> >=20
> > Signe-off-by: Qi Hou <qi.hou@windriver.com>
> > Reviewed-by: Zhang Xiao <xiao.zhang@windriver.com>
> > Acked-by: Peter Rosin <peda@axentia.se>
>=20
> Applied to for-current, thanks!

For completeness, I reverted this patch and merged the fixed version
=66rom Peter instead. Thanks Peter for the heads up!


--f3bu7gnjt2ijwpbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljBdw0ACgkQFA3kzBSg
KbY+ZA//fq2kJn0neLFr7791+4vs36pD75yHm86O55NW8dZ3nl+GidYnTjFzQykn
cAY1mZWvvdCuwB+rswsQHLB0u5BqrumY6jzByWIybGaKarKk9XRdLdjhgoNB+6uv
j3LaChUDCc109OBD2RaDCVW4+CNyKYDe6Iv5qc5k3zi6vU0217MbZUWWDEBUvhRb
FseBjVHtTOB8jcAFFRzQp0e5vZSH8s0uL5OxLSMm5ygPAFywGEyHEekJGOMa2upd
1MsIxhW++xyTD90GHQMCWfhJKK3bOnO++k/OHYz5RGq4fP5FoO6rXJhVGfi2rMRl
iDVmRTY5580TPJwz6NTBtzWpen3NAnxxXsKY77zKQpdxPRMexRk3HZaYMQXR3fhl
41KFoOLa6RaO4ykVb8E4sZ1KewTyQGRexWqPSId1jR7ypS7/cydTOKtBxv3lIRWW
ZJd7l+x/OLTNVlRshbgjd0iQ00GQrcvbkKSOY0GIU4wABV17+0jJdOV8GPbKcbnR
lAhWId/hz/8iHV5Dy3Yvs3TKyIRiXWqAf6kugm8Etl/2k6h9NJ/XnPqDMr/N5slU
W7DTIZ5BkESoqZHFcy4U60TNVxXvqADNpZ1uSyJep7i3g6BcFMUuf86OCwHvB3xh
7fF2vaZ2IIJPt4EBTLTbS8cEZ7htn/Di8L1+63VuhrXWtZ+JbV4=
=PXR+
-----END PGP SIGNATURE-----

--f3bu7gnjt2ijwpbq--
