Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501227;
	b=HzBXocDeCj6bAvcqFgVbe40SW+LK46wO1rPs3m6cQ8ocDclxK5OLkNxlhM432MeUyVea
	 BI0ZQpC3p2qTWnsI1u9V/8N6et38sSPvzV13s3+4zXKW1mwUrsYwVAxWnGbKHj9UXBdHV
	 8Jc4DrcLUqmN5sc1dbPp3VwZbyqMMiUNJzSq3/4y/09APnu4LeJ/owewRExcPenK6+Lp+
	 yEnEDqYUslHhazcGPPvwQXXaFVLeVxLdMnkOESURilt+QHVUVXCp8c/fFgXbw/SjHSp/+
	 b88IXe9ewT4u8J39RSO529msAOnuvQ+Ti0HV31RfetWZngnrDyMS84f+a037BStk/xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Fq2Tsxhf5rFExqtMe5i2fmiOO7MCidBfvMh2Y6TVSf4=;
	b=xBwUrZO/v8J+g67kv5++COkQd02QZEQHye1KlXP0qScNnsbLpqOiRFKPoRMkEB0b/dX1
	 Sh3WzEzea+EHr5miWVpRl1uuzpwtyknEQMMsAzWhy6yJBOwgZKgChOwccW/pkadduqWhm
	 +vOIlkP6aIkhkosS5scDyG536DQ30DL1XkyekI3tIUfz9PQJ2MNi4yWp4bKCQCV0QCvZ8
	 PITc0DX4c8qjZdp8FW4SaYQjVElV8pOiPoqtnkGSFmzL8D5lIbdFpPbmCaVjIWM1qiXP/
	 AKS+kWkhIsDwoTA1AzNglNW2omlGzyZHnm0oa0GtqHuY0PzWl2Q2u0y4+PNtCKaCVCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gbxi3VQ6;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34EE606AB02
	for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 16:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A34EE606AB02
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gbxi3VQ6
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1aefd1bf74aso1216c88.1
        for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 08:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501226; x=1795106026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fq2Tsxhf5rFExqtMe5i2fmiOO7MCidBfvMh2Y6TVSf4=;
        b=Gbxi3VQ6FZ4SKA8SpkY+K+CI/ecuWylsppICb+x8IPsxjVU/Hmbl+EXZdNBHoVdA31
         IWXVcAJT5Kar6Ymq21q9MyjUeqDq9dkUIS3agnXxAhujjtYt2p6QF+hoWiFi7+epcJss
         ej0SvU3DyZd3hsjtjd/S4xMxqfmBS2oztn7Lsz4PQ/yxRzFRNG37KNPCSVMhv8s7ir8j
         bXfbI+x2u64n56WsUVv7eU69fv8vfnAn1EOrppcnYK4yeDsMLS4vzb7JskBHn/OtyJf9
         gqCqFUmOgqcfIW+ioD+KuSukPQrdUsJlBvA4CqGZASxMD0tkzVDQuBSG67gkRBqSRtlt
         mBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501226; x=1795106026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fq2Tsxhf5rFExqtMe5i2fmiOO7MCidBfvMh2Y6TVSf4=;
        b=H1S9vRpMKEPTlcXpU6d6f4R1Ivf41TETZr1pSgV46RtZD7vpgGO3tQFS8eT70BzoSN
         5v5y8IFm+2IxppqUGLLN6PFeotQbrFPGIeBJOke6G9N3grY9d6eJtX2jR8Gr1ZrXbcSM
         4HW4efMIVa5x5sI9u/SfS2ZUCrhlS531ddycLz7iRrWFtTIMLe5sS4Ck6FYyQTtTVG3e
         gDcK8a3w2Jnw6dyXdDcdxGDLsy4OfWeHubG4kry8Z8CqxlaMzHccxI9iDogKeJaJ/2CO
         zbEuXgijnbjWPWgamz2wEtOwjABZIatDkta4vBKf0uCx9ABAgsibdbyE7QRVz+28atxL
         OMBg==
X-Gm-Message-State: APuU4Z9HDKHqCn3zD9vLmu1ifg0brrdjVTdshVACORtbWBspY9kqHref
	uQO2152PXsfE173lHRd3K5ClJDXfDX4iOaAdczxJOSVBJdcPYmWsjwF2
