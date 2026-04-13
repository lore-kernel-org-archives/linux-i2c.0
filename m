Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C463346A5;
	Mon, 13 Apr 2026 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100979; cv=none; b=ferYxhRoeSA/6eO+ROgYvpRnEmWcGW+XT61/UQfXsFBy4mxh1+GCcb56Yc3H6vwDkFSHn5EkvroWRcoIDyClQSNEXurnqUt58VcrmhSrechs2CrWBxro+VpUU56OBkW9AUXM2BHM47lvWVjdLZKLk11auOkaIfOTv6Dw8wLw/1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100979; c=relaxed/simple;
	bh=PdAMfFIlhyrHml59N5eWhxV+t4b7w3v+7eLZ5Vm3b9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phFyrjkXP8WecXkVYIWxvbH0zQRvqdSl4jRvyoxiPEpOyV00N52C9B3tBO3LAtjl+oC9jbrObZzP2OC4A1pHvsCWIeo0pv8PtdjVNCxU93DwJZfnWohne9IY3nGtdj5vctOBk12s1plA1UsEtzy+tWGoqYNWWL9lYQz4+lZDOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUXaBmrS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUXaBmrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464D0C2BCAF;
	Mon, 13 Apr 2026 17:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776100978;
	bh=PdAMfFIlhyrHml59N5eWhxV+t4b7w3v+7eLZ5Vm3b9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FUXaBmrSUmb3mMXp6i7GOHvLf5qtliKUzH0YAbINGdlsvUNHShVcqUwSdrQlhflpE
	 1StnpKXh1tfymV992gl3BTDzchNBag184uQvLq14wsp13Ipo56I65DYD8TunP3I4xo
	 B+JfmJmwP01DQPefAWZ+pyPxcsEkdK0Z7NpSx4hNRwgZYDXIcy95L19wnYecnr3LmO
	 XMjWr76lJLeVbrcZePz/CEhdREj+K81gGA94vq1L9/FweDn3iLannDPCtIP0Vnr/lg
	 OGMeb74ZjaN3yD+uAzp0x0zTQNBiBYXSloTd+oiSrtXZ27Pe9NlvQFUsdwZ5dlaA2B
	 1R0GqeQWuStAw==
Date: Mon, 13 Apr 2026 18:22:54 +0100
From: Mark Brown <broonie@kernel.org>
To: "Nishanth Sampath Kumar (nissampa)" <nissampa@cisco.com>
Cc: "brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v2] regmap-i2c: add SMBus byte/word reg16 bus for
 adapters lacking I2C_FUNC_I2C
Message-ID: <0d7d21e2-1ac1-4e9f-83a2-e80e91638756@sirena.org.uk>
References: <20260407233927.498932-1-nissampa@cisco.com>
 <177567169064.101848.12605250361585331832.b4-ty@b4>
 <IA4PR11MB899238768222D623BCC9A17BDA242@IA4PR11MB8992.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7gXwF8a/1N0Wwiyu"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB899238768222D623BCC9A17BDA242@IA4PR11MB8992.namprd11.prod.outlook.com>
X-Cookie: Love thy neighbor, tune thy piano.


--7gXwF8a/1N0Wwiyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 05:14:24PM +0000, Nishanth Sampath Kumar (nissampa)=
 wrote:

>     May I know if this has been merged ?

Yeah, it went AWOL (the tracking for what got pushed in b4 is a bit
buggy) sorry - I've already picked it over again: =20

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?h=
=3Dregmap-7.1

I'll send a second pull request with it later in the merge window, or
failing that it'll go in next time.

--7gXwF8a/1N0Wwiyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmndJm0ACgkQJNaLcl1U
h9C7OQf/ZGqg428I5eR4VVSKWZhQrKeW3/FO1E+j0bDlBx1ebAKctNr3CWhqPUB8
tMTB0Ysd6TPxaTK23n7KxixvYDAxkJPFk3qfM9QXjuqa3DEyZL4nNtyFFTnh6cNM
GoG9mDOdyin1PV8Ne9u4sTFM/hF2kc4IMSSgaAgqw1oSDppgRIgZ4xTdtfXXPVJL
7Mzz8qNg+PXOlFO0pmRPXm8xSufjZe809Q5Q7DPiBeBOgoKI07rGpA/T4isGySFI
kF2fd/WfVQCYSnmd/sZqMc2MIEiBCLiGPk/kZri+MCusZwvxHsPDxltxCbIPTvDB
QY0RLweyBh76ogU/D8X/MLq4H3B22w==
=nWC5
-----END PGP SIGNATURE-----

--7gXwF8a/1N0Wwiyu--
