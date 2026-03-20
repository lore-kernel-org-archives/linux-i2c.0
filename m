Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E0535B637
	for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991564; cv=none; b=E3aIxL46dVShX/AzD70jRQQEobi1gg6wVLAx4FUhq9bLgThj4mAdKKxDjsjjvDr/qC89TVzxrqnz6ffumPK5r/LC7sQGAaAIskna0E6jWrwoxXFTy5IkqzePT7Tt4Wp4p6t2UthA59n+aJimtMYZLO7WDsVv+37nmesyRF6KNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991564; c=relaxed/simple;
	bh=xtLi4IZTWrQbNgejqyOeih6Kuf2PVObdKTR3p8blIOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNvAmILa13bFYe/zosp3HddP28JSeiE5TZTgxiKSOh3UU2gdBxdD2leUQ8c6FFVkXqo5sID9GxGjkUsjsde+3cGj+KAjKQBkNG4sxBlciY4Ramh17hjcD8M2yxhB1PV3E+EtKkxwJzRblIG/KagIoMzr6XrGfWU8B4V2oIV0NE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.17])
	by gateway (Coremail) with SMTP id _____8Bx08CG9rxptfYcAA--.24577S3;
	Fri, 20 Mar 2026 15:25:58 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.17])
	by front1 (Coremail) with SMTP id qMiowJDxaeCD9rxp7DxZAA--.40268S2;
	Fri, 20 Mar 2026 15:25:56 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-i2c@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v6 0/2] i2c: Add Loongson-2K0300 I2C controller support
Date: Fri, 20 Mar 2026 15:25:45 +0800
Message-ID: <cover.1773991081.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxaeCD9rxp7DxZAA--.40268S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEMCGm7kCMaqgABsX
X-Coremail-Antispam: 1Uk129KBj93XoWxWF4fGrWUCFWxGFWUXFy7Jwc_yoW5Xw1fpa
	y5A3sxKF1jgr4Ivrs3JrWruryavayfJa1Sgr4xA34F9a1DZ3yUZ3yFkF4YvFWDCrWxCF42
	qrZrGr1jka4DZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

Hi all:

This patch set describes the I2C controller integrated the
Loongson-2K0300 chip.

It has a significantly different design from the previous I2C
controller(i2c-ls2x), such as support for master-slave transfer mode,
and  DMA transfers (implementation in progress), etc. Therefore, we try
to name it i2c-ls2x-v2.

Thanks.

======
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
 drivers/i2c/busses/Kconfig                    |  10 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-ls2x-v2.c              | 544 ++++++++++++++++++
 5 files changed, 560 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-ls2x-v2.c


base-commit: e9b13580b334040da0184a9f32106d808acd7fd5
-- 
2.52.0

