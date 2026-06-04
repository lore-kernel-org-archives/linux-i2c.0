Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB4514E2F2;
	Thu,  4 Jun 2026 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538395; cv=none; b=Dfl9sE5E3vVa92RbH9rtVBIHPkxLPqSTbp4qvzbIjwenuCANC3paV4cd40qXLL4QhLQm5TcTpzIBXRHQj6Lci4GgpXl9/36YphVsxwhpjHdIdS3XYaU+MQ3IvIPVQfn0wDZoRextkV8v4Y6uB9jO5WIfjK2vObcC5Qe1490dYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538395; c=relaxed/simple;
	bh=80v9jWFdn+sHsJkkfJpWbH2RjtxIS8mNBhaLxiejyww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UrXyzXQGcvvAAPMQh7v9z2NX1Pj6vDnyNePXY0j2mR49VqCoscn6UQ04n8SrfShwKIGmQjEabBHeMwJkjvmgEEcHdCfPyb5PhlA7vLInRd04yJgZeqht9okVzRrs7ViJCIsDR+c0yXCJ9M5V4IVGZn+31dDb7Aqnnsp7UIf+u40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8DxsOoX3CBq3F8QAA--.45493S3;
	Thu, 04 Jun 2026 09:59:51 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJDxSMEV3CBqvESbAA--.17953S2;
	Thu, 04 Jun 2026 09:59:49 +0800 (CST)
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
Subject: [PATCH v5 0/2] i2c: ls2x: Add clock- related properties and parsing
Date: Thu,  4 Jun 2026 09:58:46 +0800
Message-Id: <20260604015848.18643-1-wanghongliang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxSMEV3CBqvESbAA--.17953S2
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFyrKF4UZFW8CF1kCF43XFc_yoW8tF17pF
	s8CFZ8Gr1j9a48ur43t3yI9F9Yqws8J397GFWxXw15Zw43tr4DZF1Ikrs09ryvgrZ2yayU
	Wa98KFnFgFZxZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc9a9UUUUU

Hi all:

This patch set adds clock related properties and parsing in dts and acpi.

======
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

