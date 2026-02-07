Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602DB352F9E;
	Sat,  7 Feb 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770477033; cv=none; b=avTXn2Fcy4r5uayWqy/JdYqXsZT+qAlYvgHwl8iAm6M5z805iToYwWJiijMsayfBzv+MhIlo5WpCQOYDpANsNJGz5IkvBoGO521OBbwkCNwsbAQPN4JmSJQfIO2kr7ZZ70kYt/2b1o6L67yLkFIDgjTqf2lFG370ylpqK+hqzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770477033; c=relaxed/simple;
	bh=XfPIQa1n40k4DtDFLExyqh9x4NVudCjNtkjrXUxfOM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gF9ptiXcM4v78qGs5DLZY3E6jLsWnk0v572zkwOLLAv/+3TGszbgB1uBYxPLG+VbS++SjRPZ42PP+poCz9xXuMD2LM8nLAhPwOl/Egef+AFK/kbDxNpI7EXamMSlrm4+k+mXYlW7J7fIiRzGuIo0wF2fwN75sqZhHODGEsB8604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=UFzxJPiA; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="UFzxJPiA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770476913;
	bh=cbEqZrd+eE8o0+V2y9USilf9Tl2MxDFayuDIynRwzC4=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=UFzxJPiAUjy0aMMkU7iNNKsW6Ismx5z0+WM0+WUG23VswYK2H9MG8E8Bfk2dGtEtM
	 DeXOsDd7fvS+S5JM8QdGAi2q8DMw85ogXP8Cw3UlHQFPw/QkmLNbIwXYFf1ke2b+YQ
	 zH2sY/T/bQvUzNmtqMfAF8F+d5g43SN1omu8tUgc=
X-QQ-mid: zesmtpip4t1770476912tbef9ec7a
X-QQ-Originating-IP: vw66bwuyFVu3Pk4lOVZ93jjvDuqgSxReQjqwZN7Uwps=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 07 Feb 2026 23:08:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18296168246919023479
EX-QQ-RecipientCnt: 8
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Sat, 07 Feb 2026 23:08:22 +0800
Subject: [PATCH v7 2/2] i2c: spacemit: introduce pio for k1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260207-b4-k3-i2c-pio-v7-2-626942d94d91@linux.spacemit.com>
References: <20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com>
In-Reply-To: <20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com>
To: Andi Shyti <andi.shyti@kernel.org>, Yixun Lan <dlan@gentoo.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Aurelien Jarno <aurelien@aurel32.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770476904; l=17056;
 i=troy.mitchell@linux.spacemit.com; s=20250712; h=from:subject:message-id;
 bh=XfPIQa1n40k4DtDFLExyqh9x4NVudCjNtkjrXUxfOM4=;
 b=XIY4R0qzj1xusVZzihXzER85wSRM7WzaTl1oVUYJFuG7TIXeEs2LcJkkKrNlcoWI+dTRnAxKZ
 oGRgFjUtEi3AkwereTE8OP4fTDYRuwKBa4IYZ5pGBiuz5kZSrBdyzJe
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=zhRP1xE0bftrurqSWI+SzcSdJGIZ0BTTY9Id0ESzqlI=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N1fXDe1nQuLqzJzJOUTbdH9h9jBP7c8qePKUzi9lLqp7NJW/cdnK4SDM
	Ov7xtkjxgUqkJbUCzZVNWEAA//WadqOeRj3d7Yvmx1Ibfteccn8eXQWk30GW0zEH/DnAKKF
	gq/ars2tRCDRDyafnTWdKbpEmU1mzThCmSRgM4ISdFt3qsbfvC4Ay1Qg5kO1MklkyeXTaBH
	4fnUb23QlCFB5SAgCHo3SncwI6jK80TaIWpQRIpSHv8cBx9TQaV0F6mLYn4QaYBdSN5yqhp
	cu8AIKtjcFiM+FWZs4ELu/qHSP+h+vUN5IMbcQjT+RiH2l8n40WS9g7HPwE62l2K/XDyqiE
	hRRH3+n9/P4XFQuyeM3TpT2FT36q0NQTH+BQmLWp1YLSArdH1pdCfXUxUkknKDTKEqT8wSm
	DiW30X40xAeQgjhsmB97XPglHIIPXZUo0qnkYHU9w4BU9g84/2zr9PE5KzJtASzM4/gpv7Q
	hhlDuU+SC+92LBt719y2Az5MEjejRPsaqlR+hYaQhehI93VCSu7otgfWPhEfkKBZ+bCJDp+
	yz4MgqiVG8N+JTGMGifUDweUQ+Fb36cgxHxVe8Ua+CAbcHv8ktFO34bpuPLs1ezckfbsQID
	igD2VnolVw9FgntHILbxKGAsJCpduRWuWehmTbW27nzqBGoNqZDscOvAM+sNcbfCbg1/Tcu
	UEEiSlu3gk0jqLtH//eQlDfaZzjkg3UeMAow4B+e2LqPugXaD4PiY7ehwQeUngSS/hzjAar
	z8KFYIm5AUuL6l5rr/tjFN5HRCl5CTPAZ8vplCfRfPd26gBuuLoRUgOmvwCfpijrPaN/UJ0
	Rw+Pr2E6qPh92W+bwq9HkGx/FXsyokDuNGpvJQDSJCIMqxhcVQSe68ZftKM1l12SuU5nqQb
	kYRMG7GMreDpIIgEB04H6x2YbSEr8DlBL99Nv2AQhpH8YA3rT7jeCYMQfCu1HSMRb+D3Y1J
	f9V75cUztQmUBrerpSi+nqi+ZoZ/H/EoUMdR1X1+FhordfRmM1xvj9Vwt1uL6McFnrXVWCL
	9Li7+DaKm18dIU4b9etg4elYkn8PmagoBIIaTicV+1YxFE23ud4DstSeog39oxHURAz4FB5
	RrC4Ti9lZoGjVGGjvy88tkZaDJLKCiT6Y5dadOYSXIIh3ljmgqyhMnbEpvDjlFiidBvgldc
	cEVaZ3Flqd110OylhwDgu5S1uMrP0pXmIn+fqghV9c46OSvebs5z3IPHOQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

