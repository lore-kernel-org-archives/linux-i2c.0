Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792685133;
	b=dbeXk+CZbYSluFWSm2PWj8XgiFK24nEPKXDTQIicOW3ZFFQc+7MObTNjfpKJLHFjPi4U
	 BkC/A31DMLeF/jgQQed0jWyjnUGTildHPtzi3pPI/Q3lxixRImSqf++kr5pf7CUikde4s
	 d2zLk8RwDuk0Pv+v3eVj7iLZzhaJbthP/O76Xsnx3sWABAL9Egn8Sg0xX761F9RZf8NqK
	 C+sNDsLmHuH5hO8aSZxACzfS/8DJAPYs1vDVhhIJjKNN63OEmnTofWwEzNtC2KzZc9yKw
	 dbCNs13QaCY2ZXWPErKUSJ3HhDeBPHGwhUrjC32K0KAd572KWwUKYHXv2uJS90FDLYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=mocTbU6QYoGmhL7dstIxBqOB3/wT12OUsHUZqXTiEeg=;
	b=R4osMRJKiqZANe5i9snOs0BrY+kG59CmYAGfdZ8/h/8NHt4idb0FP5rQ609um6d1Wm4I
	 WrUJYBp5VoMtSNPG/QINLuqD2gwyzceb7SDEqLqu9mWZVF74m8glHgbm9KPFgCLRS2Wjq
	 MYExtHFVlx8cSpzQC6B6haCWBNy20cVDrRN4miYzSr8YT8VQusw6sV9YOWTY6uKtTYi6R
	 A5H+jO7pCdSXL0UuTXYHKeenHvLxLJyMmvnrGeJv+OY9/xEop37z0gjCg48TET4gXVs/r
	 yUPSmJUWdLNmzynNNUlSUYCBEQ1D6x65xIMbi97BxeSqlbHGBwY3tkgUyLN24CmTIzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=po2Ejtmm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB534606A31E
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 16:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB534606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=po2Ejtmm
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ab4354db11so15087241fa.1
        for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 09:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792685131; cv=none;
        d=google.com; s=arc-20260327;
        b=kgM6n3OYmfj6u5l54OR0H+600J5Bj5uHiBDB+qOXhOEQuGj2hl24+WWKU884w8iXzy
         y1ajMWf7S4atoqrIut5G9xuCS8fpAjWcKJDDvt+4Ho381+nLfF1dEm42keDHDPdafX7/
         UQy9wO3g6fogyaNuWAe1FHKVou3ePTR4Dk7DcmPgRByt78t81+yKXFeKxxxTFoPREwlb
         TfoXzNrcVUacXPTm5bPH5Mv3RpZ2TAoPqGLURwJAf2GjTxLXJRvS8aMujafXnoQNRNhe
         L3M9Nnt/ltjn0zfuqTWXHlWLTMgbIO9h62IxSNdRjWuSftxyf5brOlrzIFWH+JlHnH2I
         hDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mocTbU6QYoGmhL7dstIxBqOB3/wT12OUsHUZqXTiEeg=;
        fh=PlzztJJ7idhSUkOln7FcaZE97/qy9883w+zj7/5gGZc=;
        b=qLsA3fc/z44QDnKBkjN1xIqtODgLwpeMv8c7+2nzVSqaMhaZV1QhW55cDyOEVe4q+c
         TZwvCrg0Tr1EcPvkJ8AtPa9uVNJYyxezMrtz3aibeikFxk2SBVzjeu5EyQgnBpr+NQw3
         59lfoM6eBPMx6kIKmYzPb+EHE3a5f5jHwq6TdUBRXsxroho2qRXkRvjPTTPOY5I+ZG8V
         C/ktW41uae9aRrSCvBpPxnykAjuNpAXodyAp7PddwyYsyMCBvxgZ4Z5sipi0+fUuxSh8
         WTISQzNV3zhYZsU24d+OxIegE98SlhFvkYiOFdjxPeqPApVM1QtNwcQ/lM18K5yjGJmL
         f9nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792685131; x=1793289931; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mocTbU6QYoGmhL7dstIxBqOB3/wT12OUsHUZqXTiEeg=;
        b=po2EjtmmhjEnBHkbQa505xq9tldXRzLLiYUKajpmJEW6SybEo90CZ0lqMjVa63jsZc
         hBqO+hVyyfp3yMA3aOmJ/rYRiZTHJeyhNRuTBX5d7el4UNaAUSpUj0iajRk30E1ugAdr
         2G4T5gLJtkMgJThjAbkjcfdONnuZbru9nEP8pIO/2nmPriJoUBZnQekt5x2y3lec11md
         bQ7OfvBEGTrDvpc0tQtmEBfFcnEXfoKGYpnbVi8qY5k+7PRNl6d/wifiA0bHvzixl07I
         pvFROBWdh0rZOyDKhlPSor8xwgaeSIbOVGatbpAHmH/8+VTlGB27UgUCaThtBfsY4u0z
         WE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685131; x=1793289931;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mocTbU6QYoGmhL7dstIxBqOB3/wT12OUsHUZqXTiEeg=;
        b=YyDgo5/7c/z5g7L1Wld68ebbgglEhOLV7rL/EUGuTiJ4ABDxYsXvVKRprjtn7VcPfp
         AfzTx4hRTq7RbDa/aqGdiSaqTBB1li8Jeodrwsqv0YIKlZBcb6NfFv3wwCSqlPfgvDvx
         fdKdFr6dVdmutw9yIFpKJH6J85DNO4h3lQa5idlUButl25Z90fHB+yJdItB+eHwOlhF5
         +peuzf88O4n/MGxzA84Kmf5i64Y6QtxhGqARcSgXGtCE5B3EfcgAknFhUSlRq34FbCoz
         s4GE8i6ikB96Xqs2gGW3DiHlyYDrXHP4aqYjFsI0AG7aOBvh6RRGQZDLX2NlKYDSzyPX
         bw7w==
