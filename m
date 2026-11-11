Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370759;
	b=Wr5+Z3etkuh5+iN+0WbuyLKGZUuBEgDuTwEZraTtT9JdsXDfjJqMz3uLOhJDH7sAZ85l
	 xKdksHc52u9EMJ0JaBERxwevA6GhUM8+mc7gcCyjFos8412Hk/ndEitVXgtmBNu/q72jQ
	 WYeugh7GGful0PwQXhej18T+EPPfhlw/sNnejCui1xEc1U2bpMn+FgC7ezC7/Gvw62Sgj
	 h5MLcbs2LPt3G5r//+XlQGINo7LDJ8IgInK6q6u3GaEVc8ih0+OED4HNewCRgl47SXIfQ
	 FGOr/IX7sa0rTqHng/PqaAnxTiaRuBqhY5Cdk/LP8xx238AemAxzE7VP4xaj6Rx3jog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ppcz44YpOa+Rb6xSudMc3Cgx0KmX+T9PkTnsbJicNG8=;
	b=5n4Z/9PiJo9qseFBM3yv/wgdgUObuEtmuiiROdRkdfFfcG5s+NpaoGGL825yGVWysUOJ
	 aFyBiEVxpYBUT9fYHNV3Pq/I2HaofrK6XPp0OBvdTkbAjPaZQe0AnAP6D4H2m7HG7/v7q
	 W25teecq6UW+nFsLORdIHV8QSy0EP7M+4jpAkZWJ8oFNZ9pw6mFuRimm0+qUbZfmS6AqZ
	 aI3176O5Xd8lPk+zcPdt9RJnQbp86QfldRYvXKpL8CA2EMdESJXJBgex5PbmyAeKXh+NL
	 Xpv9H4daVK4rPr4SXG8oxO64aPIyks9H+KGCULAW1Gts1cY6a3bc0PDBTNSc3AtFhbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dNSqWvvB;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846C606A335
	for <linux-i2c@vger.kernel.org>; Wed, 11 Nov 2026 04:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2846C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dNSqWvvB
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so4785533eec.0
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 20:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794370757; x=1794975557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppcz44YpOa+Rb6xSudMc3Cgx0KmX+T9PkTnsbJicNG8=;
        b=dNSqWvvB04Cd+ZZ6DWdGzYKh0mEMxbWZGmm07NNGWRiubzEQi61xrQgVqHrnJxw/gv
         7m+ZZeQuesfW6vp169N+FLN4UueNzhV/VKxMREeGbzFT0mS4x7GhYpY4HDyzj6WvvsaY
         zskQEWN+Il/PH4ACI0GyPDzM5hWGWbqCAG/QQ4812hkK85iUWPnVbE+0WcpdfQGX17v5
         3/v28z8RhRXJXoSdcELukEryz3JVm59wvLDMVKfrKEZKOUHCPUyVYQ+tzDnQcd3Hy8hU
         jrS2t7vC0sefec98hlYB1IPfwcVYXZR9sbdLsN/1Ha8ezgIBDI9lHXZRqCn0RGzmhiLr
         M/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370757; x=1794975557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ppcz44YpOa+Rb6xSudMc3Cgx0KmX+T9PkTnsbJicNG8=;
        b=ZzNrABUHjfNrqG96HmAp3Y+jkMTntO9KctdUD3ih/C979L6yOuI9Rnb8JCeY3aOvsv
         8TWj4ipzG/G7WN7yP3R8vNBwXH52juaVPFVuwkerrPKupY//ePHsCj0zjOq8hfynPc5A
         vdF1mQ6xtNVwKaq5aj0XOgi76b2ZrR45NvBDyGqrtWObjy+/A8nFI+rLbeqnSBJmkbUx
         Ti25LLNCnJXe/D+uhNtB+xTXBrfg8TpwoVBGn/ffs/tvbM1Go/hxgfh969ouQYpUyEEw
         GWlg9kFPy37vTbxqKM5AM6mHivlrXIP8qtqHOW3W2JdHzThNjPdGlabq3YUGWJzcmPy2
         aDPw==
X-Gm-Message-State: APuU4Z/q2GKVV//usHXUrhGVeNV9vye4dmc0xgXNOvkYYsiOqX7HHVX7
	fuIBnDIKzp+15C6fsbGeGJ7UKRw+LmyagpOMYIiGiLiHnOKK/g6qTEF8
