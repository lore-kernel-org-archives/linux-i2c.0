Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607531;
	b=bptMWiRpwsPpuLuRNsbk6Ve+5R9UjhDnddwD2swEJEI438HcmvBOBoO9TxmuRaVwTfO5
	 6LvmruW7RXtyzJM+0rwwM0y+s28NLUUjkX9oSb1I/61H3JK/bVOiydPjIM/eRZT/EWvQm
	 LC8IG68Y8yedHyl9DttOBkjQctyg1bTFXq6c9gBPem2LKDUQpcR1WxnqBixnBFfV1iN7M
	 wxi3aJB4Icd7HlrweupF5X+fACjgTXN1rSGOxy+VpxUZWmeozR196X1H+Y0uGnYH1A/RR
	 RhrxmwOfZPIMB5JgB1S58xnm7vj8XMxNuBJLtzvCt0nlaZrbEXIQmTGkzvPpng0IuEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607531;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KDBiAP/Ln+eH+FIXOmqjg3zWT6yseYeyvqpzRG5VDZo=;
	b=388PWrN8VoaisC+2oRLZj5JcBhHp1Xc4VEhsGP6HOZ618gzAIscK1bR7zOVmwF8Ndu5g
	 FkV+gw2xlo3rUrFj5qWzXupu/1L41rF6Eyq0TZyOGd8usX5fGV2he4k3bdKZrkkcbqZ94
	 jJIxMXUdpIOV31+K6b4ZyGocZLxky2nhxUDnmjir6kePldWryp+IY8oSTx5Fq+eqF+SjL
	 Y8M3q9lA+7RIVYbilYldITvKXJx/qy2A5lirPfRWxIiU/aI/3M1Aq+stPjbW+Ka0aZO2o
	 it/B9pqD8D9TnTGsdQ7EckwzqrwYmnSTy5UFaJPdo/sEZ5fReiTaOyYQqIOHTbWOD3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=hUqpx+iO;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE865606A332
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 22:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE865606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=hUqpx+iO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=KDBi
	AP/Ln+eH+FIXOmqjg3zWT6yseYeyvqpzRG5VDZo=; b=hUqpx+iODK6xqqqe+Zwm
	OyRQqDEK4HcedhVFne6ZFKTdPAvqW9te4ZSCucAbh0/VBdqAEY49FnH1gOxtJNdj
	uPKJ0eVO2myEhlU87lE2kfflwOyWulaCl5hxTaOWkOXyI/vwoyD5tBa9CIXbYEyI
	L203NDNzD7DGMTxFAljA6akX75nAhVx8usF4LiQjiaEqAUR7pCuGKKjZBvDr8ly2
	PNq4ipCKp4DTOPrSzCbDl4fY09TVjfWOpjsQtZZusp1gpsiimxSLVcVCM7ZGMKiL
	hGCudkIGcrRyPMF2LxQhT1H+UIdo6vFRoFG8tXMtmvpoChav15C/KS1/kxa9KXX0
	sQ==
Received: (qmail 379548 invoked from network); 13 Nov 2026 23:05:28 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Nov 2026 23:05:28 +0100
X-UD-Smtp-Session: l3s3148p1@4908oC9guoAujntX
Date: Fri, 13 Nov 2026 23:05:27 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] swnode: ignore primary nodes in
 device_remove_software_node()
Message-ID: <aveJp5-BqQ0E_X6f@shikoro>
References: <20261110085125.2535508-1-johan@kernel.org>
 <20261110085125.2535508-5-johan@kernel.org>
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
	protocol="application/pgp-signature"; boundary="oHhREp/cCkpx5Oye"
Content-Disposition: inline
In-Reply-To: <20261110085125.2535508-5-johan@kernel.org>

--oHhREp/cCkpx5Oye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 09:51:20AM +0100, Johan Hovold wrote:
> device_remove_software_node() should only be used to remove secondary
> firmware nodes added by device_add_software_node() but will currently
> drop a reference also if a device has a primary software node.
>=20
> Bail out early if device_remove_software_node() is called for a device
> whose primary firmware node is a software node and fix up the two
> callers that currently work around this themselves.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # I2C part


--oHhREp/cCkpx5Oye
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr3iacACgkQFA3kzBSg
KbYVlA//eYVad2Zpmxh/QuRS+B/qbudGpoSMFDnHOBSXK6XupJ3PxzwBXAJmw/6Q
akQkJ/g+CYk6/hQyCwLAJBzAYANuNIeWzOUhyqTJzAponfWe/d4RUPNbF6MFKCHI
pm1lany0cAHzJt9LRx3EQakVUcooGfxxDPYilwEl1RNM13wpf7o8LWiTDVgLHTBz
y9o0MvOg6hsCwYSnbu3gHRrhfYfyFJaeSoDioO9Ccdc++5RIcOK1UHD2PCmhg28I
AhOHk00RirYjWnyntbT33lSMnXqqjqsioHPrDHUrUXJ1q1Z4PFx+cn4Ys5wLiWjJ
KJnCIlyqZr8WiqZJtWAIjXCtbHHjLIm9Zd4Go/XMLqjNiZW2hUwEsJgEbgWKEpGe
47Un8/oL3+N/MdYCQIBWBtnlEPE09f2Q/MWjG/3Zg01ghGDFfQ/U8ESuskvsB8cK
WWjLc19kY855+WeUlX2i8jwazp1wKNXh7QNNEemvIFdHEyfRoigXVJqOCMlUj2PW
oGruNTMZa/uHf3wegYlBx6vEQqhTq6yXW529cmxTbpBZLj1DK5AY0olawHWoPSua
cD8cToEA2zk6LDaIRlnJeBJdDpP1nX273HslXo+AnO7x8uL4MhxlllJNwkpAXdE/
P/+kLEtTdRCMnUuCan03TvAdX6ttm7qytczd6ZraA/dp0hQUXPw=
=1BPw
-----END PGP SIGNATURE-----

--oHhREp/cCkpx5Oye--
