Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CCB33EB02;
	Wed,  4 Feb 2026 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224387; cv=none; b=HmDPLjT5BoTUNcTYv+Ne5kyh33+LjnM5VJG84RfuOEqgUsbV9Ce1SWj/XmnWVHIi27a7eoU3nJgXC8UxEbdDnpL2ei+4/425lTpsCTjAqAf3BGo/z8VbdAyhzVpSvMfL9QwKETo+4T/9k4cEaujGH2bKBK9nl2iReVPxM+QAfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224387; c=relaxed/simple;
	bh=L0TT3ecTWhRMB3+CbnOIUieR27tk24jI06GH3CoruE4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=bn5VSOYmx/5E7oxEM0kim8eBpux9IiTMFffO2+ZLyrQjwwDUR+GYkd1smLeplIxEAIyjQIY3XF9+c7eYf00BAf3Vs43Dj5R2b0/cc7ytYfdJ/Ec/Evqz16EKIV8jNV5DxIT+KWIt7JSmh3EnYelisBV2z36HoFM13sXVvB/PNsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaWmHcUb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaWmHcUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F90C4CEF7;
	Wed,  4 Feb 2026 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770224387;
	bh=L0TT3ecTWhRMB3+CbnOIUieR27tk24jI06GH3CoruE4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=jaWmHcUbDproAyfuwmig4hvKUyBxc8F5Z12FbzlEheCanbQgqoqbGeIO5Wy8PTLEJ
	 uef50Vk3idSiL6ti3aGx4v+7K5k934iSgDXps98J3fGrvTuaMOCevWUds4kr0DCRAJ
	 a3hjFa/OdtqIfIjWo6iazvWAFv7WuUiAbgTgc0fNR7txDgNeIlJDL9s3UbZfReMghX
	 QN78Q0URQpQVQkTvTdtwJcoKlTpe5enQRJ/TuCSTAZMe2yIr8vkFEj+98gw7S+3iEO
	 aKEbjwCowVqHGkALslf/jQAa8RQF4ZgQWdmxuXRNqktjGtYroO4bIJNdOC1AoyqxEp
	 u07iLQMZjdw7Q==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Feb 2026 17:59:42 +0100
Message-Id: <DG6C66CP0EB4.25ZLDO70LFB7K@kernel.org>
Subject: Re: [PATCH 4/5] rust: i2c: add I2C wrappers
Cc: "Markus Probst" <markus.probst@posteo.de>,
 <igor.korotin.linux@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Wolfram
 Sang" <wsa+renesas@sang-engineering.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-i2c@vger.kernel.org>
To: "Igor Korotin" <igor.korotin@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260131-i2c-adapter-v1-0-5a436e34cd1a@gmail.com>
 <20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com>
 <4b6d9f389862aa4d2c43394cdacde059c4cbba5e.camel@posteo.de>
 <93559442-38a9-4b6b-9cbb-7bb500ab1738@linux.dev>
In-Reply-To: <93559442-38a9-4b6b-9cbb-7bb500ab1738@linux.dev>

On Wed Feb 4, 2026 at 5:49 PM CET, Igor Korotin wrote:
> I'm not sure it is appropriate to use IO and register! here. I2C devices
> are different. Not all of them use register like access. For example=20
> EEPROM I2C devices allow random read/write operations inside their=20
> address space. After all I2C doesn't implement the same way of accessing=
=20
> its memory space as for example PCI devices.

Conceptually, it is not different, it is some device memory connected throu=
gh
some bus.

Memory mapped I/O allows "random read/write operations" as well, see
memcpy_fromio() and memcpy_toio().

The same thing is true for DMA memory. While it's not owned by the device, =
it's
still shared with a device.

Gary just started working on a generic IoView<'io, T> type which will serve=
 as a
general abstraction to interact with any kind of memory that is shared betw=
een a
device and the CPU [1].

So, for I2C this would mean that if you have register like accesses you can=
 use
the register!() abstractions. If you want random read/write operations, you=
 can
use IoView to copy from / to system memory or even to a user buffer directl=
y.

Of course you can also still use Io::read32() and friends.

[1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/top=
ic/Generic.20I.2FO.20backends/with/571786051
