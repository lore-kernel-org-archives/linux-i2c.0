Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565321;
	b=Ji2xlZOF7FBMJ402bvP17UH0dPAXqER7+tlZQhQrkgHNLyQMcfuXRpz4cMqMClwO7d6j
	 qEmx+2r2+FntoRLdyK6G14o96RGyVLH15ryGUEIKO4Ho7n9ZHFgJGvne7Cv+336K7vHQf
	 cbQTcX/i0IpW8n3HbAPX1RYf/WMOFOufgcKEOgw+uBOIBAf4cQuABCU3rSbsgRnw9CSxF
	 RkzSaSx88lAAXkE4vQRw+XD7QY0xwDf3wGwgTefi75tmqQMpTdX/m5qwWuw6IUbfAA8Vn
	 0vY2G9DGLh9sL8zJqoRZgPi0Blqbufa92SFlF+3WzHSbhzCFx4nvgFLWXDuJN4WrCMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565321;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qsAv4W/a9CMihA8VWalhXUkWjd1Sp954ubrBgvkWZX0=;
	b=Arq3BX2k2BDGMDtePghFtDyHU5mdbc0b2Y/qdnoaOol2J0IpT0OHcySUNNqDX+tblInT
	 Y96x1lJvlZuzTseJ46QXpjNmYMeOJp5rSh7tia84Yzqjk6Ngf4Ns1naiFTo7PPjZjR9Wj
	 sFw5CNfufClcWJCCLObbjf6x4iOXUjtSbW/nfQxD/mWZWha+q7Z1Qtb7uKKvuPOLSb9Cb
	 wFpVCZMw+Den09nKuI3NK9z9XNPw/cNbCRG0h7y0p27ehiTJyvDwxi0ek2z8RuFfYfR4T
	 0drMIu0SJjXlr5DCvjfQtQbmBjviGFrFzQdRoQRq1CClMP01lqGapQC2JqhyO0gNpjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qzqn3OtE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F150606A32E;
	Fri, 13 Nov 2026 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qzqn3OtE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566DC1F000C4;
	Fri, 13 Nov 2026 10:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565321;
	bh=qsAv4W/a9CMihA8VWalhXUkWjd1Sp954ubrBgvkWZX0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qzqn3OtEuFB36mhbVip0jOD5GEo0AclBeDs32rCbWtuFNDvsAC+LMlXOBLboji0j4
	 oqX2qjFDR4hHBbr+1L0QdmebkMk3qFavlEWG8H8xfDHCMYT5cnGfXvIc107XS2l7N+
	 nL4xCGa9m7Vy8KC3FwGMVi20Mk4ngh5YBmXbE36boyvD897T0FNw9s67kazEVQ/9hT
	 GMIFtZVh5oCgbTlwDYhf2+JtwisbjcxUg+167radi/2IvJcrYO4LVGEXpkd9mAnx/3
	 QjsugTK7BqZBFHHiCQD4qJa88xnBnNOdRjk4KWWl3hcCwWIbI0TyLKwURVZSYey2Q2
	 0GuXCj9xK+1Gg==
Subject: Re: [PATCH net-next 2/3] i2c: xiic: add KUnit coverage for register
 access modes
From: netdev-bot+sashiko@kernel.org
To: ahmadexp@gmail.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, andi.shyti@kernel.org,
 linux-i2c@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 10:21:59 +0000
Message-ID: <179456531993.2199510.13650241681573931424@kernel.org>
In-Reply-To: <20261111041904.48916-3-ahmadexp@gmail.com>
References: <20261111041904.48916-3-ahmadexp@gmail.com>
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

- [Medium] The new KUnit test xiic_register_access() in
  drivers/i2c/busses/tests/i2c_xiic_kunit.c takes a kunit_kmalloc() RAM…

--

i2c: xiic: add KUnit coverage for register access modes

