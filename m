Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF61DF27D
	for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276953; cv=none; b=Sie/Ro/fT6fydngTsDRJ/vo65Mdzi9VyAIOF9jlYrRTOb/bhseEV/x+o0rb5Gc6M1QDJ+Sv/fCofbO1FaV/2mFdaD7TxGJCawzfcCp14ToDJzaqBRECkxuB5jyZSvwwQNu+9ocqyrB/Sl6ZzaNgq+7LLrrZ9c03eiiuZuxB7uGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276953; c=relaxed/simple;
	bh=gYOfnv10yiJnvS73tXZESoyFBLkQ9zM4fK1X0CYCrTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAlUqGZr1yQaxmpO/yxuF0sPOLVm/ZWFd+KsxMVex3yDow5lGultpf9diZT31HCK8u+URThIYQC6v/bFTnHLKjr8L9GqWl1NhzhGGkoQo4NJFwdeJ0eI8AJYsIPnyQ7L2qxTYwas6SIquqOBk1mLUc/TU3S4LrMhE0yiVMhC1+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=CtTIarg5; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="CtTIarg5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Tli1
	pCunelooiZp6O8iCJ7ZrTKoTC+hnNHTVIuK8Yso=; b=CtTIarg5HYZjCskmh2R3
	vY9AF54qWrHFJIWvB1iSmWgRqAAJ/z4qMqz+v2TRurs3/4zMlH8OhbDtOqoimdWN
	kSTvBpmNa0iol8sDPD+6hleCEFeCD1i6zXFovLQ9fQwYrV2nQ17ZyLyQ+0/Rla7P
	w47Pm/tuSLjs5hO4ACWhuW0iAH57mP1eYfavtvMdVbORaQ4HqHPpev0ewUOI1BMu
	qVryMvw1/Ik3mEoNOass2qWwCaTwDfDlSW+h+ee50fGTCxRrqtzvF0khE+f1D59F
	/OGDrcw2jkog1OjGJRdYZxa3h8oDNDQe9wwh42swBNs/0fcgeGhFH5vlwvVsF600
	Xg==
Received: (qmail 2572868 invoked from network); 12 Jun 2026 17:09:10 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jun 2026 17:09:10 +0200
X-UD-Smtp-Session: l3s3148p1@ccDU2w9U5ydtKXKQ
Date: Fri, 12 Jun 2026 17:09:09 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c-host-fixes for v7.1-rc8
Message-ID: <aiwhFWZYcCWcl1VA@shikoro>
References: <aivZw-ahxAAtnTjl@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KqbrmBTy+m2LKE1J"
Content-Disposition: inline
In-Reply-To: <aivZw-ahxAAtnTjl@zenone.zhora.eu>


--KqbrmBTy+m2LKE1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andi,

> here is the i2c-host-fixes pull request for v7.1-rc8. I
> expect this to become 7.2, but I am still keeping the usual
> versioning inertia.

Totally fine, I usually do the same.

> It contains a somewhat larger set of fixes across several
> drivers, as a few of them were still outstanding. It also
> includes the MAINTAINERS update.

Yeah, two fixes are a tad large for this late cycle, but since most of
the added lines are useful comments, I will sell this to Linus.

Pulled, thank you!

> Thanks a lot for everything, and I wish you a great weekend.

You are welcome and same to you!

   Wolfram


--KqbrmBTy+m2LKE1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmosIRUACgkQFA3kzBSg
KbYI6RAArZgUFyhaUig32rMkDVv61+zWBEUroipCJ/139ejpyL+Vx/Ot1PiNLjc3
B6xOrSYTPsa88IMyTvDP7UuOM5nsfiQ3nqO9zLUHVDUAgIJi/yVjro/gSvH3hVeA
Art7cWH+gR9dgy0YTUxtnAh7eO46ScAmhTrM3aSD032Mq00rEhV3TsB8CHve+3FV
Jkdi5rynqbpFOrroMS8gY4gQT6nqS07zF3L/eha04mrAhcdxbWVy0VZLB9D0tTrB
6qNjcr3G+8+Qk4f+/9S+oElTvOuVggc/yb1moR9PRxaRDkPJaYqA+s67czum2OEE
A051dObtP+UnFLPlOKOKynIMB/RuwfQqaVoBu+lhSYHDyXjpnZNeapNw3/gAEHf9
CJH1OmQ74NQ+SJe1AUO0wMAQJ0MYZE6QUMEckXojH6JTSViOfg4GWTd9/izl15Aq
TPtCKE+9Eje/eYkbuXFHEigXXOIxcExPSVGoeBiMx8d/7P+kAoRNplGxzNr0NURt
vPr0vJ/2DlQQLoOq7uSvOAVvFzN/49Vc2ZGObTbEjKq1TP1GKXclPP81zhd8A0OL
0XI1hMbA8ACXc8Y+rZcP4uKnSc1ZA4n8mJpmy7JtzoBfiZO2LISBZT0OBzoa6zrh
b1KK4IaAvRfrq0Nea3qHIBiExMFrZyueMvjEzY0MksrMA5b/WaY=
=sjTX
-----END PGP SIGNATURE-----

--KqbrmBTy+m2LKE1J--
