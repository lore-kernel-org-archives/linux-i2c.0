Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424072;
	b=rK8WvFN9Z6OLMF1iHubrjSIRREOtv6RZHivQ1+IZtnimPJrs3x+TWgu6VV2bXt6Keg7p
	 kFw6beumoSFaImBXWLxRCp07tSGXyJpZefmLHjeve0zk/y+u7rTwNz+j9QeqtIatWdKK3
	 OtXaucjuy/ircdQD1hZMKZUZ3B8d0m9vB3tmwj9CBoFNAqM5kF2uuNABDBZRLKHR5Eo4I
	 NwJ4XbSz4ZAzo8WiBe2eIpMqmzgLbvCwJVGxCfcnO+yfP47MBOYXe9aRW0zI2iKO6GRNA
	 39fxg+xskjHh3RABnnOKjfcWoIBVeLMh89sR6S1YssyhCCpMt/dYw2gFKJBBo3TukcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0yvdWBeIrU265b2SHajtvEKLgNwE4xzZHnqqC+Ij8lU=;
	b=Hv1Rl95Bq7mBr4TBf/LPyLIVTIbB3Z80UEPpd+ptaN1BE/MXH1Ny29xB5T6cqlFPxERc
	 Lu4BikDdAtzfZQCza23xIDJSw0dQtGU1UqMutxy5k5t/8/OmjL0N/YWZiaanYw2NP880u
	 0g9uT0yVqMgCj1lMIFhdUZ49ik0LhjA/0qkQOZH8Or7ApDAxep96tYvDRiWLontT7V/iY
	 ajMWXc0VF40tz82yTUeBtDbNDLzuA5jUTXzxeESE/W/k9Fvy62S7qF+ji9TDK3WGhGHRX
	 CsEiRAUAi23XePmTNP5/IyyJyy8ek48Pkrr7s4juPQ/TH/zkPeGJd6PBEgZXDWdG14A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mpOhWCUS;
	arc=none smtp.remote-ip=74.125.228.138
