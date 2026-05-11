Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2944E021
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517320; cv=none; b=T4cdnlXaOavP3XEGygDH/maYSs//KhCf7kuueqXyjLDKF6zZGNt5KEPCF8BN+l3AsCxbNCccoCS2DerCheV+9F6elejF8C+ZCaR4JuQ/JD1vnKcN+MXApG0bdukiGL0gNUNxtn2e+w116kzH8/sQpTHm2YJvZT5fL778C2Yaxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517320; c=relaxed/simple;
	bh=0VCvQpXBZ/w33kzXR90PEwk/7TW1kucKdv7WUkpC2Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJZQ0iOE5kRwF9eaasw/azLDk3cyWw1/XxVxwq15/BwE8907QmENUbD2K3ZYrHXR8vp4MNXPrhn4pQpF9iSqugfZXO9ecM64yhuod1E2L3L16PhNku8UFQDtmmZ9qneNTC6lp7dT8bR9trexZRjsXIdweisODgC0vK0kGmkWlW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Y4lNbZRH; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Y4lNbZRH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=0VCv
	QpXBZ/w33kzXR90PEwk/7TW1kucKdv7WUkpC2Q4=; b=Y4lNbZRH3xyFLBLgNuHj
	o4TSE1ROgn4nkkP+amyNZCDbnEXSQAvk7FvfV4iDUGDeYSOpv3sxuF5YQYNfWwhw
	66kuDO6wfMjQvCLcYoDk+K7253alja1J0YE8ex1a9Ycw7qEJEPvoBK+vpJXTOgCq
	u5+6x20mPZ8AUWatFaySOeufUaGkg1M90Pooec9gs51jstRNeNc2gjDL//bb9Etr
	uJDjXYFCxjE64hd+sUtRRJn16Y7QGjtgWufgq2oORqjefBfQ0oQJK+1zGlvLPUC9
	W8iO0q4cHrIjdF3EgvhYOlraVHPo43EHCCDPnsjYJiUZ3ryvEH0wahHbqIZk3i8c
	SQ==
Received: (qmail 2660032 invoked from network); 11 May 2026 18:35:16 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 May 2026 18:35:16 +0200
X-UD-Smtp-Session: l3s3148p1@yY7bVI1RtqEujnue
Date: Mon, 11 May 2026 18:35:16 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] i2c: core: adapter registration fixes
Message-ID: <agIFROehUpkosUkz@ninjato>
References: <20260511143715.729714-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XBY7qgeNE0P8b7PF"
Content-Disposition: inline
In-Reply-To: <20260511143715.729714-1-johan@kernel.org>


--XBY7qgeNE0P8b7PF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2026 at 04:37:05PM +0200, Johan Hovold wrote:
> This series fixes a number of bugs related to adapter registration found
> through inspection (when looking into addressing i2c lifetime issues).

I intend to review the series. I wonder if it makes sense to wait until
you don't see any valuable input from Sashiko anymore. Otherwise a
reworked series X+1 will be sent while I am still looking at series X.


--XBY7qgeNE0P8b7PF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoCBUAACgkQFA3kzBSg
Kbb8WA/9FlMYop3JcxHtEu3hV5LjOw05ZU/0fhRPW0BRwLkFyAFdvP3BT2Zqa3XQ
gol1rr4mUVqXQmtx55pGerOpsWiZDPfQE1AYUy8mleQoS4rG9ava8AjVip1DFAPW
l1LHPYNLtSrpQjJOAtFZgu3pqzcK4c6axxOsamaCG+20YBjM3IotcmpmXxHafmjw
HrhzXKmmESILNDl7rcCCaltShzyw6U/bRSO03EZcojpHKcltcCzkWm9DGLHyEt0d
lZXT6fWUddDtvFxluYRK+93y6tz9vCHfPJIBwM4lrByWYXzMsVaL11GX41G9Opvp
KzHrglXxZggpYtSdZBj2pnPk1vUY2T/LU+Um0J1l1tuZMpzzGLnUcCQSNsuxTdB2
CMglLyaqNxhn0eJUeH+iFhaegeqlr7dUQDy1NVefVvZeeiUGW6UA2S4D4lX/QjNG
kqFZTdEFBJHASO+2tLltH+v8Du1ZAmdw5piFVZIuxE1RLDGeZ6UDzyuHfQlBO7xU
DuHSSUNWddeuTINd/uR2hyxnfXjEdWcnU+HvJDj32r1t3Xf7TVjar9ZKCvxtO+r6
1Ac8JrzyFymRqA3BuOoZmVJki5uQjYj4hHSAIAs2dHuI//gwCcOeZ3GrilFXjSrJ
X4ejGjHtNzCsyjF7+gsmVVXmuJ2Gao85oCkci/c40lR5uPoBRPw=
=AnsS
-----END PGP SIGNATURE-----

--XBY7qgeNE0P8b7PF--
