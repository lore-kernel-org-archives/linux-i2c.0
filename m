Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14663309F13
	for <linux-i2c@vger.kernel.org>; Mon,  9 Feb 2026 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770636675; cv=none; b=kexEh4O4MO8fYtUExx8JxxGpq8cH70j/LqwRh6rlGT/POlXQ4KTrDs3VAp3G8wiWTBRaIejB5ucV5AxSTuPn2w9aMIxT3b6o/smG/jms86p1vJFkzQEF46OtNUYT0zPsVGTeizZeUvLrBq8SEjFffDvYa/t7bNbtVzNkhF1H0l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770636675; c=relaxed/simple;
	bh=F7CgYeYFczAzufbFEfMETyEe9HD9YnDdtisLZR34ADQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfrIT+naUzWdWzli/b/QddE+AehSX4Uzo2CimXXsuif2rdO5B18HOkbmwYITctkOVcAR0IRxVXwttVtQz8aFLoiKJjE83Y889Lpu+z/kz6QIdxUe1uH0/7gcOOKMaWfi0+HlW9z/cuvmIuFN5oTQjF0T7OrqUwmssvwOG7GAjTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhXJqY7p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhXJqY7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F3AC2BCB4
	for <linux-i2c@vger.kernel.org>; Mon,  9 Feb 2026 11:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770636674;
	bh=F7CgYeYFczAzufbFEfMETyEe9HD9YnDdtisLZR34ADQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=VhXJqY7p+48InMR3+GrsHgpinSngqGHWnP3WEZ8D4Ziwl0mD1ljFilJxmLKOKcSXE
	 s8hhKQA0am/e0uRixyXxP0XqqeLZcBUorl3N4Til3E2XYSUHTNUW38yA38gyfeU1yT
	 87I78/9AFhwd7GeIR/PKRl8JSYwoD6JpOHcELQ3eLSw9vNAyob8qfEVwf/4g0O52xS
	 bDHzfUg+7lglPWLLZIV9fyS0yR8++5Rvpv+pYU/e8Day02CeOSH2UJ84OFxxv3wUcW
	 kBOCu9bqiPOEvpLIM4vXVyAqJg76jFFuotXoyjyX7KcKVAs9BreStfM2eC5ndqgBqr
	 Na0hFZtKbXW/g==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-385bdc72422so38618961fa.1
        for <linux-i2c@vger.kernel.org>; Mon, 09 Feb 2026 03:31:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX72xgynPJG2mbai8dlXbGmA/YmZqfABSS/bE7YQ2BQFfb0O5yJTyxMRTPQarbT5YWgnfqZyhbFcjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQBR4HgEpjpJS9q6J6SifhD2sNjAQBRvXQ8uy9Vv8dz7R1z06c
	RP+WZhTxh5mj9CYFdkOC+e2DE4+5vILxRMToUajp1HHEuLFLe2+7fY3tqPG9ggJ49FK3Bzt2zRk
	SFNyZFmFOM03SOeDiE/NU1AgJNZEYSQRt1tEOSHqh6w==
X-Received: by 2002:a2e:bc10:0:b0:386:e765:e359 with SMTP id
 38308e7fff4ca-386e765fff6mr1384061fa.12.1770636673314; Mon, 09 Feb 2026
 03:31:13 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 05:31:11 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 05:31:11 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <DG2UELGNDQDS.1LR5TLOZTSC29@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131-i2c-adapter-v1-0-5a436e34cd1a@gmail.com> <DG2UELGNDQDS.1LR5TLOZTSC29@kernel.org>
Date: Mon, 9 Feb 2026 05:31:11 -0600
X-Gmail-Original-Message-ID: <CAMRc=Mc8x4gZu-ALA_c85djWHT6TinBK3KuLGQqMALWA477bMg@mail.gmail.com>
X-Gm-Features: AZwV_QihqdBsSecx2hKeC8xcTUDilEQ9rqhBDbEDj7GnSFAOP8qJjVk8adtyk-I
Message-ID: <CAMRc=Mc8x4gZu-ALA_c85djWHT6TinBK3KuLGQqMALWA477bMg@mail.gmail.com>
Subject: Re: [PATCH 0/5] rust: extend I2C functionality
To: Danilo Krummrich <dakr@kernel.org>
Cc: igor.korotin.linux@gmail.com, 
	Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-i2c@vger.kernel.org, 
	markus.probst@posteo.de, brgl@kernel.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, driver-core@lists.linux.dev, 
	Igor Korotin via B4 Relay <devnull+igor.korotin.linux.gmail.com@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 Jan 2026 15:26:22 +0100, Danilo Krummrich <dakr@kernel.org> said:
> (Cc: Bartosz, Greg, Rafael, driver-core)
>
> On Sat Jan 31, 2026 at 3:12 PM CET, Igor Korotin via B4 Relay wrote:
>> This patch series extend the existing I2C functionality with:
>> - Abstractions allowing to implement I2C algorithms used by I2C adapters;
>> - Abstractions allowing to create and add new I2C adapters;
>> - Safe wrappers upon I2C and SMbus transferring C API: read/write
>>   bytes/words/byte arrays.
>>
>> The patch series contains additional new sample driver `rust_i2c_adapter`
>> presenting the new functionality.
>
> The i2c_adapter code on the C side has some lifetime issues, Bartosz looks into
> resolving.
>
> My biggest concern is that struct i2c_adapter is a bus device implementation,
> but does not use the reference count of the embedded struct device.
>
> Instead, I2C bus drivers embedd the i2c_adapter in their driver specific
> structure, which is typically freed in the I2C bus driver's remove() callback.
>

Correct.

> This violates struct device reference counts.
>

What's currently done in order to not crash is: we wait forever until all users
release their references[1].

> Until this is fixed, the Rust abstractions should probably work around this, to
> subsequent painful rework.
>

The rework of the C part will be long an painful already. I estimated the work
will take at least a year. More info here[2].

Bart

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/i2c-core-base.c#n1814
[2] https://lore.kernel.org/all/aWYYZEPX-_1GfQtL@ninjato/
