Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A24D2EF6;
	Thu, 11 Jun 2026 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198385; cv=none; b=XBoRtGNd9auAPGhhNk2Tx9CEWCuE1uTyeVZ3daluAnuOgDuvNMf596DeCXy4WrR2IkqJ5p9IAyZpeEzBHm+Cbv/1C3kbHa3RuXcAHzR0fT+Z/nrGNBAhR/d1PAW2HjVj7b3k+Z1mwEw6wFdclsPjG0yajBFla37OJ+5zhn1KQ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198385; c=relaxed/simple;
	bh=lhSyghFSmJujEuL0UMKljJsWxAOWS084E/Fj5cduUJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbFOFZy00k4LsQYDDp6/JjI9mk6HNfjc6zkaJUgcYAGmDW0DomyFaxzpSfg6PXP+m5yoX+9DlFDYH+Q7JZ+LHREcQhi13WOyiKK99OkdQWYEvDIIQNK1Bq5t3nP9jcbalgANKUt0eUjJlI90k94nC66HybCNEH6OKpojkoJBxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyBGCoD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyBGCoD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC891F00893;
	Thu, 11 Jun 2026 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781198380;
	bh=lhSyghFSmJujEuL0UMKljJsWxAOWS084E/Fj5cduUJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OyBGCoD/ZDttDv0mmoipulpIpvwr4qeKeXy9PtxzuZ8rFBJN98FoAfEsV0J4LrYui
	 4O32BhqGTRAE5hfnTxkzT6bz6kZIF1GrTSCL0Rz/GdE/PgMWS3l/mOsBdb1V77FMXs
	 uRJEQctLkMtvqkWKo+VRfq5RVcbT/xdvVVBbS1IPGtGwlUPz7PGV5V2cYe6NPCT/VB
	 Uvc2ttDE6/HROXTHxKMqkAGHgWO1kWHYND1JkbvAHZLBvRWYhhgHgHAMwHTRmhWz2F
	 j2JXcvZZivIeMlRurXTbtdqFZevE0s7h7v6ooRxY+UTTa//8PkPdvuAk2aMkBPwYeg
	 alx2jqtaSYovA==
Date: Thu, 11 Jun 2026 18:19:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Peter Korsgaard <peter.korsgaard@barco.com>,
	Peter Rosin <peda@lysator.liu.se>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: mux-gpio: name correct maintainer
Message-ID: <20260611-impaired-spud-390f28be0c1d@spud>
References: <20260611122053.7306-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3Mn1ra3VBS0rhIb/"
Content-Disposition: inline
In-Reply-To: <20260611122053.7306-2-wsa+renesas@sang-engineering.com>


--3Mn1ra3VBS0rhIb/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--3Mn1ra3VBS0rhIb/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCairuKAAKCRB4tDGHoIJi
0pGDAQCPvLDImgP1BLafDgJtfW31t5h8UoAt9RKUI2BNQXs6/QD+Lqa/7cknjN7x
z9763xt3TJLykZTIB37Erfls5fIWugY=
=XmCF
-----END PGP SIGNATURE-----

--3Mn1ra3VBS0rhIb/--
