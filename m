From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: return probe deferred status on dev_pm_domain_attach
Date: Mon, 12 Oct 2015 08:23:12 +0100
Message-ID: <20151012072312.GB1477@katana>
References: <1444563571-12247-1-git-send-email-kieranbingham@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46016 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbbJLHXY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 12 Oct 2015 03:23:24 -0400
Content-Disposition: inline
In-Reply-To: <1444563571-12247-1-git-send-email-kieranbingham@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieranbingham@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kiera,

On Sun, Oct 11, 2015 at 12:39:31PM +0100, Kieran Bingham wrote:
> A change of return status was introduced in commit 3fffd1283927
> ("i2c: allow specifying separate wakeup interrupt in device tree")

Thanks for catching this!

> The commit prevents the defer status being passed up the call stack
> appropriately when dev_pm_domain_attach returns -EPROBE_DEFER.
>=20
> To fix we change this back to the original return status;

What about going to the error path?

> Signed-off-by: Kieran Bingham <kieranbingham@gmail.com>

Please add a "Fixes: <sha1>" tag here.

   Wolfram


--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWG1/gAAoJEBQN5MwUoCm2WiMQAIA22AuivmCY0paSHIe4FE87
3QhBAGDfBGSnIvfgZUqDXAd/rYlxwMHAwLHSvoyscoDMQkd1JizF2OxDTW8KE/He
nwY6+AwpyMlQK1Aw+QNgIS87bbP07WjweqmWh3a5DEkG2xNqlcHLlMzGcC9soiQl
mwxR22xtD3y1IRkFcpqH4WxUEKdgA3KZ6ePaf8kiwgPhzeD4Jfg7vwmkO7uw7Wmw
aqhR4WcLoOWRyAXHWfpKZocKUXUV0smKvun6OykxGrJkBxm7wywBgqFSQ/bVDiOp
z+IzVPhJx/NtehKmgBpz9mIeEnowXc/sTynm4vd809OI/K3Mv/gARl5WxFG5uzmA
uUFuixfaC8f6/aFHUSI67GHyGtvHXAPDhk88TaaGTfpdxmgAumdRJQs4Mukjbizn
8SE+dnW6wsM2CsxfIhLw7MZzewKMnr4iSX6xLh/IfuJCpiSHxas7eKmvFqoBo54c
0Ji0rDjxLW0mBKGp+SBeWOZ8u4BPr594X9T76dnm6eaXyoIRqiZbAZe7IBCnlf6a
KpJZwegFHgBStPuUIo7OluBAkXAXGP4mEFlYzZUz+Si3locd/NDpqtk46zdeDTCo
iwKIbILn1VjwePAtjisujXMbahKxpoaThKwuFeCVhtShvB9VfxjbnSq3Wd/OvuHL
i6V4ooHbLsGFOUMMOYsC
=ZnMP
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
