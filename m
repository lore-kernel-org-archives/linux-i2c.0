Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.10.215.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325432;
	b=IaROS4v/mdL5UvEi6+5SBy+CKq9UUiFreQDXw9wijLYKhKa72YIa0YsWaRPdV7RvValN
	 5GytxkPFrnrw5U7EDRJv2IHqn3iChNhwa5x3I6q4Za3Xev/tMBtEAmyiyBgPD8Hw+5oqp
	 F0eenKj7YHOlYbgSQakBb4dKQ7ePChwtDA4QwExUxJfqfIJxxDXCP0asIe56P9ig1Pwvp
	 eZT4rrRSJqmHFOg7DrzpzmnHq4c9OynYgTJWkdlximkPEMVwJKtJ6iD+KBMfwEE79Qb2K
	 dz4uRlwS86o3jIVNg56ShdcyA9tObEZ3KEEA93SZ+Exqhd2l5w4rD6+Rv1JxNkyX1hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325432;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=yBsHyFdtywgbO1ZJklNClcpA+w18K5R4TLs185ac//o=;
	b=zB5Z7iD3rpgnC6vBuYZIpLRJBIU7AebEG63A+fPXDOOia6lUvDhJNKMA8UK/cz4F/5nw
	 HlluMkxOctSR9F3O6QyRyfthDyDPw7cXTQCngegXGL+41MuR+hVFm/wAb4AoQkeCeXBE3
	 F1QPyAPtadaUgEHQIL8WgkIaqDsoXYxr5LgXhhlHWDd7Js7fAz3Ok3BlZDllMSyLsmBDo
	 dt4IsUOAjVMZKpAIiCC35EI1ilVUBU717dBbnJR4xgswZqZCA0vcuzGgHANl8/JOHWGL+
	 oAGKKa6vOepxSlsUjJH+Dejni+YP6cnm3uIIgQcaGQWwu4UkAhKyi0+8FJSL9kz88QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hetzner-cloud.de;
	spf=pass smtp.mailfrom=hetzner-cloud.de;
	arc=none smtp.remote-ip=85.10.215.232
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C592606A33B;
	Tue, 10 Nov 2026 15:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C592606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <sarah.maedel@hetzner-cloud.de>)
	id 1xQo0j-000IFG-0e;
	Tue, 10 Nov 2026 16:43:49 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sarah.maedel@hetzner-cloud.de>)
	id 1xQo0j-000CQE-03;
	Tue, 10 Nov 2026 16:43:49 +0100
From: Sarah Maedel <sarah.maedel@hetzner-cloud.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@bootlin.com>,
	David LaPorte <dalaport@amazon.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] i2c: designware: Abort stuck master when disabling times out
Date: Tue, 10 Nov 2026 16:43:30 +0100
Message-ID: <20261110154330.78515-3-sarah.maedel@hetzner-cloud.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110154330.78515-1-sarah.maedel@hetzner-cloud.de>
References: <20261110154330.78515-1-sarah.maedel@hetzner-cloud.de>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28179/Tue Nov 10 07:26:51 2026)

__i2c_dw_disable() only aborts the current transfer if MST_ON_HOLD or
MASTER_HOLD_TX_FIFO_EMPTY is set. These bits only exist with
IC_STAT_FOR_CLK_STRETCH, so on other configurations a master left
holding the bus can't be disabled: IC_ENABLE_STATUS stays set and
IC_STATUS keeps reporting MST_ACTIVITY.

If the master is still active once the disable loop has timed out,
abort the transfer and try again. Also disable the adapter from
i2c_dw_wait_bus_not_busy() when bus recovery didn't help, so the next
transfer recovers the controller.

Tested on Ampere Altra by putting the controller into this state
through /dev/mem (a write without STOP, then clearing IC_ENABLE).

Signed-off-by: Sarah Maedel <sarah.maedel@hetzner-cloud.de>
---
 drivers/i2c/busses/i2c-designware-common.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index a1eca6cd4b75..2e8de0f6c1ed 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -643,6 +643,7 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 	if (dev->mode == DW_IC_SLAVE && (ic_stats & DW_IC_STATUS_SLAVE_ACTIVITY))
 		abort_needed = true;
 
+retry:
 	if (abort_needed) {
 		if (!(enable & DW_IC_ENABLE_ENABLE)) {
 			regmap_write(dev->map, DW_IC_ENABLE, DW_IC_ENABLE_ENABLE);
@@ -684,6 +685,19 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 		usleep_range(25, 250);
 	} while (timeout--);
 
+	/*
+	 * Without IC_STAT_FOR_CLK_STRETCH the hold status bits above don't
+	 * exist, so a stuck master is only noticed here.
+	 */
+	regmap_read(dev->map, DW_IC_STATUS, &ic_stats);
+	if (!abort_needed && (ic_stats & DW_IC_STATUS_MASTER_ACTIVITY)) {
+		dev_warn(dev->dev, "controller stuck active, aborting\n");
+		regmap_read(dev->map, DW_IC_ENABLE, &enable);
+		abort_needed = true;
+		timeout = 100;
+		goto retry;
+	}
+
 	dev_warn(dev->dev, "timeout in disabling adapter\n");
 }
 
@@ -764,6 +778,11 @@ int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 		i2c_recover_bus(&dev->adapter);
 
 		regmap_read(dev->map, DW_IC_STATUS, &status);
+		if (status & DW_IC_STATUS_MASTER_ACTIVITY) {
+			/* Disabling aborts a master stuck on the bus */
+			__i2c_dw_disable(dev);
+			regmap_read(dev->map, DW_IC_STATUS, &status);
+		}
 		if (!(status & DW_IC_STATUS_ACTIVITY))
 			ret = 0;
 	}
-- 
2.47.3

