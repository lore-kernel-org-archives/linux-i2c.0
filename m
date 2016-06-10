From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC v2 2/2] i2c: Pass i2c_device_id to probe func when using DT
 ids through ACPI
Date: Fri, 10 Jun 2016 15:07:06 +0200
Message-ID: <20160610130706.GA1624@katana>
References: <cover.1465477193.git.leonard.crestez@intel.com>
 <f5d92224a005bc7b82e210957719b7be142c6388.1465477193.git.leonard.crestez@intel.com>
 <20160610070424.GA1552@katana>
 <bb2702c4-848a-4e0e-6381-66af079a7c13@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38587 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776AbcFJNHQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 10 Jun 2016 09:07:16 -0400
Content-Disposition: inline
In-Reply-To: <bb2702c4-848a-4e0e-6381-66af079a7c13@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Daniel Baluta <daniel.baluta@intel.com>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Looking at that series it seems that the intention is to eventually
> remove the i2c_device_id argument from probe completely? That would
> cause a lot of code churn. It would also require every driver that needs
> to differentiate between models to pretty much duplicate the matching
> logic performed by the core.

I am with you on the "duplicated matching" issue which I personally
don't like at all.

That being said, it is the de-facto standard way of doing it currently.
If this is going to be changed, it should be done on a BIG SCALE.

Currently, I2C has a special way of passing matches. Because I see more
important topics to work on, I personally could leave it as is. But if
people want I2C to behave as the rest of the kernel, this is fine with
me if they are committed to do it 100%. Replacing the current I2C
special way with another I2C special way is no option. The correct path
IMO is to bring I2C in line with the rest of the kernel and fix the
kernel.


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWrt6AAoJEBQN5MwUoCm2BjwP/i0L5adfg2+sYGRO43BmllrG
lyyLOg+KLDqh6HOmPTyWdFEq6WRihEkas5JLhMXYdfGbvEcc7VlGLDgGk97e33eZ
XwBTlgJ+Mjn4Zk4kdBV3oBW9Y6cTyoBitnRCB8G2sgpGT36/XBu1YdxBZ/f/w7nL
8ZcPa/0WVmBpWL4KS4PybiM2ETyNFUVwD3ldAsTpx94sadROEAWWKz8/uS8ibkx0
AzBh17t6qPFgH+7ISt96ermRmMVgvHsA0umvAKQzbwE3WPWv7EJpws+A4tPwMkEK
olta+pWVrBgZfB4mjrGusZyyuDyqbhCZ8kYDCfPlzxcfRGpECCNHF7xDwE5AfO26
E3USO7VzcZq7fsJPu8fkBccOo88/t6KUkKeiFVAeOjDYMmNtIiWC7kFIFQSuOR0C
0eHEdtb79E0CgrCH4oh8msTXCBur21/HL5gGFy/CgiPFfIAuSdZN45kkpUXnv97J
SXBC7p+eYs4ZYNngGxXUcTiBSjCGXYWiHeBXPoCiijeQ4a+EL+W9jJkU/qJc6sRt
/JNgE6m+e14t23zRzYcTgDnK2ZHUt6iLiBBhQx6YRn+o1GHJYvlGLmtx1NhuBLYv
vvXqmG8O8AF8GHs/PsJkSeQn3aImKPeCua/CcEaeniprlJaaF1lV7SdcopoNWtKl
Zcg0e6nzjn02LNCQ+X1G
=DGSY
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
