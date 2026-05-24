Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6E265623;
	Sun, 24 May 2026 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779660447; cv=none; b=DsbUwpVxqhycGu1iZIXBJwEKkuzHiCun9BedwXx0Xf8JTTfWhrc/eVb7WM68r6D8bxTzHp39I0mcwog3Y1o1DwldVp+wcG1nTIVp7FUoJ3Xf/p9/PXDLonyo5qHv/zGHYvHRR6FEZ3sYT4jYeu4z6JXRFoDiWKWbtO8CTjB+uH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779660447; c=relaxed/simple;
	bh=rKvMurOqzcM6jN1JCFrw63qcuZKBoJLc4a5ZyGbaPZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lps1+fubf7Q8ewyLyKGf7/gys7uMIYAEa4DL4t0cB83/0juBTduhuhk7ppfDioahc4iAGbZBDv4RONX/8YtMpqoxL2mIq6bVOrwKZ8Cj1WRXl4D0exDu1veLVrh9K54OZfhUoLDu+mtcvWYcCj4xpuSADsUT7O1GgsltR5YVzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtnZfh8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtnZfh8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A4A1F000E9;
	Sun, 24 May 2026 22:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779660446;
	bh=rKvMurOqzcM6jN1JCFrw63qcuZKBoJLc4a5ZyGbaPZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WtnZfh8/+B63C4ETRE4EtdchHICjLmLltzrI8n19dKyemPW0MZ+N4dIMhKamvx2Z0
	 4Jn3fngpCM91ORwYdNPeo1C1cHBvIrnWqXM+yle4keCED0K0yhxxVCBjlp6L5QxHZY
	 3621YXuDTg0nHRt6KWmhHUs2/cJ4uwa29aurYOyrblGnW1WPzqEFptUn9BBLq0pDlE
	 SnEIN+3IOwY/wZeMOA/27YtKrH9NTd7+7jY4PWGF7gO2I9geUP6/sPdqeqU+nuSbwL
	 4q86Wnp0kEJ4vB4lpP7rVYJQhtTNuZaybnJIyFolIv/Ncz5HuxD1w2rqKtslbi0GTJ
	 3x3YnvSiFFXvg==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 54AA8B5B196; Sun, 24 May 2026 23:07:23 +0100 (BST)
Date: Sun, 24 May 2026 23:07:23 +0100
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
Message-ID: <ahN2m3kCbyTUNXzZ@sirena.org.uk>
References: <20260524080533.8749-2-pmenzel@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KeG/eBaaLLasNpSH"
Content-Disposition: inline
In-Reply-To: <20260524080533.8749-2-pmenzel@molgen.mpg.de>
X-Cookie: If it heals good, say it.


--KeG/eBaaLLasNpSH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 10:05:33AM +0200, Paul Menzel wrote:

> Some platforms (e.g. IBM Power System S822LC (8335-GCA POWER8)) do not
> describe the EEPROM=E2=80=99s VCC supply in firmware-provided device tree=
s.
> Using `devm_regulator_get()` on such systems falls back to a dummy
> regulator with a kernel warning:

> Switch to `devm_regulator_get_optional()` and treat -ENODEV as =E2=80=9Cno
> supply described=E2=80=9D. When `vcc_reg` is NULL, skip all
> regulator_enable/disable calls; the hardware is assumed to be always
> powered. Linux now logs:

This is not appropriate unless the device can actually operate without
power, any driver could be used in a system where the firmware does not
describe the regultors and it'd obviously be pointless and error prone
to scatter bodges like this on every single call to a regulator API
function.

--KeG/eBaaLLasNpSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoTdpoACgkQJNaLcl1U
h9AQ+gf/U5E4/c2Zku9iNJSh3o/PFohljPgzjkghjbNZ5QVK1QDF28o8gMTU4LLv
mSj6i2bYMA/wiFrCdy8sO5iLMgnzgD8KGe9evXbxxbI2vrnsr4Hn8F2/EvKtW1wA
rF0h/DBVoBdOYAuwSYInDgS+Nih6sOeCr5yvBQT0sGAHiwz52wRkTCSCKVVuA3Cj
h+99OB69R67wvTETIZyQ7hgCSPEX+wu/4KeHv2S8aa3krQt9fNedXH5YsXe7/zIF
wZCONiRFuQ4i7UEAwpWz/iOK5PGO9Wu3daY7JxGrJNI5q/61gdrkK3aGqqrrcA/x
VZ4nFfSHEzS1tejk5ehf0A8ofSOKFg==
=yWr/
-----END PGP SIGNATURE-----

--KeG/eBaaLLasNpSH--
