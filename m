Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D847D3B3BE2;
	Tue,  4 Aug 2026 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840343; cv=none; b=hPkr5XBg6IuMnuCdMPXu8Cb0qxc16Fy3R/6Hrpn+eDha1XWivfbqeBGvN1h1HHxnsKuiTBasuuT0J2VM5mw8DTySNm5HI0PuBfV0roa+QugU/YZN4SIhDKEqVCeHZHQP1oIrLRY/Tmo2tc57CLN/r8vy1LWe9iwMl4Ua8mDctek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840343; c=relaxed/simple;
	bh=MsZfwSzSmU66b1iX87KKEAIYvTICleiiA1mwXaoZlrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ss2pKLGkpAAAVV6BcEgteRlWLLjarfiSICS+6YZlI42Xpo6NDw8rmTRmq+hO7w+LFYAC43RAaMyq532Z48oJgn8mDJZg/k1V2xS1QtSg92ja6hKH3CwzKEUEcBfvjxXgwJn4WvkfkbmgnPctrrAjAAU+tsERLjQVDNFLt8cThbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=T3mUmSZY; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="T3mUmSZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=1543; q=dns/txt;
  s=NAESA-Selector1; t=1785840342; x=1817376342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=huJokbZK2j0U2j9/oiCh1A2JWOyzh7r/H9gs5WHit7s=;
  b=T3mUmSZYzrJ57z0dvQgtzDeNnYrpoA7lNB/PTfTUi1K6pwOAb9mmBNr5
   qdaSyWM/J7cZDI4p970aoGVJCkJ+I0gKVu3WbFrRQl/p4cpXh2pAtxfwq
   pfZBIhnLnqgPOp7TPLcvq66H1W62gNblkkFwyFPf6qB9+HokAv1jEkxY7
   fgjwytLSs7VWIEyUoDIncmTu+B+SE/aMBQl0SngWx4nsqmbemPY4Cp2FI
   uaclIf65oepCLxqPB7ZxmeGnlPxYjil8zAaHlvEq+lxWTeGcq1ZcRWHk4
   y7D2N2MufzS2/+qjkh8MTpX7IH7I7Rj12iDzStP6djS1QOhag4hOPbNvx
   g==;
X-CSE-ConnectionGUID: v/P69MbNT6u5yPWBlhtM7Q==
X-CSE-MsgGUID: 7t5Pypc3SE2S5qC8hXWHSA==
X-IronPort-AV: E=Sophos;i="6.25,204,1779170400"; 
   d="scan'208";a="59628992"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 04 Aug 2026 04:44:32 -0600
Received: from AHMCPU1888.localdomain ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.20348.1);
	 Tue, 4 Aug 2026 16:14:31 +0530
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
Subject: [PATCH v3 0/8] riscv: eswin: eic7700: Add support for clocks, resets, pinctrl, HSP bus, I2C and watchdog
Date: Tue,  4 Aug 2026 16:14:23 +0530
Message-Id: <20260804104431.1391839-1-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Aug 2026 10:44:31.0525 (UTC) FILETIME=[3B57AD50:01DD23FE]

Changes in v3:
- Rebased the patches to master branch of linux-next tree having
  latest tag: next-20260803.
- Updated dts file
  - Changed "clock_24m" to "osc".
  - Add the pinctrl-names and pinctrl-0 property for i2c, uart and
    pinctrl nodes.
- Updated eic7700.dtsi file
  - Changed the node name from "clock-24m" to "oscillator".
  - Changed the node name from "hsp-sp-top-csr" to "syscon".
  - Corrected the missing space after "=" sign in watchdog node for
    clocks property.
- Added "Acked-by" tag of "Conor Dooley" and "Mika Westerberg" for
  Patch 6.
- Link to v2: https://lore.kernel.org/all/20260706081055.1126275-1-pinkesh.vaghela@einfochips.com/

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
 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../dts/eswin/eic7700-hifive-premier-p550.dts | 196 ++++
 .../riscv/boot/dts/eswin/eic7700-pinctrl.dtsi | 888 ++++++++++++++++++
 arch/riscv/boot/dts/eswin/eic7700.dtsi        | 234 +++++
 5 files changed, 1320 insertions(+)
 create mode 100644 arch/riscv/boot/dts/eswin/eic7700-pinctrl.dtsi

-- 
2.34.1

