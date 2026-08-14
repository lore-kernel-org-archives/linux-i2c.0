Received: from naesa04.arrow.com (naesa04.arrow.com [216.150.161.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A43E4508;
	Fri, 14 Aug 2026 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786690881; cv=none; b=Ed5Pu2Gd4zfNhlx2BHTCsWo/me1w76Ax6NqWbvy+TuB0bn29RaiFKOXvpm7sb6WennI/f+++wk/1SsQeH8Oy4vv/MZiTGU/3dx5MTvEntky3ogwrWV30aew7ZLIIs+9a85TPDOWnsGO+3OWqWjmmrjO7ttemlMRuDNLW7p6oeKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786690881; c=relaxed/simple;
	bh=oGOFlSyRwWNSipqtC663/06NHwSVZdbzySBFSwSOxLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MG4QM+66VK5V59UE8xVH/oGipvm8SMRrQQC/y6ilG21YsheKtMsybkOmUyZ85uuF0HZPgygDDxhOLEG8/2QMp4pp/ztqAExg0osbYsYOCioOx0VDtJ6i2bow8HTU0HUmqpkIr5JgAXUT+nLR3kuOBPsEz593rpk1jclDw6U2fHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=T816ivpM; arc=none smtp.client-ip=216.150.161.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="T816ivpM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=1887; q=dns/txt;
  s=NAESA-Selector1; t=1786690880; x=1818226880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ShnbVuSJnvDO1yDDDt1DyIbRfQh4el11rwFcGN8Hw/E=;
  b=T816ivpM7izutL2FcBX0y37iIp55XgS25/GP2dXauRvy9Zo0XEllDZ4p
   QfLvsf9xauqEAayq+DaGcmiQi4wA0ANNnX5+458HWqZqUsjKALSwe3W1N
   f1xal50XkaecixELMWgahGH1nthOkfXEV/YUN9r2osXZPj5Ao0BOTB2bt
   Yjd+7IzCE30/OQYkFeM6N1N2QCB4DUGo9qPnpg8blj7iAmAR1C+N++L4E
   uuUI2rFFugy9r9odfSpoUMosIv9zk+27FT1AzT4sP2myOykrhd90CsS7q
   TADCsc6WyNTqYGcXdRDXgGEvdxNiH3v5MHG3771RAf6IgI5TBtEWACUnZ
   g==;
X-CSE-ConnectionGUID: bt3APPY3SWa2u+83uW1fig==
X-CSE-MsgGUID: mozsszvYTx6qM3xk8E1eNA==
X-IronPort-AV: E=Sophos;i="6.25,222,1779170400"; 
   d="scan'208";a="119916440"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa04out.arrow.com with ESMTP; 14 Aug 2026 01:00:12 -0600
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
Subject: [PATCH v4 2/7] riscv: dts: eswin: add clock generator for EIC7700 SoC
Date: Fri, 14 Aug 2026 12:30:02 +0530
Message-Id: <20260814070007.1662455-3-pinkesh.vaghela@einfochips.com>
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
X-OriginalArrivalTime: 14 Aug 2026 07:00:07.0599 (UTC) FILETIME=[8A591BF0:01DD2BBA]

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

