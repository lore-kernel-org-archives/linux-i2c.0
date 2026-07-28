Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F85476CFC
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276262; cv=none; b=Jv7p+cnVFnd+MqAc/FBymOipPHxv/wNsOZxSVnPvKofXBd4xHzAAmtIJy5nBmmbknZVwnBq/daFbAv1ZglglQFQvOmKWgwxft2qIqihuiwSTRRhg2usGXbKLm2g2CUk+FcyokA/4hylwnj9o6H3KdRFsKTD0B28uNrBYXrcDTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276262; c=relaxed/simple;
	bh=dY8MPUoogrKlg5U6lHOf/140PZiQt8XPJTKz1Kidrkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLNjyLsmoPtKi9jlG/BkvY2GNgnklTA8EwhEIB4wTLA+g5ysgfwopOBtjLhvo0BycOW3uCNkMrpg9xZtOq6nGDZ7si+oM+MPQwuT8CMZP4VY9rHgP7KxI2VoPjxxRFxjE/wCahvz8iYXQO5RYbaB1hyPYsQzYuDkrjT3OKb+Be4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=L0TbBTNT; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="L0TbBTNT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=dY8M
	PUoogrKlg5U6lHOf/140PZiQt8XPJTKz1Kidrkk=; b=L0TbBTNTkcCXzVCzcQqa
	PAr3AEuPe/asXhGf/1PrNQc8pTDOgybMjYz3kt1dRwgZj0TSey1h5xDZUnHhx75+
	fGym6uB8q1rBamog/7Dc9+YnczQcclUFVJrhKLC+77mYHr+0FxOnyuMXC4I+JETo
	0dWKf7NyKwu8LgkFYc2wzuguKo8CWMLXZ5aiNkrYSmZEVQ1x6SaEtNqxr5yqN5g2
	y6qsrk6KYwFLCzU33p6BHNDK4SIq1EyhZGxogcS4ggTzZnStQ5HNfXKxw7BlPKSh
	1aO3qDPtG+RS7E/61P2U0LJbfM1bMke92BXOMKSAek8IZpVpBzrz1NoqEkSG302e
	YQ==
Received: (qmail 1104465 invoked from network); 29 Jul 2026 00:04:10 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jul 2026 00:04:10 +0200
X-UD-Smtp-Session: l3s3148p1@kU+zBLNX+pEujnsk
Date: Wed, 29 Jul 2026 00:04:09 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>, linusw@kernel.org,
	brgl@kernel.org, linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/2] i2c: i2c-gpio: Enhance driver for buses with
 shared SCL
Message-ID: <amknWXx31wBY8j17@ninjato>
References: <20260714162915.3018703-1-markus.stockhausen@gmx.de>
 <20260714162915.3018703-3-markus.stockhausen@gmx.de>
 <alfvXUq_lNXhKQZk@ninjato>
 <amkB2rm2Ochu1bxJ@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WAjOE9nbACDaiY9A"
Content-Disposition: inline
In-Reply-To: <amkB2rm2Ochu1bxJ@zenone.zhora.eu>


--WAjOE9nbACDaiY9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> are you going to send a pull request at the merge window or can I
> pull it? Either way works.

I'd prefer if you apply the patches to your branch directly. So, that
'for-andi' is only a branch where you can look up what I reviewed.

But if it is easier for you that I send a PR and you pull, I can do
this, too.


--WAjOE9nbACDaiY9A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmppJ1YACgkQFA3kzBSg
KbaaXRAAl5tI6NLP8Gs4qrzpqSwJxVvwbaG0u7fi81gbCEBdnkKkbK3tUcj73qJo
FxPW9p2LO9vaMOFh397D9/CFjnZAwClOKM1FEWJvFhTaHoIk/IghA5zyBhWTbqlu
k0ffrt8CsrekZuMvhq7pcgaW21qkzoPVOE3dN9Jx7sQIho8DWTpFIlM54cveUlrb
xyjdiPchJTqaxr/1RaLycRDEp3N1FE9ejg5WwFlGir2RPK1QYP5tC+lk2otWqlGs
TG93fn3wbDKEeoPQYVvkTIt9Hl6R7he1CsBLex6EpTjN3hy075TAk4ey1e50fceH
pR8R7R6ZktsqjfcR8KVsGjLiUDNP84XlP4rAcIOyNhXtFwi7kgFix0Z3b6Hg0Oin
jtH/O3BAsbr5H6ntkfVbYvyibC9kebk2lbnbWzK/PRCH6YiCiu0Dzr7XhL0tSw2u
ArwDduTlwYRcN1sCPZ7UMI6qht2xMxbLYH84Jj4pAQmiYgerOCiNNiI/JRLy6GM4
7o81+d1jE3Q7GFNz90i7Xx6nx9ATO36RL/F+MubXl8VD30G9eyybKRA5GnMeiNgM
yXY/mIzzHu/e3WlObtbWUMmoACR+0k2V6OwWNDa7NmBcAI+143Bq7bsrJcrzKdWX
4CB/bTwpQkOLrXITIA7nXGjw4Pj7LKA/wwTyKF4Lj4TOXK+gavc=
=mNJo
-----END PGP SIGNATURE-----

--WAjOE9nbACDaiY9A--
