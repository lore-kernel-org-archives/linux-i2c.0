Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA444A3FC;
	Wed,  7 Oct 2026 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367970; cv=none; b=lXtKg50aqGNLoEZ6exNg1HRn7tV6usd6um0MOg1uLCczavTW47///i3Q4rgIRuJd9sD5kcOUXcmqVuWM+UdHYBx6HbpEfrNFKaU0BxFYUjceYZ2LkZH0uZP5WfabmYLrFkdEBGao5z12/9ltogRp44ySHVKoB0Za+3mnpW1YwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367970; c=relaxed/simple;
	bh=o8co13SCRkIcpdcj1EAIKSYtW8l4zhIowOXplmIYhyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofCTGZwb6+KMyOmHkxikMdzsDET7elBKjk/QmVsgLrQageL5APEFsmrJAFX8bZRv7PB6CzcTe3Xtq8hxSP6dBt7WKVgInCGzcvSb373nPbVQtFqbN/Zi6BQrRMsP9A1lXugjQCgujvV0Ztljys9PDhPoefokWLQfqWTx8nl/bys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtntE4Mq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtntE4Mq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A655D1F0089B;
	Wed,  7 Oct 2026 10:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791367961;
	bh=o8co13SCRkIcpdcj1EAIKSYtW8l4zhIowOXplmIYhyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VtntE4MqhTBg1ybMzGJLqMeIIl4rPsfRA6NAQS0VTSdRnOC0npN6spLEnBa/odWkQ
	 3nQiQ4kmpYojKZU4/ULTHqESEV/A7sH0j9Ufg8C35oPVjAuDHL7+Aomsrs22xF9xBr
	 HXcn/SzeI2OQWDBnq8feejWcGZiR6Veg6g8tQ9o/uT5zfE8+T9YoY3qOLjEJesPIU+
	 Ubnsk/PWn1fm3CT2FoXLp1dKzuJC7DKJptQrDoo/1VE0CpYulYMIZPWp9ocJzqkwWx
	 ubYGDEk03TbPoX4UW6D3BT/BX+p6xu2f6Si/orjEJYaYl1NUv9CFEu39YxG2ZqvMR8
	 uIV7cCPWYBfGw==
Date: Wed, 7 Oct 2026 11:12:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Michael Zavertkin <misha.zavertkin@mail.ru>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rustam Adilov <adilov@disroot.org>
Subject: Re: [PATCH 2/2] dt-bindings: i2c: rtl9300: add pinctrl
Message-ID: <20261007-370cbe94c765a69550a85bbd@squawk>
References: <cover.1791127538.git.misha.zavertkin@mail.ru>
 <0cd1f9b98511c55a375ab82b121fe256916b87e2.1791127538.git.misha.zavertkin@mail.ru>
 <asN-O5ntmiXvZBvs@squawk>
 <asOrwd7eAddenA-_@gamepc>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5psKnE78WY10JPue"
Content-Disposition: inline
In-Reply-To: <asOrwd7eAddenA-_@gamepc>

--5psKnE78WY10JPue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2026 at 08:53:05PM +0700, Michael Zavertkin wrote:
> On Mon, Oct 05, 2026 at 11:38:51AM +0100, Conor Dooley wrote:
> > On Sun, Oct 04, 2026 at 10:32:35PM +0700, Michael Zavertkin wrote:
> > > For RTL9607C driver used to configure IO_MODE register. This register=
 is
> > > global and is a scope of pinctrl driver (either pinctrl-single or WIP
> > > driver for SoC).
> > >=20
> > > Drop realtek,scl requirement for that SoC and require pinctrl instead.
> >=20
> > This patch itself is probably fine, but the driver changes will cause
> > regressions because all existing devicetrees are going to have
> > realtek,scl and not the pinctrl properties. You need to retain the
> > driver code and make the register setting optional depending on if the
> > scl is there (or similar).
> > pw-bot: changes-requested
> >=20
> > Thanks,
> > Conor.
>=20
> I understand backward compatibilyti requirement. However all known users
> of this driver are here (me and Rustam Adilov). Does compatibility
> strictly required for such case?

How do you know there's only the two of you?

> If so, what would be better - print warning about realtek,scl (only for
> RTL9607C) and work as earlier, potentially interfering with pinctrl
> driver - or abort probe with error if there is no pinctrl property?
> Explicit error or message is better then silent regression, if I
> understand you correctly.

If there's genuinely only two users, then I suppose you can break it.
But two known users doesn't meant two users. Otherwise, use pintrl if
available and use the fallback to the existing property if not. Mark the
property deprecated and probably emit a warning.

--5psKnE78WY10JPue
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasYbFAAKCRB4tDGHoIJi
0j1CAP4xZJyKVUwno+o4bFRWL/rtURuUijtVOA76wsB9SeEtDAEAkDZMxQTCipE7
QN3+rmepnw2onGKrPjfNx4Armb4vyAo=
=/weX
-----END PGP SIGNATURE-----

--5psKnE78WY10JPue--
