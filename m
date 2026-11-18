Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026178;
	b=oJ+LKH5dSpZLyAlyCPlHKw6YvmAF/nSp1H2mxPBx7WWNBV3gn4ZChgtZCLLd5rIIK3gJ
	 Goj9nJUjiwEWgYNbFfGb4INet7SX5EyqIotBrIka2maIk54/B4WPcTGeaghlcNJ0IMw8n
	 Gt9Bg2gDzxnXjMZbf7a5Z1nZUfgyUl3Gc14PW15gU0PfxCRGVMbpzA1taCvUPIGTJryh9
	 Nv34v1tfKJniiw+89IIUEM0eWczMlFvyeEwkYZ8HNKxxW3mWIeBf3J1TSTbtY7fgAJMBD
	 v9u7ldmHjcDQ1/uj/lbqeUn0lPnPcNShjtShZjlLOHAgrt4x6BemWRsQO2YvF9oy8hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026178;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=83nStTpRlBCM/kV50VhrxEdv2aiG0+hQRKw/q7fknCY=;
	b=URuyACSULoXRK0FTp8zSFSAhNeoieo2KHrK/X1hISJNywIKK8/QJKLK2cl2uCBW88eHu
	 KRDWsJxB0kyDX/pUBCQEzt11l1ORq72yousCYgZGcWpkL2gCPWV3QLspa9fm2YklfmO6W
	 PFZ0UnzIzWbBI82DX5dxkr/bJSLQEuQ5z+pBD9qct5JDlOXFwkC+DJPGQuJqHsHgJpPZT
	 qBijFNu/EyhYwVwAOR0Uc1txO297hkcqPsP9h18mLbI2wLexIZ0sYfjXqldjGD/kfQmkP
	 hAoaHpM1FQBtbNmWB4VvJv9tao+oHqmS7CoINCAaTVIYG+kr/HcbCN+DrPVhJop7Ksg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eII3R7u7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4460A261E;
	Wed, 18 Nov 2026 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eII3R7u7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7DF1F000C8;
	Wed, 18 Nov 2026 18:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795026178;
	bh=83nStTpRlBCM/kV50VhrxEdv2aiG0+hQRKw/q7fknCY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eII3R7u7v+X2x1cFXYrljudcwtferg62bDURLm2cIFnu3j5CNP2STMqyzoGsWjLhD
	 CTenu2E6o1AeSniswhlkMZ47mbHlieoKultgsbf2CzFFqdeXnpft66Pj8fybn0Ccox
	 fAHyHVBu4ZAr6eDacCmoEH51jTb5N/uxQrvfA2zkZKldHZ10s1elkrjfhuL6gXsYeE
	 tR5YVe7Dn3DOdNEtL8eAh+mVp19AIZSzgEiZOmdfUgsWSUX4+4UjNZWZ3tol3MWHJ1
	 OktnGuoWQgsQwzmQzw2xwfwDjKmdWN3mY0MElmnwYO69H+z8GbtoV4eqRrBlxUn4u9
	 rZPekT8TuIzdA==
Subject: Re: [PATCH net-next v3 2/3] i2c: xiic: add KUnit coverage for
 register access modes
From: netdev-bot+sashiko@kernel.org
To: ahmadexp@gmail.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, andi.shyti@kernel.org,
 andrew+netdev@lunn.ch, corbet@lwn.net, davem@davemloft.net,
 edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us, kuba@kernel.org,
 linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, rdunlap@infradead.org,
 richardcochran@gmail.com, skhan@linuxfoundation.org
Date: Wed, 18 Nov 2026 18:22:56 +0000
Message-ID: <179502617695.3136.6995182814188526026@kernel.org>
In-Reply-To: <20261116-wiwi-v3-87afa10a8-2-ahmadexp@gmail.com>
References: <20261116-wiwi-v3-87afa10a8-2-ahmadexp@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new KUnit suite cannot catch a regression in the forced
  32-bit read path of xiic_getreg8().

--

i2c: xiic: add KUnit coverage for register access modes

This adds a KUnit suite that is compiled into i2c-xiic.c and tests the
driver's private register accessors against RAM-backed registers. It
covers native and forced 32-bit accesses in both byte orders across 22
register offsets. It only builds on direct x86-64 MMIO.

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 275aaa7f35833..0a7a2aeb78909 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1322,6 +1322,21 @@ config I2C_XILINX

[ ... ]

> +config I2C_XILINX_KUNIT_TEST
> +	bool "KUnit tests for Xilinx I2C register accesses" if !KUNIT_ALL_TESTS
> +	depends on I2C_XILINX && KUNIT=y
> +	depends on X86_64 && !UML && !INDIRECT_IOMEM
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Test the Xilinx I2C driver's register accessors with both byte orders
> +	  and with native-width or forced 32-bit accesses. The tests use
> +	  allocated RAM in place of registers. This relies on the direct
> +	  x86-64 MMIO accessor implementation; no controller is required.

[ ... ]

> diff --git a/drivers/i2c/busses/tests/i2c_xiic_kunit.c b/drivers/i2c/busses/tests/i2c_xiic_kunit.c
> new file mode 100644
> index 0000000000000..1b691de7e9250
> --- /dev/null
> +++ b/drivers/i2c/busses/tests/i2c_xiic_kunit.c
> @@ -0,0 +1,91 @@

[ ... ]

> +	for (i = 0; i < ARRAY_SIZE(offsets); i++) {
> +		reg = offsets[i];
> +		memset(mem, 0xa5, 0x200);
> +
> +		xiic_setreg8(i2c, reg, 0xc0);
> +		expected = param->force_32bit_access ? 0xc0 : 0xa5a5a5c0;
> +		KUNIT_EXPECT_EQ(test, (u32)xiic_getreg32(i2c, reg), expected);
> +		KUNIT_EXPECT_EQ(test, xiic_getreg8(i2c, reg), (u8)0xc0);

[Severity: Low]
Would this check, or any of the other xiic_getreg8() checks in
xiic_register_access(), catch a regression in the forced 32-bit read path?

In xiic_getreg8(), the forced path is:

	if (i2c->force_32bit_access)
		return xiic_getreg32(i2c, reg);

Without it, the function does ioread8(base + reg) for LITTLE and
ioread8(base + reg + 3) for BIG.

In the word_little_endian and word_big_endian cases, every value is first
stored as a zero-extended 32-bit word. With RAM-backed registers, the byte
at reg + 0 (LE) or reg + 3 (BE) is always the low byte of that word. The
native 8-bit read and the truncated 32-bit read therefore return the same
value (0xc0, 0xff, 0x78, 0xef).

So it looks like the force_32bit_access branch could be removed from
xiic_getreg8() and all four parameterized cases would still pass.

The write side is covered, because the upper bytes (0xc0 vs 0xa5a5a5c0)
would catch a subword store. The read side is the one behind the machine
check from ioread8() in xiic_clear_rx_fifo(). That machine check is what
motivated "i2c: xiic: allow platforms to require 32-bit register
accesses".

The changelog says "These tests do not validate physical bus transaction
widths". The Kconfig help text above, however, says the accessors are
tested "with native-width or forced 32-bit accesses", and does not mention
that read width can't be observed.

Could that limit be documented in the Kconfig help or in a test comment?
Alternatively, the accessor could be instrumented so the read width can be
checked.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116-wiwi-v3-87afa10a8-0-ahmadexp%40gmail.com
