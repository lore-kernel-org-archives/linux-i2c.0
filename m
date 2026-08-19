Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F543AEF4A
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160773; cv=none; b=Ng5x5tHdXy3Ruqd3HViS1eLsnWa4HAPTHt3PGQx8OVqSjjZrGFpxkLYzonS7K/Ae46dCWr13PjzWzMs6VjJJ3y1KR7cqacVLGoLpxtc74XQWRDi12bZVKtZKD9YTLpnmluxXaVUp+uiUeeyNxbJSLxzca9SpVZv2t3Dz9yVnPiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160773; c=relaxed/simple;
	bh=T3rgpkOwZCmpqsQd7vmcR6eXY8DQTNMbA/ff1NaES+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aO2vlLiHL0h+WKQZvIlW18oepm5zaxgA2HHz8VF7sCnzuy6oW6pPCyy827xaJj9rGxyzJSpS6bFZGYcl2a2lL6eAGkhtZuhGrE1pfuoVk9dL/r6u8Vo506y+3fnBqsQ0/mRXYfPubPJVST1+LY8CY0xBZO+rCVFIEMdm2mRK+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Yzg/uDIx; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Yzg/uDIx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=T3rg
	pkOwZCmpqsQd7vmcR6eXY8DQTNMbA/ff1NaES+Q=; b=Yzg/uDIxM47+MPsEan7s
	2igVVFFTB6GIDrQrg4Os/LwiJRfuSOnEf/WkrL1VEsqmyHegt9yOxW96e4ol7qjV
	KSBAp5zPXvqeHfECuVMI2tBZg6cmEZBcEnuq1zDCQOgJO9QeJboXhH4iJp4AaCCo
	lgx3Eb5gOIZQ3Ng5NAHZMUR0O2yhQIFTwIXvwQMUZd+wp2zrcrW/7YoUx+/BnVCx
	m/pV24vrOiY3jdg+JKnjZWjQp43WoUiG82rZco6KHIltJ6O4PPmczXmubSq6NqVn
	u8t/v2nLdl4vqb8VTMcCqXqWIztjEN0LMIui7sENL2/CVmmcjliNIBX0ztzVISch
	8g==
Received: (qmail 25601 invoked from network); 19 Aug 2026 19:32:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Aug 2026 19:32:46 +0200
X-UD-Smtp-Session: l3s3148p1@8kqWymlZ/kNtKbO0
Date: Wed, 19 Aug 2026 19:32:45 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c for v7.3, part 1
Message-ID: <aoXovR28qAO3p7hp@shikoro>
References: <aoBAaw7d1A6-a5PJ@zenone.zhora.eu>
 <CAHk-=wjmXanEnJZ9C-r8SFPSU-8Jpsnz7YDJfduZCkF-CG0BZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fufyFs6Tddhmnwbe"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjmXanEnJZ9C-r8SFPSU-8Jpsnz7YDJfduZCkF-CG0BZA@mail.gmail.com>


--fufyFs6Tddhmnwbe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> That is _not_ how you should do i2c.

Agreed. This patch came from OpenWRT IIRC, so there are routers out
there doing that.


--fufyFs6Tddhmnwbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqF6LkACgkQFA3kzBSg
KbYcoQ//Xte5Qa9wx7T/dSwUTIJnJqkiCAP/rvewUSiUA8sj5JQXXaUqK/Njphsf
9sh4jkmHPFvhSbhh0cbLcZCfH97w4DBYxwVbrplnAzxyb47fEUm9DrhRTd627C6l
feEQ4CPu3tOMbFitAP4bnAdaRfPZwM6ti9e5SkNKHle2osoWbMphhFe4UTyHJDP3
X1sU+V/EAKdSgQQuiw6sQRJpolkGUS1T5tp0svqTAN5Ndk63lKTxx+97X7wVlxkI
OT94lTaARsjorebRmF2pPqi4p8u9H7n3DQTv4hkDYBCH8Na1+rgXdLhCtm/NfyUP
2SmSv9mZxijYTYtNTvrZwRmyBoUkQNyQBWKgYmZLbkCQ42BK+1Kn3cCBmzow5CKY
mbA5QWdaOE4Oy7HchbFpmAQV2ma4dWmBiHrG4BX/78cmSjO0zL2Sx1Kr7TvB4QNz
2yQ0UdxYFU4MHP62IMxSh6FHxHwD+NZxAiotIQdxJKNwF0d62fAVoh2WtzYwGOeV
nYiwS1WfTZdNIDdvWsTp8uGfVQ/JECv6x/Y1XUBh6sdCK8UBIUJefJfTXPjk3959
oYLOkzoK5wuq1m/KyD3cpnHZdEZRg7QS7V5l+8Drc4VAuH2YMZq08Lp0ZU2xZsSw
wrGdeGD6ZcU9XfMZSrecRijkuAKux69tHFkOGg0Vqb9OVSD1OHI=
=qNvY
-----END PGP SIGNATURE-----

--fufyFs6Tddhmnwbe--