Received: from mail-ej2-f10.google.com (mail-ej2-f10.google.com [74.125.228.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E6606A683
	for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 08:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F3E6606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mpOhWCUS
Received: by mail-ej2-f10.google.com with SMTP id a640c23a62f3a-c5093617c7aso123763766b.1
        for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2026 00:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795424070; x=1796028870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0yvdWBeIrU265b2SHajtvEKLgNwE4xzZHnqqC+Ij8lU=;
        b=mpOhWCUSati+u6ALP+f8p2dRzfLlNPiKExEYGDaNf3tEQGadErCHB9qJGnm7aT+MgD
         gIBK9pQe2iQKVd6NHqmVsR8QHBGblLtkm/RLttQp7vaH9inbKn5xz/icg2d365sG5y7H
         9u8JaMD/kW1WhtMIzApl+1pQ/i3mb0YO5Qb2NvepmJrwziY4i5aDmE9haIveITxf25Aw
         m/N/i8NsGVCk6KNXW7ImVvSluzOt9qAMeTCK30YEKjEwRzAUoATL5JlAiMwZEbt+i2KS
         hmSSPb8lahaPVsXCctr9OsTTx5s6Gj/aF8aECnkV4zewl7p3CqH1Qs6UJqe1bsAkfkn8
         RaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795424070; x=1796028870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0yvdWBeIrU265b2SHajtvEKLgNwE4xzZHnqqC+Ij8lU=;
        b=Xo558crDJFeSEbYNKITNd2YGca6IkV2vvHSw/vb5NYAjjUswMXmdxG1JtocvntRsCz
         EMHfrLacbfAQNBZDH/pT7Dh0svGUeO3FIyWDMtYQyQK6lFUumoTDeljl9c4XenH79Ty9
         xeF03lkN1u+PAfwfYWFpgzbhq0/hV9DP25ARNNTdWNNY9BLhUGSoNAx4CW8G+DTOOMYB
         5uvb1c2oyfywCq2Oo9FfoqKrayCvXmqJBpj90zCirVP+ctcYFt8RdkRbn4C0FW9c+G+z
         VPG1q1dVDftzOaq1ZEfPlBhcsetWr/+6QXfVBIj+soEr3x0qWOETG0RmvoM3EKm3Cp7r
         RppQ==
X-Forwarded-Encrypted: i=1; AL+hErGNqgCFkCBwnKiHgoT2wzs9YAZ04Iwzt7GuiFHMvX5LYuL+WH3NS50x4PJpetgZKyAl4Hfax0FY+Mc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vV3RFjhFH1DDCCmhqIq/CpLLGURLBleBKqX+Gx7vrmyADwCAT
	xoLZ6l6hGIh682TL+FjhAJu/2mjV0Souio9mf0l6JwcUdN9JOi/xF0QV
X-Gm-Gg: AZFdTZcgdsxfgtnKQeBsDJXDzuIrTgmMRQxn3EvltMJ0v7/38gLK+DBqmAe1pRPORad
	VTjY18IeRMlX7mc+UXnqZ9yTUPaw6RVpSvM7bEZTYlAONl/b2eQ4TCr/UHUG+mf6itbOUn10RTR
	6H2S5KmY6TTIrZPI7ezOehSCRoJe94N19kzM3RyDgar+x+oR09DOo7tqJsl58lHQ0v5iLszF/4F
	OyYyUPmnC8Gpi78urABWmkIyhsMcO+EKY2eRYsEiigHNWd3yK33loVi/VSmXi8N4w7tekh7bPUZ
	qXgsIMnZGWOCq06RAknUuTDcy/VOm3ckcgihcAD6sKmwi9dMTz4QZJ+Zw8vscVvp/L9JpF5AroT
	aItTpHVxQDxcl24W8buF2Eo+OeyOsMX+Z2Yo9CfFGw1R7vFWrf5uTeWuBtmVZuCakGpzozBHtOz
	AS+aasT64xADlwNDOZfkMcwsaAqOL1CAzmBjtvDgReyTpO81FX11ZevNzqLFokb50a4dk/kVrGx
	MCIK1a9RkUZKYw5WZWEuOgrPBTZruvuPfMz3X6lyb81V+ZNpj83FUTZ5k0FzznzTpSjp8xNFiKD
	Bx5O2CwWEyXACtHCC6Py4EMasa/vYDj32qDcx3f20+8ZF/WRrFP86ZlGWXMiP+x9qSWr/SRb2o9
	sbUSRjnCDUcfcqbmZhR72x6mPmxCagXarRiWVm1cMzW1Joy2KHDAMJoY=
X-Received: by 2002:a17:907:3f1b:b0:c51:5547:1771 with SMTP id a640c23a62f3a-c5155471892mr569690766b.13.1795424069989;
        Mon, 23 Nov 2026 00:54:29 -0800 (PST)
Received: from thi-server.fritz.box (dslb-092-076-092-047.092.076.pools.vodafone-ip.de. [92.76.92.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdf022sm377880166b.67.2026.11.23.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:54:29 -0800 (PST)
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: michal.simek@amd.com,
	andi.shyti@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thilo Zirnstein <thi.zirnstein@gmail.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH v5 1/2] i2c: i2c-xiic: fix clearing of bnb irq
Date: Mon, 23 Nov 2026 09:53:51 +0100
Message-ID: <20261123085351.3415122-3-thi.zirnstein@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123085351.3415122-2-thi.zirnstein@gmail.com>
References: <20261123085351.3415122-2-thi.zirnstein@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function to clear the bnb bit. It waits until all preconditions
are met before clearing the bit, or times out. The maximum timeout
is set to the minimum I2C start-condition hold time in standard mode,
which is the upper bound for when the bnb bit should become set.

Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
---
 drivers/i2c/busses/i2c-xiic.c | 40 ++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index ba560462d451..c5693135d820 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -233,6 +233,8 @@ static const struct timing_regs timing_reg_values[] = {
 #define XIIC_RESET_MASK             0xAUL
 
 #define XIIC_PM_TIMEOUT		1000	/* ms */
+/* timeout waiting for bus busy */
+#define XIIC_BB_TIMEOUT_US	4
 /* timeout waiting for the controller to respond */
 #define XIIC_I2C_TIMEOUT	(msecs_to_jiffies(1000))
 /* timeout waiting for the controller finish transfers */
@@ -394,6 +396,30 @@ static int xiic_wait_tx_empty(struct xiic_i2c *i2c)
 	return 0;
 }
 
+static void xiic_clear_en_bnb(struct xiic_i2c *i2c)
+{
+	u8 sr = 0, isr = 0;
+	int ret;
+
+	isr = xiic_getreg8(i2c, XIIC_IISR_OFFSET);
+	if (!(isr & XIIC_INTR_BNB_MASK)) {
+		xiic_irq_en(i2c, XIIC_INTR_BNB_MASK);
+		return;
+	}
+
+	ret = read_poll_timeout_atomic(xiic_getreg8, sr,
+			sr & XIIC_SR_BUS_BUSY_MASK, 1, XIIC_BB_TIMEOUT_US, 0,
+			i2c, XIIC_SR_REG_OFFSET);
+
+	if (ret) {
+		dev_err(i2c->dev, "Failed to clear bnb\n");
+		return;
+	}
+
+	xiic_setreg8(i2c, XIIC_IISR_OFFSET, XIIC_INTR_BNB_MASK);
+	xiic_irq_en(i2c, XIIC_INTR_BNB_MASK);
+}
+
 /**
  * xiic_setclk - Sets the configured clock rate
  * @i2c: Pointer to the xiic device structure
@@ -883,9 +909,6 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 	}
 
 	if (pend & XIIC_INTR_BNB_MASK) {
-		/* IIC bus has transitioned to not busy */
-		clr |= XIIC_INTR_BNB_MASK;
-
 		/* The bus is not busy, disable BusNotBusy interrupt */
 		xiic_irq_dis(i2c, XIIC_INTR_BNB_MASK);
 
@@ -1030,7 +1053,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 
 		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, val);
 
-		xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
+		xiic_clear_en_bnb(i2c);
 	} else {
 		/*
 		 * If previous message is Tx, make sure that Tx FIFO is empty
@@ -1097,7 +1120,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 
 	if (i2c->nmsgs == 1)
 		/* very last, enable bus not busy as well */
-		xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
+		xiic_clear_en_bnb(i2c);
 
 	/* the message is tx:ed */
 	i2c->tx_pos = msg->len;
@@ -1181,11 +1204,11 @@ static void xiic_start_send(struct xiic_i2c *i2c)
 		/* Clear any pending Tx empty, Tx Error and then enable them */
 		xiic_irq_clr_en(i2c, XIIC_INTR_TX_EMPTY_MASK |
 				XIIC_INTR_TX_ERROR_MASK |
-				XIIC_INTR_BNB_MASK |
 				((i2c->nmsgs > 1 || xiic_tx_space(i2c)) ?
 				XIIC_INTR_TX_HALF_MASK : 0));
 
 		xiic_fill_tx_fifo(i2c);
+		xiic_clear_en_bnb(i2c);
 	} else {
 		/*
 		 * If previous message is Tx, make sure that Tx FIFO is empty
@@ -1227,8 +1250,9 @@ static void xiic_start_send(struct xiic_i2c *i2c)
 
 		/* Clear any pending Tx empty, Tx Error and then enable them */
 		xiic_irq_clr_en(i2c, XIIC_INTR_TX_EMPTY_MASK |
-				XIIC_INTR_TX_ERROR_MASK |
-				XIIC_INTR_BNB_MASK);
+				XIIC_INTR_TX_ERROR_MASK);
+
+		xiic_clear_en_bnb(i2c);
 	}
 
 	i2c->prev_msg_tx = true;
-- 
2.43.0

