Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80744D6B4;
	Wed,  7 Oct 2026 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381698; cv=none; b=UyUeYTxewwYi7MIpNtpBT4CFHvf8y6EhhTXClaok3QARUxwjzpx4oZbj9omikRF/TJl/FS0YlAI6GTEiKfXZ1LzVYTCT+aC66HyHYG/544WIk8ZwjAMm3Rdnst3VPkuYYTPy1c5IZwHCGKxzWLEQXazaPn32NIDeypsjSEJ4QVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381698; c=relaxed/simple;
	bh=PQAOQXQQabgrsu0QQpZx3L1ouvEyx2hXhU4Hhtht6Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xmgl28ss/0zCtCe86KCSpP6kga2ptJgdLS4fQ/byf7TzWTBYedcuEhaJNgLaWiXpjHFl9CETMhL4n5LwlySrEQN5Cl2zMop2Sc6qPv6rt4ftW7gO+M3K0ApmmJ2smdmOfH798DE0ce+z0FndmcmF/pvGQy51ZoZJH1Dg7CU5eco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRuC8sWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRuC8sWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBD11F0089B;
	Wed,  7 Oct 2026 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791381690;
	bh=PQAOQXQQabgrsu0QQpZx3L1ouvEyx2hXhU4Hhtht6Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gRuC8sWsQiYjijYIxNt2M1B9TwZci5Xie6QWpJmvHfn8z6IOxW5q2PNaGz8n5wGDh
	 ftEksoSVZwSKwU7lL1j79ykp1+LuGgqBLXBkIm28enx8954bgnnIn2dZNqssrArum1
	 /l5jRHTKWhn/RiB7vrE9/iqzhVilUodB/ne6cTRjkc3yj+3DxIdQRb2kqQAbjSYKCo
	 203znyKHfM+VM1oPw3VQBIU3LF69nKLnwJQ4oRRCFm4yBFor4f5GTafVBlnxFJeGVA
	 dTYODODyyBy/zFwb+M633cvD3DsVCH2EpNcLc0AtfhRo7YSMDDgDi6GZv2OxXiar7d
	 j0q8ysZ+tcYYA==
Date: Wed, 7 Oct 2026 15:01:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Michael Zavertkin <misha.zavertkin@mail.ru>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rustam Adilov <adilov@disroot.org>
Subject: Re: [PATCH 2/2] dt-bindings: i2c: rtl9300: add pinctrl
Message-ID: <20261007-7268f1c071653c5a89e28b61@squawk>
References: <cover.1791127538.git.misha.zavertkin@mail.ru>
 <0cd1f9b98511c55a375ab82b121fe256916b87e2.1791127538.git.misha.zavertkin@mail.ru>
 <asN-O5ntmiXvZBvs@squawk>
 <asOrwd7eAddenA-_@gamepc>
 <20261007-370cbe94c765a69550a85bbd@squawk>
 <asZKOn8HIuIaaqKA@gamepc>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jU4ff4PniF9MT41+"
Content-Disposition: inline
In-Reply-To: <asZKOn8HIuIaaqKA@gamepc>

--jU4ff4PniF9MT41+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2026 at 08:33:46PM +0700, Michael Zavertkin wrote:
> On Wed, Oct 07, 2026 at 11:12:36AM +0100, Conor Dooley wrote:
> > > If so, what would be better - print warning about realtek,scl (only f=
or
> > > RTL9607C) and work as earlier, potentially interfering with pinctrl
> > > driver - or abort probe with error if there is no pinctrl property?
> > > Explicit error or message is better then silent regression, if I
> > > understand you correctly.
> >=20
> > If there's genuinely only two users, then I suppose you can break it.
> > But two known users doesn't meant two users. Otherwise, use pintrl if
> > available and use the fallback to the existing property if not. Mark the
> > property deprecated and probably emit a warning.
>=20
> Okay, I'll prepare v2. Support for deprecated property should be removed
> somewhere in future, right?

Sure

--jU4ff4PniF9MT41+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasZQpgAKCRB4tDGHoIJi
0lGNAQDQMF37jZmNnj11RPDjOz5F0muHEphh5sN+oUhsxbvCWQEAzWG+99FIRHWU
plkDOPlxCPkKt3ASEOSfxRWgAqENeAo=
=5C/L
-----END PGP SIGNATURE-----

--jU4ff4PniF9MT41+--