This patch introduces I2C PIO functionality for the Spacemit K1 SoC,
enabling the use of I2C in atomic context.

When i2c xfer_atomic is invoked, use_pio is set accordingly.

Since an atomic context is required, all interrupts are disabled when
operating in PIO mode. Even with interrupts disabled, the bits in the
ISR (Interrupt Status Register) will still be set, so error handling can
be performed by polling the relevant status bits in the ISR.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
---
Changes in v7:
- optimize register access in spacemit_i2c_handle_state() by moving readl() inside the non-idle check
- refactor loop logic in spacemit_i2c_wait_pio_xfer() for better readability
- simplify spacemit_i2c_delay() to use fsleep() and remove redundant range arguments
- fix multi-line comment style and remove unnecessary blank lin
- Link to v6: https://lore.kernel.org/all/20260108-k1-i2c-atomic-v6-2-41b132b70f68@linux.spacemit.com/

Changes in v6:
- modify code style
- modify and add comments
- Link to v5: https://lore.kernel.org/all/20251226-k1-i2c-atomic-v5-2-023c798c5523@linux.spacemit.com/

Changes in v5:
- optimize code logic
- refactor delay handling into spacemit_i2c_delay() helper
- introduce spacemit_i2c_complete() to centralize transfer completion
- rework PIO transfer wait logic for clarity and correctness
- modify and add some comments
- modify commit message
- Link to v4: https://lore.kernel.org/all/20251009-k1-i2c-atomic-v4-1-a89367870286@linux.spacemit.com/

Changes in v4:
- refactor for better readability: simplify condition check and moving if/else (timeout/
  wait_xfer_complete) logic into a function
- remove irrelevant changes
- remove the status clear call in spacemit_i2c_xfer_common()
- sort functions to avoid forward declarations,
  move unavoidable ones above function definitions
- use udelay() in atomic context to avoid sleeping
- wait for MSD on the last byte in wait_pio_xfer()
- Link to v3: https://lore.kernel.org/r/20250929-k1-i2c-atomic-v3-1-f7e660c138b6@linux.spacemit.com

