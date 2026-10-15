Received: from naesa06.arrow.com (naesa06.arrow.com [216.150.161.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E0522F0E;
	Thu, 15 Oct 2026 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068910; cv=none; b=MHl2sgHKFHBCmLITeL1bjiSaXMIEsSDdoG4rCQpQR/YzM3JaQo/sHhrXeSr19HdOcn1wJ5J/UPOhIPNX4p8guLfWfXvVhxylqbaqcj4hZU86cA0LWEK7UBE0RM1Ps50NATWbzTBYdGd50AjZxrlZXH56t+NVx2YtlmVi88y6Rrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068910; c=relaxed/simple;
	bh=sFYXfRTVBaIW6mbGDe/bYSaxz7VhBO3sbXKsXbug8BU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AsgAKyUD6cYi0qtVX5NnGwjAtePax2v/evAG9ig30+rkOA/bEgTEYKNjXUC6B2rAmucoWff/rW/Hs16GnWjcTZIOmB/PupzrZ8EQ9E9vNjCwonvNePgs691/ZwIXgMEv/TQDFxJoUKyfDqkej799ujoBWGQp18Yt5USxW9I6pEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=Yadns7to; arc=none smtp.client-ip=216.150.161.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="Yadns7to"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=2112; q=dns/txt;
  s=NAESA-Selector1; t=1792068909; x=1823604909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0gn0ipHnBnEnnuWNB3XyCR/eq/dBn2N7SSrrBn41Q04=;
  b=Yadns7tohPkS4sXaN8+5jxiqTH/tNqjntkjdF3wd39J5f73Nn0aU5QQl
   OwZsdOuui/6oQvG+pd+kngQ81tqlwTUfI9o60rnTqf0sxlxTTVOLDd3Td
   DznvJsHosj6So8YqYhFR3hm2fwx7zFdJ/mP8++CwhjHOJaWWwNUqUcorC
   +OqrQRFe40ovqqGCGyX2OrS+Fh9z169pyxinZuUMRcMg2uNbzJiGWeWs0
   43EznzDMplunzgiMgA6ix0GjViMU5+nYEKsMz4aLxoBPf18ZlD0C3bAgS
   Vm4oG6mUF5xiJFxm0uhpDkvtlYryTjrtPOxNqK6M3Dl5CJ7KULKWhvc2D
   A==;
X-CSE-ConnectionGUID: vrUK9oyaSBKSmW/MB6gedA==
X-CSE-MsgGUID: r+mjYLlESGmWEurMYVaQ6w==
X-IronPort-AV: E=Sophos;i="6.27,159,1787032800"; 
   d="scan'208";a="66052756"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa06out.arrow.com with ESMTP; 15 Oct 2026 06:55:07 -0600
Received: from AHMCPU1888.localdomain ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.20348.1);
	 Thu, 15 Oct 2026 18:24:55 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Min Lin <linmin@eswincomputing.com>
Cc: Yulin Lu <luyulin@eswincomputing.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: [PATCH v5 7/7] riscv: dts: eswin: add watchdog support
Date: Thu, 15 Oct 2026 18:24:54 +0530
Message-Id: <20261015125454.1381941-8-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com>
References: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Oct 2026 12:54:55.0359 (UTC) FILETIME=[607400F0:01DD5CA4]

From: Pritesh Patel <pritesh.patel@einfochips.com>

EIC7700 have four DesignWare watchdog controllers that are
integrated to SoC.

The controllers use only SoC-internal register, interrupt, clock and
reset resources and have no board-level dependencies, so describe them
as available in the SoC DTSI.

Each watchdog counter is driven by its corresponding LSP APB clock.
The NOC_WDREF clock belongs to the separate NoC watchdog and is not
used by these controller instances.

Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 arch/riscv/boot/dts/eswin/eic7700.dtsi | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
index c0aa91b357ff..ec58a3aaf582 100644
--- a/arch/riscv/boot/dts/eswin/eic7700.dtsi
+++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
@@ -265,6 +265,42 @@ syscon: syscon@50440000 {
 			};
 		};
 
+		wdt0: watchdog@50800000 {
+			compatible = "snps,dw-wdt";
+			reg = <0x0 0x50800000 0x0 0x4000>;
+			interrupts = <87>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_WDT0_PCLK>;
+			clock-names = "tclk";
+			resets = <&reset EIC7700_RESET_WDT0>;
+		};
+
+		wdt1: watchdog@50804000 {
+			compatible = "snps,dw-wdt";
+			reg = <0x0 0x50804000 0x0 0x4000>;
+			interrupts = <88>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_WDT1_PCLK>;
+			clock-names = "tclk";
+			resets = <&reset EIC7700_RESET_WDT1>;
+		};
+
+		wdt2: watchdog@50808000 {
+			compatible = "snps,dw-wdt";
+			reg = <0x0 0x50808000 0x0 0x4000>;
+			interrupts = <89>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_WDT2_PCLK>;
+			clock-names = "tclk";
+			resets = <&reset EIC7700_RESET_WDT2>;
+		};
+
+		wdt3: watchdog@5080c000 {
+			compatible = "snps,dw-wdt";
+			reg = <0x0 0x5080c000 0x0 0x4000>;
+			interrupts = <90>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_WDT3_PCLK>;
+			clock-names = "tclk";
+			resets = <&reset EIC7700_RESET_WDT3>;
+		};
+
 		uart0: serial@50900000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x50900000 0x0 0x10000>;
-- 
2.34.1

