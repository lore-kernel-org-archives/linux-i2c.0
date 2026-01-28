Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7813A1CD;
	Wed, 28 Jan 2026 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611218; cv=none; b=V+7OWjG12x73Lr7aBzpA/QcD/1LU20f1mEJyFOwYaTOKCW9lMBOTf/rcTr08CHGCWE+txEd8qJTAdaWE/pwObaC/MoxkYWQyy6bdrZf3fmqHNiAXOvWAzgBBmI3Q6FLYr6wTP83N8ED1MQ0C2icDo4cekWni8/fWqSWtEN8iZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611218; c=relaxed/simple;
	bh=+V397SMOrDC+3Vm5YyGZsLbYiiKsHSTZGmiMS9Hv5tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7kFPiww7xjrHc8qtYNECe2rMoqW44aDxbF9AIYX1iUk1V+cH4VpxlWgVVFjv8sp352OOchADD/VMUDJY64KDGHzZT1xYCVt7tVoGuDuWLvFEhw3YzNWmnpFGgYQB8kfv523lXlS83pASipvGbL/7mWv5y4boVtIrR/KnP8TPdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNz+YEYx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNz+YEYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38B3C4CEF1;
	Wed, 28 Jan 2026 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769611218;
	bh=+V397SMOrDC+3Vm5YyGZsLbYiiKsHSTZGmiMS9Hv5tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BNz+YEYxF1GK7BXs8jSLwQ6tQ1HibxFjFu/ueuSYEh0cgIPWocxBbZ0x4z0TQ5xte
	 JO52DEOQXcciYMuwwFFc5XG0YEhkL2a1Gf6tnfNmcCobrK56aUBPl713yuPlGzHPta
	 7BB4SbDoMZO6Kj40fS1ukucf5blFXggRNCkyOBNie/PyTqZ3cQ19pSE/DR8YoRVShf
	 CmlgqFIzj1+HWFWRfjFT6r9yRu4eLDzLqH5/HwtxBSdmkjn/g+dD9/zJ22qACfndqg
	 Wra50E8Hd0h+sEpJDBLDKpmKXbg+ZlA0cuXyCjErhhv3jk4q3AFx+j95GYRgUj0RqO
	 rU3XBBRi8hK2g==
Date: Wed, 28 Jan 2026 14:40:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michal Simek <michal.simek@amd.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: i2c: xiic: make clocks optional
Message-ID: <20260128-uncivil-precut-84f8e37b7f2c@spud>
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
 <20260127-i2c-xiic-v6-1-e82e2f6f657c@nexthop.ai>
 <20260128-remarkable-airborne-chihuahua-a1a16c@quoll>
 <66c7435c-a936-413e-a016-c860d448c971@amd.com>
 <fc00f8cf-b566-4694-82fe-76010d2f7c78@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aCmLzXhnGY6FeQEX"
Content-Disposition: inline
In-Reply-To: <fc00f8cf-b566-4694-82fe-76010d2f7c78@lunn.ch>


--aCmLzXhnGY6FeQEX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 03:34:02PM +0100, Andrew Lunn wrote:
> On Wed, Jan 28, 2026 at 12:21:41PM +0100, Michal Simek wrote:
> >=20
> >=20
> > On 1/28/26 11:37, Krzysztof Kozlowski wrote:
> > > On Tue, Jan 27, 2026 at 09:03:55PM +0000, Abdurrahman Hussain wrote:
> > > > The xiic driver is designed to operate without explicit clock confi=
guration
> > >=20
> > > And if you change this in the driver, then you change bindings?
> > >=20
> > > You miss here explanation based on hardware - how does the hardware w=
ork
> > > if nothing ticks it clocks?
> >=20
> > Hardware obviously have clock input which needs to be connected. Withou=
t it
> > it won't work.
>=20
> Should ACPI potential limitations be making the DT description less
> accurate?

We absolutely should not be cocking up bindings because ACPI requires
less complete descriptions.

> Would it not be better that the driver has an DT binding and an ACPI
> binding? Where there are common properties, common functions can be
> used to retrieve them. However, if ACPI lacks usable clocks, use the
> of_ method to get the clock from DT, and skip it for ACPI.
>=20
>     Andrew
>=20
>=20

--aCmLzXhnGY6FeQEX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXofygAKCRB4tDGHoIJi
0kiCAQDNKNbaUn79Xc6x4BQryiWSp2li7RJKHh5XJCPManEc3QD+JINgu6NOEuXs
KJEnNeT2aVLtmcNMS0KMi6CR6HkRUgg=
=YpjJ
-----END PGP SIGNATURE-----

--aCmLzXhnGY6FeQEX--