Changes in v3:
- drop 1-5 patches (have been merged)
- modify commit message
- use readl_poll_timeout_atomic() in wait_pio_xfer()
- use msecs_to_jiffies() when get PIO mode timeout value
- factor out transfer state handling into spacemit_i2c_handle_state().
- do not disable/enable the controller IRQ around PIO transfers.
- consolidate spacemit_i2c_init() interrupt setup
- rename is_pio -> use_pio
- rename spacemit_i2c_xfer() -> spacemit_i2c_xfer_common()
- rename spacemit_i2c_int_xfer() -> spacemit_i2c_xfer()
- rename spacemit_i2c_pio_xfer() -> spacemit_i2c_pio_xfer_atomic()
- call spacemit_i2c_err_check() in wait_pio_xfer() when write last byte
- Link to v2: https://lore.kernel.org/r/20250925-k1-i2c-atomic-v2-0-46dc13311cda@linux.spacemit.com

Changes in v2:
- add is_pio judgement in irq_handler()
- use a fixed timeout value when PIO
- use readl_poll_timeout() in  spacemit_i2c_wait_bus_idle() when PIO
- Link to v1: https://lore.kernel.org/r/20250827-k1-i2c-atomic-v1-0-e59bea02d680@linux.spacemit.com
---
 drivers/i2c/busses/i2c-k1.c | 300 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 228 insertions(+), 72 deletions(-)

diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index accef6653b56..2e2669a7a9b5 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -97,6 +97,10 @@
 
 #define SPACEMIT_BUS_RESET_CLK_CNT_MAX		9
 
+#define SPACEMIT_WAIT_TIMEOUT      1000 /* ms */
+#define SPACEMIT_POLL_TIMEOUT      1000 /* us */
+#define SPACEMIT_POLL_INTERVAL	   30	/* us */
+
 enum spacemit_i2c_state {
 	SPACEMIT_STATE_IDLE,
 	SPACEMIT_STATE_START,
@@ -125,6 +129,7 @@ struct spacemit_i2c_dev {
 
 	enum spacemit_i2c_state state;
 	bool read;
+	bool use_pio;
 	struct completion complete;
 	u32 status;
 };
@@ -171,6 +176,14 @@ static int spacemit_i2c_handle_err(struct spacemit_i2c_dev *i2c)
 	return i2c->status & SPACEMIT_SR_ACKNAK ? -ENXIO : -EIO;
 }
 
