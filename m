Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D724F42086C;
	Tue,  7 Jul 2026 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783396404; cv=none; b=e04XeT2QacN1ubjG7PvJ7UjgoTFtKglGnTMjwfciHTvu/RWwD7huaeyMe832NLkipoHj11+vl8X6VaDI8K/D3/1b3fDWRiVV7a6tsk2e6rXP214Ch7S0JjnOd/y+Xo7mpf7z+CoENwYDFSP0OW1eZDgCpvrRwxhzDWtvhHK5MFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783396404; c=relaxed/simple;
	bh=lxLCXsDHs6OgdeBhYW2SRFl+CPcyJKKnQwmCBcUYOSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CTm/OQQtD22yL3EXQF93Hc0C/79oFecxdzHKsc0/RbSBMAMSMYFd123HysGtpjMQCou/YMLcjd6RNbPUbZDJC+k+E8f57BGn/TteAzjUtRqO20RlXmRwJo9QN7d6zMKix33GibSpf0w3t321w/sg8lDNb9pUBtVDjjgEh43Cyxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8BxmusueExqNsUAAA--.3308S3;
	Tue, 07 Jul 2026 11:53:18 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJAxX8creExqYXcDAA--.21037S2;
	Tue, 07 Jul 2026 11:53:16 +0800 (CST)
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
Subject: [PATCH v7 0/2] i2c: ls2x: Add clock- related properties and parsing
Date: Tue,  7 Jul 2026 11:51:02 +0800
Message-Id: <20260707035104.3092-1-wanghongliang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxX8creExqYXcDAA--.21037S2
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr1rWw1rZF18Zw4xZFWUtrc_yoW5WF17pF
	sxCFW5Gr1jka48ursxt3yI9r9Yqws8J397Gr9rZw15uw43tr4DZF1Ikrs09FykWrZ2yayU
	Wa93KF1DKF9xAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

Hi all:

This patch set adds clock related properties and parsing in dts and acpi.

======
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
 drivers/i2c/busses/i2c-ls2x.c                 | 36 +++++++++++++++++--
 2 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.47.2

