Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC663DDDD1
	for <linux-i2c@vger.kernel.org>; Tue,  7 Jul 2026 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783425101; cv=none; b=H3E7SM0c8LY+/XmcgOHRRuReH+mnB59wc6CWXp+CiEj8VLfdIlnU/kKANZT6nCnwZdm1zEdMloIFLdzHcHXwdu07hMLcrX+8zeqZrMPN6N05w038mSGDAGgoHOVX55SdoyZTlFNM5e04sURnmIlHZg4CEiboiYYXyimmwCmk7/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783425101; c=relaxed/simple;
	bh=vy8LLf/MwSWtX3diJMzNKFmyjMnAOWs/kzEh9bWKZfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKgnY5a3NE0du/xvq6VOWwlZZqD6jhedAAuMW1hEs0y3F+8C4ZMqaMGc9nCRyAJaQAkM3dsxCvixAvER2ONeTvQyHEZeMF9ZEQ1xWVd+Ha++GRf93SX9XMRnu4s5w6pLOu05eo0wJg8Xf+MF5B1T0ZRhS+Os16KoQltmVim3QLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=YaKdPBKn; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="YaKdPBKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=vy8L
	Lf/MwSWtX3diJMzNKFmyjMnAOWs/kzEh9bWKZfg=; b=YaKdPBKnwYOIqPNA9lV2
	zdjD9nwAlbz51h8SRQFMFqK4badnubDPq0aXQ2ARhxKttGeyavr/Uhq9cJpfaagO
	ELJNzBJWiuYfGw0wOf8kc0cLEevpbjRmar1oWSnZGmAHhw4pUTrzfgapLePMRHqS
	9QY+JavvSAFsuK4DmjPr94lHAdUohWdcMmVZIX7RtkZHoQd4k/y/oPsv06OP199E
	RNmYcY8Rgr48nQiGzoOZYTTXCPgVnMGxNqVKa5ELnl8EaG8PusJQsZLbV/RFVJjH
	CNxO0JjhTB9TQJWHDxcCKrusf1X2UO20PRxio3vmekstjfDC+TARy3eyaWgOXafv
	5g==
Received: (qmail 252802 invoked from network); 7 Jul 2026 13:51:28 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Jul 2026 13:51:28 +0200
X-UD-Smtp-Session: l3s3148p1@UiriAgRWPslQT+F6
Date: Tue, 7 Jul 2026 13:51:28 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Stephen Horvath <s.horvath@outlook.com.au>,
	Brigham Campbell <me@brighamcampbell.com>,
	=?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Subject: Re: [PATCH i2c-tools] TODO: add file and describe items for the 4.5
 release
Message-ID: <akzoQNeHb24X-XlA@shikoro>
References: <20260705181043.3757-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B7e+HLAKyDYnCiM7"
Content-Disposition: inline
In-Reply-To: <20260705181043.3757-1-wsa+renesas@sang-engineering.com>


--B7e+HLAKyDYnCiM7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 05, 2026 at 08:10:42PM +0200, Wolfram Sang wrote:
> We need help, especially with tests, for the next release. To make this
> visible, document the planned items and explain where and how people can
> participate.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Guys, thank you! I just had a little hope that this text file might draw
some attention, but still wanted to try nonetheless. You exceeded my
expectations by far and already tackled most of the action items. Really
awesome! I will look at your contributions today. We probably don't need
this TODO file after all. Yay, happy!


--B7e+HLAKyDYnCiM7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpM6DwACgkQFA3kzBSg
KbbmaQ/+L7mnWoni3kdWWTa7Xw1bDj/QgIATSTmUQwjiqKhNKWaqs0eZs06cDfjP
2UJ2RlAj0T7S9UMogrje3fF5TK1mJQBi+PgVnsBe9e62R4Sa3qH9e8VXgmEnsq7U
ECKdVGqJtlh0wpFNxR0hJdHv/3ZJBpawmGeJzvqYTVr0TK+5V0V4qVQQdBn++1lV
WaCsYHDFifuCl7cAeZTt2up0OUsKWKf3lCsF7hLxnOgOkjY3Wq+lllWO68GuOK9f
T1SuIJ2ueg264WDlkAAxH0EjNkmRlSuZNX3s9fb98q/8pTS490v/G6pW0FbiIXj/
NItqjZWF4QZJ4W4fPcKSMicAgc57/xhhE3GJiRE+ELCi7iI0pDanFs37gzNCZTyU
PUyWKHuMNwMwa5tPwJxEhSClktMs0QZbecy8rpUOFxoadC6YV8o8dfNPFn55nU0c
gWpfKr4P3j3oUFjFsW7A5cz1bBGbZMECEcS8c6c6AmaD8FbPSaJBI27Z0wB5EsBH
nNAj5zbbe1ODpaNNE5BKpSLrNykTBZ1zYxKj9DorB1KhMg/+9shdrupwfUfeXB8b
BXNIORwQMtM9DzJzWrAYdEv4FswQWiNPf7MGW7tbdgiPoxeJ2N8VIOakJdPkmueb
DGuVib7pZ4v/HowsQFUFzA7NF2eFBW331GB88Ycla7HziWS88ao=
=CnWs
-----END PGP SIGNATURE-----

--B7e+HLAKyDYnCiM7--