+static inline void spacemit_i2c_delay(struct spacemit_i2c_dev *i2c, unsigned int us)
+{
+	if (i2c->use_pio)
+		udelay(us);
+	else
+		fsleep(us);
+}
+
 static void spacemit_i2c_conditionally_reset_bus(struct spacemit_i2c_dev *i2c)
 {
 	u32 status;
@@ -182,7 +195,8 @@ static void spacemit_i2c_conditionally_reset_bus(struct spacemit_i2c_dev *i2c)
 		return;
 
 	spacemit_i2c_reset(i2c);
-	usleep_range(10, 20);
+
+	spacemit_i2c_delay(i2c, 10);
 
 	for (clk_cnt = 0; clk_cnt < SPACEMIT_BUS_RESET_CLK_CNT_MAX; clk_cnt++) {
 		status = readl(i2c->base + SPACEMIT_IBMR);
@@ -211,9 +225,15 @@ static int spacemit_i2c_wait_bus_idle(struct spacemit_i2c_dev *i2c)
 	if (!(val & (SPACEMIT_SR_UB | SPACEMIT_SR_IBB)))
 		return 0;
 
-	ret = readl_poll_timeout(i2c->base + SPACEMIT_ISR,
-				 val, !(val & (SPACEMIT_SR_UB | SPACEMIT_SR_IBB)),
-				 1500, SPACEMIT_I2C_BUS_BUSY_TIMEOUT);
+	if (i2c->use_pio)
+		ret = readl_poll_timeout_atomic(i2c->base + SPACEMIT_ISR,
+						val, !(val & (SPACEMIT_SR_UB | SPACEMIT_SR_IBB)),
+						1500, SPACEMIT_I2C_BUS_BUSY_TIMEOUT);
+	else
+		ret = readl_poll_timeout(i2c->base + SPACEMIT_ISR,
+					 val, !(val & (SPACEMIT_SR_UB | SPACEMIT_SR_IBB)),
+					 1500, SPACEMIT_I2C_BUS_BUSY_TIMEOUT);
+
 	if (ret)
 		spacemit_i2c_reset(i2c);
 
@@ -225,7 +245,7 @@ static void spacemit_i2c_check_bus_release(struct spacemit_i2c_dev *i2c)
 	/* in case bus is not released after transfer completes */
 	if (readl(i2c->base + SPACEMIT_ISR) & SPACEMIT_SR_EBB) {
 		spacemit_i2c_conditionally_reset_bus(i2c);
-		usleep_range(90, 150);
+		spacemit_i2c_delay(i2c, 90);
 	}
 }
 
@@ -237,25 +257,33 @@ spacemit_i2c_clear_int_status(struct spacemit_i2c_dev *i2c, u32 mask)
 
 static void spacemit_i2c_init(struct spacemit_i2c_dev *i2c)
 {
-	u32 val;
-
-	/*
-	 * Unmask interrupt bits for all xfer mode:
-	 * bus error, arbitration loss detected.
-	 * For transaction complete signal, we use master stop
-	 * interrupt, so we don't need to unmask SPACEMIT_CR_TXDONEIE.
-	 */
-	val = SPACEMIT_CR_BEIE | SPACEMIT_CR_ALDIE;
-
-	/*
-	 * Unmask interrupt bits for interrupt xfer mode:
-	 * When IDBR receives a byte, an interrupt is triggered.
-	 *
-	 * For the tx empty interrupt, it will be enabled in the
-	 * i2c_start function.
-	 * Otherwise, it will cause an erroneous empty interrupt before i2c_start.
-	 */
-	val |= SPACEMIT_CR_DRFIE;
+	u32 val = 0;
+
+	if (!i2c->use_pio) {
+		/*
+		 * Enable interrupt bits for all xfer mode:
+		 * bus error, arbitration loss detected.
+		 */
+		val |= SPACEMIT_CR_BEIE | SPACEMIT_CR_ALDIE;
+
+		/*
+		 * Unmask interrupt bits for interrupt xfer mode:
+		 * When IDBR receives a byte, an interrupt is triggered.
+		 *
+		 * For the tx empty interrupt, it will be enabled in the
+		 * i2c_start().
+		 * We don't want a TX empty interrupt until we start
+		 * a transfer in i2c_start().
+		 */
+		val |= SPACEMIT_CR_DRFIE;
+
+		/*
+		 * Enable master stop interrupt bit.
+		 * For transaction complete signal, we use master stop
+		 * interrupt, so we don't need to unmask SPACEMIT_CR_TXDONEIE.
+		 */
+		val |= SPACEMIT_CR_MSDIE;
+	}
 
 	if (i2c->clock_freq == SPACEMIT_I2C_MAX_FAST_MODE_FREQ)
 		val |= SPACEMIT_CR_MODE_FAST;
@@ -267,7 +295,7 @@ static void spacemit_i2c_init(struct spacemit_i2c_dev *i2c)
 	val |= SPACEMIT_CR_SCLE;
 
 	/* enable master stop detected */
-	val |= SPACEMIT_CR_MSDE | SPACEMIT_CR_MSDIE;
+	val |= SPACEMIT_CR_MSDE;
 
 	writel(val, i2c->base + SPACEMIT_ICR);
 
@@ -300,7 +328,12 @@ static void spacemit_i2c_start(struct spacemit_i2c_dev *i2c)
 	/* send start pulse */
 	val = readl(i2c->base + SPACEMIT_ICR);
 	val &= ~SPACEMIT_CR_STOP;
-	val |= SPACEMIT_CR_START | SPACEMIT_CR_TB | SPACEMIT_CR_DTEIE;
+	val |= SPACEMIT_CR_START | SPACEMIT_CR_TB;
+
+	/* Enable the TX empty interrupt */
+	if (!i2c->use_pio)
+		val |= SPACEMIT_CR_DTEIE;
+
 	writel(val, i2c->base + SPACEMIT_ICR);
 }
 
@@ -315,8 +348,23 @@ static bool spacemit_i2c_is_last_msg(struct spacemit_i2c_dev *i2c)
 	return !i2c->unprocessed;
 }
 
