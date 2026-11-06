Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934134;
	b=CAD0TJNNfOsaGAv2SvYfvZUQ94my86I1FLzJL1Hx/FM/FYYhfKZGew/OSpxAeD6Ze1Jm
	 gMiPcLZ8Ilf0V2JGImyAqCnhEN+iaU6T0f4VMGbJwtH0BLbIVOd87dQf7PChMM/AMwmL+
	 bYbsypbjznH1Tt43qXJ58LP1vziWZSrHZe/HTx8p+sikSZKwEZK10MQCTFLRX62VqMORO
	 Gck+do+7irTrFJkleWPlPwgwDkg6bW2YDIyqi/0dcihBHkSfbB8rzBwLyEH1nb7r9k+M/
	 4VAKnXXH6u23pYRfZ2Fca3pjnKbue58fBtPQWXw5J6xYU3m0vABrZyrtjJp178WXZsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934134;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=ZZgdxyQzU7G0ALVjZOlsXrIuUfV7KVW4Ab6UQo3T3JU=;
	b=YHhiwvxuI7Jyyc1PG3lrLAlG5YxEOMtnQa/k79L8vniexHYvBvR/LRfJO6csZQczNPbV
	 anFFvrpVdv+CkoQx0QMkgzslxCgW2bb3NmEjtEdIujmkffsIIlGQu+Qzp96bYpKOiZtqz
	 0Uf4pyB3HMOMbcaunzzcWafibITkD+xgCuZK1PXGS/a4vYpzaBOfxpXQ5e+VuE+EYZRPx
	 2dDnkSRy2GzhB7RgAxQ+9bPSyJFCAafR9r4tc7JgFOzX6bBo+udV+aKbSnSY9xHV5G2Jd
	 gQc9ZG4QYv8+9pS2vq3jePpe4zd6+J974MqEHVkAHiPpdlGMExuwCrS2bIWWd2D81fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52436606A329;
	Fri,  6 Nov 2026 03:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52436606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8CxPNIxQ+1qFuocAA--.18399S3;
	Fri, 06 Nov 2026 11:02:09 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJCxvM4tQ+1qprAyAA--.18991S2;
	Fri, 06 Nov 2026 11:02:05 +0800 (CST)
From: Hongliang Wang <wanghongliang@loongson.cn>
To: Hongliang Wang <wanghongliang@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH v11 0/2] i2c: ls2x: Add clock- related properties and parsing
Date: Fri,  6 Nov 2026 11:02:01 +0800
Message-Id: <20261106030203.15709-1-wanghongliang@loongson.cn>
X-Mailer: git-send-email 2.20.1
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxvM4tQ+1qprAyAA--.18991S2
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr15try8KF1xtFW8uw1DCFX_yoWrWr17pF
	43Ca98Gr1jga48ursxt3yIvFyrZws8J39rGrnrXw15uw4avw4DZF1Ikrs09FykZrs2kayU
	W393KF1DKF98AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
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
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8m9aDUUUUU==

Hi all:

This patch set adds clock related properties and parsing in dts and acpi.

======
V11:
For the whole series:
- Add Reviewed-by tag from Binbin Zhou, thanks. 

Link to V10:
https://lore.kernel.org/all/20260817090721.30582-1-wanghongliang@loongson.cn/

V10:
Patch (2/2):
- Replace '/' operator with div64_u64() to avoid __udivdi3 linker error on
  32-bit architectures with CONFIG_COMPILE_TEST.

Link to V9:
https://lore.kernel.org/all/20260810074927.25284-1-wanghongliang@loongson.cn/

V9:
Patch (2/2):
- Rewrite the commit description
- Use 64-bit arithmetic to avoid integer overflow during the clock calculation
- Add checks to reject zero clock rates and ensure valid clock inputs
- Modify the comment for clocks and clock-div properties
- Add Tested-by tag from Xi Ruoyao, thanks

Link to V8:
https://lore.kernel.org/all/20260721122604.12717-1-wanghongliang@loongson.cn/

V8:
Patch (2/2):
Fix the potential issues from Sashiko AI review:
 - Add error checking for the pointer returned by devm_clk_get_optional_enabled();
 - Add zero-value checking for the match data to provide default div.

Link to V7:
https://lore.kernel.org/all/20260707035104.3092-1-wanghongliang@loongson.cn/

V7:
Patch (2/2):
Fix the potential issues from Sashiko AI review:
 - Move the clock property parsing process to probe function to solve the issue
   of calling `devm_clk_get_optional_enabled()` dynamically causes unbounded memory
   leaks and unbalanced clock enable counts.
 - Add non-zero checking to priv->div.

Link to V6:
https://lore.kernel.org/all/20260608024533.32419-1-wanghongliang@loongson.cn/

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

Hongliang Wang (2):
  dt-bindings: i2c: ls2x-i2c: Add clocks and clock-frequency properties
  i2c: ls2x: Add clocks property parsing and adjust bus speed

 .../bindings/i2c/loongson,ls2x-i2c.yaml       |  3 ++
 drivers/i2c/busses/i2c-ls2x.c                 | 44 +++++++++++++++++--
 2 files changed, 44 insertions(+), 3 deletions(-)

-- 
2.47.2

