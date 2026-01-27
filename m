Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D0B4F5E0;
	Tue, 27 Jan 2026 02:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769482104; cv=none; b=k0iAUhH07DGDK9nIFk/UuyK7BH8xMnbBSwum6aqRpEmILF9lvWbVCKLFJtfe2wSpIHTLQoMAw1NvctM61S4qLraNUIZTHcj21WByQQlA/Y4hgOFiiYtNFgPQTr0TCeJuRn4fhULNtUpQOQ9aUM84W6xjk87hlhZD9xyzxyY/xDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769482104; c=relaxed/simple;
	bh=qs50nfhR6TdkPTvLK+9MuwCc57o3mV26cBlcEaAA3ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tdaqwyYD5uP3blFrUWnW6LvXfyTqrg2Zl/saPYGI29tiJrNDvuzDRdjpkPMFMiznOogSBuw9wVy/ufo98VEoHbKaXt1k6qEFDlgMb2Fjus0OFSAn72j3eCNE8NvLLB9ZhS6fayCQ7mq5OpkD3++GSPHCB267To/NRlz1QALTxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.42])
	by gateway (Coremail) with SMTP id _____8CxLMNsJ3hpZPsMAA--.42513S3;
	Tue, 27 Jan 2026 10:48:12 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.42])
	by front1 (Coremail) with SMTP id qMiowJCxWeBnJ3hpPJEzAA--.36583S2;
	Tue, 27 Jan 2026 10:48:09 +0800 (CST)
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
Subject: [PATCH v2 0/2] i2c: Add Loongson-2K0300 I2C controller support
Date: Tue, 27 Jan 2026 10:47:55 +0800
Message-ID: <cover.1769476820.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxWeBnJ3hpPJEzAA--.36583S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEACGl3AjkTtgAAsI
X-Coremail-Antispam: 1Uk129KBj9xXoW7XryDXrWxWr4xWF43Cw43XFc_yoWkArcEk3
	4xWasrAw1kCF93Ca4UJF4fZry3CayUta48A3Zrtw4ak3y2gw1YgF97CrZxZ3WxXF47GFn8
	Ww1UZF1IvwnxGosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14
	v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2BT5
	DUUUU

Hi all:

This patch set describes the I2C controller integrated the
Loongson-2K0300 chip.

It has a significantly different design from the previous I2C
controller(i2c-ls2x), such as support for master-slave transfer mode,
and  DMA transfers (implementation in progress), etc. Therefore, we try
to name it i2c-ls2x-v2.

Thanks.

======
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

 .../bindings/i2c/loongson,ls2x-i2c.yaml       |  15 +
 MAINTAINERS                                   |   1 +
 drivers/i2c/busses/Kconfig                    |  10 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-ls2x-v2.c              | 545 ++++++++++++++++++
 5 files changed, 572 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-ls2x-v2.c


base-commit: 880977fdc7f67923d1904ee23ca75fa1e375ea46
-- 
2.47.3

