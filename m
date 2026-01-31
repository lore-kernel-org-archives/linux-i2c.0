Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77152357737
	for <linux-i2c@vger.kernel.org>; Sat, 31 Jan 2026 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869728; cv=none; b=kbY+PudiFmj/rtf1UM7LTueFt5h4t+zDFjwaMe/Cs7Y5gOjPj2z63Cuy8dzZN4iM91gUvgRO7TDulKfUwQKov6OWcaMmwErC/ArwhD1w7xbbS3lWJpycJJuBoL0gr0u8xF0rtvamxw7UQBwNGzcp23eSKQ6jGfufTg8UzvU+zRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869728; c=relaxed/simple;
	bh=lFJrLbT/Wc8MzAVdIkZLkx1CSp8QZQ6LtXlqsdGG5aA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nbuBdJJO+ERURQe+kOLvGwoa051/dBfCjm7zpUIohhyZPUi9IJRzkfBxrTJ/OMiCmKefMEKy2xmRl1xhF+su+KhcM4Cyob59QuUck4VKNfqOsNXsL74wAL2fm4WnK/1xIOQ1XmKT1dSS0hd1LoFNUIuIcmkiLKJvQp/H2SOE5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=l61UZjRg; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="l61UZjRg"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 53405240027
	for <linux-i2c@vger.kernel.org>; Sat, 31 Jan 2026 15:28:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1769869724; bh=kuKHHD3+ePgFfclbHvifBLpNHKVEZj4LTYumCFjYlMs=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=l61UZjRgyxMyTlRasyyV1GzX1rSPc8Zxpvd5XUqnXEuztyrVUaP+mbnUHqToEZOhf
	 7kSKCXwuhBe+xydOKVcFsV2zI75APub3qZQrwEljeWlYlk3kKEb2mAmMrKXS9mFuw7
	 30HcPQURy4wqGRZq4BuLdG4HatLh4h/yxfWi9vYPf53uOrXH2QAXNCa6OjksHrb5E4
	 tb+VgJARF2aaBb3YDlc3GrDiZRq2FBWFo7IBnddLEnscccbV3hRd7pg3anq3cTf07x
	 yn8NingKdjw4i4rGKDouv5ZaJUbTVwkQGXG4Yel7oslLzmhP10QmZBTaJdDYySmiyc
	 s/kCWaUGtZv+Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4f3FcB1tWHz9rxF;
	Sat, 31 Jan 2026 15:28:42 +0100 (CET)
Message-ID: <4b6d9f389862aa4d2c43394cdacde059c4cbba5e.camel@posteo.de>
Subject: Re: [PATCH 4/5] rust: i2c: add I2C wrappers
From: Markus Probst <markus.probst@posteo.de>
To: igor.korotin.linux@gmail.com, Danilo Krummrich <dakr@kernel.org>, Daniel
 Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng	 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-i2c@vger.kernel.org
Date: Sat, 31 Jan 2026 14:28:43 +0000
In-Reply-To: <20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com>
References: <20260131-i2c-adapter-v1-0-5a436e34cd1a@gmail.com>
	 <20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-RjHlur1vU57WUSE/Rso6"
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-RjHlur1vU57WUSE/Rso6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-01-31 at 14:12 +0000, Igor Korotin via B4 Relay wrote:
> From: Igor Korotin <igor.korotin.linux@gmail.com>
>=20
> Add safe Rust wrappers for common I2C/SMbus operations on I2C clients.
>=20
> These wrappers provide safe abstractions over low-level C API calls:
> - SMbus byte operations: read/write byte and byte data
> - SMbus word operations: read/write word data
> - SMbus block operations: read/write I2C block data
> - Master I2C operations: master receive and master send
>=20
> All operations include proper error handling through the Result type.
>=20
> Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
> ---
>  rust/helpers/helpers.c    |  1 +
>  rust/helpers/i2c.c        | 15 ++++++++
>  rust/kernel/i2c/client.rs | 92 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 108 insertions(+)
>=20

I think I2CClient should implement the IO [1] trait instead, as
suggested by Danilo [2].

Also I think it is a little odd that read and write is possible, on
I2CClient<Normal> and not I2CClient<Bound>. Shouldn't the assigned
driver have exclusive read and write access to the device?

Thanks
- Markus Probst

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git=
/commit/?h=3Ddriver-core-testing&id=3D121d87b28e1d9061d3aaa156c43a627d3cb5e=
620
[2]
https://lore.kernel.org/rust-for-linux/DDDS2V0V2NVJ.16ZKXCKUA1HUV@kernel.or=
g/

--=-RjHlur1vU57WUSE/Rso6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAml+EZAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPSSCYP/RyNmWraNdMQ5px99Xya
AySSuOc7bWlNs183TTeNFr8pULnZfeQOmCMATJUK5R+zEmE/S77ujAp9zaU6FcEl
Z00j+Z3O0voHdCT0kdmMSevX+sQZk+UJLhyWLf/26XZnnclQP27l0pMfN5CgeisC
cxcwP3zyZtjjesDK6/KFZ216pL+7JgIAO8LSTnwmzhMOZsOTB5QJO+uEQ6eIRA0s
r2+bt0hf5LfywgYCZEGZOcTWnklrGgIo8WbbBwylPEcz2zI+OaGgUwaOARE1wLfO
F3pW2NhblsEVjrAel19tytL8EtqUTdTYSIKXAYaJsest648Yc+M68U5RIUicoYW+
0bl4WUtIh9hzX2PgjretpIkKnzr7pT2Cckl8yfcZUy4HxjnHPpZvczS7GgNgmn2z
K5LUA7rxykADIHzBxh365wI3PafB3/eE9J6scJx6U+eRvOSA0JcEcZg0klY1sfQ7
LFOpOzHz3PE/AI/O8o6FXWaTUwUd0AQ5oBhd4NH4nZBpG5A+ybD48cu5Er01gaXl
bhc/jMBB95CrKgmr8hFubO+8U+luCEfntvoIPikzbQveTC7qpp2i2Dty33PxjkGQ
jJiQQ9BC6nQUpCBShuvVu8UOgh0m6YrTqfspq3hTMzneHjfziqz90XShGaLJ/MTa
Ex0GU0eCTrHPpfVkct5CvUSN
=nCdd
-----END PGP SIGNATURE-----

--=-RjHlur1vU57WUSE/Rso6--
