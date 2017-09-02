From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [I2C] About warning 'DMA-API: device driver maps memory from
 stack'
Date: Sat, 2 Sep 2017 23:58:30 +0200
Message-ID: <20170902215829.3jpwmbyy27cpu5rm@ninjato>
References: <1504354088.31793.48.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kw5527oc57zspplz"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33116 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752761AbdIBV6d (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 2 Sep 2017 17:58:33 -0400
Content-Disposition: inline
In-Reply-To: <1504354088.31793.48.camel@mhfsdcap03>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jun Gao <jun.gao@mediatek.com>
Cc: srv_heupstream@mediatek.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com


--kw5527oc57zspplz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

nice to see someone else interested in the I2C & DMA topic.

Please check this series which I sent out recently:

"[RFC PATCH v4 0/6] i2c: document DMA handling and add helpers for it"

In that series, I proposed...

> 3. kmalloc data buffer instead of local variables buf in function
> i2c_smbus_xfer_emulated(...)

... this solution. Although I have to check Mauro's general response to
the series first. I'd be interested in what you think of the series,
too.

Kind regards,

   Wolfram


--kw5527oc57zspplz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmrKYEACgkQFA3kzBSg
KbZt0g//fPC1uKGhc3J/ow/k11MRV0mL/pL0/Gva6fhMRCFIAVUyT/SuOcKrn3Gf
6W9u8DUBwMTBnUDRTLIbUhfkYDfXuV7GP5McMwc+GMBAqi9iHYmOnZ3Ddr9Wb67W
iACGn7MgvDgzbHf8NcJH4EoEd6LSa1E0pHSM3cmOB3yVXfvvTlUyRJzBy7J5xPqe
w9/Yd0h4Qc6zqAmAZSa1k/fFMZnzpzRRuuXq+b2MeqWLPNbRbN3lPHuCyQyt3CtS
JOG8BL3yYv61xNlfsNKpt2WfWRLm7imPAq6jFXyqIYRzzUaoehXXEJErJBrA32hd
Glxc4txdGm6Rv+6LLDQbWoB2KUpuKu3RNdzXXZGt9YWIN6Iog3QqeTSo4xa5FVlP
uZmJONx+pCczMVaZGOEHpGH9jGP55frD5AgGvcqFf0HmvZBjOQZTu/rKhK/GR5Vj
ceqolEhoujkgFJYy/rcVgqoH2T0KyfVqjOjVVo+disgLuAf+Q8lr2neGF8BD3nFF
njSpNzzJXImNO7WkX0S2TDjR4StWgVW7kpQZAU4SlhTXdXc/8edO+3DHoEuLC1RD
aBFB8dnQ69SyQQs14XqZaN3l/W+vuXHEPD3/+3oVAnzLHeJT9t4pqcI9/nZ/r+Ax
5gK0Fi+WbiDH+wqi7UOrLWhX+nytbeIu8x7mRwPUGnoB9MWzGdY=
=Zzs8
-----END PGP SIGNATURE-----

--kw5527oc57zspplz--
