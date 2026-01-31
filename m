Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D99359F9E;
	Sat, 31 Jan 2026 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869587; cv=none; b=OsrbrCs/iQSplrIFVYFvViOfaGygCaPg//Bn3E3h5nIt+YxBwpLsNUM8ro0M7a9a0EbUrZhsz310X7Ccg9wghsakncP6J/k33mG/CQu6/Rh6ly0RUykpiIMX/mcw92lTVo/m7CEmYmYga1m1JFbFd3FNbd5wT/uM1/MNdanpkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869587; c=relaxed/simple;
	bh=u3VhyHPpmSgE968spvdigjspg7knx3QFio0q8K5leto=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ms+Cu/n0pzmJ3dV1NhN128i2c1gjPwEx9JTUvOJSo4i1Jmx4R8W/xe4OLAiYjlWR0cvQyD08rVRBK1cWWG5iFZcSSX3Z+oiVxUnkqzA6vbCbBEHfCYdBVfyDWbwV+S5C3xg8OyvFGlCEPdMzv5hndU5fdRE8xs21CxLjjyz8+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcciIHyJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcciIHyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3456C4CEF1;
	Sat, 31 Jan 2026 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869587;
	bh=u3VhyHPpmSgE968spvdigjspg7knx3QFio0q8K5leto=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=VcciIHyJvfLK+/b83PlK2qWRxzBf8mvZxkhLtVHz1W3yVuQzesPNl7ebTgY3mYs8X
	 r6bGc8qR9kWOFx9ASfWhHsg/as/AXp4CBzKSQiog8FhDEHUefB+23XWHFApzzqaRpF
	 pl53FNcwlxFFudv20nW+2T9yQ+PXmQU+VTBhZNGYFecJPpoyecVGDzdB5uRRg8JeJA
	 uy+y6r5dHbB3PnABIK3JipiTVn6SsV2hf+MgUpgWh8EULY79vSyJa7Ow6m0RwV71S0
	 EXm20oxkmf7Sa9VPPvu0fL7Z+GhcQpEdr3bQwp8b/CVIuiPzbF25/Vs0fLmTNn/Yer
	 iEUDsmIzEvBiQ==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Jan 2026 15:26:22 +0100
Message-Id: <DG2UELGNDQDS.1LR5TLOZTSC29@kernel.org>
Subject: Re: [PATCH 0/5] rust: extend I2C functionality
Cc: <igor.korotin.linux@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Wolfram
 Sang" <wsa+renesas@sang-engineering.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
 <markus.probst@posteo.de>, <brgl@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <driver-core@lists.linux.dev>
To: "Igor Korotin via B4 Relay"
 <devnull+igor.korotin.linux.gmail.com@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260131-i2c-adapter-v1-0-5a436e34cd1a@gmail.com>
In-Reply-To: <20260131-i2c-adapter-v1-0-5a436e34cd1a@gmail.com>

(Cc: Bartosz, Greg, Rafael, driver-core)

On Sat Jan 31, 2026 at 3:12 PM CET, Igor Korotin via B4 Relay wrote:
> This patch series extend the existing I2C functionality with:
> - Abstractions allowing to implement I2C algorithms used by I2C adapters;
> - Abstractions allowing to create and add new I2C adapters;
> - Safe wrappers upon I2C and SMbus transferring C API: read/write
>   bytes/words/byte arrays.
>
> The patch series contains additional new sample driver `rust_i2c_adapter`
> presenting the new functionality.=20

The i2c_adapter code on the C side has some lifetime issues, Bartosz looks =
into
resolving.

My biggest concern is that struct i2c_adapter is a bus device implementatio=
n,
but does not use the reference count of the embedded struct device.

Instead, I2C bus drivers embedd the i2c_adapter in their driver specific
structure, which is typically freed in the I2C bus driver's remove() callba=
ck.

This violates struct device reference counts.

Until this is fixed, the Rust abstractions should probably work around this=
, to
subsequent painful rework.

> Patch series depend on=20
> message-id: <20260107103511.570525-1-dakr@kernel.org>
>
> Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
> ---
> Igor Korotin (5):
>       rust: i2c: split client and adapter code into separate files
>       rust: bits: add define_flags macro
>       rust: i2c: Add I2C Adapter registration abstractions
>       rust: i2c: add I2C wrappers
>       samples: rust: add Rust I2C adapter registration sample
>
>  MAINTAINERS                      |   4 +-
>  include/linux/i2c.h              |   6 +
>  rust/helpers/helpers.c           |   1 +
>  rust/helpers/i2c.c               |  15 ++
>  rust/kernel/bits.rs              |  57 ++++++++
>  rust/kernel/i2c.rs               | 254 ++-------------------------------
>  rust/kernel/i2c/adapter.rs       | 200 ++++++++++++++++++++++++++
>  rust/kernel/i2c/algo.rs          | 300 +++++++++++++++++++++++++++++++++=
++++++
>  rust/kernel/i2c/client.rs        | 284 +++++++++++++++++++++++++++++++++=
+++
>  samples/rust/Kconfig             |  12 ++
>  samples/rust/Makefile            |   1 +
>  samples/rust/rust_driver_i2c.rs  |  10 +-
>  samples/rust/rust_i2c_adapter.rs | 170 ++++++++++++++++++++++
>  samples/rust/rust_i2c_client.rs  |  15 +-
>  14 files changed, 1069 insertions(+), 260 deletions(-)
> ---
> base-commit: a7c013f779530190d0c1e1aa5e7c8a61f0bd479e
> change-id: 20260131-i2c-adapter-d38d330c4c25
> prerequisite-message-id: <20260107103511.570525-1-dakr@kernel.org>
> prerequisite-patch-id: 6e4d28a06d842ddfc7db82f410532a35b8fe317d
> prerequisite-patch-id: 9739295d85b688257fca29be1e1217a05a69c9e7
> prerequisite-patch-id: 78eaed3746a40713f44f13508fcf43653b0a4528
> prerequisite-patch-id: 99f1881bc896896297a903affcfa4f62cab1a307
> prerequisite-patch-id: ea8baa9d648f1178d6f39d140b98bddf3c183f6f
> prerequisite-patch-id: f8a9e049d204bde04e80151a67dfff5ec2633e7a
>
> Best regards,
> --=20
> Igor Korotin <igor.korotin.linux@gmail.com>

