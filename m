From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: piix4: Request the SMBUS semaphore inside the mutex
Date: Thu, 9 Feb 2017 20:56:33 +0100
Message-ID: <20170209195633.GA1431@katana>
References: <20170202191516.4476-1-ricardo.ribalda@gmail.com>
 <20170203161739.7264f85b@endymion>
 <20170209160926.fmxmnjb7oqf27pww@ninjato>
 <20170209183139.1a63f1fd@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:46028 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932131AbdBIT4i (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Feb 2017 14:56:38 -0500
Content-Disposition: inline
In-Reply-To: <20170209183139.1a63f1fd@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I use Signed-off-by for drivers I maintain, and Reviewed-by for the
> rest.

I see. I never noticed so far :)

> But I can use whatever you prefer if that's a problem, I don't really
> care.

Patchwork collects Rev-by tags from threads and shows the number of tags
in a list. This is helpful for me because I want to process already
reviewed patches earlier.

So, Rev-by would in deed be much appreciated for a better workflow.

Thanks!


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYnMlxAAoJEBQN5MwUoCm2SmwP/10vvycX9SVrU+kHRfl+KOMg
ShITtLQEmegRPxTlnjWo9e52M3xkoGg9BPx1NhQh+0h/tUpidSwCueTAvh5+cRqm
XjYvNO1OdwvzehdCAMEBq1yghFjOC2qu/R80e5p3RJc1Qj8nGVhJ1bwIkuNuI65r
9PITHf38MpVDXMrGm4CbgUj+IPjLsyVtDZGIaJcUXjifyYuKjXKK8DU2SLS850Du
DR46GAIiyWPEkqXKqoIiWi51b6n3Lrg0ZHBvNd1K81KECuVhR+yYpH+x87SpT9Ts
iJHwJJnVSdtZ3idxjiZSHPTGzzk4Po3jybMLZoZZRuOOQxeR3KXLhJtbBgflnPFt
l6OfeJOUP0/OSjzpBh8c2D73cmiPBx+9c2BgbORWhkgvtXF531F86YOcc1cgOreq
8AlWF1LRYNiit6raHCZZRA5v3VMcJ2eFbF0QBg0bpEDDgo0ci/yBYHLGAk6lOIIG
2MhrjMmXtUBzWkw9DcSegk+IeqHEFzn1IxX0i48xnd4gBymGkRuDXOHUGU7KbxyO
Eg+EZGCTUpYbEPj5Jqp6E9e17YAeJYxM49lPpBdCjEpev9aAea52JZwwOKcVelXJ
6Vv5ZbLkg4+JG5HtSxTlrfu7uVwmZHUsqDLnXGFCS9+vX3HD2Mw0f1cSntgYksi2
yN0pyti3NGHETXRryR4/
=NVdz
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
