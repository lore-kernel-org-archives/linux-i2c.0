Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21714322768
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008794; cv=none; b=KV4Lc4Hk4Pon+6ExyaAMqexcLg+GTI6wIeL1Ho4jGTwD2N8DR7Okae0FOdB4Ttxdux9HTZeZAUSUGFDtvltH3Rzdt4KiNR1mZnwApVBoDsHUYREL1IRA3i28W8WQRImBRLrW73lcG2flXtlsYeOP+/If3jnZW0QOOJyYvWaTDP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008794; c=relaxed/simple;
	bh=+UjPjUqSSRRR889tLVwy6e5/4wCCnTqRcR3NMKnxhzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psX48IGsq7/W6/H3ewlDwWM5xU4OfLoXHO+jhtkyJzhMQd7GLzKye2zMjw4SAlRjCtsf6As+T8RIQcRiO/3tEoYPbsQdMTqtmbhMGfEmBCJpXe6qjil8dLyhK3deCznwJ+3gHkXf0e3WgAoLfIn7PO8YJ/Hrvf1OmiXSpeZYzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=aImqA+KY; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="aImqA+KY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=+UjP
	jUqSSRRR889tLVwy6e5/4wCCnTqRcR3NMKnxhzo=; b=aImqA+KYyPUBSKzC/U6p
	fga6igOMhSG1uCVTeTDAOPBndqpmfny/eTphgvejbHEjv3fvaNV0DUJ9UCv84Abz
	I/fvMQRRAM+x64Hcz5srgFyO53LKPAkFlOe35k4kKpx/pyQE5yzYvAL+yeUhkRzD
	GQ3D3exW0bC8SlkN6VHJsUv9U41pjzO0I/kp+aAvDlwwN30WMMToXT1vLtbuYUkq
	meJ9/T92SlcCJ4EhqqTDKycrEcsRnQHAOT7kf5Lz00mGVOAdBri6/Gvpu4x13sVW
	F39qNPQY85bimUTOZkN9hif8Q+8QSdwVxIpVs+h4bA+vx3KORfyBVIVvunoB2GK2
	hA==
Received: (qmail 1274815 invoked from network); 9 Jun 2026 14:39:50 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jun 2026 14:39:50 +0200
X-UD-Smtp-Session: l3s3148p1@vCRAbNFTMM4ujnvA
Date: Tue, 9 Jun 2026 14:39:49 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PULL REQUEST] i2c/fix-registration for v7.2
Message-ID: <aigJlbxRhEdj1vBy@ninjato>
References: <aiclzp0IA2Rk7NyU@shikoro>
 <aifphmi1oFYZz7dQ@zenone.zhora.eu>
 <aifz56BVLCdk-lDu@shikoro>
 <aigH9xxr_2T8EZEm@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X/7QBt/Xw7xHX/+B"
Content-Disposition: inline
In-Reply-To: <aigH9xxr_2T8EZEm@zenone.zhora.eu>


--X/7QBt/Xw7xHX/+B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> yes, I did spend some time looking at these patches and i was in
> doubt where to merge them. At the end I decided to split the
> series.

My suggestion: When in doubt, tend to be conservative in changing
something. Fixes can always be backported, but regression are a real
pain.

> Now they are all in the non fixes branch.

Great, thank you!


--X/7QBt/Xw7xHX/+B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmooCZUACgkQFA3kzBSg
KbaCCg/9Eh4ph0WTi3o5jkEFvoSeGLNAy31iLE/SH9ynv5/anYjnbAEs6Anxg0op
Yfmbm2VK4IW2Ho/x/VTeF5RBhyF8FttaIttjQ6+VvmANm+nP7wySnH6BzcA7Wu2z
bOtAGbwAIj7CUGjcoMvZM5KzH80Qc4+M+Qyh4msRB48ae3kpv3ipHrsKOQXThvHU
0h2j58oh1JtZtgtjdWT9VV66fTzQc8jD9TACVmDMqGABOCmMolU45rN3ByJ/FDNP
7Y5vP1YMasndWtjW3IzZBhhK5MbwGqdGXcn6MSIB/Z39ae0aEvKY0pGGsixGv3Q5
w1cwd9V/5/R6Xg2KkpR/dl4222I8+8+DOl/jGfEwWvAVfdeLvXdSDG76MgHHbn1W
frkH0TRYLGLHtHjmelP7XopMs+tyG3Op2ZiW+S/VCU30Gypc7RMF1n1B8WpUj0U6
oWMBtJAmgILu8CikuhEgo5FGl3FAzxGzOFKQKN1hr0QbI8Z99GbRWWT7p4WhsmhM
ozMYu78nI8Qrza7U+9UnC/QpUtg6i1oG4UmObhWBZQ9Q3sqnnDhSi5GxEniCwD44
ZKO1cSQ4aA5Z3jsZY3b95bpsvlOlLKo4WbvEutZvxqpa2ZsgoKV/Iq/UFFmg13/m
0KPktP4gW0PF2Ruw2oVs9J3Nw87+mX1YbG3JHJweubZtRRzburY=
=XuMo
-----END PGP SIGNATURE-----

--X/7QBt/Xw7xHX/+B--
