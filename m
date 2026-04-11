Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC472F0673;
	Sat, 11 Apr 2026 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775901527; cv=none; b=aGyXVmbiiWpU9I0in4Fmzx184s1qGMvW2l0xEkR6hHG9v47X8piaYRSQ4gmfUHBKdYNvQ9o/jJa5EJ1CDlxSVMWZL0eTZ5HkGcxOA+OqC0BhZTmSbxvxnG0s1zxHax+t1bQt7C4T5f+8WFoPBchatdeymd2iEnmgNUYL9Ud36WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775901527; c=relaxed/simple;
	bh=IHAGdw1aVu7ekSu6b1/9p6ag+6/LvGrWHxRvxe4feeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzvkAwh/8VZ6ZM9nPPJMVZDNX1ryoXyIdhKAFThhDFAKE1jCbwCHBMZGbi72aTJxVc/16cnkZf9EsUTC+yTcgck24cxk6q2yoWv9DboBDYglUHJCDVKmGiXhmhsmDx36X1DfQSfGvAHKHlauhwuC+/s44e11erSzsjYejbpGa3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.17])
	by gateway (Coremail) with SMTP id _____8AxBMFQG9ppDkYkAA--.2071S3;
	Sat, 11 Apr 2026 17:58:40 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.17])
	by front1 (Coremail) with SMTP id qMiowJAxGMFLG9ppx_NqAA--.58577S2;
	Sat, 11 Apr 2026 17:58:37 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-i2c@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v7 0/2] i2c: Add Loongson-2K0300 I2C controller support
Date: Sat, 11 Apr 2026 17:58:23 +0800
Message-ID: <cover.1775900045.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxGMFLG9ppx_NqAA--.58577S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEOCGnZ4sgBzgAAsT
X-Coremail-Antispam: 1Uk129KBj93XoWxWF4DZw4fCr1DGF4xJry8tFc_yoW5Cr1kpa
	y5C39xKF1qgr12vrs3JFWrurySvayfJa1Sgr4xA34F9a1DZ3yUZ3ySkFs0vFWDArWxuF42
	q39rKw10ka4DZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
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

This patch set describes the I2C controller integrated the
Loongson-2K0300 chip.

It has a significantly different design from the previous I2C
controller(i2c-ls2x), such as support for master-slave transfer mode,
and  DMA transfers (implementation in progress), etc. Therefore, we try
to name it i2c-ls2x-v2.

Thanks.

======
V7:
- Add Reviewed-by tag from Huacai & Andy, thanks.
Patch (2/2):
 - Add the REGMAP_MMIO Kconfig dependency;
 - parent_rate_MHz -> parent_rate_mhz to avoid CamelCase.

Link to V6:
https://lore.kernel.org/all/cover.1773991081.git.zhoubinbin@loongson.cn/

V6:
- Rebase on linux-i2c/i2c-next;
Patch (2/2):
  - Update comment;
  - Use regmap_get_device();

Link to V5:
https://lore.kernel.org/all/cover.1773142933.git.zhoubinbin@loongson.cn/

V5:
- Rebase on linux-i2c/i2c-next;
Patch (2/2):
  - Add time.h header file;
  - Add the `MHz` suffix to `parent_rate` and `freq`;
  - Define an iterator within the for loop, with its type being
    `unsigned int`;
  - Use dev_err_probe() in loongson2_i2c_adjust_bus_speed();
  - i2c_adapter_set_node()->device_set_node().

Link to V4:
https://lore.kernel.org/all/cover.1772714348.git.zhoubinbin@loongson.cn/

V4:
- Rebase on linux-i2c/i2c-next;
Patch (2/2):
 - The parent_rate parameter type should be `unsigned long`;
 - Drop fallthrough and add missing break;
 - device_set_node()->i2c_adapter_set_node();
 - Use i2c_parse_fw_timings();
 - Use i2c_t.bus_freq_hz instead of priv->speed;
 - Sperate loongson2_i2c_handle_read() into loongson2_i2c_handle_read()
   and loongson2_i2c_handle_rx_done().

Link to V3:
https://lore.kernel.org/all/cover.1772001073.git.zhoubinbin@loongson.cn/

V3:
- Rebase on linux-i2c/i2c-next;
Patch (2/2):
 - Reorder header file follow IWYU principle;
 - Better indentation and coding style;
 - Use generic macro definitions;
 - Amend *all* struct data types;
 - Correct unreasonable variable type definitions;
 - Refact loongson2_i2c_isr_error();
 - of_property_read_u32()->device_property_read_u32();
 - Remove meaningless blank lines and output.

Link to V2:
https://lore.kernel.org/all/cover.1769476820.git.zhoubinbin@loongson.cn/

V2:
Patch (1/2):
 - Add Acked-by tag from Conor, thanks.

Patch (2/2):
 - Reorder the definitions of read() and write();
 - Adjust the calculation method for bus speed.

Link to V1:
https://lore.kernel.org/all/cover.1763018288.git.zhoubinbin@loongson.cn/

Binbin Zhou (2):
  dt-bindings: i2c: loongson,ls2x: Add ls2k0300-i2c compatible
  i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller

 .../bindings/i2c/loongson,ls2x-i2c.yaml       |   4 +
 MAINTAINERS                                   |   1 +
 drivers/i2c/busses/Kconfig                    |  11 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-ls2x-v2.c              | 544 ++++++++++++++++++
 5 files changed, 561 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-ls2x-v2.c


base-commit: 8fc326e15895c9f0403e6243dd4ad468b10aab3d
-- 
2.52.0