X-Gm-Gg: AYBFou2Ainp3SYD/Six+CiFp/FzmkJBBDqB6A/xDuvjhCUTqvhTwzqESJbaKv0CqT6U
	uThHYpdn5/ytZCKReRkeSxn3jo9ilv5NOm8s+oCjhszTi8jxFt6RSehwH/DUmzYiGLD57UPM/gc
	3mWkMOXwQPp4Kbq7rwBV1XQhZ5C9ssiOrzIdQc+no0XBbpntbmVo8QMroTx191f/WxQHMIe+aYx
	DHhi0aShuSRLsoRUXc5HT4tmns0eHqt8fGvY+nZ+vczLFRr8mzNKK8h1CBiCKehzntPGywxyD+S
	GnjowuDSXz9p54QCmh/EhdgqTQG4Fw7SR7VZvc1gUakYxB/wdCfsbGwbVmh8tQAtNDTB7o4LZVB
	ifU+CFugOaXegCWMGft4z0t04td52H9YyXJpPMRFwHEkQNK/VIimGJDv4STdVj/6QwpBmdVID+a
	lTgaZi7dCvfYXk7ikkZtKhFQkeXyZn1oBv07OI5kMzjmG4SpN6oQiTHobrFQlvSJjRu0K0HtivK
	pKghLutcuCeWlPf42rzmjJqnIbXXOhl9P71ggGekSAfhRT4ymZmjl0GRHj5/NFR2QZ0y2QF+WVr
	AxTsqOQ9/QyBo4/gHvOIIaswsKPerJyiGlQ3jNCOVze9YA7Lb0Gv86057dvNVci6WkLLcsBtGj7
	FKdpLvRp2KCS4lo5idwn9A9eHEcnxxJS4HqUS2BDTIR62U/NvpQnIlO3TynZ/h1ju5VyOlXyI
X-Received: by 2002:a05:701b:4294:10b0:1b3:b3d5:566f with SMTP id a92af1059eb24-1b5030990dbmr88896c88.11.1794501225666;
        Thu, 12 Nov 2026 08:33:45 -0800 (PST)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50300e5dcsm230248c88.0.2026.11.12.08.33.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 08:33:45 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 2/3] i2c: xiic: add KUnit coverage for register access modes
Date: Thu, 12 Nov 2026 08:33:31 -0800
Message-ID: <20261112163333.12523-3-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112163333.12523-1-ahmadexp@gmail.com>
References: <20261112163333.12523-1-ahmadexp@gmail.com>
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
 drivers/i2c/busses/i2c-xiic.c             |  4 +
 drivers/i2c/busses/tests/i2c_xiic_kunit.c | 91 +++++++++++++++++++++++
 4 files changed, 110 insertions(+)
 create mode 100644 drivers/i2c/busses/tests/i2c_xiic_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 893b0670a..64fa74c40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4018,6 +4018,7 @@ F:	drivers/cpuidle/cpuidle-zynq.c
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
index 8425a540f..6c0f04aaa 100644
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
index 000000000..b4c818d8b
--- /dev/null
+++ b/drivers/i2c/busses/tests/i2c_xiic_kunit.c
@@ -0,0 +1,91 @@
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
+		XIIC_RFD_REG_OFFSET, XIIC_GPO_REG_OFFSET,
+		XIIC_TSUSTA_REG_OFFSET, XIIC_TSUSTO_REG_OFFSET,
+		XIIC_THDSTA_REG_OFFSET,
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
+		KUNIT_EXPECT_EQ(test, (u32)xiic_getreg32(i2c, reg),
+				0x12345678U);
+		KUNIT_EXPECT_EQ(test, xiic_getreg8(i2c, reg), (u8)0x78);
+		KUNIT_EXPECT_EQ(test, mem[reg + sizeof(u32)],
+				(u8)(param->endianness == BIG ? 0x12 : 0x78));
+		KUNIT_EXPECT_EQ(test, mem[reg + sizeof(u32) + 3],
+				(u8)(param->endianness == BIG ? 0x78 : 0x12));
+		xiic_setreg32(i2c, reg, 0x89abcdefU);
+		KUNIT_EXPECT_EQ(test, (u32)xiic_getreg32(i2c, reg),
+				0x89abcdefU);
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
