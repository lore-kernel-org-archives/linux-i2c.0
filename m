Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF103FD139;
	Tue, 11 Aug 2026 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433447; cv=none; b=M+LJoXVjcsVG5P4k4ZW7c/tccn4t50SUb9w3OjlBLpAL0tUVHCeM+FlyG9DnzIuwGodMCJpruPhZDjS2bv0w9zDplUgfMBZAyhLE6AQBreG23UhMSQz0ilqkqnTdjOhlyuAuaMJsFJhgz2VLlCm5zZuxQRDGEvn54UO/wANq4VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433447; c=relaxed/simple;
	bh=pQvbm859US7PYhb6B+bNDD/Lm9FA9m+P3JXYFow6Rhg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gOwKxEom9NGeY3C45rNqwzHsRF0ZI3uVVOoXebhnEoe7ga57sWle48Q3FGQbRAS74Rk7VFF2XejBcneoVqRaz4LvMFN20NMIWARNc8NxBmVJikInAHF1E4oiA5c5ZLeVwo78OOJZViL83ZZdTB5Jb+NLL5BX8bDI0hp1aM56ArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=o7vfXSSp; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="o7vfXSSp"
X-UUID: 8906785a955611f181a149c3f3c08161-20260811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=bp80VYkzuEyErFHFLFYPVK959iD4wEwz0P7VeuMMRPQ=;
	b=o7vfXSSpQg6bsxMZncZchvpY3sZD+R7MCF47nWpkAZpnyks0rLrUPAHkL7fb0bv6fjCZKIRMCghLkoo07rV24yDell63erMNdBWzONduT1ohcdfmyrx4ExObLSNd2fpMxg1otmGhXPQ9y/OHFE5QTER6EBCun4v3BIw7h0M4Yao=;
X-UUID: 8906785a955611f181a149c3f3c08161-20260811
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 560657524; Tue, 11 Aug 2026 15:30:32 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id 5D8631A1E1C;
	Tue, 11 Aug 2026 15:30:32 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id 63B5AC600D0; Tue, 11 Aug 2026 15:30:31 +0800 (CST)
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
Subject: [PATCH v7 0/3] i2c: Add Novatek NT72676 SoC I2C controller
Date: Tue, 11 Aug 2026 15:30:28 +0800
Message-Id: <20260811073031.1019576-1-nina_kuo@novatek.com.tw>
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
v7:
  From Sashiko AI's review of i2c-nt72676.c in PATCH 2/3:
  - Modify the flow of checking the sub-address pattern for 2-message
    transfer and the control to I2C_REG_CTRL and I2C_REG_SUBADDR
  - Add NULL checking of i2c->comp_data
  - IRQ will be enabled only before read/write operation
  - Add spin lock protection to msg_complete
  - Use regmap_update_bits() instead to control the STBC syscon
    registers
  - Advertise the I2C_AQ_NO_ZERO_LEN quirk

v6:
  https://lore.kernel.org/lkml/20260806035632.777782-1-nina_kuo@novatek.com.tw/T/#t

  - Add a Reviewed-by tag to PATCH 1/3, where novatek,nt72676-i2c.yaml
    is not changed
  - From Sashiko AI's review of i2c-nt72676.c in PATCH 2/3:
    - Fix potential interrupt storm in the IRQ handler
    - Add IRQ handling for I2C_IRQ_CLK_STR_TIMEOUT interrupt
    - Add a spinlock for the synchronization of current_msg and
      interrupt register control
    - Check the first message type is a sub-address write and with the
      maximum length of 4 bytes (32 bits)
    - Interrupt registers would be cleared if failed to
      i2c_add_adapter()
    - Move i2c_del_adapter() before disabling I2C controller

v5:
  https://lore.kernel.org/lkml/20260804033419.693819-1-nina_kuo@novatek.com.tw/T/#t

  From Krzysztof's review:
  - In novatek,nt72676-i2c.yaml:
    - Remove '|' in description
    - Add `clock` property

  From internal review:
  - In i2c-nt72676.c:
    - Use dev_err_probe() for errors in probing
    - Modify coding styles

v4:
  https://lore.kernel.org/lkml/20260730072529.492398-1-nina_kuo@novatek.com.tw/T/#t

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

 .../bindings/i2c/novatek,nt72676-i2c.yaml     |  90 +++
 MAINTAINERS                                   |   7 +
 drivers/i2c/busses/Kconfig                    |  10 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-nt72676.c              | 756 ++++++++++++++++++
 5 files changed, 864 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt72676-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-nt72676.c

-- 
2.40.1