This adds a KUnit suite that is included in the i2c-xiic.c translation
unit. It drives the private xiic_setreg*() and xiic_getreg*() accessors
against a kmalloc'd buffer that stands in for MMIO. It covers native and
forced 32-bit accesses in both byte orders across 22 register offsets. The
new I2C_XILINX_KUNIT_TEST symbol enables it and defaults to
KUNIT_ALL_TESTS.

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
> index 0000000000000..f8df88ca65124
> --- /dev/null
> +++ b/drivers/i2c/busses/tests/i2c_xiic_kunit.c
> @@ -0,0 +1,88 @@

[ ... ]

> +	i2c = kunit_kzalloc(test, sizeof(*i2c), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, i2c);
> +	mem = kunit_kmalloc(test, 0x200, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, mem);
> +	/* Aligned RAM stands in for MMIO. No hardware is accessed. */
> +	i2c->base = (void __force __iomem *)(mem + sizeof(u32));

[Severity: Medium]
Is it safe to pass a kmalloc'd buffer to ioread*() and iowrite*() on every
architecture that can build this test?

This works where the MMIO accessors are plain loads and stores to the
virtual address, as on the x86-64 setup the changelog says was tested.

However, I2C_XILINX_KUNIT_TEST only has "depends on I2C_XILINX && KUNIT=y"
with "default KUNIT_ALL_TESTS". I2C_XILINX only needs HAS_IOMEM. That means
the suite is built and run automatically on architectures where those
accessors don't touch RAM.

On sparc64, arch/sparc/include/asm/io_64.h implements readb()/readl()/
writeb()/writel(), and __raw_readl()/__raw_writel() for the be variants,
with lduba/lduwa/stba/stwa and ASI_PHYS_BYPASS_EC_E_L:

    __asm__ __volatile__("lduwa\t[%1] %2, %0\t/* pci_readl */" ...

That uses the slab virtual address as a physical address. Could this trap?
Could it instead write 0xc0, 0x03ff, 0x12345678 and 0x89abcdef to an
unrelated physical location?

On s390 with CONFIG_PCI, __raw_readl() and friends map to zpci_read_u32()
and the other zpci helpers. On the non-MIO path, zpci_load_fh() and
zpci_store_fh() do:

    struct zpci_iomap_entry *entry = &zpci_iomap_start[ZPCI_IDX(addr)];

using bits from the fake address. They then issue a real PCI load or store
with whatever function handle and BAR they find there. On the MIO path,
PCI load/store instructions are issued against a RAM address.

On UML with INDIRECT_IOMEM, the chain is KUNIT_UML_PCI -> UML_PCI ->
UML_IOMEM_EMULATION -> INDIRECT_IOMEM. The default
tools/testing/kunit/configs/arch_uml.config sets CONFIG_KUNIT_UML_PCI=y.
For a slab address, get_area() in lib/logic_iomem.c hits:

    if (WARN_ON((a & IOREMAP_MASK) != IOREMAP_BIAS))
        return NULL;

Nothing selects INDIRECT_IOMEM_FALLBACK. So the fallback path WARNs again,
reads return ~0 and writes are dropped.

Wouldn't that give two WARN splats per access, across all 4 parameters and
22 offsets? It would also fail every expectation, and panic if
panic_on_warn is set.

These three statements don't hold on those architectures:

  - the Kconfig help: "These tests use memory-backed registers and do not
    require an I2C controller"
  - the comment above: "No hardware is accessed."
  - the changelog: "memory-backed registers instead of physical hardware"

Should I2C_XILINX_KUNIT_TEST get an architecture restriction, for example
excluding SPARC64, S390 and INDIRECT_IOMEM, or using an allow-list? Or
could the test go through an indirection it can mock, rather than passing
RAM to the MMIO accessors?

> +	i2c->endianness = param->endianness;
> +	i2c->force_32bit_access = param->force_32bit_access;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111041904.48916-1-ahmadexp%40gmail.com
