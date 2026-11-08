Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145897;
	b=A/cED07E5DnAHNaQula/1UaHodO+pBYS3G1GCLF6N/nFCn50Wfy6dCMcbG8k9blHg0TU
	 NuY4Qtk9q/3x0wxzBqMFznD6SwQZs7+P/LvKWOPhnELEslRXkgOlYbRjMGNPC/XMrnutX
	 2BCBId7jdzWLOXf2PimfxNSKr6qI2BzhrJA922wKj3OYN4d3XKSzll5McwOUjOynAUVGR
	 a8P1bVkznHSJrhyDlOtzQf0xtTq2AHoXU7OmzNt/67KhGvPudKCn7dCKBlFOPIOQJ5MA4
	 rBSnv3C2gxWz3hwLV6MJKTF0EKpKVl4ymvMGCGNAwsB8EkkAiFjfB6z8lsyoz/XFLIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145897;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fuP7hihf8bmWh/n4wZAIHP56JKtn7m8SpeRVLAjUG9U=;
	b=tqIf5fM80s1kCAG540UT4LlrdxJ1hCPa5TxE+D6h8MTI2B75aFCnotelBxMvHU56BebE
	 wQhpy81Vj843UfZTd0CmhZZev5w2rcpwbRreZVk7wYe2MLKZCxR51E60QEs/GGIpTPBEl
	 OftAmnMMmxSOA4ca2ATBuTCEA5LmNm82WBRE6HIIdnu6l/zcXURM5/g/QLU2dWJkKu1+m
	 MaWohVS3tU9myFSK91vUW7ZzaTDSDS64khbtwmGkmSh4VbDJUC4ipVmLDQhig8/SGeCO9
	 9oKl9avsO1NJFpGKNIftgmVbRRXearDR5kwY5AfLOXGEkv2gJ3WXCjAlv3jiibf+gqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=HLulHmyj;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4EF606A31C
	for <linux-i2c@vger.kernel.org>; Sun,  8 Nov 2026 13:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F4EF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=HLulHmyj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=fuP7
	hihf8bmWh/n4wZAIHP56JKtn7m8SpeRVLAjUG9U=; b=HLulHmyjjfnG+arvVpG0
	NiX5mN0GFTf2FqHCKWDFDQDz8a9EC69ySsH+XbvpD7j+YUTrJo2iUaAg4ZdJpBwl
	ooHTIxQEEN/ClvJrenMbhF7V5nq60DwyjuXJZGhphlywPDxtO4OIRFrsnK7c27Eh
	PoY2k2aQbcLOkTlwFZT3kEQ7IfrxzSm740kuliqhckHN3T91OhJMF0B+F0YFTyLK
	HykhZ8dzpezwN6meK5B7lvKczyr4BLrAg15qgkq0RYh5opmvMwTBpfS+0tmvsitX
	nr3J1nXYW0V73+BAYX2xuGOY45U5N6/h7rMRrgFB6R+//aQFeCIACRNQ1koUEpCU
	4g==
Received: (qmail 2866644 invoked from network); 8 Nov 2026 14:51:33 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Nov 2026 14:51:33 +0100
X-UD-Smtp-Session: l3s3148p1@5dqbJMRfFsEvQDC3
Date: Sun, 8 Nov 2026 14:51:32 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Stephen Horvath <s.horvath@outlook.com.au>
Cc: Jean Delvare <jdelvare@suse.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kamil Aronowski <kamil.aronowski@3mdeb.com>,
	Darsey Litzenberger <dlitz@dlitz.net>,
	Brigham Campbell <me@brighamcampbell.com>
Subject: Re: [PATCH i2c-tools v4 0/8] decode-dimms: Implement DDR5 decoding
Message-ID: <avB-ZAfbTW_ZDLOV@shikoro>
References: <20260723-ddr5-v4-0-d7cf78ebbbaf@outlook.com.au>
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
	protocol="application/pgp-signature"; boundary="1hyxQ3O19qW7Y01t"
Content-Disposition: inline
In-Reply-To: <20260723-ddr5-v4-0-d7cf78ebbbaf@outlook.com.au>

--1hyxQ3O19qW7Y01t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen, all,

On Thu, Jul 23, 2026 at 01:40:11PM +0000, Stephen Horvath wrote:
> Hi, this series of patches adds DDR5 support to decode-dimms.
>=20
> I'm not too experienced with perl or the JEDEC specs, so there's
> probably going to be some questionable choices here, but I'd love to
> hear feedback.
>=20
> The first 4 patches (1, 2, 3, 4) add the essential DDR5 information to
> decode-dimms.
>=20
> The patches 5 & 7 haven't been tested on hardware implementations so I'm
> happy for them to be dropped if they're not useful. However they add
> type specific information and error log support.
>=20
> Patch 8 adds XMP and EXPO support for DDR5, though I don't have access
> to the datasheet for either, so I'm fine if they get dropped as well.
> Though I may also implement XMP for DDR3 and DDR4 in another series if
> these are well received.
>=20
> Patch 6 just adds a new function `prints2`, to print a subheading,
> used for the error logs, XMP and EXPO.
>=20
> Signed-off-by: Stephen Horvath <s.horvath@outlook.com.au>

Thank you so much for the new version! I would really like to include
this in the next i2c-tools version, hopefully this year. This is the
last "blocker". But being zero familiar with the topic, I really need
help. Reviews would be most awesome, of course. But if nobody has time
for that, test reports would also be super helpful. Sadly, I don't even
have DDR5 here.

So, anyone interested in helping?

Happy hacking,

   Wolfram


--1hyxQ3O19qW7Y01t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrwfmQACgkQFA3kzBSg
Kbag2w/+JZtzLjifQ95ZlkY89V5/pFwQRElODPnFz4u0vPTXFNOW/mZaroRzhwZL
ow2IObhVomqW5G+QMB7DxCATJ6BPbHnUqnlUwgt9asLsiHqSKRi5en02PURPOVhH
+VlrD70mM4jsSdn2Wctt8td3hmMhCm4rzCwYiPssgdkRrNOHGnkRmuJrZWsTC/6J
8zlhPC/JJl4EijZcV2F2iiuETwxkaAyVy/gjgngAjaKZmrK2TgcQNnq2WnoQWNzG
NgGO4vgy5JMcdCgVSdgsZ+gVV5bZBvQPCHb89MXkPl2wqC9R2Ae8Ext4zSqR3tfU
Ncu0sbWEV7CO/5jdczxUbAUSWhB196bMZNaiY7z7vygI6dmsyDJm76K9p7uUybGP
LZaQkbw7dsgBVIZz8bSLpI1htxfsy63HyWWqejWR8rnd+Vnq/Cquv4Syos0WUgSC
0uup+vgU/TqENiwTChq7hqh70pXYgSvG47Yf6q+OPUTD72l3LvTNIDn4A82pPA6+
6VMEVDuc6EVBMUYnrd2NAYIha2NB06CsFaxERWvJU8I80rDM+pGOKczBa92JtZIM
WFiPv9Eo/dGvH4X1uvgJ93hYHCedPfqpxngL6MB71DupCbQ8PPBPwa+glhN9ocqk
J5B+VTro3ikPBhpN5T9nEjeZSkqUOJ6NqWBC2TLfiB15n0gonlA=
=J3oB
-----END PGP SIGNATURE-----

--1hyxQ3O19qW7Y01t--
