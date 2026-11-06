Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793979918;
	b=NkCO7tplVWjys/GpCeWyubaczK3d+JuvEm0gh68MSUiUXRCHfOFvUzNS79CdBpmzWVUY
	 XwcWCOxFXB4l1sMfcSFxAIWhjvHI274Us3AvJLS92tzoDVYxQKNebW7VbkvaA5tDAOTNS
	 6tWRMkSYZZX0TcJQV7zKrYX4BtmcHof+N0DpTxrBeVgPIkeGa+8E5VKmUqe0nafUlbRVt
	 GC2Nin89RGX6Hx099asHqrx9fvlxMQ4obn3EQGXeDg1et8csOwbYk9mRiU3s/J0SKzXWZ
	 n+0EGhn0dPdzL8k2O808yTNwNvYbP8XtDdjE1ojS6ytJA8Bdm3ElCb2+2/Qc9sTGwnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=l5tSVn8Mj/CO6j1uR03XuID6rPx5lFsALyBs+/EQOlk=;
	b=XWEaFE9shDw742EIjLXa8xxaPCg/7bLSlsEqxRAQD2Xeta5jSSvDhws8KwP/QyXYSoZn
	 GZuJO8CLRhHpqIkHeb1VwG4y7EuQyJZOp69x82FMluAWM2eDngPSClZeIQ1kSJ8Sjgl9m
	 n4wK/LUclGqfAwN9UujhB4GOllKM46huwRQSN4UVQpzt6Dit5agBl7EWaTtR3phFNbIcO
	 cKbhg+iWsSYJ1bYzH0Hpw3nNTVJ0JF/eLxDLa69EjiJHyJIeTRZnmU7DhdlAwUTzYyuzk
	 AOSOurv4F8s+/8QFHdKAK0386SB8/7/4NumeFvRSX7b5kY6E1Zc7CEInIvLzmgLX9AA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVCIfsqA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CA5606D80B
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 15:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05CA5606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVCIfsqA
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ac99992373so5685721fa.3
        for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 07:45:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793979915; cv=none;
        d=google.com; s=arc-20260327;
        b=GXYfQ0XdATbeug/9uixTFe2neYssInALZC9MDsMfCCGyBmey5f4cJpBoDKETfvo6LM
         S56XVKJbfRwTn9COlfGNz10P95WHN+c0r7vvzksmB03gbaBAWZUozvqGsRwM48C8vE7m
         IjD4f3Z5KuIiBQfBtyrTz5ZKOoP5WkvBCP1Czmph4CISwDD+mYI9oqH47UpogWDWh/eV
         4MSpQZoDqNNfomXT8FJMT+Kg3JcpiDgcSbTsRGeETPuNdhIb6IQk/P4ruYzsSOoorEqV
         XE+MUpDb53knNMHzwnFVSnP+ci1c21ouqbtMFMnoiPZr2m2+xd+1ViaTIAtB2OSjWhaL
         klxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l5tSVn8Mj/CO6j1uR03XuID6rPx5lFsALyBs+/EQOlk=;
        fh=xPMA8vMySxz0rhTHIZYcAV7lRWyASeCKhS8T5CTyn/U=;
        b=qiCw6YZtKfWozDwWN9S4lzSagxxu4oP8gxuWiuFfEXH0Lpek6tJ4fuXWFyOt2GRvLI
         lLzpswgCd2vLUWyI156hET5eOzKtDtUQm0KAGsyRjO6LIAVF3XPGi7lAomgwynFr0Wmq
         gD9A2DUg8+jVAWz5aDcuKGyupLmd0If9WYxz4o1aE2L7FbDE0AgAoMm5fxXTqPkYUefX
         5/L93c0qqqqk+CDtjs/KxGmpE8/XXL9gB0xpk5FaOe6x94CZQ5VNAg9N9wEoKD3w8NqZ
         ARkUeUkVM/tEi6l0V+ht3zQUlpGoHNcusRkpFkdAmIWXL+sWQMmg/G26H0iVx8y8bWyv
         ikGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793979915; x=1794584715; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l5tSVn8Mj/CO6j1uR03XuID6rPx5lFsALyBs+/EQOlk=;
        b=PVCIfsqAf5aued+4UX32Kej7j7opbHVpjVXl5FZhp8j7wmRx+DasE0lzqCRuCo3clz
         qpbZownOonc5iRdpEU++sYYh99mbKPzkdcUIBKSCWol08MUuBedGLqibNKlos7VlUh8r
         7A8x1Glzqk56FB6vNv9Ay8IAYUnQcclrwpbPUNZyW2agundbnQWocEB+qhdWhxiy0Ggk
         OlnGvRba4fyzYD+DqcHCtBwKjxZ+t+hgEhg38kUVvHd2alHoa4rKFCAGAJ6as4EvXDZb
         MrDVN32K6YE4CsqwBhQfmd3ez5azKL4hFjGjVZyDnPpHWxOysMEkGFCjyPG47s4ObB3R
         evmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793979915; x=1794584715;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l5tSVn8Mj/CO6j1uR03XuID6rPx5lFsALyBs+/EQOlk=;
        b=Pu+U+lY0Dfc+uFI7rnr3gxds4EA5gtb00PYABrJHhFuumDMCsZSH/EWojianF6g5qe
         IP94Y+8Jg3gSGgmqUOntu6qBknqKRV6o495/4nH8LNWVAFNGdF2h6GRB/1Kid+Q58Vss
         vdIWQQ20ZriWV++/P+fpwTpqjZcuQuzCJNh/wG6n+LlWjvJMOoSChJUpHM4vaHlsDHhX
         7RwdkuAc9tAW4lhddu+e4WExWM95BOEb5cBezEDmfjIB4U7TcKVvgb9TA2pVJK483htg
         TRONFrHbLpoh1YnYXOxiULhHZ+HTSYEmV5KWGuB1tr2G9l8OqOibWGWkKa5Ch5VzxSGU
         SAcA==
