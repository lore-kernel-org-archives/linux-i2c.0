From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rcar: make sure clocks are on when doing hw init
Date: Wed, 11 Nov 2015 17:34:03 +0100
Message-ID: <20151111163403.GA1527@katana>
References: <1446146356-26166-1-git-send-email-wsa@the-dreams.de>
 <87io5pgrcr.wl%kuninori.morimoto.gx@renesas.com>
 <20151111082606.GA24344@katana>
 <87wptoewvw.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47030 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752328AbbKKQeK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 11 Nov 2015 11:34:10 -0500
Content-Disposition: inline
In-Reply-To: <87wptoewvw.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> On SH-Mobile case, it automatically power-off:ed if all driver
> user was gone.

It does that without calling some callback?


--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWQ237AAoJEBQN5MwUoCm2jRAP/iyFz5+8hQ8fsyb7izJlbuFR
Y7qVtw5RKnzZ9jNLahcD9ejRRkXsnFXYF0g/Vn9YKoir0KUqtCKXOi/YuMpmo9g9
/siXzm5DIexEBI1X2gaQidHShjruwlYn7oAU4ZR4+kdmQEu75lczww/qwzhMcX9a
lMdB+pdeBBwx/KB7hufb3unsFen5gUjpCq8BkU+Q9M1NePduvVmZWsrCQsPB171f
D8VcDKBbr4nsc7HV1jgliAnS/QWcmfVvgt1l/gGH/9egQFiWKatd0FVBEwSOv79H
6ixDiqRU+dyM1I7Ix/HpE9JP2PrrE05PRFScVu0UMPwhxcFQE13hhYZ/0B35G11X
UXLKDYIooUYoL8zWglPx9xTtKy3VcV8zRRXtxQkqdSwDaUAu7+0BbpQYitQrEGgo
NHxivhWvvbtivwxlLJacWuQ6SkxD69kUgFC1/Oir5pmImLAcktnEXsnEjJ1Gi3Jf
e118MUngscrSIUUc/5dpaGSzgYuD/++5oQC3cx0Wn18did5W5K3WN9WW23/+mhJb
ncuOOh5ORIeCVg0sXK0BMMYdnTtSx4YR0lST6L/Um/JG344Nzym4ouq3Hmmsh0uX
PoP/eWdgBcpLXLbXZQemkQezMmjzh8KjyXeAQXI3D1qu4BY5Gzx5iOXLkSexk7Tf
6C3h433WaV8Y75Pc0kOw
=4RWJ
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