+static inline void spacemit_i2c_complete(struct spacemit_i2c_dev *i2c)
+{
+	/* SPACEMIT_STATE_IDLE avoids triggering the next byte */
+	i2c->state = SPACEMIT_STATE_IDLE;
+
+	if (i2c->use_pio)
+		return;
+
+	complete(&i2c->complete);
+}
+
 static void spacemit_i2c_handle_write(struct spacemit_i2c_dev *i2c)
 {
+	/* If there's no space in the IDBR, we're done */
+	if (!(i2c->status & SPACEMIT_SR_ITE))
+		return;
+
 	/* if transfer completes, SPACEMIT_ISR will handle it */
 	if (i2c->status & SPACEMIT_SR_MSD)
 		return;
@@ -327,16 +375,19 @@ static void spacemit_i2c_handle_write(struct spacemit_i2c_dev *i2c)
 		return;
 	}
 
-	/* SPACEMIT_STATE_IDLE avoids trigger next byte */
-	i2c->state = SPACEMIT_STATE_IDLE;
-	complete(&i2c->complete);
+	spacemit_i2c_complete(i2c);
 }
 
 static void spacemit_i2c_handle_read(struct spacemit_i2c_dev *i2c)
 {
+	/* If there's nothing in the IDBR, we're done */
+	if (!(i2c->status & SPACEMIT_SR_IRF))
+		return;
+
 	if (i2c->unprocessed) {
 		*i2c->msg_buf++ = readl(i2c->base + SPACEMIT_IDBR);
 		i2c->unprocessed--;
+		return;
 	}
 
 	/* if transfer completes, SPACEMIT_ISR will handle it */
@@ -347,9 +398,7 @@ static void spacemit_i2c_handle_read(struct spacemit_i2c_dev *i2c)
 	if (i2c->unprocessed)
 		return;
 
-	/* SPACEMIT_STATE_IDLE avoids trigger next byte */
-	i2c->state = SPACEMIT_STATE_IDLE;
-	complete(&i2c->complete);
+	spacemit_i2c_complete(i2c);
 }
 
 static void spacemit_i2c_handle_start(struct spacemit_i2c_dev *i2c)
@@ -383,8 +432,129 @@ static void spacemit_i2c_err_check(struct spacemit_i2c_dev *i2c)
 
 	spacemit_i2c_clear_int_status(i2c, SPACEMIT_I2C_INT_STATUS_MASK);
 
