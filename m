Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694610;
	b=ZGORc8nkNRaL5FPZNaicaIehdB8v+4Az+ty238CtoObpNCyODlX8w5E8WjbJQGgoNGmR
	 HuN34YHqRt7XgJcZ9XHoKLiSKu66jXj91ucA20PNH49/tj61lVaCetl3gyVADpMdJ8inD
	 b6lC0M1NoeMF5c9zAV92wREEk1AJmviJC9x0uzhdU8FyyiegnjTl/DlTzFTJqN92GmMg8
	 4yvEAYXFKreTF9qjVvPaKWmUxtl57Bmj+S7NKJwGW4+W/HnRDuYsRejRCMaQk92kbESro
	 iwYwO8HRdF1JMBXHq/DfJmoawYl4jI86wyRP7vIEXWQj8ZC+XziKOhu5Wp0F0Rz0alw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694610;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=lBty04VWGx6OTs8IxjT6/mXezzwuQfDiBt+l30CB91E=;
	b=VX91i/KqB+DdYvb90fBYfydxJO3nGgnKFzki9KA0dymHiOd6S3RXo7HbOTFJhen4djwx
	 6f4BiYj3mH55tmex18HNGbpHqdQuixAhmczJ5oIVoube2sfcf1LRj73wO6fIhoqeWXayp
	 UtfEpgqxSSYctaKsjidh+by8ExhfddzZXD4r4GTgsSFuMcKGwm8e9VhrF9OHWbVCdw3M8
	 VsboCUAN1LLp2LVrhgVbwHM9HhQ0ajdEigFLmNGR72xBe5JrEWoLtp5aiBETahJt2zhzu
	 fnjGIfdN5WH/Q0HZKKZ1fDjopSEFkDDb0CDHgvhHUDR+5OOlo2850ec4CoUaIeGv8XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7173606D814;
	Tue,  3 Nov 2026 08:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7173606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793694609; x=1825230609;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6NQ+JCrUKfrA7uFLiOTfNzx/YP0EhppYPV0YnJM/iC8=;
  b=YRlmKHmRe0QUR0NVi5IrH+hloOdRtg+5y803lH4NeOhWkY6S4z3hwKEi
   0y+uRoGYf2vPwj0w5pbIFZ8XCLgW0Tz0/CGwCJxXtEuZknFyXusVcFwDj
   iwqESvsYXOYViKvFDl7pdyP1kYYpInzcEc6GSl2vemhAuMGE5J7uJX9kS
   eVW71AjmYsNfOmFrz/5W0i3sutLmoLuULwZZ+HTChfc439VJLcLxwR3+6
   TgEJNUqf11E6qrVjCx/SZhMGoic6/M2iXuntjFbTscYMYvOBmOX0xtUdi
   ybfKblwzSeDPwty6thJ8K6TxdAFXHAFnX/QPOiulOjbYaMLCnRVUtHr4O
   g==;
X-CSE-ConnectionGUID: WKayc7FvTj6Ghpb3AUjXyg==
X-CSE-MsgGUID: wpfEUyjmSLKUvNnHbQBibw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:30:00 +0200
X-CSE-ConnectionGUID: CTAxmoEyTR6UyFIkVF/rng==
X-CSE-MsgGUID: Z2v27LxZQs+5B/Dvmx/71A==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces01_data.me-corp.lan with SMTP; 03 Nov 2026 10:38:00 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 03 Nov 2026 10:29:58 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 03 Nov 2026 10:29:44 +0200
Subject: [PATCH 8/8] i2c: nomadik: reduce FIFO flush timeout to avoid long
 interrupt handling
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-i2c-nomadik-fixes-v1-8-655c6af2cb70@mobileye.com>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
In-Reply-To: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
To: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 srinidhi kasagar <srinidhi.kasagar@stericsson.com>, 
 Ben Dooks <ben-linux@fluff.org>, Andrea Gallo <andrea.gallo@stericsson.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Dmitry Guzman <Dmitry.Guzman@mobileye.com>
X-Mailer: b4 0.16.0

In flush_i2c_fifo(), the driver sets FTX and FRX flags and waits until
they are reset (these bits are self-clearing). If after the first read
one or both of these bits is set, it waits until both are reset. The
timeout is 10 * I2C transfer timeout. I2C transfer timeout is by default
200 milliseconds. 2 seconds are much more than needed: as stated in the
comment above, the flushing operation takes just several cycles before
completed.

flush_i2c_fifo() is called from init_hw() that may be called from
interrupt handler. So, if the I2C controller is stuck and the FIFO does
not get flushed, the CPU may spend up to 2 seconds in the interrupt
handler and cause watchdog timeout or other unwanted consequences.
Moreover, if the interrupt is handled by the same CPU core that updates
jiffies, the loop may not finish at all.

To avoid too long waiting, reduce the timeout to 100 microseconds and
use read_poll_timeout_atomic() instead of relying on jiffies.

Fixes: 3f9900f17cdb ("i2c: Add support for Ux500/Nomadik I2C controller")

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index cc8b5a357f06..1f332e66a243 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -278,9 +278,8 @@ static inline void nmk_i2c_writeb(const struct nmk_i2c_dev *priv, u32 val,
  */
 static int flush_i2c_fifo(struct nmk_i2c_dev *priv)
 {
-#define LOOP_ATTEMPTS 10
-	ktime_t timeout;
-	int i;
+#define FIFO_FLUSH_TIMEOUT_US 100
+	u32 reg, err;
 
 	/*
 	 * flush the transmit and receive FIFO. The flushing
@@ -291,21 +290,16 @@ static int flush_i2c_fifo(struct nmk_i2c_dev *priv)
 	 */
 	writel((I2C_CR_FTX | I2C_CR_FRX), priv->virtbase + I2C_CR);
 
-	for (i = 0; i < LOOP_ATTEMPTS; i++) {
-		timeout = ktime_add_us(ktime_get(), priv->timeout_usecs);
-
-		while (ktime_after(timeout, ktime_get())) {
-			if ((readl(priv->virtbase + I2C_CR) &
-				(I2C_CR_FTX | I2C_CR_FRX)) == 0)
-				return 0;
-		}
-	}
+	/* This may execute in interrupt handler, so use read_poll_timeout_atomic() */
+	err = read_poll_timeout_atomic(readl, reg, (reg & (I2C_CR_FTX | I2C_CR_FRX)) == 0,
+				       1, FIFO_FLUSH_TIMEOUT_US, 0, priv->virtbase + I2C_CR);
 
-	dev_err(&priv->adev->dev,
-		"flushing operation timed out giving up after %d attempts",
-		LOOP_ATTEMPTS);
+	if (err)
+		dev_err(&priv->adev->dev,
+			"flushing operation timed out giving up after %d microseconds",
+			FIFO_FLUSH_TIMEOUT_US);
 
-	return -ETIMEDOUT;
+	return err;
 }
 
 /**

-- 
2.43.0

