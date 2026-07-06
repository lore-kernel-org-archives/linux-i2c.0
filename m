Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4F3806B4
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350781; cv=none; b=n3bUamxW2wH4sML4UK13joHLR12exGqT0qqQM6OjiAMvBguUvKKA1uYjmddW7Z/PHpNA/w1RIKT/TIy+IMR28dTq4wQ9GRZGkaKm6AlsNIUI9fKq6t/Udr877e1LoSZT0rxnV8Nc6FOdNC7Twx6DjMjpFD6/x2sNnBn4y03zywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350781; c=relaxed/simple;
	bh=2Ivj9KRH48TmXy/tfH2gpyyfVZRysXO2gtNEbDKxlLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqIPlJji1GNCmdw43ysW8R6PBPr8hhvd2zRkZ8zpgr8aSunPRD4NLW78730DYJvkSFOL8ZJQcOmEnNr40GbwDzT+dqupW38vunDx31BYeXf74B7rPaKbQTYwmbgwlVGXM2cfDKLJ/7so1Ee35MeMeS8cSo+i5uSXZZ6q1x+Eurk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=SLW6RhKa; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SLW6RhKa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=AI0I
	OOA5GfmXX/Dt+FJkxYr7+85kkoh/7+UJ3Pn4O84=; b=SLW6RhKaOXUiiIcxSnv6
	acqWoRQXOuiBcqiQo2x9WdZeIjEbZfM7uPTcXolKZwvwz+X5imZx9oPRhwrV99p2
	hrm49KhK+6FaMxL4W7DnqHBWCFSubQUyTBjkAcWgl2cTCvKgRTVR7YQAnrgQePm2
	y6CI2fgMsBjni/lr++JDW8LUE3NNvRL7/QyP9fuywLj01LlRsFtn8Qj4PO83prsX
	+xzcKVi/N5eP6TzJeCyzmLAxfUAklNOLr0Ul08rxIsD+n0TYVF+olkJWMIp+FLnU
	Qx2nPgNyhWWRwSzPXHoCvDjS+flrx1/4SfWy/5IVzqgLWydJWpaXyxQim+7P6WbM
	cg==
Received: (qmail 2744588 invoked from network); 6 Jul 2026 17:12:53 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2026 17:12:53 +0200
X-UD-Smtp-Session: l3s3148p1@bm1ctfJV9uZQT+F6
Date: Mon, 6 Jul 2026 17:12:53 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Stephen Horvath <s.horvath@outlook.com.au>
Cc: Brigham Campbell <me@brighamcampbell.com>,
	Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org,
	Gero =?utf-8?Q?Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Subject: Re: [PATCH v3 0/2] i2c-tools: Make tools accept bus path
Message-ID: <akvF9W7r2gXi77eT@shikoro>
References: <20260530-accept-device-path-v3-0-20c01b8f6726@brighamcampbell.com>
 <SYBPR01MB45868F802BCAB22D56DDDDC0C5F12@SYBPR01MB4586.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vqgIfxHBq2WknXjF"
Content-Disposition: inline
In-Reply-To: <SYBPR01MB45868F802BCAB22D56DDDDC0C5F12@SYBPR01MB4586.ausprd01.prod.outlook.com>


--vqgIfxHBq2WknXjF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

> I hope this helps,

Yes, it does, thank you very much! I will convert your mail into

Tested-by: Stephen Horvath <s.horvath@outlook.com.au>

if that is okay with you.

Happy hacking,

   Wolfram


--vqgIfxHBq2WknXjF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpLxfEACgkQFA3kzBSg
KbYgdA/8CZxcJUfYqNjVbT3SI3W02zS9o08GgFmz05pyALYPH0ySGyXLRkeya5X1
5oSVLwVohaneK6exl6L1t6ymgXwe4qSaU2n+dI3Wnp59yjJWu2mjj1QpUG/Btd0t
YXpVgTa6fGiaB7WfSw2o0ZdBZmoV3TWSkN2RdXMscGcFI7XpqvXqHTwNk3EYFXQJ
mb4PLuJUSHDJJRX9rWGlyGhiJFX7QA/xA5USnA2OwHijq6rwrpC8DUhNhe2VQjiZ
bmsnro7LF1ePHzGjspWUEhyCl7uIObI6DxEj6YZ3XeBjXuhzK5FuyUY2ekgw1sKD
Lt4jEz6OV6o6VfaTJNu0AcuZu1NKjk8r7l6zpvSpLQ/aNv+EB4MLDlShmiOgqimR
88rxjsmc2aQK7zo+9Lvk44Sgy/5l4Vy3RZc+AYZdGPlm8zL8mDPwOzJiUOx87jeR
AM3lM9WmKfBXHF4yIH/UJLwr2gR2K151/o3mg9/WbkVDePz9FBez/L/3RfwSruxE
wgueyyANrklOYr0JIJpaqovjP0nHhjQbbw7qdmo//o6RaHeTOGfBYp22xnFZx1Sr
BicThCf5PaNC/9MmoNvfql0QMfNa/btJy7rm5xGWwenq2z19uVVHc3zTzQt9lQ1t
HrVYog7eHONGQkageNu7vXpcRlCxDuI+Bs5U0u2gDINrXIZTHtY=
=xihQ
-----END PGP SIGNATURE-----

--vqgIfxHBq2WknXjF--