X-Forwarded-Encrypted: i=1; AKwUvBwlUXZF0qV3sUGnpUDrS6poZAIADjiHfRQUoIus1z1aMqSxRKlazst1EKIGfcA/BgVlV5LuJrsjGVI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TOJy9WpiQfhT3eUBhYadttltaPb7HD47gEfLJd13IZcj5n+zs
	sWOO+TQljrRww9DsjslQbABdrA79Lbh5x/w3o7HAX+xi3g+ElX6hU8FlwM0ddijctT2jQOxdDzs
	ntb9SAjXUXuzZ5r6XEyuRrCOLolYfEI8=
X-Gm-Gg: AYBFou3fIaos+2NvdMs0iURX7U5vLDHidMGIG7vhG3uTBdvBOokpgIf3nsquaKUSNTV
	HeURWV2dwbYOcUUAL3dHP9om9MQpooDF8GHQmQh2woTIeRvJWggCMD9dQQu6LPsyWC381Kpe5Vu
	qZU7MicM5+/0LRsY8ZB9S3+ZLNzqvgNBxw0BHvTaRy7Ki69GLDHmV9mV4zwemcR72/+LjVY9tHK
	rYPNcgf3BpfU16l2/t8X2ZIgCQtP4UbdAXbmJB7xObqVKYbgYd84qoxoBQyEYyU6AH3OphvEHOO
	OvPLVr0DTn0cmNLjKaLe3CZA2Tsv8eQhNrdH1DCvD1j7P7dvokSAsf4RWmV+j7SBCRj0RjflnHo
	MDlDNAadMZ/NHg1eChf7OcIlGvxwjRV9tjTtqbJk=
X-Received: by 2002:a05:651c:1612:b0:3ab:2a19:8624 with SMTP id
 38308e7fff4ca-3acf3a11804mr5879131fa.5.1793979914945; Fri, 06 Nov 2026
 07:45:14 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com> <tencent_173B7731E90B9624F9F82613DC3031B70907@qq.com>
In-Reply-To: <tencent_173B7731E90B9624F9F82613DC3031B70907@qq.com>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Fri, 6 Nov 2026 22:45:02 +0700
X-Gm-Features: AclHuK-XTflrXNbXUwnG9Gy_4IC-jvOmhlr3UlYx53CWnDfOKCsQP4T4U6VaP7U
Message-ID: <CAO26r3TMHb=YxzwS7DYDUTS9U454zrq05yC-b8ojva-pAdCsRg@mail.gmail.com>
Subject: Re: [RFC PATCH v6 0/4] iio: position: add Rust driver for ams AS5600
To: Shuai Liu <847807867@qq.com>
Cc: Igor Korotin <igor.korotin@linux.dev>, Danilo Krummrich <dakr@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Brandon StJohn <branstj@gmail.com>, 
	linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 16:53, Shuai Liu <847807867@qq.com> wrote:

