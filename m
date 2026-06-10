Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED483A7F5E
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781124942; cv=none; b=YRSSYhH0XNnQAjRsgUODx4eI8LD/ARRI9veAvQVT7CvWAVRNodEfOqenfFUEP1V1lkdnsPDsKXk/yPS9m3RYU7bN307dnf1lx/yfK2o9FnmC5unUO/pLKiEE3m7vIrjRO67/gJrBQ3j1U4/PclR36Dus5lgIcKootkPZnDxl0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781124942; c=relaxed/simple;
	bh=dYZneVDq69yyREuHFM7YMZq2gzB0czeJF5yyx5GVjS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoXwFJK3ioFqERNDZaf3jrKHeOJatO2vzb0o9cueB08NvQ2hzX73/MEL10d4pxEcwaRDQwHcYVBm1gAs9WFdlQGEdVUEH6ibLM33uCwCJRXW7XTiAJaJndogbMRkV+3WBBP+16JJ/Ir8aTNk5hr5mWMU6Q5+18qch2pRfN5ZkhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VRXvkycd; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VRXvkycd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=dYZn
	eVDq69yyREuHFM7YMZq2gzB0czeJF5yyx5GVjS4=; b=VRXvkycdV13+udC5MsgJ
	e9PDZxpPhx7OhvSIaCsDqm/9ZI488R1i3RIgoBUkgKhfzWrWLcGsu9TeN9IMTph4
	+po7n0J8XDIQ3WkwolWboY8qOtQQc3yRoqTSOmsVb87ynlB8dY1BSFgNaqwKmiBL
	Mh/H3eFrG2tVMywZ/8V7IAbgVB1yIvDOBOvkH3+ts/+q5jXHG2AQ9de4JLdY+PW1
	ZePkiWeJ5B9X5gO4xWZoVrP59C1SaBIs/GIjAIEyWjDv+m3BFgVlPx8JWqH+EHs0
	X8oQemkvIBNaIp3zQ5pAPM/figv0ZgWoI/pUYW7xceB1efECoATTNZJsUq4eKypc
	Wg==
Received: (qmail 1838798 invoked from network); 10 Jun 2026 22:55:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Jun 2026 22:55:33 +0200
X-UD-Smtp-Session: l3s3148p1@Alr3duxT0MAujntj
Date: Wed, 10 Jun 2026 22:55:33 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH i2c-tools 2/2] treewide: update outdated links
Message-ID: <ainPRckapuz2b-Cc@shikoro>
References: <20260529205147.145266-1-wsa+renesas@sang-engineering.com>
 <20260529205147.145266-3-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SpgurScpLZGjnBJH"
Content-Disposition: inline
In-Reply-To: <20260529205147.145266-3-wsa+renesas@sang-engineering.com>


--SpgurScpLZGjnBJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 10:51:47PM +0200, Wolfram Sang wrote:
> Jean's page has moved, point to the new one. The I2C wiki is stale,
> point to the download folder. Add a link to the git repo while here.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied!


--SpgurScpLZGjnBJH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmopz0UACgkQFA3kzBSg
KbZioQ//aBexyhW1Ipol6xk5cyZrQliACxHsG+LKH34ZT3jsCBMcTs97MRoupdNV
pjKhTdsIAJ9Om1QCRkJU50Es7lpDNIUC9lryUhz9pyFIYeyy7lWOfNIeaqlhWXwr
RIlR8lWc6gfwIGoZ2ys9nOuo0ZyqSigT9BM9GtjVp49YLgx+v1qCgOMzFTcTGqOT
Dl/NFpsI5V/PAkUiw+Uu85AIx4iD2l8NmtRGXrv4YDe88Gab5pu+jmTxtleSUQ4j
1kS5hUudGYsYm29eb2Y2VkcssdjAzL2R8awFLDhF8RSmA9DCbxhbGh29kyk2/+kh
msWxPSpOwMUk7OYRJdKfh53/+xxVWaksUVV1i/MWSV5ELaKFEYiXiCyIised1P0+
+Enq3k4r0mKk/gjudfELPhTB0TSGyx/AYOqy1itXMrYHUjuv2yqnBDzLZb3PC1LM
Idh5NEp/7gt2sN91KzVufp+fuK6g+5RO0zhQF4x/Wkw++I4EQNKmAFdz1MrNRb/Z
0hHVKGZ1Tv0ES0PXUeolcwD3nXp7UZwZFbHTwXzhpa5gu25FXgdb2RN9RKM805FG
QyvoTQe3CT96SbIJethZfZLGpJXMXGiG/sZZbOYhVrQuGFvPmeiEHtRE+UNw2qEW
wTTI+0NONWNkA4C2mOjtWT0NLEzlEIPi24WIR0fd6xRcZTEta68=
=Paoj
-----END PGP SIGNATURE-----

--SpgurScpLZGjnBJH--
