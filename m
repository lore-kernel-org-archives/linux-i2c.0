Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596AB2405EB;
	Thu,  5 Mar 2026 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715415; cv=none; b=YiJ7uMJLlgjMWYvfbSEjH10blvSuOeoDh1QI0T01jMjXvijAuoTiFZdgwI6takDIzlOcYsFSsRcd81jrA9v5U8CAMVdQvNMpE0/k/PyH2FTrvTRhBembTJdrQ6aNtpO3BQK0T4G9mhXZlTb+IAcRY9NOz/ncfSX3n1g7cUJySxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715415; c=relaxed/simple;
	bh=OohVGk8rJoJKukEILdvo11BXKOqdjAIBoh85kJ5Eye8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1O62aZKleB0UCgqLzX8TmB9Xjvec89AZ26z6q3HSVz6H4gZ6ps7TJ7QO2sHrNKh9AnFkm8xM+mN+XSKvPcZ+HMH7I9tXS1w+KTcsyH+vO0pAY2ffYj/9fmQ/T4OEdBBP6yBi67pQKP7A1qUce6/PUro3LLoRMV7v7fxxwZyBtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.227])
	by gateway (Coremail) with SMTP id _____8Dx7qmOfalpJsYXAA--.11818S3;
	Thu, 05 Mar 2026 20:56:46 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.227])
	by front1 (Coremail) with SMTP id qMiowJDxjcKGfalpJt5OAA--.16319S2;
	Thu, 05 Mar 2026 20:56:43 +0800 (CST)
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
Subject: [PATCH v4 0/2] i2c: Add Loongson-2K0300 I2C controller support
Date: Thu,  5 Mar 2026 20:56:29 +0800
Message-ID: <cover.1772714348.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxjcKGfalpJt5OAA--.16319S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQERCGmpG0IKfAAAs2
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrWDWFWfCr17uF1DKFWxGrX_yoW8uFWfpa
	y5A3sIkF1jgr129rs3XrWfZryavF4fJF43Wr47A34Y9anrA3yUZ3yakFs0vFWDCryxuF42
	q39rKw1UCa4qvFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2
	AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jn
	SdgUUUUU=

Hi all:

This patch set describes the I2C controller integrated the
Loongson-2K0300 chip.

It has a significantly different design from the previous I2C
controller(i2c-ls2x), such as support for master-slave transfer mode,
and DMA transfers (implementation in progress), etc. Therefore, we try
to name it i2c-ls2x-v2.

Thanks.

======
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
 drivers/i2c/busses/i2c-ls2x-v2.c              | 545 ++++++++++++++++++
 5 files changed, 561 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-ls2x-v2.c


base-commit: 6117e1ba1db78a52a4161208ea403d3769ad73c6
-- 
2.52.0

