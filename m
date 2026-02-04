Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85A33C18E
	for <linux-i2c@vger.kernel.org>; Wed,  4 Feb 2026 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223797; cv=none; b=kLwFx4ytaaArt+6cImtPaU0x1YWZKMxb3OSW4pZWF1axGC+ZGp03TObiSAHJlaEP+xPYIBGv/B7SANzvqhz5H94Fkjw+eO6ATAyAeRdDQveDjeq0tF+mow2NwlkKRxxAq5KeANjOxXf5+o5Mw8o4aGBfK4/zy9JNGL4gEAtlvIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223797; c=relaxed/simple;
	bh=xm432Lcy+Vg/DVbgPpqk0++wflxIp7iQuBgLv1K8QUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8f1ywkmpHkLKkqoB8mny0JtiUb3sg60oXI6wQzOokPUuMOuF177sXkYSsxZLk4bw56FrFYc3Q1KCzQfNS6CJDOeLlRRQygMN/PlaRRoSOrNLkg/g1pUHqICWDyrJsuqFtMIqgeo+lUxlyFgJ8WnGiXYMSVkpFAxBhdRFNxIj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gh8iS+sd; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gh8iS+sd"
Message-ID: <93559442-38a9-4b6b-9cbb-7bb500ab1738@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770223784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZ3yaEuYA8SSB4hotfyih7rLcKK4+CgU/6Dm8mx7YIc=;
	b=Gh8iS+sdMLguHEZ0Zg7yQa/OWzlkt9sbfbX1ZhXBD/EVbEU0SHJUWWErzJfarQSiBj/xd7
	7mgPUSmwmi2D0fVTl0b44m0nAx71Dabm4RwujU6T1kYXgO/vEhyrHNXJ9y2MxEJwULK1gH
	cpJ8j1Mu/BYOFGlhQIrpmyKMY+Kk+Kc=
Date: Wed, 4 Feb 2026 16:49:41 +0000
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] rust: i2c: add I2C wrappers
To: Markus Probst <markus.probst@posteo.de>, igor.korotin.linux@gmail.com,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-i2c@vger.kernel.org
References: <20260131-i2c-adapter-v1-0-5a436e34cd1a@gmail.com>
 <20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com>
 <4b6d9f389862aa4d2c43394cdacde059c4cbba5e.camel@posteo.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Igor Korotin <igor.korotin@linux.dev>
In-Reply-To: <4b6d9f389862aa4d2c43394cdacde059c4cbba5e.camel@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hello Markus

On 1/31/2026 2:28 PM, Markus Probst wrote:
> I think I2CClient should implement the IO [1] trait instead, as
> suggested by Danilo [2].

I'm not sure it is appropriate to use IO and register! here. I2C devices
are different. Not all of them use register like access. For example 
EEPROM I2C devices allow random read/write operations inside their 
address space. After all I2C doesn't implement the same way of accessing 
its memory space as for example PCI devices.

> Also I think it is a little odd that read and write is possible, on
> I2CClient<Normal> and not I2CClient<Bound>. Shouldn't the assigned
> driver have exclusive read and write access to the device?

`Bound` can be safely dereferenced to `Normal`. Since `Normal` represents
the minimal required typestate for device operations, any API that works
with `Normal` automatically works with `Bound` or `Core` as well. Requiring
`Bound` would unnecessarily restrict the API and force duplication or 
unsafe casts.

> Thanks
> - Markus Probst
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/commit/?h=driver-core-testing&id=121d87b28e1d9061d3aaa156c43a627d3cb5e620
> [2]
> https://lore.kernel.org/rust-for-linux/DDDS2V0V2NVJ.16ZKXCKUA1HUV@kernel.org/
Cheers
Igor
