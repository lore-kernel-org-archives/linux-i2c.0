Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB92BEFFB;
	Sun,  8 Feb 2026 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770570445; cv=none; b=eteISJL04m+YxSyvDW889i+lJCRovv7+aZ+oFzP+77ajYm2qzqeGB+DWjDr6TjyKuZnBWVXf738LPLEliAbTeUhV9x7PGGTOPLT7jsULnmv++Oyks6kjC5hc9yiPk8bFq4AUnydsfHU3lNnWiHLvlsvnz0n+Bw+8Yo5KNVrDTGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770570445; c=relaxed/simple;
	bh=6Hu/RW4jpYfSrjKyDdckRE5CC7Xr5QjCEoswDpeYpYE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=aUuv1jh28Sr44WRHvW9wTqfFF2viDDo/TUAhOwVRLhEvGz2VbkZcJ7gPRPpCwUstXYFT/ikY0DJxpXHL6nFvW2X/BBW7b9Pf0zX1TIul8FqgVTDqptaJVi3y7YRtArKz18s8B4hovu2BdlJgpyU+Cp/ExHWl7gHupGEzH949OnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zwi0ZVXG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zwi0ZVXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E543C19421;
	Sun,  8 Feb 2026 17:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770570445;
	bh=6Hu/RW4jpYfSrjKyDdckRE5CC7Xr5QjCEoswDpeYpYE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Zwi0ZVXGVouJUwz9hWPjlEJKcqcPkesO7RHJBMgMFCmq2RASmi9gHQu+Eqkok1XTT
	 WwrWVBLnTuH15iH7ZFdnwFSf6pU3x35pm+hLa6lXFJaIA+wNwJCClND0n0JTKv1q9T
	 FzWuLLCjpeDkCx/uDcKo7f+qnADBG8BVaGJKBxwzGjnKm+s1n2svmjdr215Z3kqfZH
	 +RRATyLr/HIM7HaFZA7+NzdqGOQ3OAwegTGigRylq25vEmGH7cSamAIBUdn3XnTvj2
	 aUUH0JpXq50CFOHt01C05wiLXXgZpfrNIlYBmia1Xs28oz5+rMl7hlb/Quf4JoqfY0
	 P0tWBlgSH7aHQ==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Feb 2026 18:07:19 +0100
Message-Id: <DG9QU6ZMT9B8.HYIDD2GJGZUH@kernel.org>
Subject: Re: [PATCH 0/5] rust: extend I2C functionality
Cc: "Igor Korotin via B4 Relay"
 <devnull+igor.korotin.linux.gmail.com@kernel.org>,
 <igor.korotin.linux@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Wolfram
 Sang" <wsa+renesas@sang-engineering.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
 <markus.probst@posteo.de>, <brgl@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <driver-core@lists.linux.dev>
To: "Igor Korotin" <igor.korotin@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260131-i2c-adapter-v1-0-5a436e34cd1a@gmail.com>
 <DG2UELGNDQDS.1LR5TLOZTSC29@kernel.org>
 <70302f35-918e-4dc8-b4f4-30b86064251c@linux.dev>
In-Reply-To: <70302f35-918e-4dc8-b4f4-30b86064251c@linux.dev>

On Sun Feb 8, 2026 at 1:34 PM CET, Igor Korotin wrote:
> Hello Danilo
>
> On 1/31/2026 2:26 PM, Danilo Krummrich wrote:
>> (Cc: Bartosz, Greg, Rafael, driver-core)
>>=20
>> On Sat Jan 31, 2026 at 3:12 PM CET, Igor Korotin via B4 Relay wrote:
>>> This patch series extend the existing I2C functionality with:
>>> - Abstractions allowing to implement I2C algorithms used by I2C adapter=
s;
>>> - Abstractions allowing to create and add new I2C adapters;
>>> - Safe wrappers upon I2C and SMbus transferring C API: read/write
>>>    bytes/words/byte arrays.
>>>
>>> The patch series contains additional new sample driver `rust_i2c_adapte=
r`
>>> presenting the new functionality.
>>=20
>> The i2c_adapter code on the C side has some lifetime issues, Bartosz loo=
ks into
>> resolving.
>>=20
>> My biggest concern is that struct i2c_adapter is a bus device implementa=
tion,
>> but does not use the reference count of the embedded struct device.
>>=20
>> Instead, I2C bus drivers embedd the i2c_adapter in their driver specific
>> structure, which is typically freed in the I2C bus driver's remove() cal=
lback.
>>=20
>> This violates struct device reference counts.
>>=20
>> Until this is fixed, the Rust abstractions should probably work around t=
his, to
>> subsequent painful rework.
>
> just to clarify what is currently implemented on the Rust side.
>
> The Rust I2cAdapter is required to be bound to a parent Device<Bound>.=20
> The implementation keeps a reference to the embedded struct device=20
> inside struct i2c_adapter for the entire lifetime of the Rust adapter,=20
> so its lifetime is tied to the device model.
>
> I am not entirely sure which specific lifetime or refcounting scenario=20
> you are referring to. If you have a concrete case in mind where this=20
> would still be problematic, could you please point it out?

The implementation on the C side does not consider the reference count of t=
he
embedded struct device, which is not correct.
