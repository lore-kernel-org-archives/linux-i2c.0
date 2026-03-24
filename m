Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1D740B6CE;
	Tue, 24 Mar 2026 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374532; cv=none; b=NbJQGBwLkZDZmGQEXXlQzKVz0IQNEWdQ/eC+7c2eafmzbAHsXM/CR/9F9+h5Epziediex91oE6suHTHEy2/NFUbYi/f+vWQTdlTZrGsOXKr3plOIYEp+G16f+G99gTnXvTtxCZ/2q4YdktiGSDAOmQ1wDe99ucS/8Yj/elYj9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374532; c=relaxed/simple;
	bh=uebf1ABkwaeVnFp8nHzIpAEyO58SycgnWPAt7+UyLFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6uEO7504oqXpggXKxuzGREOCivHxb0fuZjvOdj/MELwUCQJ5QJiZMXyDt4JPZ47CO0gRQOAM8ifT2ycy+Ma+5mbwIQGAMSS5qH8KC8kC7wTQUyKQ5nJEfqRYteyaVMK97yoeQuMNT+KggZbNvv4x82ZROWNzkneLGkvTPRqiW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rh+toUdw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rh+toUdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4B2C19424;
	Tue, 24 Mar 2026 17:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774374531;
	bh=uebf1ABkwaeVnFp8nHzIpAEyO58SycgnWPAt7+UyLFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rh+toUdwVcc8P2/8tOuOuFjT5+URXH+P3+vAkUSIr+P1K9q2ivawt7OVQJHiqr7L5
	 V0rEPaLI0xKfEYSjHRabNBPFSdJQuJsWQECeMSIRAmXF5A8+wM8PKVw2ueSWx1+iPA
	 pD1izOvDF0w7cqRUHeRuuctw6RhlXv1t04ffMc4SpLJ0bHMAkueRGJMX9JZz2FfK3g
	 E/t2EPlcyBa8EtZyPk+Wst90mtrf16vthkvdjgfTJCfEwpLK5/WUtWRDyzAlXK7HiA
	 +qRwsZ4kpxpOH51RwAxyUsh1JhHDNv9p/NnsiZv4XyeSYdLf6fPcE5M07tJQSoczn/
	 2Mgmexm7xtnrQ==
Date: Tue, 24 Mar 2026 17:48:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Rustam Adilov <adilov@disroot.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] dt-bindings: i2c: realtek,rtl9301-i2c: extend for
 clocks and RTL9607C support
Message-ID: <20260324-musty-tapering-f7700d6ed947@spud>
References: <20260323071337.15410-1-adilov@disroot.org>
 <20260323071337.15410-6-adilov@disroot.org>
 <20260323-stash-contend-ea5974195eac@spud>
 <be24b1e5651ba3a059cefdbbee361ed7@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RQxAsDOKHrbFGI/O"
Content-Disposition: inline
In-Reply-To: <be24b1e5651ba3a059cefdbbee361ed7@disroot.org>


--RQxAsDOKHrbFGI/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 03:30:34PM +0000, Rustam Adilov wrote:
> Hello,
> On 2026-03-23 19:41, Conor Dooley wrote:
> > On Mon, Mar 23, 2026 at 12:13:34PM +0500, Rustam Adilov wrote:
> >> Add the "realtek,rtl9607-i2c" compatible for i2c controller on the
> >> RTL9607C SoC series.
> >>=20
> >> Add a clocks property to the properties to describe the i2c reference
> >> clock and make it available for all the compatibles. This i2c reference
> >=20
> > Why? I can see that you're doing that, and it's good to know that that
> > is intentional, but why is it being done? Need to explain that all of
> > these devices actually do have this clock etc.
>=20
> As far as available information goes, there are some datasheets that note
> the existence of these clocks. For example, RTL9310 Developer Guide 1.0 i=
n [1]
> mentions "I2C master support 12 peripherals with 2 clocks" at page 19.

> I hope this explains the whole intention behind it. And if there is bette=
r way to explain
> this in the commit message, let me know.

What you need to say in the commit message effectively boils down to
"the existing devices have these clocks too".

--RQxAsDOKHrbFGI/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacLOfwAKCRB4tDGHoIJi
0uMUAP9bey8dJ4tEjQtPpBSFxDD/K4F6nSdS+qIxSip/YZYcJgEAvjMM+AOjQhrw
yB+95Orr5iHnvjb2AUxLQkIeHYdpoQg=
=KwEH
-----END PGP SIGNATURE-----

--RQxAsDOKHrbFGI/O--
