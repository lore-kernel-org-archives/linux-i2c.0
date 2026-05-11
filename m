Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5A34B1A7
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495602; cv=none; b=GbZK9Qu1v8gYtHRPAwMbE9gLYCGoJ06xRrdFKfo7yF+ei7pdjxZsKtEJYa40t1CfbJ3pl3Dyh4+vwM/nyx8ridz1g4i4VRb/+rDmhDurfK/zB7oZLmVdOzX/ZZJ797WH6DxVGRns9DUAa+g2krN0vkoaiLynKsytz8nHonGs1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495602; c=relaxed/simple;
	bh=sy8FL7aK3NrhtRssRkrMqVNuTzd1KZ/TvQxITYkNFWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCUkETsTY5jtPzoVAvq6tbc6FM0Uxc12vtocsQuA0z4mQ1M1wnC67yxv1Y6vd5ecyb8wAS/klormLmkMFF3VugKtpsgj2pc2r86as30hUTGRuh4xNMxe2UGIaKQSamhF4QJsUup2cChwAXLOWi8Jh9/zdBLoA953gZMhX+39oBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BdyzFF+e; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BdyzFF+e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=sy8F
	L7aK3NrhtRssRkrMqVNuTzd1KZ/TvQxITYkNFWc=; b=BdyzFF+eTZRRl4RgF+9g
	VDAWGjAE4jcFSVjtgoavmCJL8j4jEtJ+UGUqvoiChluKLAYtwiihT8gxy9/dv3QZ
	I9222G9yvDrWidXImeSpijR/BtRo7yecqyLsWeT/hgbCV2Z6xYMUegvXf7Rg5NRc
	uQE3N9fD58KMleCdawPkPb4oGbKMcYAP5zOnijgovSBb7BtMdqsj+ZqmviaVMGcm
	mesD7WUxn09TZTBWTjVa9dOuZ6bK3BzizuDFTb6XRuqgzI7MQONfh3P8CHjfFj9S
	ZXJlSo3QcdPRURGbFq4y53Kw7GC//mPLq+r001cwCnrD8/LCoCtIodCjXtJlb+5V
	eQ==
Received: (qmail 2540152 invoked from network); 11 May 2026 12:33:15 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 May 2026 12:33:15 +0200
X-UD-Smtp-Session: l3s3148p1@SbkxRohRuqUujnue
Date: Mon, 11 May 2026 12:33:15 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	=?utf-8?B?5p2O5p2w?= <lj29312931@gmail.com>, wsa@kernel.org,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jie Li <jie.i.li@nokia.com>
Subject: Re: [PATCH v4 2/2] i2c: core: support recovery for single-ended GPIOs
Message-ID: <agGwa7ejgQJb_tyr@ninjato>
References: <afiNrr4Llm0LWw-5@ninjato>
 <20260509091208.18346-1-jie.i.li@nokia.com>
 <20260509091208.18346-3-jie.i.li@nokia.com>
 <af8IB46ST70lXVsk@shikoro>
 <CAO3NRJg3wPVLgnyd=eD=TkkS5J24ww9WP3nNuiCnCL8=aLEmwQ@mail.gmail.com>
 <CAD++jLmcFEcHoCWq_4=7so5gV5Usj45n6qOYj8xrfsgAYufkEw@mail.gmail.com>
 <CAMRc=MdGd-6vUabTd5aJpjMbxRT3Mo8YH_jVyZzGLPyFsvce5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FcRo2vuRf5gjEmOk"
Content-Disposition: inline
In-Reply-To: <CAMRc=MdGd-6vUabTd5aJpjMbxRT3Mo8YH_jVyZzGLPyFsvce5w@mail.gmail.com>


--FcRo2vuRf5gjEmOk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Am I missing something? Why does this need to go through the GPIO tree
> if it doesn't seem to touch any GPIO file?

The new function this patch uses is only introduced in patch 1/2 (at
least it is not in -next as of today).


--FcRo2vuRf5gjEmOk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoBsGcACgkQFA3kzBSg
KbZhGA//faP2CS6ozJEULYVfEeYHniCtT/F5Gbw+FbwphnqOoeJrQs7TAwMRFv49
+VpTsFKeSPOX14su+m7SR1bgHOFgeJlxvYEWeCRvVowavpLHypJofhCBZvOtUhFQ
mcOaGfbSuxjFAbKCu/J3aV9jB/HiTipc6yHXVSEOVN5sPLpKYFwvDlBehY7NVi7F
w5j0dD6VKG4lQZjfgZ0zNoZilMNZ+28kpzTeK/0rlpnSrK9oS0kRw41zL4C4mdZK
E+f5BQ+hFF6uEA7QbhxV23nJfjc8OLulfEgf0h7A0Sjtxft7MAIgPgPYKbEPIcBY
zWeTBz6YgLYGQK5lpXCxpEVIL9AJyxo/0ZBi3n+x6QCQxwoyoYCK4i9NWwMZXAef
oXzu/yj3F8iE8GdlaN9dqMQUsg0NBww7imIc1CMS5y8XHHUyyOucyN1jf84DbGbD
yKFj1/A9pyDqqQU0FjuzP+tqZLzcg3RTndpm26XS2xxoNt9ph73Huc33+Hq8+XOW
j2F4M2jMgfHeL+8FTP2VJkDeE/O/5DjoxNzYiwES+uTWhEq8V9Uc4buAA4CT1WJ9
MylOVfwJ0Az4WLqdG5x/+1ucOK0LtDfw7eJNuW3sCknNvjKrVk3rHl5T868m0dIw
OTY1W1v4HBb7VxH2o73pNyFfJSigcTJ9LGVQcmScp/yoNf8Z5zk=
=WA4D
-----END PGP SIGNATURE-----

--FcRo2vuRf5gjEmOk--
