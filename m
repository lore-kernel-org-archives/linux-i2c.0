Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C611E9B3A
	for <linux-i2c@vger.kernel.org>; Sun,  8 Feb 2026 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770554700; cv=none; b=rJq+aIs+djje2BfTMAv5aaKNOtJBap14A1RkaUudTjWh7JG9jxuf5EyLf2zZS3h9D1+Ag3Ziud7/F1KU4kI8am4Y5BRyjQUxOcLVOefi7rx3Zzkja6ZggLmNWUp98627M4IYD0G2aOrhH8Op1Hp1F5Hso4R0fp2PDrOOpvTen60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770554700; c=relaxed/simple;
	bh=D+EUYBUZjIsc6u5gxPTv8LEey3MhOBiiMYBJSL6skcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxCBwQxHQoSPv3cjjQsMpV4RYn0FYuj5OlCyK+1s+UXIr5Brf+HOfFrm5yTsUrKi2ssZ5YAZKFPEQ7Lm+Zs514M169pKtS8DmyRaeL2bcfTXAYkPRCLHz/w3dXASTcrRPgg9XvfkmyuGP8NA9k/VODsovWvFPj/hXf5yjHkvKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YaxASlQ5; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YaxASlQ5"
Message-ID: <00b38d6a-a334-4e9b-b8ae-172f3ea16cb1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770554698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5pvPzHQRA687G7iFYxf5JKbuac/N6m1mxI8gk+AN1s=;
	b=YaxASlQ5lRZKoMi6lSwCy9V49yUvk5iKJt/vIGNlhUU7fzxTg7f4wSAaYU9Zbz1TRb6wNC
	qZ8nmTkzTxMOR1t8nc+xZBzRJfuf2WYpj0BKz6nMK9dOKZU7qOkOzIsgjstoRY/zaFI5zg
	+iOk6/44udOClRGPUxo9YrY+wN5Z7+E=
Date: Sun, 8 Feb 2026 12:44:53 +0000
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] rust: i2c: add I2C wrappers
To: Danilo Krummrich <dakr@kernel.org>
Cc: Markus Probst <markus.probst@posteo.de>, igor.korotin.linux@gmail.com,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-i2c@vger.kernel.org
References: <20260131-i2c-adapter-v1-0-5a436e34cd1a@gmail.com>
 <20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com>
 <4b6d9f389862aa4d2c43394cdacde059c4cbba5e.camel@posteo.de>
 <93559442-38a9-4b6b-9cbb-7bb500ab1738@linux.dev>
 <DG6C66CP0EB4.25ZLDO70LFB7K@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Igor Korotin <igor.korotin@linux.dev>
In-Reply-To: <DG6C66CP0EB4.25ZLDO70LFB7K@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hello Danilo

On 2/4/2026 4:59 PM, Danilo Krummrich wrote:
> On Wed Feb 4, 2026 at 5:49 PM CET, Igor Korotin wrote:
>> I'm not sure it is appropriate to use IO and register! here. I2C devices
>> are different. Not all of them use register like access. For example
>> EEPROM I2C devices allow random read/write operations inside their
>> address space. After all I2C doesn't implement the same way of accessing
>> its memory space as for example PCI devices.
> 
> Conceptually, it is not different, it is some device memory connected through
> some bus.
> 
> Memory mapped I/O allows "random read/write operations" as well, see
> memcpy_fromio() and memcpy_toio().
> 
> The same thing is true for DMA memory. While it's not owned by the device, it's
> still shared with a device.
> 
> Gary just started working on a generic IoView<'io, T> type which will serve as a
> general abstraction to interact with any kind of memory that is shared between a
> device and the CPU [1].
> 
> So, for I2C this would mean that if you have register like accesses you can use
> the register!() abstractions. If you want random read/write operations, you can
> use IoView to copy from / to system memory or even to a user buffer directly.
> 
> Of course you can also still use Io::read32() and friends.
> 
> [1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Generic.20I.2FO.20backends/with/571786051

thanks, that makes sense.

I don’t have a strong prior opinion on how this should look yet, so I’m 
fine aligning the I2C abstractions with the generic direction you 
describe. Using register!() for register-like accesses and IoView for 
more general read/write patterns seems reasonable.

At this point I’ll treat this as the intended model and adjust the I2C 
side accordingly once IoView is in place and its API settles.

Regards,
Igor