X-Forwarded-Encrypted: i=1; AKwUvBwdsELoG6AL+AKNALHUgsAy+uZ1TvKKVwIMwh0nPF12o2LwSZxtAGTUBaE6KZrT2VyFzaWFI1/rZJE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1sWZHBRsH/4UVoWbq6mpjYqVx58jmcqqJ2AXPaSxTunY2l2Ay
	82Di2f/q6Kq4ADBKkwxulk4/W/FvC7WILCboxLHztTt7nt83vjTjSqakMTat3iAYl0xdMtdJB3o
	WW8NKJCh5MwrkfBwXtOTQTRy0EmUplnM=
X-Gm-Gg: AYBFou3d0fpBAoosOFZLoD678pYBQCeEUiFJAnooF0cVRqYOwiYkHbTkAmukhMzWNEX
	76/H4YY3+DoG2C253K6Ocebl4/5ZhtRu47/zMWueeY2J5xpbcE/Jrbsws/uxN05SKWrtO9kJ7W8
	5HEKPibcXXG6xQA1j0QflaDF+4/EuhE4zhQnq02imBXrfu5PJC+tHeJOHXETrd0gH9NBGACfJV8
	IdnP75x0w556npUonhXlunAGoJ9MKN48R5P/X9ZVCUWRSLWRAiyorIII75tOToWPfD2xqxuDDV/
	5pQyxpfttHTi86m5A6r1f5JXAeBls3+GMpfp9zKV8i/8FfWk5ghT+gWBBQXKfYr48l1pesKlpN9
	lx3AoEqx4wwg4WP5dZ7w2SZ20PaDSvCa+7VZHog==
X-Received: by 2002:a05:651c:c01b:20b0:3ab:3f1c:c2c0 with SMTP id
 38308e7fff4ca-3ac441adcf0mr12071131fa.22.1792685130710; Thu, 22 Oct 2026
 09:05:30 -0700 (PDT)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com> <179260197668.3127.18219777718091081046@linux.dev>
