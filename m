Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B73A1A3C;
	Sun, 30 Aug 2026 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788098838; cv=none; b=RbofQimheJ7H1hOEffMa1GILADRBvxXyn0SCaaFImnYLRhvAXMq6VePX2CQ+o282e7vdjqxxVKtf2CWIdhJNgCMiOexYP2By34mKr4nMJEVH5HnVB6x31idsgRoX7c0bCxnxoh5hHsXCybeX7YnyWy+3IbCdbnucsSFjKZg8X9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788098838; c=relaxed/simple;
	bh=fKLS6+L+SYIc5j/um1xloKOutoeFQWzh/gn7hySPDRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJ6dk7loK8bCqX3F918NPWUoJoopF0CYDSIS5TOwlyGenCzgOyBoKmAWhdd6luQ4JFi9OYh2stydAVn9/WSlvPbPUTxt8pMU1NB62T4Btb61Gc+jazy9l0VQ5kcBaENw2YoM5UiCOFFJVoNuzofYLs/CAdA7CxBIRVbFUcZK36U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowADH0T8POZRqsIibBg--.48420S2;
	Sun, 30 Aug 2026 22:07:11 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Andi Shyti <andi.shyti@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-i2c@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: rzv2m: fail probe on reset and runtime-PM errors
Date: Sun, 30 Aug 2026 22:07:09 +0800
Message-ID: <20260830140709.28745-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADH0T8POZRqsIibBg--.48420S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWxJw45ZFWfJw1kXF17GFg_yoW8GF4kpa
	1xKrZFyry0qFWSqa1DAry3ZFyFgayftFW7JrWIgw18Zw15Cw4qkFy5tFyag3Z7JFWrAF45
	JanrJayxuFyjvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjZNVP
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Probe ignores reset deassertion and runtime-PM activation failures before
initializing the controller and registering an I2C adapter.

Propagate both required activation errors and disable runtime PM if its
initial resume fails.

Fixes: e0ca796a151b ("i2c: Add Renesas RZ/V2M controller")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/i2c/busses/i2c-rzv2m.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rzv2m.c b/drivers/i2c/busses/i2c-rzv2m.c
index 206a99e722a37..81e0101b61946 100644
--- a/drivers/i2c/busses/i2c-rzv2m.c
+++ b/drivers/i2c/busses/i2c-rzv2m.c
@@ -433,7 +433,9 @@ static int rzv2m_i2c_probe(struct platform_device *pdev)
 	 * The reset also affects other HW that is not under the control
 	 * of Linux. Therefore, all we can do is deassert the reset.
 	 */
-	reset_control_deassert(rstc);
+	ret = reset_control_deassert(rstc);
+	if (ret)
+		return ret;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -461,7 +463,11 @@ static int rzv2m_i2c_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0) {
+		pm_runtime_disable(dev);
+		return ret;
+	}
 	rzv2m_i2c_init(priv);
 	pm_runtime_put(dev);

base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.50.1

