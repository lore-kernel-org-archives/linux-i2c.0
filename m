Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B79F21D596;
	Sat, 27 Jun 2026 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782530255; cv=none; b=cEA/ZnJb+KI1WWex34I6svSGeWQPWoc/jjKkWEm/+5Jr1X3qVTzKeqb8qLFh13BkGQcSd+Rrt+FLpV5FhjifGiIfuc7fmn43X7QrW/IG97et8V4ipGLFlXkLRpX9PFWtKeuF/YE/mf89tvInwQXLH6QSz7PdHyIAOiDe5GxqvGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782530255; c=relaxed/simple;
	bh=8VaLBopyOAqfm9YKbvX7rn1Kwa1bZrK21npI0wtAbhg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ml744+HS4k7e+jv71k2XOra/BADMo0JocF8p3MGpRY9sQOmBvvBc5SnlUSfqGaUGbrjNq56iFY3zQaY3jQJtzOptTDB3xrqlthP85uVBuDsN0VRCM/kkxWLyYEsR/+E9ziYxTsM1SBaXr0TnJ4hVBaZ2YyqL36Mjlq/jCgNWliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=nPGGFYa1 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="nPGGFYa1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=lOj48OGNNB
	Ea4iWe6H+Xz2y+iWhYIJ40m30ygmzeMNM=; b=nPGGFYa1XWrtr2sZMI2Wd0qYQH
	g763np86SOzLNqdXSddp5tnkjVtBNhYNa86s+vCs2cXnXcY1Q6GlmaR30kXPP+NA
	gDIjn6XEFQ/F2atfjhtxrqj9KPMrZGb5VCy3Ew8pGR8aThzcC5la7/Yu8Gk5B77p
	gfOidaGcZRDb+iyvk=
Received: from wmy.localdomain (unknown [113.200.174.100])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkC23hS1QD9qgjMaAA--.22728S2;
	Sat, 27 Jun 2026 11:17:13 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] i2c: i801: Fix stack-out-of-bounds in i801_isr_byte_done()
Date: Sat, 27 Jun 2026 11:17:07 +0800
Message-Id: <20260627031707.473833-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkC23hS1QD9qgjMaAA--.22728S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4rJF47Xw18ZFyrCF13twb_yoW8KF48pa
	y7Crnakw4Dtr1akFn8Ja17ZFyY9ws5KayUGFZrtwnxua13Jry09a48tF909F1v9ryDXa42
	qw1aqanruFyqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUfnY7UUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUREWo+l+ZJdQAAsd

Under extreme conditions (e.g., fault injection), the i801 SMBus controller
may experience transaction timeouts. The driver aborts the operation, sends
a KILL command, and returns from i801_access(), which destroys the
stack-allocated union i2c_smbus_data.

However, priv->data is not explicitly cleared. If a delayed or spurious
interrupt (e.g., BYTE_DONE) occurs later, i801_isr_byte_done() blindly
dereferences this dangling pointer, causing a KASAN stack-out-of-bounds
crash:

  BUG: KASAN: stack-out-of-bounds in i801_isr_byte_done
  Read of size 1 at addr ffff8881026dfd91 by task in:imklog/218
  Call Trace:
   <IRQ>
   ...
   kasan_report+0xca/0x100
   i801_isr_byte_done
   i801_isr
   __handle_irq_event_percpu+0x222/0x830
   ...
   </IRQ>

Fix this by clearing priv->data in the unified exit path of
i801_access(), and adding a sanity check in i801_isr_byte_done() to
ignore interrupts when priv->data is NULL.

Fixes: d3ff6ce40031 ("i2c-i801: Enable IRQ for byte_by_byte transactions")
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/i2c/busses/i2c-i801.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 32a3cef02c7b..6631b6db783b 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -562,6 +562,14 @@ static int i801_block_transaction_by_block(struct i801_priv *priv,
 
 static void i801_isr_byte_done(struct i801_priv *priv)
 {
+	/*
+	 * Bail out if the transaction has already timed out or completed.
+	 * This prevents a Use-After-Free/Stack-Out-Of-Bounds when a delayed
+	 * or spurious interrupt occurs after the stack memory is reclaimed.
+	 */
+	if (unlikely(!priv->data))
+		return;
+
 	if (priv->is_read) {
 		/*
 		 * At transfer start i801_smbus_block_transaction() marks
@@ -936,6 +944,13 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	 * Unlock the SMBus device for use by BIOS/ACPI,
 	 * and clear status flags if not done already.
 	 */
+
+	/*
+	 * Clear the data pointer to prevent stale pointer dereference
+	 * in the ISR if a spurious interrupt fires later.
+	 */
+	priv->data = NULL;
+
 	iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
 
 	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
-- 
2.34.1

