Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535443C063A;
	Thu, 30 Jul 2026 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396648; cv=none; b=M3+u0HpaDY8b8cI9gF82rpDHi6i1tiWVTMla1D3/RqjZiX4G7dFFE9BRs9BN9NZbLPRS0LDzxPHybxR9WiVRB58HlOSKRdbIiaDToQJd3KCzihHJmps8P0t+PqJdg0Ga9o7CCmTlxyN2BO0X7aH82qsXVI87V/Dr+bua/jPTPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396648; c=relaxed/simple;
	bh=8WpAkduFdZ6ug593/4QpOWGNMyig/xKW9ZgqKDqhqiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BW86rVawbfrloX7kKfNPotUU8C5lOop4biSJ7H/jpHzYKRSut0wRmP7FG8pmA+vb36WJ66zp7U3LpgeGgrIJEmxQtPpiROiYI9M4KJ7GNlmGMHLR22UYNlXz/NbwmhwVvYVcS4tBtPIyf+vtHxEu1Jsoe2uQcxzkk6CpBrTQxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=qE2UPmGy; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="qE2UPmGy"
X-UUID: d80fb5d88be711f181a149c3f3c08161-20260730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=THQP/Pex6bFx9fE5Ro0GudfwOQGGezmYlDNzOaf1li8=;
	b=qE2UPmGyLEwwnjM3CWrOBd3oZUGz0mgM/7K10D48sxGcArboyRUQRrBR5a30bogvPODCmgNxEoRp2V1fwrEG2lAy5Nyygrv0HsBoMbt2A+pod3qQfwOeGYp1o+yU/hs6WJ9J8q7r7LLchWI++FWqjEazucZ94Mxm3mUqSFUq5QY=;
X-UUID: d80fb5d88be711f181a149c3f3c08161-20260730
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 673353461; Thu, 30 Jul 2026 15:25:30 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 5AF111A1E1C;
	Thu, 30 Jul 2026 15:25:30 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 69B33C600CF; Thu, 30 Jul 2026 15:25:29 +0800 (CST)
From: nina_kuo@novatek.com.tw
To: andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ben_huang@novatek.com.tw,
	toby_chui@novatek.com.tw,
	shihpei_hsu@novatek.com.tw
Subject: [PATCH v4 0/3] i2c: Add Novatek NT72676 SoC I2C controller
Date: Thu, 30 Jul 2026 15:25:26 +0800
Message-Id: <20260730072529.492398-1-nina_kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>


This patch series adds support for the I2C bus controllers on
Novatek NT72676 SoC.

NT72676 SoC provides two I2C controller variants:

- Generic I2C controller
  - Accessible only by the host CPU
  - Driven by a 96 MHz AHB clock

- STBC I2C controller
  - Accessible by either the host CPU or STBC (Standby Controller)
  - Driven by a 12 MHz STBC clock
  - Requires STBC authentication before CPU access

The controller driver implements the fundamental I2C read/write
operations and supports Standard-mode and Fast-mode.

The input clock rates of the two controller variants are fixed by
hardware integration and are not configurable. There is currently
no clock provider driver available for NT72676 SoC, therefore the
driver uses compatible-specific clock rate data instead of the common
clock framework.

This series was tested with concurrent I2C read/write operations on
two I2C buses for 1,000,000 iterations on NT72676 SoC.
No errors or data corruption were observed.

---
v4:
  From Krzysztof's review:
  - Replace all occurrences of "726xx" with "72676"
  - Reorganize the patch series
  - In novatek,nt72676-i2c.yaml:
    - Correct the order of entries
    - Change the compatible string of generic I2C to
      "novatek,nt72676-i2c"
    - Add the compatible string of STBC I2C as
      "novatek,nt72676-stbc-i2c"
    - Remove `novatek,hwmods` custom property
  - In i2c-nt72676.c:
    - Use dev_err() and dev_info() for driver messages
    - Remove unnecessary logs
    - Add different compatible data to "novatek,nt72676-i2c" and
      "novatek,nt72676-stbc-i2c"
    - Replace platform_get_resource() and devm_ioremap_resource() with
      devm_platform_ioremap_resource()
    - Remove definition of owner under nvt_i2c_driver
    - Register this driver with module_platform_driver()

  From internal review:
  - Modify commit messages
  - In novatek,nt72676-i2c.yaml:
    - Add description about the I2C controllers on Novatek NT72676 SoC
    - Add `novatek,stbc-syscon` custom property for STBC authentication
    - Modify the examples for generic I2C and STBC I2C
  - In i2c-nt72676.c:
    - Add nt72676_i2c_writel() and nt72676_i2c_readl() wrappers for
      register access
    - Modify definitions of the I2C registers for both generic I2C and
      STBC I2C use
    - Use BIT() and GENMASK() for register bit definitions
    - Use regmap to access STBC syscon registers for authentication
      before CPU access

v3:
  https://lore.kernel.org/lkml/20260715073443.147490-1-Nina_Kuo@novatek.com.tw/T/#t

  - Only remove attached HTML messages, no code is modified.

v2:
  https://lore.kernel.org/lkml/20260714094145.84387-1-Nina_Kuo@novatek.com.tw/T/#t

  From Krzysztof's review of novatek,nt726xx-i2c.yaml:
  - Explicitly specify the unique compatibles "novatek,nt72600-i2c" for
    Novatek NT726xx SoCs
  - Modify `maxItems` as 1 for both `reg` and `interrupts` properties
  - Modify description and allowed values for `clock-frequency`
    property
  - Remove `minItems` for `novatek,hwmods` custom property
  - Rename, fix wrong type definition and add more description for
    `novatek,stbc-controllable` custom property
  - Remove `bus-enable` custom property
  - Add an example for dtsi declaration

  From Sashiko AI's review of i2c-nt726xx.c:
  - Remove flows related to `bus-enable` custom property
  - Add default value 100000 (100 kHz) of `clock-frequency` property
    to prevent from divide-by-zero panic
  - Add flows for handling ioremap() in nvt_i2c_use_case_feature()
  - Remove I2C_FUNC_SMBUS_QUICK functionality due to unsupported handling
    of 0-byte messages
  - Add flows of disabling IRQs in nvt_i2c_suspend() and nvt_i2c_remove()
  - Add of_node_get() to release the reference to device tree node in
    nvt_i2c_remove()

v1:
  https://lore.kernel.org/lkml/20260604060411.355675-1-SP_ISW1_AT@novatek.com.tw/T/#t

Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>


Ben Huang (3):
  dt-bindings: i2c: Add Novatek NT72676 I2C controller
  i2c: nt72676: Add Novatek NT72676 I2C controller driver
  MAINTAINERS: Add entry for Novatek NT72676 I2C controller driver

 .../bindings/i2c/novatek,nt72676-i2c.yaml     |  87 +++
 MAINTAINERS                                   |   7 +
 drivers/i2c/busses/Kconfig                    |  10 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-nt72676.c              | 683 ++++++++++++++++++
 5 files changed, 788 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-nt72676.c

-- 
2.40.1