X-Gm-Gg: AYBFou0MAgfrAR0K/zyONzTpjwgesmNdK2SOEoI9OQqllrSxA76vfiu4QEVXIHSLL86
	8wHrlPPWzdSZcTnhvCCtioFG/K5f5PAo7+IPPWPV69THZzNuu09GKEJhMnYehlC3s2zQQR1hqPC
	vRrnmsHu9mTcfWFumV/n3Spi4I3ivCrjdYkGqgp+xojeaUjW1SlK81vjaRJbH4w6fBBxjbCLIus
	VduTeaqLEL8Hwr9jHbJpTzLQyeu2hlauEGVrVPp4Nred92xprEhDocMtpcvMKa+sLQJfkKsKH9N
	GufYjJR3pCQo7ulwNNZ9yKYlsQn2+y0vrG4eBEZ0sVYCpvsAChAkEV6IqpBdLV1lx66lsYDG4xP
	7I9WttoHpn6H19V0ORO+bsWoamq8qKpM74UCvCV4gdN0F3cyc8jQT4WqeXazujfr2IunotQtflc
	yZt+2F7B6lf3H7RUZtionAVhCpc1yidJDIvwDVxNTtlQJt2TzhtwJ9i+0nXbE40Jz62XioNY5CF
	O+xrJbhJ+EPl7UUjNgK00Pi5tSQKtAGRQH4WLtstnvN/kA36qMm6MaYfpGAmBKcKycoJ7jSX9Ne
	1+n+471b5w6zz6tz2oqu9MsJI2lNof5a6aZ3hV5D43m4GfQb5B4fN8K7HRlb2X/0LT4Wy3SYTWT
	JlTZGRRVgsVgjCdZOkH7xmrRB0lT+W/IvRJBMsbHXcUxyzlo3oucGRqP99fL0aP+IYB018oXw
X-Received: by 2002:a05:7300:f542:b0:376:98e7:eeae with SMTP id 5a478bee46e88-37698e7ef9dmr1582189eec.6.1794370756966;
        Tue, 10 Nov 2026 20:19:16 -0800 (PST)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060c4b6sm11820704eec.15.2026.11.10.20.19.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 20:19:16 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 2/3] i2c: xiic: add KUnit coverage for register access modes
Date: Tue, 10 Nov 2026 20:19:02 -0800
Message-ID: <20261111041904.48916-3-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111041904.48916-1-ahmadexp@gmail.com>
References: <20261111041904.48916-1-ahmadexp@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise the driver's private register accessors with memory-backed
registers instead of physical hardware. Cover native byte/halfword and
forced 32-bit accesses in both register byte orders, across 22 register
offsets. Check payload truncation, high-bit values and neighboring
sentinels. These tests do not validate physical bus transaction widths
or hardware interrupt behavior.

Include the tests in the driver translation unit so no accessors need
to become exported interfaces. Require built-in KUnit to avoid a
built-in driver depending on a modular test framework. The tests follow
the driver into either its built-in image or module.

The four parameterized cases passed in an isolated x86-64 QEMU boot
with networking disabled and no physical-device passthrough.

Tool-origin disclosure, as required by generated-content.rst: Codex was
used to implement this test suite, run the KUnit build/boot and draft
this changelog, in response to a request for upstream-quality testing.

Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
---
 MAINTAINERS                               |  1 +
 drivers/i2c/busses/Kconfig                | 14 ++++
 drivers/i2c/busses/i2c-xiic.c             |  4 ++
 drivers/i2c/busses/tests/i2c_xiic_kunit.c | 88 +++++++++++++++++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 drivers/i2c/busses/tests/i2c_xiic_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 76fb13c87..eb5777316 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4017,6 +4017,7 @@ F:	drivers/cpuidle/cpuidle-zynq.c
 F:	drivers/edac/synopsys_edac.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/i2c/busses/i2c-xiic.c
+F:	drivers/i2c/busses/tests/i2c_xiic_kunit.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
 N:	zynq
 N:	xilinx
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 275aaa7f3..014281fa2 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1322,6 +1322,20 @@ config I2C_XILINX
 	  This driver can also be built as a module.  If so, the module
 	  will be called xilinx_i2c.
 
+config I2C_XILINX_KUNIT_TEST
+	bool "KUnit tests for Xilinx I2C register accesses" if !KUNIT_ALL_TESTS
+	depends on I2C_XILINX && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Test the Xilinx I2C driver's register accessors with both byte orders
+	  and with native-width or forced 32-bit accesses. KUnit is a kernel
+	  unit testing framework. These tests use memory-backed registers and
+	  do not require an I2C controller.
+
+	  The tests are compiled into the driver to exercise its private
+	  accessors, and follow the driver's built-in or module configuration.
+	  If unsure, say N.
+
 config I2C_XLP9XX
 	tristate "Cavium ThunderX2 I2C support"
 	depends on ARCH_THUNDER2 || COMPILE_TEST
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index d13cfb012..f2a77ca8d 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1650,3 +1650,7 @@ MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("info@mocean-labs.com");
 MODULE_DESCRIPTION("Xilinx I2C bus driver");
 MODULE_LICENSE("GPL v2");
