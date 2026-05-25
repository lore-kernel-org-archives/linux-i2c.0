Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4B34F24A;
	Mon, 25 May 2026 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779705185; cv=none; b=cmg0MVfmy0yVQWSporlKTS0RpqLs+jWwVk1GQ81m7djGA66L6glY6X5qr/S3AbqdzgNp0wfWjbPwsCyrCcl8ipgQ0wxxzJc7MvLIJnnBB+acAltGOg4b7alA3RFbJCoIjj1b4glNw64qDRQ37wBmRZiwrV8cOX6jMucNglgm2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779705185; c=relaxed/simple;
	bh=KAZDuzP9gijbdivs8EV0WW9vXZa0QHchZnHc3UcVfKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmQ3WtjnS5OwKA//uvmbYHs9IhAboHQ/qGfLn/CvJHFjdgmSlfU4lt5/NRSBxapTFVX0Ub861f1IgDd+DtrRnfdbNqFiIV1z/voezqs1d870j6p1a14C1QLlZkOyWgnRCO3oOMXHultePFrHHiTsZ0TZ3AYL0XquWSX3U769BVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVkX4JLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVkX4JLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EB81F000E9;
	Mon, 25 May 2026 10:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779705183;
	bh=KAZDuzP9gijbdivs8EV0WW9vXZa0QHchZnHc3UcVfKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CVkX4JLxb7HaWjUtQlrnAVuwlF8utsaH7hoDGGQVTbahetlxUakzK3OdbPCKp6I6E
	 py6FY8lHYeOhdUW5HEweEaWdfm/LK8Wyt9VOBs/2/njR0FjFhHScrv9c/C4ZiboKmN
	 bWG+SBKd8WA3bLDdt+QnxA28klqmRLuT3/9AbsnAEXjED+RKQ/RORg1PyJCb3B1d7O
	 khEnTRvtMCT3H/V++iHj4BUizlljIGFY9t+j6csDKKfATUvi5ar4LuhgHRj6fsl9u8
	 t1t33znDbhcYeOAtWK/npIDpyHwXh59zgfq/wkwsneDtDL+CdpqqzERmR7kivDAgKF
	 s8QBMbsK1vY9w==
Date: Mon, 25 May 2026 11:32:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: eeprom: at24: Make VCC supply description
 requirement optional
Message-ID: <e71a9a6e-b6b5-42b6-b7a3-a689aed77faf@sirena.org.uk>
References: <20260524080533.8749-2-pmenzel@molgen.mpg.de>
 <ahN2m3kCbyTUNXzZ@sirena.org.uk>
 <84448a84-1c96-45a9-9ba8-1e058d0bf8a5@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jB4dCdALwZLV8nsW"
Content-Disposition: inline
In-Reply-To: <84448a84-1c96-45a9-9ba8-1e058d0bf8a5@molgen.mpg.de>
X-Cookie: Prevent forest fires.


--jB4dCdALwZLV8nsW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 25, 2026 at 09:07:42AM +0200, Paul Menzel wrote:
> Am 25.05.26 um 00:07 schrieb Mark Brown:

> > This is not appropriate unless the device can actually operate without
> > power, any driver could be used in a system where the firmware does not
> > describe the regultors and it'd obviously be pointless and error prone
> > to scatter bodges like this on every single call to a regulator API
> > function.

> How should the warning on the POWER server be addressed then?

They should fix their DT, or you should arrange some way of identifying
that for some reason their DT is like this and dummy regulators are the
expected case.

--jB4dCdALwZLV8nsW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoUJVYACgkQJNaLcl1U
h9AREAf/f/v7mAzKhtOmRxOlT4TGjQJtePIPPOm6XiISP/8a1lNhvpCtL2KgDxcr
Iv7aZOZF8Ob9aM+VcpXShG33QQR8UENGmNQzQTZQGUj+pmaL3J5sgXCTQ4dLAajp
8v6MqtFBpLqTRXsDM7OWtACOPcfeAxzryWOvmus7dnEIMkzhEyHQ6aTai2hw7PyY
UjPm1ynrtZW/YuShzDmoFdfsiY3uzI2NBrTv3GoHe5LIOxHxQtTOitwy62xSkFUn
lh0zFO3elO0qbj3h9yMznmrlp7NLybaH37p1hrJEXZTyUqv2DFyq41WmHuJFK+5y
r0lUT3Oeeqzp5CYrkcIoShE7zdUx2g==
=sanc
-----END PGP SIGNATURE-----

--jB4dCdALwZLV8nsW--
