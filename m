Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEDB369D64
	for <linux-i2c@vger.kernel.org>; Thu, 30 Jul 2026 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443040; cv=none; b=G1jg10f7Ok34ZEfG9zWAoojeQ1ki7+/AivncWAPpwwbChEpIPm28Hv6LHfeiFrgGU3qwz9MTUHQ6ZAJ3skxT2MCVdXBoAMn/enNbmNA7ZGtVePc6QkvmqcBGDiuLbTAhS7jF/Qc5am52aIUbVsZBmUTHJFnD6OYXABYSvNrBoKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443040; c=relaxed/simple;
	bh=cLEDCXJcA8BK/WrOkUtMR7BaGv9prsWZhysV/YchxbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwXCwZLv7RA1z86xG6S0umm860lvrtI/Dw3WTEVOcLVjDn6oeY24up6LrN5NzIPecs4z78DqAM4RyqyPZSQP/QDa7Y5dKVE2zRqMdhp5cA7Hkzv4MquQKcyEVaTLO6A/lBzOnD+vlgZ4VOX3hSqxzatU0MeH150zzapyZDEK2z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mK691obv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mK691obv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=cLED
	CXJcA8BK/WrOkUtMR7BaGv9prsWZhysV/YchxbI=; b=mK691obvzHJwb4BfCLm+
	4aDPFY6VNRLDZQKnsQCq80mPGjnZ2njo27ly2lnoB7rSR9biVexy1OW1Z68sSnKj
	RuD12YpF/Skp6qAsfXkvaYCoEY99464CPzNPxkIK4ra5MXYCgWaWqbg8/c89aRNN
	BWpTKHmk5IH4LAGWyyhMCaqpV7FDM3mhlDJEJYjyce4nblxkI4DmlBVHb2qI99Sk
	T8iNKAkzPLQGXImJX2bInSCJlh5Hs7n8fQwYVJYVadX0dFgRUqoVeiFY8jyycWAL
	RQj/141RPg3V5wO14N4JpLTYsWnmXl440wdUOxxX3c7NB51EUhum0HidHWGpxrUw
	1Q==
Received: (qmail 1850518 invoked from network); 30 Jul 2026 22:23:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Jul 2026 22:23:47 +0200
X-UD-Smtp-Session: l3s3148p1@sANf2dlX/i0vQDOV
Date: Thu, 30 Jul 2026 22:23:46 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
Cc: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v6 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
Message-ID: <amuy0mdHQlYCcRfb@shikoro>
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
 <20260720-master-v6-1-671261b05c61@oss.qualcomm.com>
 <amZkf3lu7gjWhw04@zenone.zhora.eu>
 <0c0d1406-949b-49ee-b203-3833b9f8433b@oss.qualcomm.com>
 <ame2tX1RwOo4F6Lk@zenone.zhora.eu>
 <cb1e00ea-658a-416b-aef6-46c151d15685@oss.qualcomm.com>
 <amh5l4Yvwemws6Cx@shikoro>
 <fc90084e-c9bf-43da-bb8b-43a8d2d0cb7f@oss.qualcomm.com>
 <amoaEGX8Q4zwHF2i@shikoro>
 <be5ba8e8-15d0-4fe4-a66c-fe7ce8da6cc3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LtUAlmVp+O5c2oKO"
Content-Disposition: inline
In-Reply-To: <be5ba8e8-15d0-4fe4-a66c-fe7ce8da6cc3@oss.qualcomm.com>


--LtUAlmVp+O5c2oKO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Given the feedback so far, would maintainers prefer that if i drop the core
> helper entirely and keep the dynamic timeout calculation local to the
> qcom-geni driver or should we continue exploring an opt-in core-based
> approach?

Well, I suggested a potential way in my last mail (Kconfig option). So,
what do you think about it? Does it handle your use case?


--LtUAlmVp+O5c2oKO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmprssIACgkQFA3kzBSg
Kbaftw//f4sM4W3OptQWLvmi+D+5r6RzcQ5yaxgI8XDtr+iuV7uRh5mc8lsV8GLK
V8pQLX7MSJuDfopakepHsCEBb6RcGAV+DrP3WrA5hzYK5jkROpUb7kyeY2F1EUQ3
RI8TKkPBWzoovKkRkQNXEl40hLKJ6oEyTYnsCyfoRrMNKW7hbr0aKEvMDV6PsnwQ
s8HXqsDlCTgo4Y5ZCBXUbfXyNOSlh7K+/HQnxy2oNhy7OVatcnYbNYyqSZC3WXx2
q+N+axoMviTXxcpMNlBm/jiZ01zc6quR7cfUos9OboMHe0hFAnuAD8br97y8F0nn
tD+IK1VpDpv1yRleCyuwE05jKxKwTqIwhboYPY6tXk+gm7QL7mXrUnDTBz0LqYwm
iDp9W5nwhwVKr8hA29WHgo1XEuy2Xwd3HyMupj7fHIngGt8+0BY2Z/0n4RD4TY1N
RHCm2hxn/8/YVJULmvsLwE5kti5qAxQzLLA29XRybo22YwN5dEsxHSB4xza0T43y
fd222yWYpuc9taHsmkb2hF3/Pj78zTL2ppauaixX6ZiczW1SsUnV/ItH+CfrG7yK
3LIbztrteC2zP22ezgW8N3y0mVvLLhchPyEAWTJx+NSElonQfEsV1gLvF181brsf
cYkJ6tAKc3hjGMtBNlPh5pIMeQvB1ZuPfzcT28DRw9p6rOtBqys=
=BDhl
-----END PGP SIGNATURE-----

--LtUAlmVp+O5c2oKO--
