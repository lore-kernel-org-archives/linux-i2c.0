Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588639A812;
	Mon,  6 Jul 2026 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325535; cv=none; b=Bk6YE94Ehra+xFdT64f3Nb2y1kUFa4lNGrTmfGSTG1W4uoHqNlHs1GfDU52EXypPBNXTdXlEf4Zh76EkewYVt5tgjrgR0Ltx0LpyahWVLqwEQjFbn1/Evt57VUkV/MFbC4K403DtpJRxJb8SbrShqMmCLfGuLZEngZXPXUTdEJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325535; c=relaxed/simple;
	bh=pw0vj+IpR76LWh+hrLVLHyzI3AzgtdkykGqp6E1Y7Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UjcAtF5S18Kch05UlxWp92D3CWlxyzzlCq2zOcvagDvTjUEk6CRFYpW2Qc9FoPF2Zl3L2Y2AiCnmg60Eo8NhkBFc25OT91k8wgVDDVacKBeut7t9XhjgL1kimf+A0TjFbsvcY7EVbfdBs+1KUTpGFNnxiu8prmYeNWX7k+v4JZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=kTVoD+hW; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="kTVoD+hW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=1762; q=dns/txt;
  s=NAESA-Selector1; t=1783325532; x=1814861532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DsT3k1JxGiBxu8sTPdmZdN71lJZTeiOhorI0VrVBI4Q=;
  b=kTVoD+hWTU2Gi37oH5kdwZkmM2DWNKX4df53NpEOWhD70SKByw9S0zoB
   FpPI7aR4ksnSJJUDxFUJBTNohQ4KiQIbajEmKb1ASZzFvvQGpXbOyM6oD
   XuNniWpD+VGxV1255YYzGpvyASl0FFUtEpcgwFV3XNvS16nyGN9MHjVYM
   OBd/AcWbUN5froU0s98QXdPnR20SAk+8/JtNft6QgDkwA3V1CB2jArle+
   dtuKk68rcLivJ9wXNPgvaxBe+maElU0pTAaw5wfcNkMbdbvPpNBhJWiHV
   LboMqbpE8znDeO8EUFzgO9d6QmgIxe+X9kLEejtPHwfpSAuEDzecctz5U
   w==;
X-CSE-ConnectionGUID: cOMtjOruTUSRlcdRNeXm3w==
X-CSE-MsgGUID: LCxTXXzCS26HvEadZL00sw==
X-IronPort-AV: E=Sophos;i="6.25,149,1779170400"; 
   d="scan'208";a="57540289"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 06 Jul 2026 02:10:57 -0600
Received: from AHMCPU1888.localdomain ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.20348.1);
	 Mon, 6 Jul 2026 13:40:55 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v2 0/8] riscv: eswin: eic7700: Add support for clocks, resets, pinctrl, HSP bus, I2C and watchdog
Date: Mon,  6 Jul 2026 13:40:47 +0530
Message-Id: <20260706081055.1126275-1-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Jul 2026 08:10:55.0812 (UTC) FILETIME=[F85EB840:01DD0D1E]

Changes in v2:
- Rebased the patches to kernel v7.2-rc2
- Updated dts file
  - Changed "xtal" to "clock_24m".
  - Changed the node name from "vcc1v8" to "regulator-vcc1v8".
  - Changed the node names from "pac1934" to "adc" and "ina226" to
    "power-sensor".
- Updated eic7700.dtsi file
  - Changed the label from "xtal" to "clock_24m".
  - Changed the label from "hsp_power_domain" to "hsp".
  - Added soc-specific compatible string for all i2c controllers.
- Updated pinctrl.dtsi file
  - Corrected the function of rgmii0, rgmii1, and the i2s pin groups.
- Added "Acked-by" tag of "Conor Dooley" for Patch 4.
- Updated the commit message for Patch 5.
- Added patch(#6) that introduces ESWIN specific compatible string
  "eswin,eic7700-i2c" in snps,designware-i2c.yaml file.
- Link to v1: https://lore.kernel.org/lkml/20260615122016.1110206-1-pinkesh.vaghela@einfochips.com/

Pinkesh Vaghela (2):
  dt-bindings: mfd: syscon: add ESWIN EIC7700 compatible
  riscv: dts: eswin: add hsp bus node

Pritesh Patel (5):
  riscv: dts: eswin: add reset generator for EIC7700 SoC
  riscv: dts: eswin: add clock generator for EIC7700 SoC
  dt-bindings: i2c: dw: add ESWIN EIC7700 SoC I2C controller
  riscv: dts: eswin: add I2C controller support
  riscv: dts: eswin: add watchdog support

Yulin Lu (1):
  riscv: dts: eswin: eic7700: add pinctrl support

 .../bindings/i2c/snps,designware-i2c.yaml     |   1 +
 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../dts/eswin/eic7700-hifive-premier-p550.dts | 182 ++++
 .../riscv/boot/dts/eswin/eic7700-pinctrl.dtsi | 888 ++++++++++++++++++
 arch/riscv/boot/dts/eswin/eic7700.dtsi        | 234 +++++
 5 files changed, 1307 insertions(+)
 create mode 100644 arch/riscv/boot/dts/eswin/eic7700-pinctrl.dtsi

-- 
2.34.1

