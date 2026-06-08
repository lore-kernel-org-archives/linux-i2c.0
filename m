Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4352ED846;
	Mon,  8 Jun 2026 02:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780886802; cv=none; b=PRijoD3Z6aFFIFjZMbMNS8eU7JYxoSqV9BJA7owE+yw/oOyNcFMOEDX4AiQRzwDMpv8J6Ei/Js493OujpEA3sQETs3MmylGx6YqJ3aczGGAV8Ce7aucKptwGSr4lKQ2m5444XJETbjFFM9tXmN0sEfZ1B+GZ0V+cfIfQMKspnig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780886802; c=relaxed/simple;
	bh=N3f5ccj80OsdAd5yUBa0fpDtkYWFvOUkkGZOXr8USEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qgxdOvWtiUBzcxYopcZR8uSwic8UkcIdAGMXIPNCzHPu8PB/mZktLaffk/FY6KmgX3DAk/Tto8p1n2JlN5wigX5+pUB1b4A8/+qECJ+i4r/uXGdP+JUfr6OWxlFjLa/5/D4ZhwpBcCP3qyEG/VHPpxtuq5ptRDNVpEVMWH8RWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8BxDuoMLSZq9Z4RAA--.46485S3;
	Mon, 08 Jun 2026 10:46:36 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJCxOMEKLSZq9ESfAA--.25894S2;
	Mon, 08 Jun 2026 10:46:34 +0800 (CST)
From: Hongliang Wang <wanghongliang@loongson.cn>
To: Hongliang Wang <wanghongliang@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH v6 0/2] i2c: ls2x: Add clock- related properties and parsing
Date: Mon,  8 Jun 2026 10:45:31 +0800
Message-Id: <20260608024533.32419-1-wanghongliang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxOMEKLSZq9ESfAA--.25894S2
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFyrKF17GF1rCr47KF4ftFc_yoW8Kw43pF
	s8CFWDGr1jk3W8ur43t3yI9F9Yqws8J397GrWxXw15uw43tr4DZF1Ikrs09rykWrZ2kayU
	Wa93KF1DKFZxZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9UUUUU=

Hi all:

This patch set adds clock related properties and parsing in dts and acpi.

======
V6:
- Add Reviewed-by tag from Huacai, thanks. 
Patch (1/2):
 - Remove CC stable. 

Link to V5:
https://lore.kernel.org/all/20260604015848.18643-1-wanghongliang@loongson.cn/ 

V5:
Patch (1/2):
 - Adjust the position of #include <dt-bindings/clock/loongson,ls2k-clk.h>;
 - Add CC stable; 
 - Fix Signed-off-by.
Patch (2/2):
 - Replace 2K0500/2K1000/2K2000 with LS2K0500/2K1000/2K2000;
 - Replace 7A1000/7A2000 with LS7A1000/7A2000;
 - Replace if (clk && !IS_ERR(clk)) with if(!IS_ERR_OR_NULL(clk));
 - Add document that clocks and clock-div are only ACPI properties in ACPI;
 - Remove unsigned int cast in code (unsigned long)device_get_match_data(dev);
 - Add CC stable; 
 - Fix Signed-off-by.

Link to V4:
https://lore.kernel.org/all/20260526031021.32662-1-wanghongliang@loongson.cn/

V4:
- Add Acked-by tag from Conor Dooley, thanks.
Patch (2/2):
 - Adjust the position of #include <linux/clk.h>;
 - Remove struct ls2x_i2c_chip_data and use macro to describe div;
 - Use div instead of factor in ls2x_i2c_adjust_bus_speed;
 - Reverse the "if & else" code logic in ls2x_i2c_adjust_bus_speed;

Link to V2:
The PATCH v3 is incomplete, v4 is the replacement of v3, so the previous patch link is v2.

[PATCH v2] dt-bindings: i2c: ls2x-i2c: Add clocks and clock-frequency properties
https://lore.kernel.org/all/20260507081010.12810-1-wanghongliang@loongson.cn/
[PATCH v2] i2c: ls2x: Add clocks property parsing and adjust bus speed
https://lore.kernel.org/all/20260507081010.12810-2-wanghongliang@loongson.cn/

V2:
[PATCH v2] dt-bindings: i2c: ls2x-i2c: Add clocks and clock-frequency properties
- Remove the custom properties clock-input and clock-div, use clock framework;
[PATCH v2] i2c: ls2x: Add clocks property parsing and adjust bus speed
- Use clock framework to obtain the i2c reference clock in dts.

Link to V1:
https://lore.kernel.org/all/20260325011852.19079-1-wanghongliang@loongson.cn/

wanghongliang (2):
  dt-bindings: i2c: ls2x-i2c: Add clocks and clock-frequency properties
  i2c: ls2x: Add clocks property parsing and adjust bus speed

 .../bindings/i2c/loongson,ls2x-i2c.yaml       |  3 ++
 drivers/i2c/busses/i2c-ls2x.c                 | 36 +++++++++++++++++--
 2 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.47.2

