Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5884C274B2B;
	Wed, 25 Feb 2026 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004906; cv=none; b=g4USiafJH/PA6rprB/DKVJtorZkcYrK9sMes9BWGkSO/To3SyU8T+E27hpcvb1SJOprJtlams2DKYgW6gUJ0fXKLkLblvFyNH/HPH+sZcor69RDrHBj+npBmFs1II4rc7T9FR0JWMTa9qhprosaB0WVmAWjhCeyeQPgwrfpqCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004906; c=relaxed/simple;
	bh=+yBWQeNfgbn1YzlZgOOINbQ1VVXe/SU11SE1jUNt9sI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4AmOjzmPOyxszvXhIRW0dcYeV8SBiXQsVmkNdhYTtGHRDE+BCll0W9d5wHmkeDZcPJYTJALAnIxyw4Z4LKTqZGMS/OAslwSPJ3t982qQyxs+qcr/ZtC3JoaR/zgn+1IodVUMTTRuXcJAGv8o09czfxz3RfIplAkNxiWgqn0zcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.227])
	by gateway (Coremail) with SMTP id _____8Dx_8Mlpp5pNP0UAA--.64600S3;
	Wed, 25 Feb 2026 15:35:01 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.227])
	by front1 (Coremail) with SMTP id qMiowJBx78Ifpp5prsNKAA--.10268S2;
	Wed, 25 Feb 2026 15:34:57 +0800 (CST)
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
Subject: [PATCH v3 0/2] i2c: Add Loongson-2K0300 I2C controller support
Date: Wed, 25 Feb 2026 15:34:42 +0800
Message-ID: <cover.1772001073.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx78Ifpp5prsNKAA--.10268S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEJCGmejyEBaAAAsy
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrWDWFWfCr17uF1DKF17Arc_yoW8WF43pa
	n8A3sxKF1jgr4I9rs3Jr4xuryYva1xJF43Wr42vw1v9a15A3yDZw4akF1YvFZrCryxZF42
	qrWDGF1xCa4qvrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7
	AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8aZ
	X5UUUUU==

Hi all:

This patch set describes the I2C controller integrated the
Loongson-2K0300 chip.

It has a significantly different design from the previous I2C
controller(i2c-ls2x), such as support for master-slave transfer mode,
and  DMA transfers (implementation in progress), etc. Therefore, we try
to name it i2c-ls2x-v2.

Thanks.

======
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
 drivers/i2c/busses/i2c-ls2x-v2.c              | 510 ++++++++++++++++++
 5 files changed, 526 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-ls2x-v2.c


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.52.0

