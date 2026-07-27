Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C932136F8F1
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785152938; cv=none; b=regNH+OnU/FFdaUm3CRqb5t0HhltquFjGwCQtSbJhoJj4qHv8+ntS6lAFfTzEWySstyOD4tTXTOH4oNpL+xMR/8EEx/vn+nEUppV4b6pT35kPDg/dMLb5GgQy/doafoemSNnN8Co9nYZhdMyZat5yMZ7e/bNM/71KYXbYGZgLII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785152938; c=relaxed/simple;
	bh=H80Hpm/pWkGc/27kmBxealO5KYUVsLA7kjm8dQLn28g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNeD2lsUujWut4i53opXuv8UuJSuRy6ILVisjuLIslKUZVU9xVKZnHY4y3OEWATLxS2eQSmuVUlDRpt3yZWoEoxfIEDWk4th7xz2FJfpz1IVwyQpj+fkL1wNvqLOE+ld1ZGtBnjhj6UqlwjNfOkuj8hmDxIRTEFXsFPOjCLgwOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=eYKX+l8F; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="eYKX+l8F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=H80H
	pm/pWkGc/27kmBxealO5KYUVsLA7kjm8dQLn28g=; b=eYKX+l8FqxdTV4eSRYx8
	0HpV1zZboHeZ4OgspCSmu9o4OXr9U2JmoHuiLtYppWbCje+/3SasPBkNjILjj3Bd
	8edS+w4/e8QTCtNg9Fc2S9YpD2gbgg0cOIrwXNYxvmOqtucOTQRYrcGSEzxap9EZ
	1yJ/cpxyCPKZqIpuuyc00pz/jjXqkMbmHXb9hnPOZdUb90EBNeBu/fOVQ+v8xUNU
	ZY4CTOKhjaVNhe3AJdR16ay57bpWKX6qGq5g/rufzETxLbpMNZvFzvgF1ki76lVR
	Nh9XbfwDf1PTSQn/6YLIdo66Poz2BPYlV0G5UhSw+XRvKZufwsLdhGSBQW5EOjoL
	iQ==
Received: (qmail 592533 invoked from network); 27 Jul 2026 13:48:54 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Jul 2026 13:48:54 +0200
X-UD-Smtp-Session: l3s3148p1@QMmDTpZXUo8ujnuy
Date: Mon, 27 Jul 2026 13:48:53 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Minh Le <minh.le.aj@renesas.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: i2c: rcar-i2c: Document R-Car X5H
 support
Message-ID: <amdFpUfVfarpQ8Jv@shikoro>
References: <20260727113441.11193-4-wsa+renesas@sang-engineering.com>
 <20260727113441.11193-5-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/tmssG9MVCrb1WwB"
Content-Disposition: inline
In-Reply-To: <20260727113441.11193-5-wsa+renesas@sang-engineering.com>


--/tmssG9MVCrb1WwB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The new renesas,rcar-gen5-i2c string is defined here, but the allOf
> conditional block for the resets property lower in the file only matches
> Gen2, Gen3, and Gen4:

Sigh, yes.


--/tmssG9MVCrb1WwB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpnRaEACgkQFA3kzBSg
KbZitRAAgPseLenZ8Pz6RnsZtdDvuu+x97zKrtNR9rQCQPi/I1ypP5YFA3tlKBb9
XV5N9juOrbghI63qIfIg9efzq/IWumoMdt3DX90gM/9tnYQJvaSLsaXCap0Dh63q
js1+8uJ6PGLC3150D0wZdtwJEl2swvzxlb+Skr/4NT4etDWDINM5S/3UbnwQA2bG
hvRFY8zIO/7BupiQaPyEWwSf5jCQk4cp0r+TPk33Yi+honR0ygmf5fGoaMWC3M8u
qjtUqMENrzWew+D6qzCLTjk3/2xwGhaO26HCZUlaovc1d7lMVvPhtuwJuxWWxwSN
bXzopVsfpK+Zj5RyoVeEBlEUQMNRskfZSoYSlusUWFWw4lh+8/DmdsLRHzy34vif
gzjYtonwdmCUfHaOSnOXuEuFzwSlJuhvh+OGn4Y9e9IUC8/vhtF3zpakT9fMGhx/
/0/UEogXrPjF7DQcCa+2tMlrPOWlRlmLJm3OiTrRAtYM6/sZoVcqZMDAS0AVoyf7
aECCJKO8Rl0xhTuzU2Z97mmf1hgcC0ZCa9e5OMNUIizacUJMLf/u9WOnNbn6KhuA
8EPZwIklbkJhWwIgaczRxspkJFPoLx1yMAsetm7yKro7wmiAvnX6NMAQc3xkzNjX
NsbUKtWJc3aIbP0iM8VmPplVw2aOGa+ARIU6ICRJUyqLaaS4njg=
=dtYt
-----END PGP SIGNATURE-----

--/tmssG9MVCrb1WwB--