-	i2c->state = SPACEMIT_STATE_IDLE;
-	complete(&i2c->complete);
+	spacemit_i2c_complete(i2c);
+}
+
+static void spacemit_i2c_handle_state(struct spacemit_i2c_dev *i2c)
+{
+	u32 val;
+
+	if (i2c->status & SPACEMIT_SR_ERR)
+		goto err_out;
+
+	switch (i2c->state) {
+	case SPACEMIT_STATE_START:
+		spacemit_i2c_handle_start(i2c);
+		break;
+	case SPACEMIT_STATE_READ:
+		spacemit_i2c_handle_read(i2c);
+		break;
+	case SPACEMIT_STATE_WRITE:
+		spacemit_i2c_handle_write(i2c);
+		break;
+	default:
+		break;
+	}
+
+	if (i2c->state != SPACEMIT_STATE_IDLE) {
+		val = readl(i2c->base + SPACEMIT_ICR);
+		val &= ~(SPACEMIT_CR_TB | SPACEMIT_CR_ACKNAK |
+			 SPACEMIT_CR_STOP | SPACEMIT_CR_START);
+		val |= SPACEMIT_CR_TB;
+		if (!i2c->use_pio)
+			val |= SPACEMIT_CR_ALDIE;
+
+		if (spacemit_i2c_is_last_msg(i2c)) {
+			/* trigger next byte with stop */
+			val |= SPACEMIT_CR_STOP;
+
+			if (i2c->read)
+				val |= SPACEMIT_CR_ACKNAK;
+		}
+		writel(val, i2c->base + SPACEMIT_ICR);
+	}
+
+err_out:
+	spacemit_i2c_err_check(i2c);
+}
+
+/*
+ * In PIO mode, this function is used as a replacement for
+ * wait_for_completion_timeout(), whose return value indicates
+ * the remaining time.
+ *
+ * We do not have a meaningful remaining-time value here, so
+ * return a non-zero value on success to indicate "not timed out".
+ * Returning 1 ensures callers treating the return value as
+ * time_left will not incorrectly report a timeout.
+ */
+static int spacemit_i2c_wait_pio_xfer(struct spacemit_i2c_dev *i2c)
+{
+	u32 mask, msec = jiffies_to_msecs(i2c->adapt.timeout);
+	ktime_t timeout = ktime_add_ms(ktime_get(), msec);
+	int ret;
+
+	mask = SPACEMIT_SR_IRF | SPACEMIT_SR_ITE;
+
+	do {
+		i2c->status = readl(i2c->base + SPACEMIT_ISR);
+
+		spacemit_i2c_clear_int_status(i2c, i2c->status);
+
+		if (i2c->status & mask)
+			spacemit_i2c_handle_state(i2c);
+		else
+			udelay(SPACEMIT_POLL_INTERVAL);
+	} while (i2c->unprocessed && ktime_compare(ktime_get(), timeout) < 0);
+
+	if (i2c->unprocessed)
+		return 0;
+
+	if (i2c->read)
+		return 1;
+
+	/*
+	 * If this is the last byte to write of the current message,
+	 * we have to wait here. Otherwise, control will proceed directly
+	 * to start(), which would overwrite the current data.
+	 */
+	ret = readl_poll_timeout_atomic(i2c->base + SPACEMIT_ISR,
+					i2c->status, i2c->status & SPACEMIT_SR_ITE,
+					SPACEMIT_POLL_INTERVAL, SPACEMIT_POLL_TIMEOUT);
+	if (ret)
+		return 0;
+
+	/*
+	 * For writes: in interrupt mode, an ITE (write-empty) interrupt is triggered
+	 * after the last byte, and the MSD-related handling takes place there.
+	 * In PIO mode, however, we need to explicitly call err_check() to emulate this
+	 * step, otherwise the next transfer will fail.
+	 */
+	if (i2c->msg_idx == i2c->msg_num - 1) {
+		mask = SPACEMIT_SR_MSD | SPACEMIT_SR_ERR;
+		/*
+		 * In some cases, MSD may not arrive immediately;
+		 * wait here to handle that.
+		 */
+		ret = readl_poll_timeout_atomic(i2c->base + SPACEMIT_ISR,
+						i2c->status, i2c->status & mask,
+						SPACEMIT_POLL_INTERVAL, SPACEMIT_POLL_TIMEOUT);
+		if (ret)
+			return 0;
+
+		spacemit_i2c_err_check(i2c);
+	}
+
+	return 1;
+}
+
+static int spacemit_i2c_wait_xfer_complete(struct spacemit_i2c_dev *i2c)
+{
+	if (i2c->use_pio)
+		return spacemit_i2c_wait_pio_xfer(i2c);
+
+	return wait_for_completion_timeout(&i2c->complete,
+					   i2c->adapt.timeout);
 }
 
 static int spacemit_i2c_xfer_msg(struct spacemit_i2c_dev *i2c)
@@ -402,8 +572,8 @@ static int spacemit_i2c_xfer_msg(struct spacemit_i2c_dev *i2c)
 
 		spacemit_i2c_start(i2c);
 
