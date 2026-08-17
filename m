Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681A53C3F79;
	Mon, 17 Aug 2026 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957453; cv=none; b=nQD2vC4c15Tj/beVpUiQhtcijnXlhkzgQNbOt12a1KrYevqb8CGpLYZiM0MMkHulUB7/w2+wGdIAP7KQIW4GMHgI7WUjOHp6RxgXHUo6MeGNMPxGOc+1rGRLbGwfLQzleP3bd6AjxY46qoNYyxqIfOsCBn31YAJFSsJ0wUgriY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957453; c=relaxed/simple;
	bh=/IMgB3/UFMGoS3Vaqy1X0xxwG0KSL7shNh4K3vC7JHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BJfIudDIUfWzrNFdiGsMk1CQqSabQEQ40bFNeAkSZ4++GEoaXn3oXlekMp76wB2Gyixx/38gwp2qOsuWaNMpdKtvM4mygCsIuoqQRkzKRgcIV5wMrtSei3hfMuMxtBSCIooBlCXoCyoOsxfbKNgcNbN8lJ1nz3nATtGGkY5WJsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8Ax29GIzoJq5tIBAA--.5567S3;
	Mon, 17 Aug 2026 17:04:08 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJBx6c2GzoJqWMIHAA--.7126S2;
	Mon, 17 Aug 2026 17:04:06 +0800 (CST)
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
Subject: [PATCH v10 0/2] i2c: ls2x: Add clock- related properties and parsing
Date: Mon, 17 Aug 2026 17:01:10 +0800
Message-Id: <20260817090112.27151-1-wanghongliang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx6c2GzoJqWMIHAA--.7126S2
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wASzI0E04IjxsIE14AKx2xKxw
	AqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8I
	cVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjc
	xG0xvY0x0EwIxGrwAKzVC20s0267AEwI8IwI0ExsIj0wCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	1j6r18MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_
	GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

Hi all:

This patch set adds clock related properties and parsing in dts and acpi.

======
V10:
Patch (2/2):
- Replace '/' operator with div64_u64() to avoid __udivdi3 linker error on
  32‑bit architectures with CONFIG_COMPILE_TEST.

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

