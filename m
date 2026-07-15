Received: from ms1.novatek.com.tw (ms2.novatek.com.tw [210.202.87.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585E93093B2;
	Wed, 15 Jul 2026 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100891; cv=none; b=VXcje52mipDLMlgtyWqRKlk8n1I8zWAzUvfd6yvOnDVmgly2eib2AOzMm8b/9Q7by5UuFnFNYBNsf/sJ+2rDQsvoyjPmLffRAaCWEae/VhjDYFtd7mu8Fiusa1ClyyEwGIQ7WrLWzB8J2sNky+o7sUjybNYfuoMFE0Zl0APqcMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100891; c=relaxed/simple;
	bh=Wcb++m92V9hvFlQzcVIJv64/Pwz+jt3TQ7gFX4Lppkg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KGIQP98Sk+QMg8nZoGQ0RED3/k0QdNAyhX8Nf0w4YH57X5sB4ix+6iW3VEaxGJbx1xto/0nqGhu7cd+xMQP4wOjif7Q4lkX10Dw6DNfKJjoATj+eMYE91rg0zcm/Lk63UuzTCfSzOrxhpNYeDxdeXZjz6kY9JLl0bPmnUYG13xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw; spf=pass smtp.mailfrom=novatek.com.tw; dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b=D/bNx/28; arc=none smtp.client-ip=210.202.87.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novatek.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=novatek.com.tw header.i=@novatek.com.tw header.b="D/bNx/28"
X-UUID: a640f0ea801f11f181a149c3f3c08161-20260715
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=novatek.com.tw; s=dk;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=zUt4As37EymK+5fg83gCf/6qVyPw1vM27E8ObrpMyqE=;
	b=D/bNx/28Pa0FbtA1wz7hOOttXllk2SF1JRXrW7HtwqSHi8qBXXMPeauvGwjFllJBno089G6XLqi6YJY5TjZ6i4WtQN0W4LCZmWcgNrJTSAyXLTSadBjQmq7b7NcwKZgFtXHzqRKLXhddM2GcnJwDPD4AcFI5nvBrgYULmyUh3U4=;
X-UUID: a640f0ea801f11f181a149c3f3c08161-20260715
Received: from spmgt1 [(172.20.13.10)] by ms1.novatek.com.tw
	(envelope-from <sp_isw1_at@novatek.com.tw>)
	(Generic MTA)
	with ESMTP id 1059255918; Wed, 15 Jul 2026 15:34:44 +0800
Received: from oabuild50.novatek.com.tw (oabuild50.novatek.com.tw [172.20.13.160])
	by spmgt1 (Postfix) with ESMTP id A89DB1A1E1C;
	Wed, 15 Jul 2026 15:34:44 +0800 (CST)
Received: by oabuild50.novatek.com.tw (Postfix, from userid 1005)
	id A9C48C600CC; Wed, 15 Jul 2026 15:34:43 +0800 (CST)
From: Nina_Kuo@novatek.com.tw
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
Subject: [PATCH v3 0/3] i2c: Add Novatek NT726xx SoC I2C controller
Date: Wed, 15 Jul 2026 15:34:43 +0800
Message-Id: <20260715073443.147490-1-Nina_Kuo@novatek.com.tw>
X-Mailer: git-send-email 2.26.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Huang <Ben_Huang@novatek.com.tw>


These patch series adds support for the I2C bus controllers on
Novatek NT726xx SoCs.

The controller driver implements the fundamental I2C read/write
operations and supports Standard-mode and Fast-mode.

Some I2C bus controllers on Novatek NT726xx SoCs are controllable by
stbc (Standby controller) and named as `stbc-i2c`s. These `stbc-i2c`s
are driven by stbc clock (12 MHz) and require the authentication to
stbc before any control.

The patch is tested with concurrent read/write operations on
2 different I2C busses for 1000000 times on Novatek NT72676 SoC.
Neither error nor data corruption is detected under this test.

---
v3:
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
    to prevent from devide-by-zero panic
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
  MAINTAINERS: Add entry for Novatek NT726xx SoC I2C controller driver
  dt-bindings: i2c: Add Novatek NT726xx SoC I2C controller
  i2c: Add i2c-nt726xx.c I2C driver for Novatek NT726xx SoCs

 .../bindings/i2c/novatek,nt726xx-i2c.yaml     |  74 ++
 MAINTAINERS                                   |   7 +
 drivers/i2c/busses/Kconfig                    |  10 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-nt726xx.c              | 698 ++++++++++++++++++
 5 files changed, 790 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/novatek,nt726xx-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-nt726xx.c

-- 
2.40.1