-		time_left = wait_for_completion_timeout(&i2c->complete,
-							i2c->adapt.timeout);
+		time_left = spacemit_i2c_wait_xfer_complete(i2c);
+
 		if (!time_left) {
 			dev_err(i2c->dev, "msg completion timeout\n");
 			spacemit_i2c_conditionally_reset_bus(i2c);
@@ -421,7 +591,7 @@ static int spacemit_i2c_xfer_msg(struct spacemit_i2c_dev *i2c)
 static irqreturn_t spacemit_i2c_irq_handler(int irq, void *devid)
 {
 	struct spacemit_i2c_dev *i2c = devid;
-	u32 status, val;
+	u32 status;
 
 	status = readl(i2c->base + SPACEMIT_ISR);
 	if (!status)
@@ -431,41 +601,8 @@ static irqreturn_t spacemit_i2c_irq_handler(int irq, void *devid)
 
 	spacemit_i2c_clear_int_status(i2c, status);
 
-	if (i2c->status & SPACEMIT_SR_ERR)
-		goto err_out;
-
-	val = readl(i2c->base + SPACEMIT_ICR);
-	val &= ~(SPACEMIT_CR_TB | SPACEMIT_CR_ACKNAK | SPACEMIT_CR_STOP | SPACEMIT_CR_START);
+	spacemit_i2c_handle_state(i2c);
 
-	switch (i2c->state) {
-	case SPACEMIT_STATE_START:
-		spacemit_i2c_handle_start(i2c);
-		break;
-	case SPACEMIT_STATE_READ:
-		spacemit_i2c_handle_read(i2c);
-		break;
-	case SPACEMIT_STATE_WRITE:
-		spacemit_i2c_handle_write(i2c);
-		break;
-	default:
-		break;
-	}
-
-	if (i2c->state != SPACEMIT_STATE_IDLE) {
-		val |= SPACEMIT_CR_TB | SPACEMIT_CR_ALDIE;
-
-		if (spacemit_i2c_is_last_msg(i2c)) {
-			/* trigger next byte with stop */
-			val |= SPACEMIT_CR_STOP;
-
-			if (i2c->read)
-				val |= SPACEMIT_CR_ACKNAK;
-		}
-		writel(val, i2c->base + SPACEMIT_ICR);
-	}
-
-err_out:
-	spacemit_i2c_err_check(i2c);
 	return IRQ_HANDLED;
 }
 
@@ -474,6 +611,11 @@ static void spacemit_i2c_calc_timeout(struct spacemit_i2c_dev *i2c)
 	unsigned long timeout;
 	int idx = 0, cnt = 0;
 
+	if (i2c->use_pio) {
+		i2c->adapt.timeout = msecs_to_jiffies(SPACEMIT_WAIT_TIMEOUT);
+		return;
+	}
+
 	for (; idx < i2c->msg_num; idx++)
 		cnt += (i2c->msgs + idx)->len + 1;
 
@@ -486,11 +628,14 @@ static void spacemit_i2c_calc_timeout(struct spacemit_i2c_dev *i2c)
 	i2c->adapt.timeout = usecs_to_jiffies(timeout + USEC_PER_SEC / 10) / i2c->msg_num;
 }
 
-static int spacemit_i2c_xfer(struct i2c_adapter *adapt, struct i2c_msg *msgs, int num)
+static inline int
+spacemit_i2c_xfer_common(struct i2c_adapter *adapt, struct i2c_msg *msgs, int num, bool use_pio)
 {
 	struct spacemit_i2c_dev *i2c = i2c_get_adapdata(adapt);
 	int ret;
 
+	i2c->use_pio = use_pio;
+
 	i2c->msgs = msgs;
 	i2c->msg_num = num;
 
@@ -518,6 +663,16 @@ static int spacemit_i2c_xfer(struct i2c_adapter *adapt, struct i2c_msg *msgs, in
 	return ret < 0 ? ret : num;
 }
 
+static int spacemit_i2c_xfer(struct i2c_adapter *adapt, struct i2c_msg *msgs, int num)
+{
+	return spacemit_i2c_xfer_common(adapt, msgs, num, false);
+}
+
+static int spacemit_i2c_pio_xfer_atomic(struct i2c_adapter *adapt, struct i2c_msg *msgs, int num)
+{
+	return spacemit_i2c_xfer_common(adapt, msgs, num, true);
+}
+
 static u32 spacemit_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
@@ -525,6 +680,7 @@ static u32 spacemit_i2c_func(struct i2c_adapter *adap)
 
 static const struct i2c_algorithm spacemit_i2c_algo = {
 	.xfer = spacemit_i2c_xfer,
+	.xfer_atomic = spacemit_i2c_pio_xfer_atomic,
 	.functionality = spacemit_i2c_func,
 };
 

-- 
2.53.0

