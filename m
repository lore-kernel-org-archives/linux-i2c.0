Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677B339B486
	for <linux-i2c@vger.kernel.org>; Wed,  3 Jun 2026 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472021; cv=none; b=GL/2ByIcf98hNRgxUfo+gXcy3YBsXpJBPAc7SZqTzmAdt7H42DJX0o5WtOl4fYXWVsUlsw+8DfkMkKLjbXvaxYToN26BnltFvmoJiufWe3qgtywQYuoRIBc/H2Rr9yrDfc0HnpkrArmRspOjTaL7wtJSj4OwkOyCqsdHI8HHp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472021; c=relaxed/simple;
	bh=BYCmoOKfJA84F2Kpcq+xsS0zeD3qgKSCgFS0a6RYq1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DH9bu4oCIw6S0NFCLPDRVxIoPwIDA/5hSuo1ijNpqQQUXQRRilqNtJD+TSkg+ITn/wB1Vx4mBp8UmgeyV9FI0+7S/Lm+ejX6H+Z5W1INmVSXSL0HGVVloYeW4PhCqZ0ikJfEV3AfS3/swucc6f6Yw0SKHfENpPdpbXv4aYkWHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MKYmJlO3; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MKYmJlO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=lJ6M
	Th2tA0pzk3ZV5YJ6ObQnkHaRsY2i25XIqMTBjU4=; b=MKYmJlO3SY1ciHrpBsOb
	ZNE5m3Zj8a8Yt25Ujpu5vN3E8wWzBvv3i/x+dn05/Qrg5wHoaPvrCK35wW3yo2sU
	9Hi0Ia1ofqyyn4B/oBA4qpKzpOFmXdqld2LZQ73dleQ1ZxwLmP2w8U+N5Iq804dQ
	c9ZXVL44Z6nyXYabw1HDq690Ozv5HLJF0kcjS1pf8mnem1M0yclgut7nNkvpKQQt
	NFSGzWg8UKlcL80kLUBH9a6q+EHFbwjee7NoSne2nY13Wtsaqgj4NuOnnC2Mq8SR
	DEvzSlVQ0cshDK381OiZMDs/Hjm9aawefGDYxRU49xvEFjhzAahQ3BA+/6zW/sck
	vw==
Received: (qmail 3177941 invoked from network); 3 Jun 2026 09:33:37 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2026 09:33:37 +0200
X-UD-Smtp-Session: l3s3148p1@iFIdclRTIKIujnsK
Date: Wed, 3 Jun 2026 09:33:37 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH i2c-tools v3 2/2] i2ctransfer: Add optional message
 modifier flags
Message-ID: <ah_Y0bOyXRajpp8O@ninjato>
References: <20260127-msg-flags-v3-0-e7539945db2b@bootlin.com>
 <20260127-msg-flags-v3-2-e7539945db2b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X/ycBd5XyaSH+Ubv"
Content-Disposition: inline
In-Reply-To: <20260127-msg-flags-v3-2-e7539945db2b@bootlin.com>


--X/ycBd5XyaSH+Ubv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Beno=C3=AEt,

On Tue, Jan 27, 2026 at 10:25:58AM +0100, Beno=C3=AEt Monin wrote:
> Allow setting protocol mangling and repeated start elision flags of an i2c
> message with a set of optional command-line flags. These optional flags
> are parsed at the beginning of the DESC field up to a read or write flag.
>=20
> For example, to read one byte from address 0x50 followed by a stop, then
> write two bytes at 0x54 on bus 0, one would call i2ctransfer as follow:
>=20
>     i2ctransfer 0 pr1@0x50 w2@0x54 0x10 0x20
>=20
> Since the new flags are optional, this patch preserves the compatibility
> of the i2ctransfer syntax.
>=20
> Handling of the message flags is done in add_flag_if_supported(). This
> function checks if the flag is defined at compile time and if the adapter
> supports the required functionality to handle the flag.
>=20
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

I don't have a controller supporting 'mangling' here at the moment, but
the code looks good and my regression tests went fine. There is one
thing about error handling, though:

> +			for (ret =3D 0; *arg_ptr && !ret; arg_ptr++) {
> +				ret =3D add_flag_if_supported(&flags, funcs, *arg_ptr);
> +				if (ret < 0)
> +					goto err_out_with_arg;
> +			}
> +			if (ret !=3D 1) {
> +				fprintf(stderr, "Error: Missing direction flag 'r' or 'w'\n");
>  				goto err_out_with_arg;
>  			}

This error message now only shows up if the 'rw'-flag is missing at the
end of the commandline:

# ./i2ctransfer -y 0 p
Error: Missing direction flag 'r' or 'w'
Error: faulty argument is 'p'

Otherwise it complains about '@' not being a flag:

# ./i2ctransfer -y 0 p@0x1a
Error: Unsupported flag '@'
Error: faulty argument is 'p@0x1a'

It would be nice if '@' would be recognized as a terminator for the
flags and would then complain about the missing direction flag, or?

Happy hacking,

   Wolfram


--X/ycBd5XyaSH+Ubv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmof2NAACgkQFA3kzBSg
KbY9gQ//RT2tksAbyaHhnDCCuICcIWPaAcwLUwJdAr7JZ2H6Ap2ysSKXiTFcfmgX
M70EIULYIUMc9o5NKCKOOS8FU33O/4i18Y9l0HKXvfioo5cy2wQy+wlS3VzMIsj4
BNcPzj/3occt2oIGAPtfN2Kqy1Jw1zrySNYQ05y5JwacZNtj5D33ySvXvMwXxn80
VPmquFpMWsCrd5eqcP+ciLami81JARYn45NlxeoSpsQ+cxiu0WTXUqyE6hZ7YeL+
CWGYVqqr7nKRfX6/R23h33930H8wsAh6HwDVVSeornUIlgWtqXg8gffYCdZ3CZlb
MJyzDp8ztsc5qVYsq8tUE210DPI6GcZfCPkCIcV2I62mnHiKGVXO2n7SHAvxijph
1htOUo+U0Jq86Ad+awhs+gofELMo2skFYEd1zvTt2gOdM6BKzJ65X1/b/zJNftBi
WQqWX65Q6bmOaZCobNh9XckchsiGRadnnVrsmuCOxk6i/zU03ujqtcJlu3e7kcjw
qnnJFchGHLbyFYdqdeUfgUME3Xi+MNyozssIJpAxUoT0CxjNYD/dT+EO3KbHw/xs
w3B4LTVrOIZlYGkOWCfJNRu5SkY+acBHDg/a2Y69gLx1CDKFWWiKfxasHCJKmG7M
gXgADs4/pFr1hqJNghHEc+z4JJdPiYCMHiWjJ+p8ONApjynuxl0=
=S/hb
-----END PGP SIGNATURE-----

--X/ycBd5XyaSH+Ubv--
