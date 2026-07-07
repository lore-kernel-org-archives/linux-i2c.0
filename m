Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C13ACA7E
	for <linux-i2c@vger.kernel.org>; Tue,  7 Jul 2026 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432112; cv=none; b=rPVjfzTL5GG3i6rhb8RSItn3bi5iYNd0+z5PXB7xe8DB2N8c26gy0qCIKNnWyoSpO3whqq1W6hXRL1n72FJ2t15i7320WYmD/fTzYkrTFFUMuIA3PnzAottS563xsIXuTUhLbxmhcXvCGAanp44pDSCzMZRPojylVHdf4nfatAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432112; c=relaxed/simple;
	bh=TimQTiCahggrEopi+zYTAHts/AHOO5TN5vvvjxNQWTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpcgiDTazmknVCHnVeCt1ebfHhmD+PoGWKYiyC7h1lREwekgizTkbbKrD73mmsiqmtv9BbTDZgiGqKTpPHdmdDOfptx4GiT5qCd2EV53AkWhkufJcYyxVLMey/4YcQ01r6bcW+LX/CvBKo9pX7lsw5vb15JGN+WVedXg6R0WuY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=JbDV3t7d; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="JbDV3t7d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=S/66
	Tr4/wWw2e5wyOQkpseGKYcZeRgyxcklvG+85blU=; b=JbDV3t7dFJEMuBpPM9UT
	ypdaJRL+Vt/m67oZTrVq9b86tS3KUME22Aj+axzg2/1VNfdTGBSxXou01cN7t5wI
	YZUv51JQdc31g0cPcsZzdlst8DIkRrzBKLifLn5jdsUgxeoZB+I/GiFMUFy12Pwk
	96Yzd8dRDf3liwSU73pEzhDZRALZ131YfXvM8N25TF2kqTeXK7FdOBxC3B8LlbE5
	tZk5LyVIBcwu9wA6jGgZfzlesCrXq0rpzTU33dNOUkVZi+IGAwRZUvMxV/k5O5io
	3fUjWaYHG1u20AaZtHRAFnbIHiR5o8g/l0oFVDzdW5+1++gBfnGBJ/tNiU+/ZQN7
	Fg==
Received: (qmail 295838 invoked from network); 7 Jul 2026 15:48:23 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Jul 2026 15:48:23 +0200
X-UD-Smtp-Session: l3s3148p1@umMDpQVW6NFQT+F6
Date: Tue, 7 Jul 2026 15:48:23 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] i2ctransfer: Print modifier flags in PRINT_HEADER
Message-ID: <ak0Dp14YqxRjA8TV@shikoro>
References: <20260706-print-header-flags-v1-1-6d63b357d77b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h/jK0ROStuBGN7LL"
Content-Disposition: inline
In-Reply-To: <20260706-print-header-flags-v1-1-6d63b357d77b@bootlin.com>


--h/jK0ROStuBGN7LL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 03:18:46PM +0200, Beno=C3=AEt Monin wrote:
> Print the optional message modifier flags when printing the message
> header. For example:
>=20
>     i2ctransfer -v -y 3 pr1@0x33 itr1@0x33
>     msg 0: addr 0x33, read, len 1, emit STOP, buf 0x10
>     msg 1: addr 0x33, read, len 1, ignore NACK, toggle read/write bit, bu=
f 0x10
>=20
> If no optional flag is set, the output is unchanged.
>=20
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

Applied, thanks!


--h/jK0ROStuBGN7LL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpNA6MACgkQFA3kzBSg
KbYQTg//Xsa11Mf4nieXP/npZ7X4wS1CFkFWgwnVAvupWGUWMjlC4jotvvGWBG4q
5O/RVhZxKBiwCGD2kNFWor7h7FFAjG7ij7dYvu9NjDcaTzb2nrKmYUkr/ViRw0v4
BGrC59QAWRlzi6hW5ELjrPsksLncCk5VH8LCanrLFZMgphNsY6Mzn+VUh0ihFArR
3+PHqODVg6QaBrn3CJf6HwF3Gws5msNTErl0Cb6Yf7H5m+dtBS9EL/INrDSZfPVj
MoM6INyKYWeEFljHMcwr6kFrahLhM0/b9rx7uhuYhgqA+yff9TDuQyYiXLaEDNp+
hDkJbTCVr0uwVeB87SjRJZfIn2XygfItsXfDUb6RLN81d+4mWuguJuoRA+rGnLKr
8hbuJCjn2N1hiepAL8KpKitzYk80xg2w8fXz+0lS0Ha6ZJ0CcZtrEU0II/OyeFlx
uhDVeg5p6rOg9Z8WUWiDII+ow4beSKgMQhpsvVIvUNVb1uYgnPb+57u0WDQpHZ8Z
x6bYxPpt4rYkuTc4AIh7PAKsZQW9dCxTuWBLOmAdtCuX7f6yebg6JMxz7OAn557Z
4GVC4xRZLjmd1iSEeFC8lzdr+W6UGai55pC5lDDHVTAJGp1YVaZOvHFqwQ7s6iiX
JfjXGWb10xHkbX6+sK/c/pPKVZeZ1ozVXO3QRkO5hbkPhAHw5to=
=PRJp
-----END PGP SIGNATURE-----

--h/jK0ROStuBGN7LL--
