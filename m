Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C03F2FD1B5
	for <linux-i2c@vger.kernel.org>; Sat, 30 May 2026 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780149154; cv=none; b=XnBzKC4e92HCI1qsfLBRxC0UYu+FBSwHpA7jgrCwTlk7kTOfiCCYKgJPR1MFDRPJYqtGZUKv/uJPodLjqpKtudgUH5n6udrzIl1OUPG8IeiEkqO3XYcOAcS/XuB2CL8o8A5KTAOzdbrlafY793h9f9KUTdSI401teU+sRiuGI1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780149154; c=relaxed/simple;
	bh=ZRodLq7Zlj77ukTwxdnA0K5wC/oWMV9FnJjR/yRLk9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Og7M1EUZABngrl/+uqTm/2onHAAhupk8j901jbfnM9Tt3Sr3ailgKg9quCIYYmrD1PrlyTAYU9FUL7vh3oWOEjtePJA05zPFzqjOZVL6e7RbLBuzptzJ4QcMAdE1MVPyn8vL1q0PmBQ10ovUvsV+sVulQ0imLrTXO4Mi6e3wNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=F+pbUNc7; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="F+pbUNc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ZRod
	Lq7Zlj77ukTwxdnA0K5wC/oWMV9FnJjR/yRLk9w=; b=F+pbUNc7JWGJsAIn4M9E
	LRJbVOQ8M8euXaaOB+YiKO+xa12GZXmaDHlF8Nt1HzN+2zJrvGeeQKHDwXD/Br0+
	lBwMh5sYkAgBYItP/a1jxftqZACwPbD7psQ+NG0oE6UCAqGeuKgKQOdIZP3YalIF
	0hucntptP4zgDR7Kt0+Qo19vq7b42ISWwnfhLRG4jJkNgHb/fgRr26VUC25uGxKu
	IXc1BU1rJn2M3gxRycrtKXSg8JM6olnEBErZsyugkwEBG2XOkRvXYiGuYp02Mb75
	9LWrY8ZKgBUYR2oF5Yf2JQ91Qj7fWFXP1wEeaGaLSUmbQRGqiu2dE1iPbyMpyDIc
	fA==
Received: (qmail 1760560 invoked from network); 30 May 2026 15:52:31 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 May 2026 15:52:31 +0200
X-UD-Smtp-Session: l3s3148p1@XeLGRQlTvMQqAQ4KEBW5QLbOwWyJKVt/
Date: Sat, 30 May 2026 15:52:30 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c-host-fixes for v7.1-rc6
Message-ID: <ahrrngQ-Iw4v5R-n@shikoro>
References: <ahpi6WYWZumbtfa5@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cGG/XCj29jLhXw9l"
Content-Disposition: inline
In-Reply-To: <ahpi6WYWZumbtfa5@zenone.zhora.eu>


--cGG/XCj29jLhXw9l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 06:11:19AM +0200, Andi Shyti wrote:
> Hi Wolfram,
>=20
> here's the fixes pull request for v7.1-rc6.

Technically, it isn't there, but I know what should be there ;)

So, thank you, pulled!

>=20
> Thanks and I wish you a great weekend,
> Andi

--cGG/XCj29jLhXw9l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoa65oACgkQFA3kzBSg
KbaraQ//agidFNrDsVMzfjkmH94E0caq2ERvDDrKheEgqJ7Z5Ol+on7izpTsnk6a
9EJSGfSxfIlfNxiC6SfB8p3iVn6qq9dIQnm4EGKtgCugkxpvjd5pGMogt/KYFMAJ
0aGgKnOuKb2XQwFizkDzkSfDOR4zZqr1zwpMpAo3I+rIyBBPsK75WSw6h2dl/CJ4
wXHn5STQdqHpYJJ0FSC9etv13Zq1ZyOQGuS8tA4HJO1XK3Lnf1hg7wp8ZCbzqPjZ
hZyTNeHt+TiNR2/VCfA1qb4UmWAWX68oLqiLTEwki3F0IEC9wevquGuG9NqlQaP4
xsVtzMbJPa6faSCV86jwb0r+WJDa9/BRo8kXFZyW4MQ++HmXF73U56VGp2aknsMv
KEWwY4c6V0P1dynyVv7o3iLKEw45X63phbqWxQ1JxczRk4VGcbp1uICFy7DZfe6q
iOyShitfuDg/O77ZO17kXMAbk9rVYBUBv56Zg6jijrIimSDS+moXiKiByFmLORUt
Z2iia6o4OWCUQxNu7VKMxCHc186Hj3uk3be2o2xj7W+PsDNU7+VNO63VPcnJIP7D
A4k0/mYDQbYZ6vnp4NNqRuEkzYwqREOuaYoNuOhv2LGcdUShjUjq5KEOlecZcTzO
2o0Zvi6gBVxv//jP+GP0ttAQFQ7fuorYd+5ipRGQePng9hHwVQI=
=sjVB
-----END PGP SIGNATURE-----

--cGG/XCj29jLhXw9l--
