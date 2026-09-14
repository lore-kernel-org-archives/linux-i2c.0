Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61548415F23;
	Mon, 14 Sep 2026 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381056; cv=none; b=eBmi1fTTDfFnC2IM62mUhgjs4RUptrrqr/ioELfGYZ+bAIT1C86hnJHbYDydqyk32CbaXkqhmZ+k5mD/hYzD6ZrTYu/hlfN/j9i3HUYYnnJhYep8m1eb7rz+fdZMcOu7nkjFAk7LvMuWXRJEDXm5uAoFKVjMGba+y8acTUY2NS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381056; c=relaxed/simple;
	bh=YgwMSL2DfS6Z71Ol2dt2Xh64k0FHnIYhlRjZmBPc0hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERNuYNwrAPsP+7g7PxFINvRVtZIpKNP7tZgYEAUS4J+hrAqlZFqb5WLnJNPTdYfA1HpW9F3v0lA6Y9aga4EZmWJIPmIbPfC9VTab3PjQqMsnz35DK9Jh3sc0Ng10BUWnJVRZPqmjoufFUuP0mRWt3K8Z4GIBKawVcUOIS3t2kbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYDq+mGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYDq+mGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7D91F000FF;
	Mon, 14 Sep 2026 10:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789381051;
	bh=YgwMSL2DfS6Z71Ol2dt2Xh64k0FHnIYhlRjZmBPc0hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lYDq+mGJqr9IgENqdrucgdgVBVO8BcmPTAGLx01IfET8Xw/MrpJTu8OLqtfTql80a
	 9WYWsD1y/tupjxF9WI8uuUuHBBlIs5EndFVgOL3SKxrqoXqJH1sIYXpKjV4n9Q/8Ic
	 4tqypts+zYeSQbcuyfbwUSHQGEdXAP5F+HoGDba6yXMRcB4WzfBl5ZwDpz+2yVH2Sy
	 c/Krj3PXqjzks5UNih2jJQNp/pkjtWNUfIJqWY+q3UHrV/hSSFPf4TpTjwmxIHI/e5
	 uXuwG4EncvwTu3gjbsngvHOmeXiylJf975/pj7GVjwOqnRkC/x7i1udR6YOmSzcU9x
	 TCpS6EUFzXJ4g==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 390AE1AC52F1; Mon, 14 Sep 2026 11:17:27 +0100 (BST)
Date: Mon, 14 Sep 2026 11:17:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Carlos Song <carlos.song@nxp.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>,
	Frank Li <frank.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: regression in i2c-imx-lpi2c.c after rust-i2c-next
 merge (next-20260910)
Message-ID: <aqfJtxvw6MM6l9s-@sirena.co.uk>
References: <AM0PR04MB68023742F715A3BB3DEC1929E8BB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c6yA6j/BNL4mrRfs"
Content-Disposition: inline
In-Reply-To: <AM0PR04MB68023742F715A3BB3DEC1929E8BB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
X-Cookie: My vaseline is RUNNING...


--c6yA6j/BNL4mrRfs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 14, 2026 at 03:28:29AM +0000, Carlos Song wrote:

> The root cause is:
> Change to lpi2c_imx_probe() from this patch[1] was replaced back with the old logic during the merge conflict resolution(2edfbdfb8f9c).

> Could you help pick these missing codes back?

If you think there's a fixup needed for the merge please send me a patch
with that fixup.

--c6yA6j/BNL4mrRfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqnybYACgkQJNaLcl1U
h9AZxAf/WfLXO+qKCuJZWHuf+qHA9f53nQcqvQKtj+NBJ4Eg7ut014zJbEMZBfAE
CXozba/agwGLQ1uUWk7qtmFuZlY6NKsutbJN4w1xyTYMgR9uJczv4D5rEouOcRPw
emAvd51FZrOUv5sN7Q7GYaGEHy+MZb16iU5Rvr52IMAZCW8mhks7VZQEWtoJ9juu
9RRsGZ31Cv1uZPN0v9nOrcIG9gVgENjW/SXuzcnkf8GfB92VF/VVK/F0zCERLahT
JCkQyCC2uvtASmkwMx7SYBiYJUGQbew6HwChABfS1cfTjTE62MjWi244Hp8+UNCF
X3UhcxFkhWtrwSDcbm4RZFnTKWvhpQ==
=j71t
-----END PGP SIGNATURE-----

--c6yA6j/BNL4mrRfs--
