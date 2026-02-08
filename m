Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8615539A
	for <linux-i2c@vger.kernel.org>; Sun,  8 Feb 2026 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770571371; cv=none; b=MTsxQAx9fWV5UFgV4O2epc9bxXNTK9rwrWBcED+/8M4WqGxRVnDfVUN8I/QA0qi5IsyYX3Dro89Akt74L8gmaRpgR6aC/PnkMYusljpxgjozcSfgZpX62PekcTwwnSAuOX/r+/1ZX0TFO9yF1aCHnfR5sGKhLvSDuJ8ofSOkshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770571371; c=relaxed/simple;
	bh=wv5GKBbg9TZSznC4JwYyXtj/zG5wXk6C4FcXgfg8EfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of3lR4AVhDyQFwNB6+EoEhuOR5mffSxfGXnbzPza3OXGaW8NteQOBsQa4OjGuvcNRK/uOjjH2Wu6xipt11ncka9c+ov5BHZMSRfEJ5amb0+T4GpWKr2tnfacFgjvnxcUlnx4RQB3rTV6X8yinSHFstJ0/JfwdsIpL+1hTmJMw68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=HOkZyFzW; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="HOkZyFzW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=n+bk
	dw3//T+LC4O8F19LmzyEJSJilvg74uF8cQGGLQk=; b=HOkZyFzWbMNaVHEEQY8b
	ULjYb13sBuqhr4YL6WCs75FnBQfr1ixtE5W845YKLX55rmoEjkOW7xgIto7EFFGy
	tSlk5zG6iK8w+vUKokXtWntxGtG3JbsdKYlXFkoMExt1HTK0Vk3+hsq0nD0HORlw
	K/1XwPLNO0RSkDKpfY00gZqr66uYeyEZStAGtvq391dGyzpcoleZSoiUhGyO9SMu
	ICC1Yrs8eBhDjV3Z4FZCCPWZikapD3vhd6sm7fB7GYfm+OXzEcOUJdSw7e2zmaXs
	ygS9vqTShZrYbkpNIV8XL73O1PaDiSiBlOzSj9OSHoPJ99OHKNlZQIuMr4/WWHJw
	jQ==
Received: (qmail 648753 invoked from network); 8 Feb 2026 18:16:04 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Feb 2026 18:16:04 +0100
X-UD-Smtp-Session: l3s3148p1@a5tlLVNKsrkujnt2
Date: Sun, 8 Feb 2026 18:16:04 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: i2c-host-fixes for v6.19-rc9
Message-ID: <aYjE1N-_26RNg6os@ninjato>
References: <aYZ-AZcfwfG1poEH@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+HSH1unwJL+ztNJ/"
Content-Disposition: inline
In-Reply-To: <aYZ-AZcfwfG1poEH@zenone.zhora.eu>


--+HSH1unwJL+ztNJ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andi,

>  drivers/i2c/busses/i2c-imx-lpi2c.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 83 insertions(+), 24 deletions(-)

Well, this is a bit too intrusive for an after-rc8 pull request. I will
add it to for-mergewindow. With the tags in here, it will be backported
nonetheless.

Thanks and happy hacking,

   Wolfram


--+HSH1unwJL+ztNJ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmmIxNQACgkQFA3kzBSg
KbYfYQ/9FYZB/5mEWCVtKoXf02viQweI28UZj4uQhOgmlPUItHW+McZnsYaVr2mn
yMAD/ahQZ6Hf72UK2lj9AnGtMrN1euVXebuLW9N79bnrtINX2TYh8iNf9rbIjIUk
nePBX/rCIZq3IJ446bF5MOK+O61LcisSOXYQkX1QgELMJT/PILS3vSlE8USRjymR
id5qGRcn5sRpWeq9P2Yt40py4aVWQHLX0GdEnM1kr2JTTbvy0u+Z0Lh90agpHq6d
I4/k9dniWkV+aFkMgGt+xz5Y4+NcPZ0M9etGvgkr4GX2PqxoBERq61q60TsWjAL1
agOKgcT/V3hJTDOKwn0SpnSKHIihhYxNN2AIPhKTY1Vc4weZBvElAIvGGE+6OKQf
vzDUZ6MkvywiFKSrYXTlTTpL9D6Nshn1odLSA036aBJMM6FbJYB5TMgar9m0InD4
k8bIgwAz9MeaTwdVPUsMaV4t3em1I2RuI6hBoAahV7aBx+yP/TYZAoINIjHKBo0O
uGWd66IWX9XFKOi73mjwih4qQtei7leWHafBeUW/9J7nfFRf5b4kyaTHfDc3UilP
LIZDYBVpC21XNWX55rexhjZunR2Ar+aN93LWx1eB4D+D2eRTO0FKNgmMCze7pbzo
NgjRaeTL2NFerapNopgtFKock1/qpVejT+utOI0ZoAB1JH3cxM4=
=V5R/
-----END PGP SIGNATURE-----

--+HSH1unwJL+ztNJ/--
