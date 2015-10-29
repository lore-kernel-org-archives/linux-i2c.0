From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] MAINTAINERS: i2c: mark also subdirectories as maintained
Date: Thu, 29 Oct 2015 16:52:59 +0100
Message-ID: <20151029155258.GB22218@katana>
References: <1446103548-2217-1-git-send-email-wsa@the-dreams.de>
 <1446127903.2757.163.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51336 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753388AbbJ2PxG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 29 Oct 2015 11:53:06 -0400
Content-Disposition: inline
In-Reply-To: <1446127903.2757.163.camel@perches.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +	   The scripts/get_maintainer.pl tool has a quirk about subdirectories.
> +	   If the file pattern is for a directory, then any subdirectories of
> +	   the parent directory should also be specified.  For instance:
> +		F:	drivers/i2c/
> +		F:	drivers/i2c/*/
> +	   Otherwise, the scripts/get_maintainer.pl tool by default will use
> +	   git history to add additional people that have "Signed-off-by:"
> +	   style signatures on commits to files in those subdirectories.

I'd be fine with the change. The patch description should probably state
why fixing the tool is not worth it.


--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWMkDaAAoJEBQN5MwUoCm2BqEP/R/1FHB59cduBqEvYUlkrf4m
eH9Kh1gzNfRznE31oRrj13GKJx6vqZSBsnn4p9SzYDT1oDoVCVTRxgM6wC9ZsCb0
IFC8LGh+fN1R1Jj98vCc4fhFNmdfMNl4e4/u4tGeA6BzwteFSyrMjfEVe3ghu59v
YEqIY0rLbUf00iJddCqMu2NmWdk+GmyHykzhsTfHcNzLCGRNST87BRftCll7zptS
UYzsFwPA6j4LM45ccnSwlQF58q4Ol85xvOHJzpj2smtWw+g9/nLuNQWHW7yQVC/o
f25bBARWlxfNz5wtblV1d7UzcSGnRZSfes3UsAqni7LpcbQwMuJJw52TgUJRh9lu
40rdyjZz7JbuiovYHpvCnPOhlr4ESzt4zdsYFM9lAddRpRjydHCIFPESgeRPJQP9
1jlbhoNBp8n+rVZVc0uYe4px80rUh5l0m8mTwAy3zC5HEa46jN+mVI0617f3XEiF
/IbUhtAcjV5Daq3FRAufo2y8e+atgPDrYRubSFE4gQwhSBgjeBwX5YuliP3SxFG/
zojkNbwyj73CbT6UmrhgjgMEdzxJfeyLOjjsEltGX/ZwFUyB3i/HETo1e2NOR7nN
wxBLX0L4a8kpKe+g4yPwYd2F6+3TI289cC3iWVt33CIJ2gnx6JXLJsPD2gnCZE5r
Jh8tRB/zhZFG8cdCzY8Q
=7X0Q
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
