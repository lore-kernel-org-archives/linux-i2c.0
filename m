Received: from naesa06.arrow.com (naesa06.arrow.com [216.150.161.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD371525A75;
	Thu, 15 Oct 2026 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069093; cv=none; b=oQtHtIBD7F3WR+1GtodRyKnsXsZqNhzjC2pDOb6b2qYHOjl6dvY8U7M8umc8+MMh6ktOjedtcmSB6lenVdX5S2N8Sl44pXnjC6UdxFgoY6+BrJEAtt1OQd9tKveYjaONx8oRIRVQ5EzCZuRGopF7ecgwYrud6eC4u7hy1ITWPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069093; c=relaxed/simple;
	bh=oGOFlSyRwWNSipqtC663/06NHwSVZdbzySBFSwSOxLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SPs22L3e0t2pH3oGYnKrERJGgF9SrppdoR2V0EvjVfyQqhl+54TSzGXArCmZYnndCgEsZe+Pi/Wz5G1qs0XzTxPX+uLtA+7mDCVsfNcy2dkrzDfjZ6aGDFswuT4yGbxcJRXD9m3nOHqo6Zoqmr0pdTXWyDkavqJ7RZNCNMkbRTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=SCcHD+aA; arc=none smtp.client-ip=216.150.161.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="SCcHD+aA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=1887; q=dns/txt;
  s=NAESA-Selector1; t=1792069092; x=1823605092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ShnbVuSJnvDO1yDDDt1DyIbRfQh4el11rwFcGN8Hw/E=;
  b=SCcHD+aA91yyg09Wrkaevjv9UDG2fSo8EHG3rrmq0jLCqnj0kVcxyCXn
   rFm3jzXkq7jyUOiVoxxVCDjxmdeRsIH/cIsfnd7WF2fRfEs6YDNWY/SeE
   ws/FnpefXbDfhMOOsleh4CqjPlob7NWdTPcC/BEdzJQnPuJJDhUEBaQiG
   oz1+3+1YouJZUM5q2MHJuSYw4mCYviHM5O4lv6XUxlIsRLGzyMGYuMM/S
   cnSnKXFha+h1wK3cYZpBVTNEoQWh7wwUY+zXrDGriTaA3tQlNdXpXRKIl
   GziKPIJ0IRvMcZhTrBWGqNhyW6Y4YRxNDUrSm0qHcjRI7sgbOD7bfBIj0
   g==;
X-CSE-ConnectionGUID: eOAY/qkoRCWtlFLImXL/hQ==
X-CSE-MsgGUID: HnYv07CSQJ+gIEMigW6eYA==
X-IronPort-AV: E=Sophos;i="6.27,159,1787032800"; 
   d="scan'208";a="66052735"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa06out.arrow.com with ESMTP; 15 Oct 2026 06:54:59 -0600
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
Subject: [PATCH v5 2/7] riscv: dts: eswin: add clock generator for EIC7700 SoC
Date: Thu, 15 Oct 2026 18:24:49 +0530
Message-Id: <20261015125454.1381941-3-pinkesh.vaghela@einfochips.com>
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
X-OriginalArrivalTime: 15 Oct 2026 12:54:55.0154 (UTC) FILETIME=[6054B920:01DD5CA4]

From: Pritesh Patel <pritesh.patel@einfochips.com>

Add clock generator node for EIC7700 SoC.
HiFive Premier P550 boards have 24MHz crystal oscillator to provide
the input clock.

Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 .../boot/dts/eswin/eic7700-hifive-premier-p550.dts  |  5 +++++
 arch/riscv/boot/dts/eswin/eic7700.dtsi              | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
index 131ed1fc6b2e..a5c76b14a38f 100644
--- a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
+++ b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
@@ -20,6 +20,11 @@ chosen {
 	};
 };
 
+&osc {
+	clock-frequency = <24000000>;
+	clock-output-names = "osc_24m";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
index 430a210f01e6..b3a230870315 100644
--- a/arch/riscv/boot/dts/eswin/eic7700.dtsi
+++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
@@ -4,6 +4,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/clock/eswin,eic7700-clock.h>
 #include <dt-bindings/reset/eswin,eic7700-reset.h>
 
 / {
@@ -203,6 +204,11 @@ pmu {
 				<0x00000000 0x0000000f 0xfffffffc 0x000000ff 0x00000078>;
 	};
 
+	osc: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		ranges;
@@ -343,6 +349,13 @@ gpioD: gpio-port@3 {
 			};
 		};
 
+		clk: clock-controller@51828000 {
+			compatible = "eswin,eic7700-clock";
+			reg = <0x0 0x51828000 0x0 0x300>;
+			clocks = <&osc>;
+			#clock-cells = <1>;
+		};
+
 		reset: reset-controller@51828300 {
 			compatible = "eswin,eic7700-reset";
 			reg = <0x0 0x51828300 0x0 0x200>;
-- 
2.34.1

