Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846818;
	b=nlCN0QTLXsBxGCtBwmxqJAyQXpgBwBq1daHNl0l/q6/VZv+U5l4TxWsIir1SL6mi0OTZ
	 gqhtJ2CIedys3CtXFIJXEPW72TR5j1tWfbZa9yFHwXOaw8GAfmmAq/cnnpjys5FS9j0vh
	 sjz9ib3IAzyw6vPgRa/WQuT0GHPGAhRksb9k2mBhv6tHhAef3dv9ojyfDBAIP1WZHiLc7
	 7tVlsy85YaFmmi5GcyQuGMTAfluwEDuXTFpHxEyU3A7lVbmRtkW/rwdPh2zaCDtj6lWaV
	 Y4XYKat6dkLoYu17eLHLUj10zky1cKI9X4BKfrUiAk3RY936Y9HTB9BWZMBiOJ3ECCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846818;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lAsf+sMMq5bVx/eFBObeO8BbOzzotZiN0ESA48dI7mg=;
	b=ET2QjEUkQuQwN8CXNibcmp54zRsEQenhVRcUpb9qOG8LqaEmtzrB5oVGKu5Ekw0YVodx
	 9iADqns0fEUGI7bC8U1/xSQv3WEpdHPyhal9kOtPsGV0hdscvVlhqq132gQ6xmRGGeHHI
	 40jehYAp9UkHP+AOFZUGRRK1htL0yOx56REuK4KMDqomIb6ZoHgxNVzL7Xd+eXgrbjqjb
	 WPr9wEurcCH4Ouo5OClTKMdlnY/qd9UWIhfAkQI8iGeOBlmLvfn1sdbUN2BRHVwgb8ESS
	 ng/gH5l4pn8B1Lbr4JopJ4r9i3MBtCLbVEZ3Csms3ABevym6KStoH0vQo7SXYnO/5SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NS5mYxsJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931E606A31C;
	Mon, 16 Nov 2026 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NS5mYxsJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BF81F000C4;
	Mon, 16 Nov 2026 16:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794846818;
	bh=lAsf+sMMq5bVx/eFBObeO8BbOzzotZiN0ESA48dI7mg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NS5mYxsJUyb5qdQX2jRqFMtqo8hreun+NiWu2e7s4itUbj4RgMszUIL/B4VIGMvnJ
	 LkNL0gnC54IReO6iiL/Rj4H609ggPT3pMbZGfp6gdSHjzNjXaTH7SueYJe//3IHINV
	 uGe5cq12+pSAye5OSZWbo4i/29l9WPUCZlOKRbCtZ0jwsMunyvQzVRpA1pja0vElWu
	 oLApev6cmdh6e4kmXc9Yi40gVQtmYxVpywSeK75BwcwfZeWGvf5o08FmWX6OYp+qUG
	 3h84P+2QT4qP67HTYmh7Em10WgPaLrjFBufa68BQ5Fk6m7yVbEFxGR4VaaG6Rw92cN
	 Pbo7D9gQI6rKw==
Subject: Re: [PATCH net-next v2 2/3] i2c: xiic: add KUnit coverage for
 register access modes
From: netdev-bot+sashiko@kernel.org
To: ahmadexp@gmail.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, andi.shyti@kernel.org,
 linux-i2c@vger.kernel.org, michal.simek@amd.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kuba@kernel.org