+
+#if IS_ENABLED(CONFIG_I2C_XILINX_KUNIT_TEST)
+#include "tests/i2c_xiic_kunit.c"
+#endif
diff --git a/drivers/i2c/busses/tests/i2c_xiic_kunit.c b/drivers/i2c/busses/tests/i2c_xiic_kunit.c
new file mode 100644
index 000000000..f8df88ca6
--- /dev/null
+++ b/drivers/i2c/busses/tests/i2c_xiic_kunit.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Included by i2c-xiic.c to exercise the driver's private accessors. */
+#include <kunit/test.h>
+
+struct xiic_access_param {
+	const char *name;
+	enum xiic_endian endianness;
+	bool force_32bit_access;
+};
+
+static const struct xiic_access_param xiic_access_params[] = {
+	{ "native_little_endian", LITTLE, false },
+	{ "native_big_endian", BIG, false },
+	{ "word_little_endian", LITTLE, true },
+	{ "word_big_endian", BIG, true },
+};
+
+KUNIT_ARRAY_PARAM_DESC(xiic_access, xiic_access_params, name);
+
+static void xiic_register_access(struct kunit *test)
+{
+	static const int offsets[] = {
+		XIIC_DGIER_OFFSET, XIIC_IISR_OFFSET, XIIC_IIER_OFFSET,
+		XIIC_RESETR_OFFSET, XIIC_CR_REG_OFFSET, XIIC_SR_REG_OFFSET,
+		XIIC_DTR_REG_OFFSET, XIIC_DRR_REG_OFFSET, XIIC_ADR_REG_OFFSET,
+		XIIC_TFO_REG_OFFSET, XIIC_RFO_REG_OFFSET, XIIC_TBA_REG_OFFSET,
+		XIIC_RFD_REG_OFFSET, XIIC_GPO_REG_OFFSET, XIIC_TSUSTA_REG_OFFSET,
+		XIIC_TSUSTO_REG_OFFSET, XIIC_THDSTA_REG_OFFSET,
+		XIIC_TSUDAT_REG_OFFSET, XIIC_TBUF_REG_OFFSET,
+		XIIC_THIGH_REG_OFFSET, XIIC_TLOW_REG_OFFSET,
+		XIIC_THDDAT_REG_OFFSET,
+	};
+	const struct xiic_access_param *param = test->param_value;
+	struct xiic_i2c *i2c;
+	u32 expected;
+	u8 *mem;
+	size_t i;
+	int reg;
+
+	i2c = kunit_kzalloc(test, sizeof(*i2c), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, i2c);
+	mem = kunit_kmalloc(test, 0x200, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mem);
+	/* Aligned RAM stands in for MMIO. No hardware is accessed. */
+	i2c->base = (void __force __iomem *)(mem + sizeof(u32));
+	i2c->endianness = param->endianness;
+	i2c->force_32bit_access = param->force_32bit_access;
+
+	for (i = 0; i < ARRAY_SIZE(offsets); i++) {
+		reg = offsets[i];
+		memset(mem, 0xa5, 0x200);
+
+		xiic_setreg8(i2c, reg, 0xc0);
+		expected = param->force_32bit_access ? 0xc0 : 0xa5a5a5c0;
+		KUNIT_EXPECT_EQ(test, (u32)xiic_getreg32(i2c, reg), expected);
+		KUNIT_EXPECT_EQ(test, xiic_getreg8(i2c, reg), (u8)0xc0);
+
+		xiic_setreg16(i2c, reg, 0x03ff);
+		expected = param->force_32bit_access ? 0x03ff : 0xa5a503ff;
+		KUNIT_EXPECT_EQ(test, (u32)xiic_getreg32(i2c, reg), expected);
+		KUNIT_EXPECT_EQ(test, xiic_getreg8(i2c, reg), (u8)0xff);
+
+		xiic_setreg32(i2c, reg, 0x12345678);
+		KUNIT_EXPECT_EQ(test, (u32)xiic_getreg32(i2c, reg), 0x12345678U);
+		KUNIT_EXPECT_EQ(test, xiic_getreg8(i2c, reg), (u8)0x78);
+		KUNIT_EXPECT_EQ(test, mem[reg + sizeof(u32)],
+				(u8)(param->endianness == BIG ? 0x12 : 0x78));
+		KUNIT_EXPECT_EQ(test, mem[reg + sizeof(u32) + 3],
+				(u8)(param->endianness == BIG ? 0x78 : 0x12));
+		xiic_setreg32(i2c, reg, 0x89abcdefU);
+		KUNIT_EXPECT_EQ(test, (u32)xiic_getreg32(i2c, reg), 0x89abcdefU);
+		KUNIT_EXPECT_EQ(test, xiic_getreg8(i2c, reg), (u8)0xef);
+		KUNIT_EXPECT_EQ(test, mem[reg + sizeof(u32) - 1], (u8)0xa5);
+		KUNIT_EXPECT_EQ(test, mem[reg + 2 * sizeof(u32)], (u8)0xa5);
+	}
+}
+
+static struct kunit_case xiic_access_test_cases[] = {
+	KUNIT_CASE_PARAM(xiic_register_access, xiic_access_gen_params),
+	{}
+};
+
+static struct kunit_suite xiic_access_test_suite = {
+	.name = "i2c_xiic",
+	.test_cases = xiic_access_test_cases,
+};
+
+kunit_test_suite(xiic_access_test_suite);
