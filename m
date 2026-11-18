Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012825;
	b=X4UxG4EAMNIA86D4PgU0ls9pvYHUDsRgQuE9zgBYrlniZ+CoxYRi10yNofwcB2d9Q1dh
	 bMvEGaadwTboIwclNiQOLVATrSh46dG9OU2QISegQvz0QOcE/TG1C/O0oDEL2yIaklw07
	 Td0eqz5U2qEDo/FV8gXyFQMENdzuverlkZWrAZmZCJDLFiVXot0O6RDWaDMHLamaHLUCu
	 SmtEKh//4ZBo8ibVpCt/CXL8MMrslrUiixEnlAKWU/XO98I+p6nnAHgA6OE2RWo2P0IaB
	 gUOG83QYPus3gBv8xFp5vNkBf+XHatoXpclMnYdaBcyjfBQpKZmJNltsMFb9u6eWm0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012825;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=H8ZYFsx3cIv638S7nr6/ZHv18L4yXOfMeCoVrlHn+d4=;
	b=ZqpPvRrilpL5qX8cR1o/3CNrQNRs3E92QMl50Q85aoKdxyjWP0mzambzJYQ9+VxzGX/h
	 8XKFtgV0Ir9yLvc3B07llqeLWtnYRzu9sf4xgixMq+6oMMCbCBhfA9tzPg2Yv87HZR+Gq
	 POwFjWO+h0yG2A8mX79tZdXaLluZFGifb5NPuqViuRMtp24z62lsJ3w1tHhaVH43NnNTc
	 I8n9NyKw3DNAm/k5zcYO9k6w/NEH0Vt/i+yJPoZtkXu03xcCpW7LXHboWjWD1vVDZzd3C
	 Z+2MIxHO2DG4WO8rx4Tu0421LePhSP8KlU9YL9pjwxOMCzkvKtqcINz3Rw9U30CQ0vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=QzDYbG5M;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D5606A32F
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 14:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C8D5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=QzDYbG5M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=H8ZY
	Fsx3cIv638S7nr6/ZHv18L4yXOfMeCoVrlHn+d4=; b=QzDYbG5M6wIAwIVxj30x
	fZHXWmNXtd1nqlZJFXCNMOFA8ybNCpa5aKFSspOBjAWsvfafei72TFHDhX5006Pj
	p1pHbzLdx7gr3Uzu6uNPmVJgc1PXwdIBdles1IDygHuKzU/UkNmzPHL1KDI4I6uG
	SyUTVZ4buU8EYOnLOh4/Oztowt1FBuL6KxfDw4w3x7JQHk8vjZu+whMk8YnHuTRO
	RAtzuNiCW7V//LceDjwu8wLfb0+deMoOCTnX/Rjs94YKONgU/3jgmd+z81j3cDfl
	yQu+NwMha23Lme94wMtLA7dOOyw9obf0JnmVbmFv1Iarm7w8W8bFgzxKBYz9muz5
	lA==
Received: (qmail 695558 invoked from network); 18 Nov 2026 15:40:13 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2026 15:40:13 +0100
X-UD-Smtp-Session: l3s3148p1@ru8e/Y1g3t4ujnsi
Date: Wed, 18 Nov 2026 15:40:12 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: i2c: Document ASUS Transformer's Dock
Message-ID: <av24x_dcu2hggP5y@shikoro>
References: <20261118134555.195479-1-clamor95@gmail.com>
 <20261118134555.195479-2-clamor95@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DIlP1nKDevOE76tJ"
Content-Disposition: inline
In-Reply-To: <20261118134555.195479-2-clamor95@gmail.com>

--DIlP1nKDevOE76tJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


>  .../bindings/i2c/asus,transformer-dock.yaml   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/asus,transforme=
r-dock.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/asus,transformer-dock.=
yaml b/Documentation/devicetree/bindings/i2c/asus,transformer-dock.yaml
> new file mode 100644
> index 0000000000000..5f4a40539c2b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/asus,transformer-dock.yaml

This is not an I2C controller, so "i2c" is not the proper directory, I'd
say. "connector" maybe? DT maintainers may have another suggestion.

> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml

Hmm, this bindings only uses "i2c-parent" which is not even described in
the above file. Not your fault / problem, but we should describe it
somewhen somewhere central maybe? I guess the above $ref could be
dropped still.

No comments on the general approach, I'll leave this to DT and Asus
platform maintainers.


--DIlP1nKDevOE76tJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr9uMcACgkQFA3kzBSg
KbbjqA//WGstlBBoM6kifSDuMhhE5o4s9akn25YMVlabG0uopUorrCRS61OHeD9k
Fd6y/hKKgIHg4QR6d8EukwQCoj/x70e3fz4UezmK8zIB3ReunhegAHRmQdrB0iA0
mg5/wuYZJt0aYFHlyeCyzTCbQ2ZJRnvjY9SjIdG0pyZ8Rh7zP/lt41t9RackiQUn
Iv9uvVd0LOUpg33qk7g1dPOhz0Lfn5Uyr32xh2bZnm7932tDAB45Hgka85z7BS7X
i95Dj+M5VXH0cZfrr4Rt/2zIPG4n/y+3k6Em5mjrQ9syop++9zgDV0WhqDyGkdHb
QtQ7L/YfyBtJnitukLiiF9zQv2n3yCcmnX6oFe3LKcqSV1rSf+nW4yu5Qxu/Ctx5
QzOunuc1HP8GwFv1e2k1bOXJBDMjykH+/M8yDLi43YF/BjmwSLCkHHQRiPqKBhn0
TuEaF2ggGzKJGBuahT9wyhHSsbvmGoP0wrdCHC1DTPeqtat83w55mJo30BD1jgBg
MuypI9guTu+fPSKHWots83hKMxoUy67Yf8JnYCXN4nJaJaufZTi5spc8bcIrgF25
zLYBqyWyIrtXUI62Tf/NcLfV76RwN+Bw0bQkkttc4nTX4bfjO+4jTFPNVYIkB1LH
dpP+bybRKlRSPY38lpaHN6zFM5oSdqTbeLXX5qMYZIQ3J8ng/uA=
=qm1m
-----END PGP SIGNATURE-----

--DIlP1nKDevOE76tJ--
