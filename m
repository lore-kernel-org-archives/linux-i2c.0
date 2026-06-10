Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9FC38B7D5
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781124935; cv=none; b=K4Loh3sfxEfEZ8jZFgG89dICH3H5gjO+P9tsVyLRd+PQ1UdqU5g1WWxSUsPMAWHgAWd0rvYYhR0zK2hclplVWs1SYptwnNTrcPZ0gpEKJc7upssryGSbKpJK5Kmlx/hQjectP3zVF0PKl/3wveB0IR3wOhRNkhX4RADNQfDIcJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781124935; c=relaxed/simple;
	bh=mIXHirpoO5JUOLrI+CTBQl1+UH+6R+mRqug9nEPOvFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7AND7euZs4ozuwnyrS6R1YH4iLUBszQ7OeepwrKgFJIUaWiXmC8Hby3gm7pELfVyfnaHpezEYJOHO3tFOlo91/cn2AB95y8PgqZwote6fZEIWa22oVkF/uu/eNYc444LqkC33TX5foaymf91MO8klsZ2q3Mo6GIhprxPJpIoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=HWMpgHtk; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="HWMpgHtk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=mIXH
	irpoO5JUOLrI+CTBQl1+UH+6R+mRqug9nEPOvFw=; b=HWMpgHtkXKhBjnUT7rp9
	YV5aIPnNst8cRRK4hBjhzCwJE8dC1U8tiMP46/3YsZH6AMfNsNBrUr9wCoo4AarZ
	C3MWYue3kN2Us9CfFOKjLqBLKGAiW3MwEtv+oByh4owtybHAVDVx94jmwH8Vktqn
	Mcr81yloQQxCdrPx3e7Y60A6XUjwkV7BaqGdNMQq5ABUBHwoknbQISI2c1BWPYpC
	K6umUQ4LoRI0//jU0WJG+S+tABnIHl8z9HwkuGMJ3oH4mUwkvzUzblzJi97CAaev
	bbWLbXTi8wXzOY51J9rWXzH3cksfYDTNNAuAG6wNESoasqzLtuLMJ19AwSVdlPg3
	7A==
Received: (qmail 1838772 invoked from network); 10 Jun 2026 22:55:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Jun 2026 22:55:25 +0200
X-UD-Smtp-Session: l3s3148p1@YIt4duxTbIsujntj
Date: Wed, 10 Jun 2026 22:55:25 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH i2c-tools 1/2] treewide: use https instead of http where
 applicable
Message-ID: <ainPPRiDgSZVYJvs@shikoro>
References: <20260529205147.145266-1-wsa+renesas@sang-engineering.com>
 <20260529205147.145266-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cAYK8pz8byegQmaf"
Content-Disposition: inline
In-Reply-To: <20260529205147.145266-2-wsa+renesas@sang-engineering.com>


--cAYK8pz8byegQmaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2026 at 10:51:46PM +0200, Wolfram Sang wrote:
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2388757 # Issue 2
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied!


--cAYK8pz8byegQmaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmopzz0ACgkQFA3kzBSg
Kbb6PA/+NKpEgVY/O/NAXb8ta9PO2xZZgXox2qt0+cxK+1TeeOTG25roHJd9vb1M
vcOrpWy+eVMV7REFNuV1ulVybrZbvZTCI6mDEDoYuOwIIgxoMFufwC564WmgSKIh
6VUGUequurRgPClHadoOPCBI8tCJ0a8MaRdIJEuLrUnBLbu540Cwj4agBD0YXUES
hBm/Ro2J9JJyaBAT5fqwQVf8JcQPS9Q2RABI+K4Rz1Y8mMkkYyS0TitBAoWw57H0
mADfLN8zmzWssVBOB44mNnm/mFkUGv5TQk19DxRuY8is/pu85N+TOuz0ffPG6xyw
BxpFi/M1RFU3ZVf7/ffCm/EqDbiKk7o5z/QY8n72QhVKKC0bG3ZVZd4oCErLRe0R
93xlJhhFUQzVLub8Z62ovk4AviJKiDp+TUauKPN4/yshIWK5lYz6Ex3Jvn0QkXJ3
drFhiLayTECXbLMk6xScZPTWboILcfa8e7ywQoUPVNNH6CPEBGlypQ/etIF0Xdf0
cSMdUrCJ+D+hQkJSYuvuVoO79/3iIflDS8CSF95BgRQZwn3hYdlwS3FDQP8JGlgH
Aif4I9BGUDxEgBS1J0P3viHqTVojqJsoE/0b+Ni2iN00nP5CBjIgPET3X6xo+W2i
WMZhgajDTzSh59e9pt2/R/gcXGsZZeBZqB+oZtGD4KeuU6Fwgzw=
=5GxN
-----END PGP SIGNATURE-----

--cAYK8pz8byegQmaf--
