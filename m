Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5146AED8;
	Mon, 11 May 2026 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521762; cv=none; b=lsU6KhrgzwWd0StoOBJfZNS6F3NRY80ze2LuV8yacFhghAdN6f5ymDjM5TJSb/XW5YeQLbc/hq08vRxD+X3ekT0CCrMUZvDORo7tSXdQ1sEqk3ycHT/iEdO5FEcwHDkSWz7c1SiaB0CVxgfpUT2kBH056zRH4Dp+DiAmkwWuhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521762; c=relaxed/simple;
	bh=/1oWzYg67N/ufz4D1PqHRWljC6l7edXuX/1L0zHiv00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c98JjJ+AvlvUm59fl2pfUx34Nh2mT4MqUCmk8aUP8yyf+GkdIofAuTOwxFp6X0trFfPp+5OfgzOUcdbBgyKZqPs4cHJNsJ8nsD9IGWH0KaJ8uQ+H0QtglbAQY5JWGz/Tx8orzmDcKQk/KWBdgLdh/FZaXI970yoVximCr7fKuvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqQ8mu8K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqQ8mu8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71148C2BCB0;
	Mon, 11 May 2026 17:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778521762;
	bh=/1oWzYg67N/ufz4D1PqHRWljC6l7edXuX/1L0zHiv00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LqQ8mu8KK9OYD2NQYma1LT38JZu03UnQNNdoyeBqK5EwBjCLqf06AqqIst9lEMioM
	 qjnpeR1XPYxSgoXDLwytt8XGH3qbl+JM77oyirXXiTOnWz7z1TgKkehffnuNsO5zkQ
	 /8VO0upsF8kaFJTV6XzZqjYGZQKbI4vJ9rcEyLRh/6KaWd/iFOQd2wqWW6EHSjdKSQ
	 BwsTE453pWWYVeIggn2PJcnugTVMHk1fk6Xj8D7vNL5Uxz0jkuzGx3x/SvodeOTY5w
	 FDj089XCJonj9J835HLIggJjKKUR6vY/SN2XQQMQ2Fd8h1dxihCzC63zqmEACUzUTz
	 8E9ltJ2pW8xzg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMUkq-00000003N7k-10RE;
	Mon, 11 May 2026 19:49:20 +0200
Date: Mon, 11 May 2026 19:49:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] i2c: core: adapter registration fixes
Message-ID: <agIWoD88sI9teD3B@hovoldconsulting.com>
References: <20260511143715.729714-1-johan@kernel.org>
 <agIFROehUpkosUkz@ninjato>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GuiUyweRpUbDAMiX"
Content-Disposition: inline
In-Reply-To: <agIFROehUpkosUkz@ninjato>


--GuiUyweRpUbDAMiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 06:35:16PM +0200, Wolfram Sang wrote:
> On Mon, May 11, 2026 at 04:37:05PM +0200, Johan Hovold wrote:
> > This series fixes a number of bugs related to adapter registration found
> > through inspection (when looking into addressing i2c lifetime issues).
>=20
> I intend to review the series. I wonder if it makes sense to wait until
> you don't see any valuable input from Sashiko anymore. Otherwise a
> reworked series X+1 will be sent while I am still looking at series X.

You can always wait a few hours until the Sashiko output is available if
you're worried about that, but I don't expect there to be any further
revisions of this series.

Johan

--GuiUyweRpUbDAMiX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCagIWnBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQC8XNwux9ZQjopgEA1cAkYcNmViCo7Nxu/LB/
T9FhxjMuZjqktlm3aKlZOUEBAIVaQRxFMA/hS5/6KQ2VBFVSkAyJLcGh3Lli+N6+
d6oN
=fi/w
-----END PGP SIGNATURE-----

--GuiUyweRpUbDAMiX--
