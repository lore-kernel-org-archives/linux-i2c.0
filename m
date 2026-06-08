Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443E37C90E
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950483; cv=none; b=Jyu9uhx4kbmMJOa8gGgS4V+nQsV3UEZoPCQTlfX9ftk1sqczMQNPpsWhGZKN+dWhkdxp4diH4xPxDzn2RlyvzIgS3gW/e6sPMpw9GXJetgRxe7IRSOYGbTkacqG9g7cqaZVD7fI6GtC0J/9wagbbo8hUUIHMMc7u4LqsZ17MWnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950483; c=relaxed/simple;
	bh=2VofoPMEYxc4wDDusBuqtDeVgMwvndUqWW9B3UChsjk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AvqsosROauAKWPyb0Nd8s1xxrhg+6+AJ0H5ROG3IOOwrXZo+k9ctEwzdyQfY6rBBqbUqYJ4e1aoOWS9BxmojMT3ctP1vmIPljBiAJd7v4Au7ZBNNbZ3uBi9XXNX/00BuR4J6FwArOgwOvH6zQNUXwtiHi+sxDSjghyWIFPAFQSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZI/B7EsB; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZI/B7EsB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:mime-version:content-type; s=k1; bh=uT+0GN/TYXJNru01ErFby1MApT5
	Ldmd94AlEN2i+BUw=; b=ZI/B7EsB8tQ6xAG5lBA/tKdgFwXSCuhsbYZbdQFTeNN
	ZWtSTgryBGDkhhknHH0FugJOMXNfGoO+LVqA/zcNrA4wxr1dn3KOH/9oZXSNqkO9
	igaJw4impcafTZwhtHpuH4mJnS4358fDneknW3PGNesLlWUwV4vrftubNhD3OAZG
	FQb+YpXE76tMFAnfS9yOG6z31FX49DkcC5OW3uiFEYhhJWFjoaHsLDjhFkWqk21q
	8m2KKwjI/0aqy7P7WvO2FkcJARmgcar3BoHGhzA2+zW6myxMZTC82EoVsuj1ODzf
	zDQWf0Q2JuGGoLX5lBuKxtkkK1+e8Th3nvRn97dRZhQ==
Received: (qmail 984100 invoked from network); 8 Jun 2026 22:27:59 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Jun 2026 22:27:59 +0200
X-UD-Smtp-Session: l3s3148p1@/Umo2MNTctUujntX
Date: Mon, 8 Jun 2026 22:27:58 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PULL REQUEST] i2c/fix-registration for v7.2
Message-ID: <aiclzp0IA2Rk7NyU@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oi38VQ0XMm11UNGm"
Content-Disposition: inline


--oi38VQ0XMm11UNGm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andi,

here are the latest patches from Johan. I reviewed them, tested them as
far as I could, and already let them sit in next for a while. If there
are problems with these patches, I'll take care. Please pull, so Johan
can continue work on the life cycle issues.

Thank you and all the best,

   Wolfram


The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/fix-registration

for you to fetch changes up to 1640403fd38e9c0a1d9d70965d36410b263b6e2c:

  i2c: core: clean up adapter registration error label (2026-05-30 23:57:19 +0200)

----------------------------------------------------------------
Johan Hovold (10):
      i2c: core: fix irq domain leak on adapter registration failure
      i2c: core: fix hang on adapter registration failure
      i2c: core: fix NULL-deref on adapter registration failure
      i2c: core: fix adapter probe deferral loop
      i2c: core: fix adapter debugfs creation
      i2c: core: disable runtime PM on adapter registration failure
      i2c: core: fix adapter registration race
      i2c: core: fix adapter deregistration race
      i2c: core: clean up bus id allocation
      i2c: core: clean up adapter registration error label

 drivers/i2c/i2c-core-base.c | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------
 1 file changed, 100 insertions(+), 73 deletions(-)



--oi38VQ0XMm11UNGm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmonJc4ACgkQFA3kzBSg
KbYgUg//WxsBf/A2PrCIZRB+gZJbxp7ai/YW+1w9kktajh0Ml5up5tdgiBpZa5v4
xZaqJXujFyCRIOQXpbbTG1lvCjVC81hsJSuxnmKjwjzDRlLGV4sKBwwm1CVnhgOT
EqXwNi8mhkNCaFkVNziQRq3A50sZ5CJasQeWxg2Puy+bcM0eEH5CiXgbehp4JATy
QyjIJi3uqCSBjr6ArvVSYsBWVvwUBlROTVOhlYoKM94XGDuGTJbkeEICWRmlDPCC
E6EKcyHxmwzfOS9dRSrvS8M8F+cFpPwV6Nuzzu5nSjNsgrtivk9gdQk96dkNjHbn
DtgZ/qCdAw1dH9FT8YDRLBQNONk5rQjd0KgujggH7MseL/jitki+KWTe5o31Tw//
jwSJIDzhniSAMLTgD8tAfvP7k5KbLZaPls9JR1GT4+J9bRrS5CM4MrTrnzdKkGUO
bgTj9O94A1ba0Q/k8B1orc5dc4fYK9f3NpTJcV1elfSdlwAjSdZmrOlB921gUGB/
mP1YEHgvlDfGsTtposFX8qkAW7aJoldbwLmLyfaG1YM7xf8etof9eoCTNbdNsLh3
exs7Gy0yMvDhR+EInp/eU15YUYg5TVsN8DOoJHSnuNXAa/pxK0hFrHMJetjhPPIU
R3+YkYnQSN5E1QauebxPTfkxR0UNuP9jSH6g8eeGjioLFDRDQEI=
=0k5c
-----END PGP SIGNATURE-----

--oi38VQ0XMm11UNGm--
