Received: from naesa06.arrow.com (naesa06.arrow.com [216.150.161.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359B23A99F;
	Thu, 15 Oct 2026 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069090; cv=none; b=X4+5LKAqAAs/rhyxzDgA6Vid4ZbugqwAxt/Pc9wj2lwTxfc1g/JYovt6ocSXBjUeemyMiFwiSUf7qqDao7sB78vwuZHuUVJNenO1hHNQtfCeb9SEFigrue40x/eOUar7TiKLmAbx4SUiHQd3j2ZCI6uENPKPyOPVnscE57AcJR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069090; c=relaxed/simple;
	bh=epzI3b95cmaUe+XED/ujwoGNUbfRLLENFhvSJ98CLDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YY4g9vvDpVABAZclnlLbsJHLF39xBI2qPwHd6ch9XRzEHPGEbXy0QQth0MME/6YAgWsir7GZtYSyGK36NPW9nX1Dl9DQwD8A5S+Tos3+O1MutKn7mYLS/y5hFV+CisSOxNAKyw3YdoDgWT/DP75qVtfXZJRwfpOHlZvM/p3IDEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=RahSIRdO; arc=none smtp.client-ip=216.150.161.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="RahSIRdO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=1839; q=dns/txt;
  s=NAESA-Selector1; t=1792069090; x=1823605090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KFb8TFgQbX2FJlutJnLiqDlIKXZrvpZGANN2h8M5k74=;
  b=RahSIRdOg63oaUXYqde//tdaKDwPHJJ085/9LFzypmnzH+v6SCgKyur7
   VA03eluGM4f1fnoHkVGCGEPHnUUoQ5o0/GPYtZC/EK2r44UkLfTVkruSU
   Mu26gngbH9rENmr8z4jHhwXHuKaydYmh6ZdMa06shMvsCBA93h+Mjv+z3
   hVeHLh3iySGviph/Da9fdybeYpSIqP5yUWOoDGNU+ZaUOke3qikQSo3mk
   OLHBsn7le+rHyBQbqKPQHyIJKhjAlxw1EKUFSolOFXa9oxy4G79GgYGWH
   rdNSASwf1oLWGoLE99FnkjF4XRzKJoUIE9Euj0OuoOqvshWloK+a7DaXx
   A==;
X-CSE-ConnectionGUID: JLe9iawMS9O6s+tuZ6siNQ==
X-CSE-MsgGUID: RcH2yzdzSZmGWO2JzaUlCw==
X-IronPort-AV: E=Sophos;i="6.27,159,1787032800"; 
   d="scan'208";a="66052728"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa06out.arrow.com with ESMTP; 15 Oct 2026 06:54:56 -0600
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
Subject: [PATCH v5 0/7] riscv: eswin: eic7700: Add support for clocks, resets, pinctrl, HSP bus, I2C and watchdog
Date: Thu, 15 Oct 2026 18:24:47 +0530
Message-Id: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Oct 2026 12:54:55.0091 (UTC) FILETIME=[604B1C30:01DD5CA4]

Changes in v5:
- Rebased the patches to master branch of linux-next tree having
  latest tag: next-20261014.
- Updated dts file
  - Arranged the nodes in alphabetical order.
  - Removed the board-wide GPIO pinctrl state and attached GPIO84 to
    its gpio-leds consumer.
  - Moved the invariant I2C pinctrl states from board overrides into
    the corresponding SoC controller nodes.
  - Removed enabling watchdog nodes and describe them as enabled at
    SoC level.
- Updated dtsi file
  - Added pinctrl property to all I2C controller nodes.
  - Sorted the always-on I2C controllers by unit address.
  - Removed default property "disabled" from all watchdog nodes.
- Updated pinctrl.dtsi file
  - Resolve missing space issue.
  - Annotate all nodes with /omit-if-no-ref/.
  - Removed duplicated base pins from the quad-SPI pin states.
  - Split UART1 RTS/CTS from its TX/RX pin state.
- Added "Acked-by" tag of "Andi Shyti" for the I2C binding patch
  (i.e. Patch 5).
- Link to v4: https://lore.kernel.org/lkml/20260814070007.1662455-1-pinkesh.vaghela@einfochips.com/

Pinkesh Vaghela (1):
  riscv: dts: eswin: add hsp bus node

Pritesh Patel (5):
  riscv: dts: eswin: add reset generator for EIC7700 SoC
  riscv: dts: eswin: add clock generator for EIC7700 SoC
  dt-bindings: i2c: dw: add ESWIN EIC7700 SoC I2C controller
  riscv: dts: eswin: add I2C controller support
  riscv: dts: eswin: add watchdog support

Yulin Lu (1):
  riscv: dts: eswin: eic7700: add pinctrl support

 .../bindings/i2c/snps,designware-i2c.yaml     |    1 +
 .../dts/eswin/eic7700-hifive-premier-p550.dts |   91 ++
 .../riscv/boot/dts/eswin/eic7700-pinctrl.dtsi | 1065 +++++++++++++++++
 arch/riscv/boot/dts/eswin/eic7700.dtsi        |  255 ++++
 4 files changed, 1412 insertions(+)
 create mode 100644 arch/riscv/boot/dts/eswin/eic7700-pinctrl.dtsi

-- 
2.34.1

