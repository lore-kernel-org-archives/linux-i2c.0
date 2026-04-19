Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E384019A2A3
	for <linux-i2c@vger.kernel.org>; Sun, 19 Apr 2026 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776636381; cv=none; b=Hag3uQUFLqO6LXLeUutXj0Vikf51xj3fyGgUspLrO1I9UVrMpfXTSqswijdNMfwrJkFxDJn/J+8S07fjWsFwFfEQ83p9rIwZacJQ/ELf7Jq6gPrPnnjG1uRRXGWM0BKhD858w7d5SsVdeapAIyxrfG5FL/cXKoJd0gvHQArP48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776636381; c=relaxed/simple;
	bh=nMV6TrDA/g/b0AvkqygO2mCVOh3iv6kVpuCjBPr0hPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6Mm3Ee4bMevu3alXc4JTWtcIuw1HaDvb/kOkQLCFtVEQW2gmu3KFC29KmKEvtR9Q7W0GbNsvcqWCL6ADVch6GftAkO2PFz6SV95XcEVMSTnwLS9w9VLxSy0WOz9n0bTUbUfVnUacgfiAhrNP+Q92A2hruvq1geXnD89+MCFNKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VSpHaBAv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VSpHaBAv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=nMV6
	TrDA/g/b0AvkqygO2mCVOh3iv6kVpuCjBPr0hPM=; b=VSpHaBAvLcekjCDQW46t
	uOS3VH52WBjHvzXAK/XoJbemXEbeQ8LjG4by745WQT3UirV9KQgghw+MabkJb9ee
	k3jrm8HYnvZhgc6wUlncMqCafJyuSp84bc5hYmqoWHvfQ2NC92zKDAAWsftTvRgb
	ypGLuFW/zHtTNWtyKdzzBbwcbqyDuNQpzRyt/hKMCjTahaRC85UEPdLsyAFLn+9P
	jvgGOar8j28yEtvwCT9Eqj8Z68kqjFCF2QEEjUSHiwIxfm6AVITxmMi8zbcUB4ry
	vph80gTkNZZY57shKZTSUxX8O8N1kqFYONd7wNpPQ2V57bdSieyxZi24YYfcr5iF
	MQ==
Received: (qmail 597225 invoked from network); 20 Apr 2026 00:06:11 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Apr 2026 00:06:11 +0200
X-UD-Smtp-Session: l3s3148p1@Ap7SY9dP1ooujnsM
Date: Mon, 20 Apr 2026 00:06:11 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c-host for v7.1, part 2
Message-ID: <aeVR092NVd15UEAA@shikoro>
References: <aeQgYZcS1FjB1KwJ@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AX8xHFeJmm5KvIo9"
Content-Disposition: inline
In-Reply-To: <aeQgYZcS1FjB1KwJ@zenone.zhora.eu>


--AX8xHFeJmm5KvIo9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 02:35:42AM +0200, Andi Shyti wrote:
> Hi Wolfram,
>=20
> here is the second part of the i2c-host pull request for v7.1.
>=20
> Just three patches, all tested in i2c-host-next for quite some
> time. The pxa change is the second patch of a two-patch series.
> The first one [*] went in as a fix in -rc5.

Thanks, pulled!


--AX8xHFeJmm5KvIo9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmnlUc8ACgkQFA3kzBSg
KbaIFhAAmd7xjZ3uZ7pULhJlKQVi8qji6QuCOh7lZ3VnB1heO0pUNn8p+5MtaRzN
b1cQAM7mKqp7JGWBHJ3/0SBfY5mhOQ0o75nbddfociSd7XduJBUWumozR4EhlBPe
gNvghT5iJQ51M4Fupzd2FmfrnVc/RxHpWcmJMWm3bsmH5aoHehFE6V+MyBdcv/yO
DqXaqjzHF3w9yYmZ0083bqAMhDkU4dI04qIbP7kcVYxDdgpMiyvcVEUGNaexAzmP
lNqzMHEjCQc6DXmVNMxMxm6uBPxuZYThObOx5M9Sm6MJJmKQyJ7eFn1vZpf/OBai
LP577HF3NlfSknKUdyhPkPBVsgrMV1DhIFLPTbHTGwL0UdWPgkyu2PFPPSVsFa9P
/Wm3cvZQd41h07sxPUHqGj1uoVLr6ZA+iwcQqQtlp63EUiavWwGrYfD8NTApOTQG
reGcB63VdGn+8ieTRI65NYIucQygqmBxadsfmPNuBfEoDTRygqHKiBeZjnMb/F1s
sOYksYagj13hxSIMnYTe6x+T4ch8QxGriftrW9+b2n8VchHY7pEpBi5x2AZkaJsE
1KhaupamO8pDIgc5LIJy3qmJtQKWpaC7CKjP4iUTE8ZoHOAWpIceFYzqgyAC3B3/
1jQe/1w3OKciz8n59WQfoQ+Ma7kYlqHNMlqCuy6RyJ/HQ1VS59s=
=tLgE
-----END PGP SIGNATURE-----

--AX8xHFeJmm5KvIo9--
