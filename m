From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: brcmstb: allocate correct amount of memory for
 regmap
Date: Tue, 1 Mar 2016 19:19:36 +0100
Message-ID: <20160301181936.GA1488@katana>
References: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35355 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbcCASTm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 1 Mar 2016 13:19:42 -0500
Content-Disposition: inline
In-Reply-To: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 21, 2016 at 03:16:48PM +0100, Wolfram Sang wrote:
> We want the size of the struct, not of a pointer to it. To be future
> proof, just dereference the pointer to get the desired type.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-current with stable tag added, thanks!


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW1d04AAoJEBQN5MwUoCm29MMP/j4iTIuedyjHQ0YcfgCxxn+/
w85ailSFRPc3k2Ac5RzJKSPnaR1DZQCl3XMYhSZaVmerp04Dqbc2me9zf6/j20rO
VEqevBDFhjHvtDrukVsyfCfALe/7BZcOzqj0wI/N73k3gti9R6woRe55O43qAClJ
YQ1QYNfXL7wVbLDxgA4D79p9H84eEPiTIAc2WxERNoFCnjECAPmVnXFB4sjxS/EP
3/4Dak/kbOfHkSUFPhwViT1eDiOqJw+XZ2LLKlZqm/bXxOWCeIaC7txNo5GDT8gX
QoKMV3iWPmFIFttbne2bSj7v9JLfLR8REl7yPYTmWb9aFYuiiOHxXKyUe+hRFIw/
ZewKptx7JB7CEF8WhkV6iuEzdPT1tXANoSl0fX9AhWN+Whe1oeqD8lZjYULotySK
g8dKAcXrkXXYWgfuMmeDDfbO6zFQxFt5VimRcMEP9wlf5SvFcVa2/GueDvTQqhWK
igUy3tvQyKB57JOa0s6YgJwSBdiYnWPyoY71N0D5ynGpHZ9nDEwBwgTJ+2+rCMJt
hydVgx64bK50NzDpwAgoWQtx1Lcs0cc25qkPIURpNnF5+L0uosaD0nlgpFr+HKBx
RDxP5j25P8QyjOAQJwWD4aezHEPhsi+Y2AHzJ820SBPGO/qa9igriOf36koUy5T3
ndk/6K8b/xY3sPlp8BoU
=3bfV
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
