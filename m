Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ED321B9F6
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781124515; cv=none; b=Hdz+ct2ZknMnM9KW3zeMw+nMYZNT21Tpk/N8bQHiPdLWTw3DGtuuGkyF9WooWqpSf54RquUr7dr+hZcZ413j2UoDCQd4e1SOKIIqnglIpnyDnjrh4laX7S1kPrzsBJ8unm/NDbdf7f8HFYo6VZ8iv1LKz8g/HGwtW682LpHgGjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781124515; c=relaxed/simple;
	bh=sPinqEB3Z0ew/vBOMNFTDPXp1Adrszq1I+ViiwweoOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVr6jUD4glygzxHKn9IVsgifMWyn3//3fjvghEkPkUnR4QvGntJf80W7/MWu8YZ79oIQIB5lERO/0aKZDnD42wSuanJf67K6wDYp5cjeTep2WUPzUhCjlwhosHUKkxhRZhieUWxpeod9tyan6uoDvExpd7IhDOgLtAjBvle/Jdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=j4Y7AJ5o; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="j4Y7AJ5o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=92WF
	uM+RE6p7fwgY5Ms/HqY+tX0ytigNWlvpSNxP9/I=; b=j4Y7AJ5oef1vaBhb7sJl
	nN/TER65Bq4tADx91VAtBbKOnYcQsDjAW7bl94A3GaZW321VxBlVRnfVaJO2Xh0X
	wrQNiHRbCazkO8rU910FnCPTxy7Nrl8eyP/asJ0KfkYbYBGugNrmsOkU/ac/hmex
	yd/q3eZqrEcB9RIMCSrZfQBAPlg2finnjOH8DYSu7MACCJg6qsA63OsS/KsAkOGV
	E0O79rub5QI84W2jn0jFoma/+qpQd6jEqnJm/QTV4RTFhE0vek0uWTSFlW8STu53
	mNLLOHwNB5dm6TcdtdwOq+ZZjMfyqZwvXUBE9UVaqksHFZbZUv5rT0zrAIHBSyqJ
	HA==
Received: (qmail 1837123 invoked from network); 10 Jun 2026 22:48:21 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Jun 2026 22:48:21 +0200
X-UD-Smtp-Session: l3s3148p1@PF8tXexT2OQujntj
Date: Wed, 10 Jun 2026 22:48:20 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH i2c-tools v5] i2ctransfer: Add optional message modifier
 flags
Message-ID: <ainNlID05qsaaCD-@shikoro>
References: <20260610-msg-flags-v5-1-0814fcd44693@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1oHnojwk5f2nBo2M"
Content-Disposition: inline
In-Reply-To: <20260610-msg-flags-v5-1-0814fcd44693@bootlin.com>


--1oHnojwk5f2nBo2M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Beno=C3=AEt,

On Wed, Jun 10, 2026 at 09:49:01AM +0200, Beno=C3=AEt Monin wrote:
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
> supports the required functionality to handle the flag at runtime.
>=20
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

Applied, thank you!

It would be awesome if the PRINT_HEADER part could be extended to
display to the user the flags used per message, if any. As an
incremental patch. I don't know if you have time for that?

Happy hacking,

   Wolfram


--1oHnojwk5f2nBo2M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmopzZAACgkQFA3kzBSg
KbanvRAAkf2wfn7zpHnP2M8c/p8+dRrFFtogs6PfSvUmK8WNZNBqbQTBdLFWO6dh
A47M2U2OXVOoA1USespHMKSUCe98LWAm5NSrmceTVinhNoNs8470yASVrsJkeu5O
+EVAHzU3enj22U+7juqj+xrwJiYpFfAOqyDW3+NVS7xc2C+vF5xHnejLmd6DwpCr
cp2k06cSfeBALr5Mp8wk51tf/qmrqIUcISKrANGSCErvjksSbXetMfxF3sEPxdh1
Epq5iImN1HMdToiUMhZ/DJiuQvPVlR9mRrJBxIFOr+0Y/acOEfPTOxYAsNuj5Gwp
Jv5G9rO5VvfEbqw7qQnjuDyJCvcNo1Xi+0WtX/Cp3fuPtoZu+QdZWeZuU512bo8J
zXU1SWSZpycsHsliYPwsAO50ktdnCjViRlEnsmMLnPcoBG/9tHDrHkyr7hqRnzjN
6V5jKF962gyqQbMgI+b1zGW9g1Se8e7w0+SizwEC0JXf6/iCsLNnP3hJnbDP4WNe
FjuV3sDrMywuzf/QLDJBl7vuvQ4X3eQRbKL4rJE8Qb8NNf2Yu+G3bgkhBcueZCkZ
hFtITmz3KYgnSQO0oXiKhx9abUIug21DQK7Guruw/hscsRiXNPPnFJkY3ExUyujf
j61f+gRqhFljeymlRz1prq1nSs7aPdmv906ScKhg6u2dDzIjuQ4=
=UPhP
-----END PGP SIGNATURE-----

--1oHnojwk5f2nBo2M--