In-Reply-To: <179260197668.3127.18219777718091081046@linux.dev>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Thu, 22 Oct 2026 23:05:18 +0700
X-Gm-Features: AclHuK-_6y3CZAcHO0wx7PGRH7qXj55F0nJkQUzx_zuArGiTC_UADw4Zf8xvi5o
Message-ID: <CAO26r3QK+Q5=JR5TeMzEX-WiLpgYWd8Zn0O1qx11LxTgN96BPg@mail.gmail.com>
Subject: Re: [RFC PATCH v6 0/4] iio: position: add Rust driver for ams AS5600
To: Igor Korotin <igor.korotin@linux.dev>
Cc: Danilo Krummrich <dakr@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Mark Brown <broonie@kernel.org>, Brandon StJohn <branstj@gmail.com>, linux-iio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 23:59, Igor Korotin <igor.korotin@linux.dev> wrote:
>
> Hi Muchamad,
>
> Reviewed the lifetime/teardown contracts you asked about. read_raw() has
> a problem: it takes parent: &Device<Bound> and recovers &I2cClient<Bound>
> via TryFrom. That conversion just got removed upstream ("rust: i2c:
> remove TryFrom<&Device> implementation for &I2cClient", use-after-free,
> unrelated thread), so this won't compile anymore. More importantly, Gary
> Guo made the point that needing the conversion at all is the actual
> design issue: a class device shouldn't reach back into a generic parent
> reference during a callback -- whatever bus-specific resource it needs
> should be captured once, at registration time, and handed back via its
> own private data.
>
> Concretely, this means dropping devres and letting Data<'bound> carry a
> borrowed reference directly, which it's designed for
> (Driver::Data<'bound>: Send + 'bound):
>
>   pub struct As5600Priv<'a> {
>       client: &'a I2cClient<Bound>,
>       #[pin]
>       io_lock: Mutex<()>,
>   }
>
>   unsafe impl Send for As5600Priv<'_> {}
>   unsafe impl Sync for As5600Priv<'_> {}
>
>   unsafe impl IioDriver for As5600Priv<'_> {
>       fn read_raw(&self, _chan: *const iio_chan_spec, info: IioChanInfo)
>           -> Result<IioVal> {
>           let client = self.client;
>           ...
>       }
>   }
>
> In probe(), capture the client once via deref coercion (Core -> Bound)
> and split the driver struct so the registered IIO device carries the
> same 'bound lifetime:
>
>   struct As5600;
>
>   struct As5600Data<'bound> {
>       _iio_dev: Device<As5600Priv<'bound>, Registered>,
>   }
>
>   impl Driver for As5600 {
>       type Data<'bound> = As5600Data<'bound>;
>       fn probe<'bound>(dev: &'bound I2cClient<Core<'_>>, ...) -> ... {
>           let client: &'bound I2cClient<Bound> = dev;
>           ...
>       }
>   }
>
> register() then just returns Device<T, Registered> directly instead of
> transferring it to parent devres -- that transfer is what forced T:
> 'static in the first place, which is what made storing the borrowed
> client impossible and pushed you toward TryFrom.
>
> I built this end to end against current rust-next: compiles clean, zero
> warnings, and zero changes to rust/kernel/i2c.rs. Happy to send the full
> diff if it's useful as a starting point for v7.

Hi Igor,

Thanks for working through this and building the changes. I'd be glad
to use your approach for v7, and I'd appreciate seeing the full diff you
offered.

I got the lifetime model wrong in v5 by storing an
`ARef<I2cClient<Bound>>`. I only realized that while fixing the
documentation for v6. In v6 I stopped storing that `ARef`, but ended up
relying on `TryFrom` in `read_raw()` instead.

Storing the client reference in the IIO private data rather than converting
the parent back in `read_raw()` makes sense. I'll check the lifetime and
teardown details as I prepare v7, and I'll acknowledge your contribution.

Thanks again,
Coirul


> Cheers
> Igor
