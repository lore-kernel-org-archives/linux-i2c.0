Received: from naesa04.arrow.com (naesa04.arrow.com [216.150.161.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463213E1D08;
	Fri, 14 Aug 2026 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786690822; cv=none; b=qH5aJUFsccJayxFMmQ7UkACiXgcThTT3EsAtJIV1mHE58BUzNeYhAaj0+LfAvMcIocjF4L9MNdrdC7QLTmdl0svC57vS7eGc7+tvYV9/z5J6HvgLovRKZEstGPFAMpbV9FsYxwYdT1ooLy4XLuR3VMx3VY8+rN+cOxY56siLeeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786690822; c=relaxed/simple;
	bh=GmibCSG1czEh4eM32+v3ST+nPO+iDZcFxLpO9psyBK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RYp/ruWYsXsSE0qOpyLuI4+VPU3PV9b6ghS3CGEda9I4killcn9ilu82NpgLPM5CEAkSfUfYPHH71iGLefsOF/koRcPsPmouUm/m5XG8YQ251T1lJ//R/r5VoP3L3fhXG+3ZDZdJZ4iPAx7NNSPdflGswTk7G2oY1k9GKgL/pCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=acG93n+6; arc=none smtp.client-ip=216.150.161.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="acG93n+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=2469; q=dns/txt;
  s=NAESA-Selector1; t=1786690821; x=1818226821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zWjc0zDm2XCS4I4d7OAmZbsTMJxQhD/sBavgsjk79Ho=;
  b=acG93n+6lewcnYlwwpjfKveEfldvl8QU5OUMQgkASs6xGjLnqfCy0pMQ
   e1ZoAJqjx8QXU73lN1+FNaOANjjO0iLGK980HVSmab+5tyuowicG+4Fjb
   65VB7r/bmKQHNKOxSgZW8pN6N7JIm9y+18IPXSXEgQMSNCDn0BoPJxLm8
   injM0lMR7pW5FLdzSTIxOueAQWCVpNA0xisZJ4E1m1ffiMByU4gFsOvLa
   /FZbUXOtDlAORf99YuLGTElj4V4FjjAUQsVUhsSeP0ICD0rnSKb4VQEoW
   v57N3K7HEMEpIMkraqbMDxHNG5vlC1CANZnhLF4dMBzoqVOd1YT82GMbq
   Q==;
X-CSE-ConnectionGUID: nnH5iGmoTMmuxxXu1OzYng==
X-CSE-MsgGUID: 4Cot5nFZQiSwVp5knSQMSA==
X-IronPort-AV: E=Sophos;i="6.25,222,1779170400"; 
   d="scan'208";a="119916488"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa04out.arrow.com with ESMTP; 14 Aug 2026 01:00:20 -0600
Received: from AHMCPU1888.localdomain ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.20348.1);
	 Fri, 14 Aug 2026 12:30:07 +0530
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
Subject: [PATCH v4 7/7] riscv: dts: eswin: add watchdog support
Date: Fri, 14 Aug 2026 12:30:07 +0530
Message-Id: <20260814070007.1662455-8-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260814070007.1662455-1-pinkesh.vaghela@einfochips.com>
References: <20260814070007.1662455-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Aug 2026 07:00:07.0833 (UTC) FILETIME=[8A7CD090:01DD2BBA]

From: Pritesh Patel <pritesh.patel@einfochips.com>

Add watchdog node for ESWIN EIC7700 SoC and enable them for HiFive
Premier P550 board

Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 .../dts/eswin/eic7700-hifive-premier-p550.dts | 16 ++++++++
 arch/riscv/boot/dts/eswin/eic7700.dtsi        | 40 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
index 5dddcf13fd25..103c3dab184f 100644
--- a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
+++ b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
@@ -207,3 +207,19 @@ &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_pins>;
 };
+
+&wdt0 {
+	status = "okay";
+};
+
+&wdt1 {
+	status = "okay";
+};
+
+&wdt2 {
+	status = "okay";
+};
+
+&wdt3 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
index c13432d14504..f873e9eeb929 100644
--- a/arch/riscv/boot/dts/eswin/eic7700.dtsi
+++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
@@ -265,6 +265,46 @@ syscon: syscon@50440000 {
 			};
 		};
 
+		wdt0: watchdog@50800000 {
+			compatible = "snps,dw-wdt";
+			reg = <0x0 0x50800000 0x0 0x4000>;
+			interrupts = <87>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_WDT0_PCLK>;
+			clock-names = "tclk";
+			resets = <&reset EIC7700_RESET_WDT0>;
+			status = "disabled";
+		};
+
+		wdt1: watchdog@50804000 {
+			compatible = "snps,dw-wdt";
+			reg = <0x0 0x50804000 0x0 0x4000>;
+			interrupts = <88>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_WDT1_PCLK>;
+			clock-names = "tclk";
+			resets = <&reset EIC7700_RESET_WDT1>;
+			status = "disabled";
+		};
+
+		wdt2: watchdog@50808000 {
+			compatible = "snps,dw-wdt";
+			reg = <0x0 0x50808000 0x0 0x4000>;
+			interrupts = <89>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_WDT2_PCLK>;
+			clock-names = "tclk";
+			resets = <&reset EIC7700_RESET_WDT2>;
+			status = "disabled";
+		};
+
+		wdt3: watchdog@5080c000 {
+			compatible = "snps,dw-wdt";
+			reg = <0x0 0x5080c000 0x0 0x4000>;
+			interrupts = <90>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_WDT3_PCLK>;
+			clock-names = "tclk";
+			resets = <&reset EIC7700_RESET_WDT3>;
+			status = "disabled";
+		};
+
 		uart0: serial@50900000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x50900000 0x0 0x10000>;
-- 
2.34.1