> 1. clippy warnings
>
> `make LLVM=1 CLIPPY=1` reports four warnings on this series, which the
> Rust CI gates on. Three are `clippy::ptr_as_ptr` in the IIO abstraction
> and one is `clippy::useless_conversion` in the driver:
>
>     --- a/rust/kernel/iio.rs
>     +++ b/rust/kernel/iio.rs
>     @@ -202,1 +202,1 @@
>     -    let priv_ptr = unsafe { (*indio_dev).priv_ as *mut T };
>     +    let priv_ptr = unsafe { (*indio_dev).priv_.cast::<T>() };
>
>     (the same pattern at lines 334 and 397; line 334 is already inside
>     an unsafe block and just needs `.cast::<T>()`)
>
>     --- a/drivers/iio/position/as5600.rs
>     +++ b/drivers/iio/position/as5600.rs
>     @@ -133,1 +133,1 @@
>     -                Ok(IioVal::Int(angle as i32))
>     +                Ok(IioVal::Int(i32::from(angle)))

Hi Shuai

Thanks for catching the Clippy warnings. I reproduced and fixed them,
and the Clippy build now completes without warnings. I also replaced
the ignored, AS5600-specific example with a generic `no_run` example,
which is now compile-checked without being run.

> 2. ignored doctest in the SMBus word helper
>
> The example on `smbus_read_word_swapped()` (rust/kernel/i2c.rs:841) is
> marked "ignore" and references driver-specific facts (the AS5600).
> Ignored examples are not compiled or run by rusttest, so the helper
> currently ships with no tested usage. A generic, compilable example
> works here:
>
>     --- a/rust/kernel/i2c.rs
>     +++ b/rust/kernel/i2c.rs
>     @@ -841,8 +841,15 @@
>      /// ```
>     -/// // AS5600 stores the 12-bit raw angle at command byte 0x0C with its
>     -/// // high byte first, so the SMBus (low byte first) word result must
>     -/// // be swapped.
>     -/// let raw = client.smbus_read_word_swapped(0x0C)?;
>     -/// # Ok::<(), Error>(())
>     +/// use kernel::{i2c::I2cClient, prelude::*};
>     +///
>     +/// fn read_hi_first_register(client: &I2cClient<kernel::device::Bound>) -> Result<u16> {
>     +///     // A device whose 16-bit register selected by command byte 0x0C
>     +///     // transmits the high byte first needs the SMBus (low byte first)
>     +///     // word swapped.
>     +///     client.smbus_read_word_swapped(0x0C)
>     +/// }
>      /// ```
>
> 3. repeated unsafe blocks in the SMBus access helpers
>
> Patch 2 implements the `FallibleIoCapable` impls for `u8`/`u16` with
> five near-identical unsafe blocks wrapping `bindings::i2c_smbus_*`
> calls plus error conversion. Extracting four small safe helpers would
> put the safety argument in one place and turn each call site into a
> one-liner:
>
>     fn smbus_read_byte(client: &I2cClient<device::Bound>, reg: u8)
>         -> Result<u8>;
>     fn smbus_write_byte(client: &I2cClient<device::Bound>, reg: u8, value: u8)
>         -> Result;
>     fn smbus_read_word_data(client: &I2cClient<device::Bound>, reg: u8)
>         -> Result<u16>;
>     fn smbus_write_word_data(client: &I2cClient<device::Bound>, reg: u8, value: u16)
>         -> Result;
>
> For example, `io_try_write` for `u8` then reduces to
> `smbus_write_byte(client, reg, value)`. Happy to send the full diff if
> that is useful as a starting point.
>
> With 1 and 2 applied (and 3 sketched on top), `make LLVM=1 CLIPPY=1
> drivers/iio/position/as5600.o` builds with no warnings and the rusttest
> doctests pass.

I also followed your I2C refactoring suggestion and added the four safe
helpers as methods on `I2cClient<device::Bound>`.

Thanks for taking the time to review this. I'll Cc you when I send v7.

Thanks,
Coirul

> Thanks,
> Shuai Liu
>
