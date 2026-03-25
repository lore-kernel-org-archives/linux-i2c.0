Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB171624C5;
	Wed, 25 Mar 2026 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774401552; cv=none; b=Rl8bPE9/QGbNMcNNF5wUX10If0N0DLvaMkF10fjtORb0LAPuEjPXXOuhyN6RMhHjIvCFDHB4AK8JC/WYiehB+Q6/FxEIt3CzU31FNNJPw6T3Jc+7U6dsMXLtHoR4PLt6IfnDG0fm1UsiY+7P08/LUMtsa5K6dliC+MnMuD5X4Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774401552; c=relaxed/simple;
	bh=xP0nkKINC3/gyblFT29SEm+ETNn3fGaYihFyUg+2H7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O2cShtKDdEY/SAUQHUVy8q3eo/+ebJQfHkpKL52i9yM5MeI+XqOE2F+sF09JL02tx1PDsY1mIhhTQFjH+uPkwnEvch/wMck7ki6e0JTz14V8nwduqZxJ9QhwixFfyhtirUzq6cLtzxPI36CiaCc4yRB/DyqStpZqkdKxnfGs+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.101])
	by gateway (Coremail) with SMTP id _____8BxHMMJOMNpu2keAA--.21003S3;
	Wed, 25 Mar 2026 09:19:05 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.101])
	by front1 (Coremail) with SMTP id qMiowJBxLMIIOMNpi6xcAA--.44576S2;
	Wed, 25 Mar 2026 09:19:04 +0800 (CST)
From: Hongliang Wang <wanghongliang@loongson.cn>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hongliang Wang <wanghongliang@loongson.cn>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH v2 0/2] i2c: ls2x: Add clock- related properties and parsing
Date: Wed, 25 Mar 2026 09:18:50 +0800
Message-Id: <20260325011852.19079-1-wanghongliang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxLMIIOMNpi6xcAA--.44576S2
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GrWDKF47GF4xGr4kuw1Utwc_yoWDGrc_Z3
	4vk34kJ3s2yFZagF9Fqr4fAr90v3yUGryUAF15ArySkFy3Gw15CF9Fqr98Xr18JF42g3s5
	Kwn2kF1xA3W7CosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==

From: wanghongliang <wanghongliang@loongson.cn>

Hi all,

On 3A/7A/2K platform, the input clock of i2c controller and the divisor of
input clock maybe different, so define the clock-input and clock-div properties
in i2c controller node description of dts or acpi. clock-input describes the
input clock of i2c controller and clock-div describes the clock divisor of the
input clock.

Compared to v1, v2 modified the following content:
1. Add dt-bindings
2. In i2c-ls2x driver, the definition of pclk and div variables is placed on
one line
3. list the different value of clock-input and clock-div on different platforms

Thanks.

wanghongliang (2):
  dt-bindings: i2c: ls2x-i2c: Add clock- related properties
  i2c: ls2x: Add clock-input and clock-div properties parsing

 .../devicetree/bindings/i2c/loongson,ls2x-i2c.yaml  | 13 +++++++++++++
 drivers/i2c/busses/i2c-ls2x.c                       |  7 ++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.47.2

