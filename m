Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A33A38A722;
	Fri, 12 Jun 2026 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299503; cv=none; b=ra3561WmDGq5xlVA8v/gGCsdw1lXEHV+I2KEUckU2yLLB86vCps9qD4NGNGmm8Suao6oPgF0dVj0iwMefh60QudrKe/0U+cqjuA+xbhvMIRs1fKIqEDjMuIbOV2cpJa89meaHjxG2znwh2Fsv6nvamzTRi02/jxLxY8Gy1/FOW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299503; c=relaxed/simple;
	bh=z28Hfe+YcR8O/UuukxI/rVF93ouCC3XO/PTSSqULbs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLYMug1M5/1hIvMlDre4ByWUHWR1+jfnfOMN3psCoRHYyigxDjl4LVVoFBX+R5oVtY3yTCQQvz9ROZzqX+XNayS3xeiM7GrDgIoE9wjdVk41Xh7XKNlF6wp2gDi3EmzooQZN5TorDjWGyL3WCM24tlpcIORmMwx8/ktOPVXZJpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBngajr5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBngajr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0381F000E9;
	Fri, 12 Jun 2026 21:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781299502;
	bh=YmUQQc7/FzgbJGihhd82zZ/dDswySV9Lk1KdLAlsFss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BBngajr5yr+kTtl87rL3JsBlauYsw2mlm0PF6hbMYMK0wN7cPkLlBps+CgEbK3dz5
	 GSGB9WOJ6AM2bfjn2b3DuROVjPjrK0z/+jb02aADDRTffnI3CmglTP6Q/wcGfAeBgS
	 s5wt8tHnunpACqKyMVYcz48FMGI+acF5Y4m7nQ9PIjw7ysJ5b18ZVSJOJM0Rc5fpYV
	 cBmU+srUzsj6YA9i2tpcl3N53qtPXMZZoTZdJbUXHbp1gEHfl7w6rpCeAkcCMwdTk9
	 qffjvd0tiaD1zW/teuPC5toGnbW+z0LdBjEMHW5b/jhhYx82ddC378iwRdNCTILxOD
	 WMmO2Zr6V58tA==
Received: by venus (Postfix, from userid 1000)
	id C5883180674; Fri, 12 Jun 2026 23:25:00 +0200 (CEST)
Date: Fri, 12 Jun 2026 23:25:00 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 1/1] MAINTAINERS: hand over I2C to Andi Shyti
Message-ID: <aix4RWPM0iSKD3ZL@venus>
References: <20260609091612.8228-3-wsa+renesas@sang-engineering.com>
 <20260609091612.8228-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b5k7pk7jyaljoizq"
Content-Disposition: inline
In-Reply-To: <20260609091612.8228-4-wsa+renesas@sang-engineering.com>


--b5k7pk7jyaljoizq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] MAINTAINERS: hand over I2C to Andi Shyti
MIME-Version: 1.0

Hi,

On Tue, Jun 09, 2026 at 11:16:14AM +0200, Wolfram Sang wrote:
> After 13.5 years of maintaining I2C, it is finally time for me to move
> to other areas. So, I hereby transfer I2C maintainership to Andi Shyti.
> He has been taking care of the I2C host drivers for a while now and
> kindly agreed to look after the whole subsystem. Thank you, Andi! I also
> want to thank all contributors, reviewers, and fellow maintainers making
> all these years a mostly smooth ride. Happy hacking, everyone!
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

I believe 13.5 years of I2C subsystem maintanence is worth a CREDITS
entry ;) Thanks for handling the subsystem all these years!

Greetings,

-- Sebastian

>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04542eebfbea..a4a0fcabe516 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12094,11 +12094,11 @@ F:	Documentation/i2c/busses/i2c-parport.rst
>  F:	drivers/i2c/busses/i2c-parport.c
> =20
>  I2C SUBSYSTEM
> -M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
> +M:	Andi Shyti <andi.shyti@kernel.org>
>  L:	linux-i2c@vger.kernel.org
>  S:	Maintained
>  Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git
>  F:	Documentation/i2c/
>  F:	drivers/i2c/*
>  F:	include/dt-bindings/i2c/i2c.h
> --=20
> 2.51.0
>=20
>=20

--b5k7pk7jyaljoizq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmoseSwACgkQ2O7X88g7
+ppx3A//RRSRCe4meuRXa1IOfQnISvW/qBLbEgfpk2C5hZSrtM64Tt7f3qwkfJVx
NNNugMgkujqQV7BIWL4F+7IUzcuJLZTFuIs4GVclMnHYkAiEfzBapFH8A3IDAEpV
UZ5NHQeSZMd9i2WRiO+e8vVALFCWqafQJKG/QA49tWncrrxsORKWnaIKq0UCOmHv
5nMhxQ9VEE7FhbaMM+0AcJBnfh45ZMMiaBHlXnIoWu7v3bfFPpizI/T9SIEDkRUS
w6NkzGKlATKJAqgY9qTO25GAmMtpnFLQRmrGAJsLxlo0z+X7TPfb1BOWM+leszmb
DWAwZPgmQrocq8cMy1sK3yN8ystQKQv5Fg3EKO0vf4QlF/B6nmTi4Mtvl9KGe4Y0
Y8f8mmMDOa27sRpk5i+zmgNiXCxRiU8XIO2gdIC3rluFWTJwiQScxNjizv9tWzrE
LDkMFZrJfUi7tZAb1BuYtdH0cvgFeDSdbDU6Xj73zk9VGjAvNLr5nSi97Ra6Mu/r
2DLpVU0uBJ3nmVK9ggLaknhhewRnqmgZtP2ERfFkzsIpxD9hDFzvx+RNkzLjJQxl
+EeKxQRhXj6mD4gyA/WgC1VI2fjv/nDNiAUc5bFkH5GFZuJ8ID6R1X7vGreAUi+F
U334dfWph4sk6slbabBEmIQR2ohtHn9r7FJ7rHE2+6cxCm+tm58=
=bbBg
-----END PGP SIGNATURE-----

--b5k7pk7jyaljoizq--
