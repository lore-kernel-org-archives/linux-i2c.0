Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391257;
	b=WFQVp7PMeqUJ4enUigugBzoGEB/CVJhfxa5bLrFPzIAQlByalNA4EtAu/MWT61XOjNtJ
	 ef+HdypxQp3dp51Zg2vwza0dqj1TbuBqAYT6uvcG0Jr4jpUWJaa92jgNSAAvAW6P3x24x
	 J4yZQBxIu7QHuZIuXKsl3+ZKvUZSmrTSbMuCnwHtfg7TJWmh/zyh7EEM27JQLhxkaMhzQ
	 UsFY/FTqjGhOtIeqKq2xxWeqtb0mdpmEXGQip073GAN+nYCQMjxrsnH1vYUqcLJ2UUQvQ
	 7YHmm3edUH3yJDQTNatwOCgKD3Y4JaazdOrj44kJ6dQ00DU6LCFg3gtwetGfn6bj5mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391257;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=GdUKNDib9XPzffYgYMRXTLPTfVOcK09Ll0AhFILzf0M=;
	b=KYgYtX0xpWbQU6eU5PCFRT2ZMps4x6GG4VipmZI6xxpqUdEi1zP2paGYQXJJV0CtTnbv
	 LjdIcjT/1UOGMV2r6ygfXKCJcLqBIVfDQc+1b9/9iapPcAdxdkvk8IQ1U22vAMEnbwC+N
	 YtAiAAEPQh+5cWnQX4fa9luE6rZ9U9ePbfNz1TZUn1nzU9OsDpTsVzXWwYz78kY7Ud4z2
	 sViBRHV2oRUGpR8D3Y6sPfJZcfJdSQnOgeyPPFEbEyEq2qjzmQYwhUEHRovXK9gTli9p8
	 5HDlVCtWAhAvxIc39+aYL7oA8Is51+LOJmF6zu6E2WjibDlf4B0HbmbYQ4i628ZIOqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=GsOr1M1m;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA935606A31C
	for <linux-i2c@vger.kernel.org>; Wed, 11 Nov 2026 10:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA935606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=GsOr1M1m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=GdUK
	NDib9XPzffYgYMRXTLPTfVOcK09Ll0AhFILzf0M=; b=GsOr1M1mhTGoWUW9/JZe
	lbF+uUA8UdX5ZP223BAW3B6wzUy06KcaNBRWIJ50d3LQ4AC9DtEZC5e1Of31J6wE
	Dq2S2EvbMDmysSBd5CdtuVjsPoLjy5lOnrqFFz5NPi70egStvEDXY0A6suUhqcCZ
	PG2DWmbn2167UiV+TXsgTwvjRj2VX3YVRn4rK71FYloWuMSqVnXYs4zxU8JPAG6L
	8My1LMRQZBCxX6gd7OKh9fLzQsCWCaCH4g2VwyB2t8isGRLc2FwcMaZAP3ufxaML
	5NuzHQ+LJjvtEuij+EfQnZ4iF5q7EgxBPu4k+rgC2TWfBNvOTaZHqWVIkvtQ4nBD
	vA==
Received: (qmail 560195 invoked from network); 11 Nov 2026 11:00:51 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Nov 2026 11:00:51 +0100
X-UD-Smtp-Session: l3s3148p1@VLMbRf1f/IMujnun
Date: Wed, 11 Nov 2026 11:00:51 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: aiyengar1990@gmail.com
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: slave-eeprom: Add an OF match table for module
 autoload
Message-ID: <avQ8z7jFK3T4uZ_1@shikoro>
References: <20261110-i2c-slave-eeprom-of-match-v1-1-8f762bf06205@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vyq6EiQGiyJAgcJC"
Content-Disposition: inline
In-Reply-To: <20261110-i2c-slave-eeprom-of-match-v1-1-8f762bf06205@gmail.com>

--Vyq6EiQGiyJAgcJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The slave backends have no DT binding (they are debug devices, as
> Documentation/i2c/slave-testunit-backend.rst says)

So, why are you adding them then?


--Vyq6EiQGiyJAgcJC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr0PM8ACgkQFA3kzBSg
KbZKhA/8D4RU9YJt6iRvnmEvY4t9DPSJMpkouaoi36OTJGIHaLOALgEl0BJc2IjT
c7SK7zpuO4U6VMZjOHcgzrihrDfycPeu7RcAamUG/vOnqVoH9+c8N3EDwoulx7wY
4yljp8Ck6Clny0dDNqAfGDiydCfaqZThj3RvdFx5Gs1QE5Wbrr8KQeXkkXdi5+TW
bXZ60Fmhua+1DAvGEp4ItLexCOFmJrEIjySTN4f7JBkn8zJVkK7RV9+yT18+mdCY
YFbDPSaHbZc037tZJfjZ7wCnCaFoCgsONReQBypF3GJsd+A7gYIVgq7HxAUQtuPs
0jAmmBLEh58e3Q3VI+QrFOLLwqkZQSWLTtdBSwrNraCP8QffFZvzEJYLjXZ4QYQ6
+omjVt/9rDuHayu6sHxe1BfqkK9Iwv30bnmoprgg+098v+oKxm0msNQ+tSs/HEKk
3pT6rxjTcc36blKl82KJ6CreG7o+U+CaYT5rC6Sxgoj26Opjlm6WlhSLP8+ntxfQ
wXpxe2LXpBIaY2MxHuhisAFmyNOjNVhcMkSNmWPzPQ9LKnKIUpBrGYLstvzfUvVg
hB6/MOcNod2pwGOQ5JvjZuLgANcU2muOBa1lezO7D2AfMRZ2iuoWX5gq6QdHwRC6
1Nz4JaMi21dyewjv+dBgrdgJ8wougHB3SPp0YrOgQ46FEFkVFHU=
=kXIl
-----END PGP SIGNATURE-----

--Vyq6EiQGiyJAgcJC--
