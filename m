Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6625D263F44;
	Sun,  8 Feb 2026 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770554108; cv=none; b=JMrD6rd5/UuDGBp1OD8GAHhkw+jK2pqNxVLi/eb6jQU+Z+1lzli0wra9w84puTEmuFBLsZ5Ltc6NdD4ecs3Rn2GBMZhsysJ3vPs+UlUc3hzIWNnbt4g/GyRI8Mwqe7hYsIctzoxyl+3ki7Sa2l0Filk8l3+2m4cmV83Io7CZ+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770554108; c=relaxed/simple;
	bh=juguovnNh5Dyvmv7EuaALJ6VLYEM93Of1tPlNEETgPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkEypZTvIEEZSaaLZ16D6OqnReCVGSLAgdkxdQbPv30TaC51dskFA00wTkbwGDo1mFjeAHqr4HwNpu3V9DOYYZoCxV7Ydoo6wFUwnGN5LUQVDpPoqxQFus03GArFK8TvsfGhab84cHbiOM77WHv/ipcIBv8hvErFM8CMlLoHXqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z5ZEDnby; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z5ZEDnby"
Message-ID: <70302f35-918e-4dc8-b4f4-30b86064251c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770554096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TQyY62mNFaoAbw8K8f9cLsQDP0nS5guZ05j72G3wQM=;
	b=Z5ZEDnbyEthFJv1Cd2qyVLTaRevsYYIR7T6PuG+KvaIb/hsHF/q+5uVYypHvtakASn2TU/
	Y9z2a8+oGx/O7wZ/f570iZZo5JbsJzzjwNJAMxn3x2ZHTaBpA+4rEjw2KwV8z+pL0E2o9E
	k+FA5wkeDVa8/mqQTkMUlj0z6Zp83v8=
Date: Sun, 8 Feb 2026 12:34:46 +0000
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] rust: extend I2C functionality
To: Danilo Krummrich <dakr@kernel.org>,
 Igor Korotin via B4 Relay <devnull+igor.korotin.linux.gmail.com@kernel.org>
Cc: igor.korotin.linux@gmail.com,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-i2c@vger.kernel.org, markus.probst@posteo.de, brgl@kernel.org,
 gregkh@linuxfoundation.org, rafael@kernel.org, driver-core@lists.linux.dev
References: <20260131-i2c-adapter-v1-0-5a436e34cd1a@gmail.com>
 <DG2UELGNDQDS.1LR5TLOZTSC29@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Igor Korotin <igor.korotin@linux.dev>
In-Reply-To: <DG2UELGNDQDS.1LR5TLOZTSC29@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hello Danilo

On 1/31/2026 2:26 PM, Danilo Krummrich wrote:
> (Cc: Bartosz, Greg, Rafael, driver-core)
> 
> On Sat Jan 31, 2026 at 3:12 PM CET, Igor Korotin via B4 Relay wrote:
>> This patch series extend the existing I2C functionality with:
>> - Abstractions allowing to implement I2C algorithms used by I2C adapters;
>> - Abstractions allowing to create and add new I2C adapters;
>> - Safe wrappers upon I2C and SMbus transferring C API: read/write
>>    bytes/words/byte arrays.
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
> This violates struct device reference counts.
> 
> Until this is fixed, the Rust abstractions should probably work around this, to
> subsequent painful rework.

just to clarify what is currently implemented on the Rust side.

The Rust I2cAdapter is required to be bound to a parent Device<Bound>. 
The implementation keeps a reference to the embedded struct device 
inside struct i2c_adapter for the entire lifetime of the Rust adapter, 
so its lifetime is tied to the device model.

I am not entirely sure which specific lifetime or refcounting scenario 
you are referring to. If you have a concrete case in mind where this 
would still be problematic, could you please point it out?

Cheers
Igor