Date: Mon, 16 Nov 2026 16:33:37 +0000
Message-ID: <179484681740.3136.17781028072212776292@kernel.org>
In-Reply-To: <20261112163333.12523-3-ahmadexp@gmail.com>
References: <20261112163333.12523-3-ahmadexp@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new KUnit test in
  drivers/i2c/busses/tests/i2c_xiic_kunit.c (xiic_register_access(),…

--

i2c: xiic: add KUnit coverage for register access modes

This commit adds a KUnit suite that runs the xiic driver's private
xiic_setreg*() and xiic_getreg*() accessors against kmalloc-backed memory
instead of MMIO. It covers both byte orders, with native-width and forced
32-bit access. The test file is included directly into i2c-xiic.c and is
enabled by a new I2C_XILINX_KUNIT_TEST bool option that requires built-in
KUnit.

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 275aaa7f35833..014281fa2be5c 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1322,6 +1322,20 @@ config I2C_XILINX
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called xilinx_i2c.
>  
> +config I2C_XILINX_KUNIT_TEST
> +	bool "KUnit tests for Xilinx I2C register accesses" if !KUNIT_ALL_TESTS
> +	depends on I2C_XILINX && KUNIT=y
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Test the Xilinx I2C driver's register accessors with both byte orders
> +	  and with native-width or forced 32-bit accesses. KUnit is a kernel
> +	  unit testing framework. These tests use memory-backed registers and
> +	  do not require an I2C controller.

[ ... ]

> diff --git a/drivers/i2c/busses/tests/i2c_xiic_kunit.c b/drivers/i2c/busses/tests/i2c_xiic_kunit.c
> new file mode 100644
> index 0000000000000..b4c818d8bac78
> --- /dev/null
> +++ b/drivers/i2c/busses/tests/i2c_xiic_kunit.c

[ ... ]

> +static void xiic_register_access(struct kunit *test)
> +{

[ ... ]

> +	i2c = kunit_kzalloc(test, sizeof(*i2c), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, i2c);
> +	mem = kunit_kmalloc(test, 0x200, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, mem);
> +	/* Aligned RAM stands in for MMIO. No hardware is accessed. */
> +	i2c->base = (void __force __iomem *)(mem + sizeof(u32));

[Severity: Medium]
Is it safe to push kmalloc memory through ioread*() and iowrite*() here?
xiic_setreg32(), xiic_getreg32() and the 8/16-bit helpers call
iowrite32(), ioread32be() and similar directly on i2c->base. Those
accessors are only required to work on cookies returned by ioremap() or
pci_iomap().

On x86-64 this works, because the generic iomap code treats these
addresses as plain MMIO. But I2C_XILINX_KUNIT_TEST only depends on
I2C_XILINX && KUNIT=y and defaults to KUNIT_ALL_TESTS, and I2C_XILINX only
needs HAS_IOMEM. As a result, the option can be enabled on architectures
where RAM can't be accessed this way.

On UML, tools/testing/kunit/configs/arch_uml.config sets
CONFIG_KUNIT_UML_PCI=y. That pulls in UML_PCI -> UML_IOMEM_EMULATION ->
INDIRECT_IOMEM and enables HAS_IOMEM. The accessors then end up in
lib/logic_iomem.c:

lib/logic_iomem.c:get_area() {
    ...
	if (WARN_ON((a & IOREMAP_MASK) != IOREMAP_BIAS))
		return NULL;
    ...
}

INDIRECT_IOMEM_FALLBACK is never selected, so the fallback
real_raw_read*() and real_raw_write*() helpers WARN a second time, return
~0 and drop the writes.

Wouldn't that mean two WARNs per accessor call? Across 22 offsets and 4
parameters that is about 2100 WARNs per run. Every expectation would fail,
and with panic_on_warn=1 the kernel would panic. A plain kunit.py run with
--kconfig_add CONFIG_I2C_XILINX=y looks like it would hit this.

On s390 with PCI, __raw_readl() and __raw_writel() map to zpci_read_u32()
and zpci_write_u32(). The test would then issue real zPCI load and store
instructions on a heap address. Without MIO, the address is decoded as an
iomap index plus a PCI offset:

arch/s390/pci/pci_insn.c:zpci_load_fh() {
    ...
	struct zpci_iomap_entry *entry = &zpci_iomap_start[ZPCI_IDX(addr)];
	u64 req = ZPCI_CREATE_REQ(READ_ONCE(entry->fh), entry->bar, len);
	return __zpci_load(data, req, ZPCI_OFFSET(addr));
}

Could this fail with zpci errors, or reach an unrelated function's BAR if
an iomap entry happens to match?

On sparc64, __raw_readl() in arch/sparc/include/asm/io_64.h uses lduwa
with ASI_PHYS_BYPASS_EC_E. That treats the kernel virtual pointer as a
physical address and bypasses the caches.

Because of this, the "No hardware is accessed" comment, the
"memory-backed registers" Kconfig help text and the changelog only hold
on architectures like x86-64. The rest of the series doesn't seem to
change this Kconfig entry or the test file.

There seem to be two ways to fix this. One is to restrict the option by
architecture, for example depends on !UML && !S390 && !SPARC64, or an
allow-list. The other is to route register access through a hook that the
test can replace with a memory-backed implementation. With either one, the
comment and help text should be updated to match.

> +	i2c->endianness = param->endianness;
> +	i2c->force_32bit_access = param->force_32bit_access;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112163333.12523-1-ahmadexp%40gmail.com
