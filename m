Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722361;
	b=Ffg6PSO33e6ae/RpVTEP32h2l6G1SCoqKmFMDTycNUyozCUazR10+8ytbk5xPCPJyHmC
	 nmDyX0I5BDI9hY5uD3Q3D+wMwceB78FxsW/pFDt8Zci8PMOp0mbYUgu2RvrSG0ikvYdo8
	 7WNAfRk/rhg2w1JeJZ1l/SVCXRnsYqNHB5Nri6jRfLN4sOrwbqI+BQemuhSPFFhF/XXSf
	 1Q9/e+DZGYcGYWawuktHajy7EnY0bSc32TXJra7l0BC0GtHUYtMlMgTO1IFZekzlhnvLX
	 f0UlhKAxXe06FwQuCOz13j1NIHSJJnIrS5vKoezPwvpBVjTgxYeg5o9K+YGwHrmFMeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722361;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=hBDO8Msiv8jaGludKRh/EiGLGSqgrzQCArT+HYcx/PU=;
	b=RHA7dVw9xrmYLV4aKvqpB5C95diSTIKYmzWfEqHavMHB//0Lu54b9UtmDrySS9KDRM1L
	 8STrNZ9xLJQmcINLT0LItqXl1JA1MEDSJoDDmfWlxLu5aDo27Pidgm9nfoZ2S2gkWT9XV
	 UG+cLJBfQgjyOMR990KXSA9ASTZ4C6QFcJiJC3TUiZb8NdbamuyqvxAa53hYGi8LO3aeD
	 Cb12asQWbKKrShA9j/XCKvSPJBc+2aRLGN2Ym1Mp223KQNFo4z5JTHQTEf/LN8/pwF5qI
	 mKqSGy4SMYc7QC4GNQvdMXTcZww/bRce5DDN3JoyBgxTUU9NzBPctJYQ1JkdUkOlVsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F02606EE88;
	Tue,  3 Nov 2026 16:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99F02606EE88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793722358; x=1825258358;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=RU8wwx9R15Mr3gG1Xd5gijADtqrLP+TA57/EffDrdCU=;
  b=CcOTIg8j4IwCTzkyEM1uBVydewRo0i6Nn7nl3o6UcP6TfoXt5q/+xWR2
   mNnOKlpioPvmWCFZnNwg/AK7zUEeor500MFDIGNgqL+n4HLcYwxbkoZYd
   qwME6qwKulp48dfbkZKTe/bIOnX/S2WSvYV17mJu1Bi8osb+9pmiQtPnl
   Vc9AR3GiXLNfJlyN+QTDsnDv7sqg6KrdHhFjloo84oSyvw3GwNzTsQRr7
   L46xtsC7p++3gxQyI8PiqC8yT1jz+6WxKMJ0eZOC232vUc0DVmFwwwHmU
   +PC51nEgzBqbnWpa3YuV0u8FRVedFaAIa5LSmX9AQj01+7xJtBe66aGk+
   g==;
X-CSE-ConnectionGUID: YBds/MQ1QHWE0YrOb3RwOA==
X-CSE-MsgGUID: i6aMI7/mS2OusN4yYlaCtg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 18:12:35 +0200
X-CSE-ConnectionGUID: KmtwslnNQru2+zmtAciTVQ==
X-CSE-MsgGUID: r98I9sp1Qw+3c6MwRdzEvw==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 03 Nov 2026 18:20:29 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 03 Nov 2026 18:12:34 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 03 Nov 2026 18:12:16 +0200
Subject: [PATCH] i2c: designware: return proper fault codes
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
Message-Id: <20261103-i2c-designware-fixes-v1-1-f83dd71f988c@mobileye.com>
X-B4-Tracking: v=1; b=H4sIAN8H6moC/yXMywqDMBCF4VeRWXcgRrz1VYoLTU51ukhLplVBf
 HejXX4c/rORIgqU7tlGEbOovENCfsvITX0YweKTyRpb5caWLNaxh8oYlj6Cn7JCuSh93frBNFX
 TUko/EdeQykf3t/6GF9z3/KJ9PwBgeJdxeAAAAA==
X-Change-ID: 20261025-i2c-designware-fixes-35d79db08689
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Guzman <Dmitry.Guzman@mobileye.com>
X-Mailer: b4 0.16.0

I2C documentation Documentation/i2c/fault-codes.rst defines fault codes
for different negative results in I2C transmittion. Previously,
i2c-designware driver didn't implement them properly - it returned
EREMOTEIO on NACK either on address or data phase instead of ENXIO and
EIO respectively, and EINVAL instead of EOPNOTSUPP if a message cannot be
sent due to controller hardware limitations.

To comply with the documentation, return the proper fault codes for
different conditions, namely:

- EOPNOTSUPP if the controller cannot transfer the message sequence
  requested (for example, target address change without STOP condition)
- ENXIO if target address is not acknowledged
- EIO on other faults detected by controller (for example, NACK on data)

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
This patch was previously submitted as a part of a patchset that
introduces detailed fault reporting feature in i2c-nomadik and
i2c-designware drivers and i2c-core. 

This patch does not depend on remaining patches in that set, so I submit
it separately.

Link to the patch set that it was submitted in:

https://lore.kernel.org/r/20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com
---
 drivers/i2c/busses/i2c-designware-common.c | 8 ++++++--
 drivers/i2c/busses/i2c-designware-core.h   | 3 +--
 drivers/i2c/busses/i2c-designware-master.c | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index a1eca6cd4b75..e934bcbe7660 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -776,11 +776,15 @@ int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 	unsigned long abort_source = dev->abort_source;
 	int i;
 
-	if (abort_source & DW_IC_TX_ABRT_NOACK) {
+	if (abort_source & (DW_IC_TX_ABRT_ADDR_NOACK | DW_IC_TX_ABRT_TXDATA_NOACK)) {
 		for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
 			dev_dbg(dev->dev,
 				"%s: %s\n", __func__, abort_sources[i]);
-		return -EREMOTEIO;
+
+		if (abort_source & DW_IC_TX_ABRT_TXDATA_NOACK)
+			return -EIO;
+		else
+			return -ENXIO;
 	}
 
 	for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 2c929a6e8da2..025311c8662c 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -112,10 +112,9 @@
 #define DW_IC_RX_ABRT_SLAVE_ARBLOST		BIT(ABRT_SLAVE_ARBLOST)
 #define DW_IC_RX_ABRT_SLAVE_FLUSH_TXFIFO	BIT(ABRT_SLAVE_FLUSH_TXFIFO)
 
-#define DW_IC_TX_ABRT_NOACK			(DW_IC_TX_ABRT_7B_ADDR_NOACK | \
+#define DW_IC_TX_ABRT_ADDR_NOACK		(DW_IC_TX_ABRT_7B_ADDR_NOACK | \
 						 DW_IC_TX_ABRT_10ADDR1_NOACK | \
 						 DW_IC_TX_ABRT_10ADDR2_NOACK | \
-						 DW_IC_TX_ABRT_TXDATA_NOACK | \
 						 DW_IC_TX_ABRT_GCALL_NOACK)
 
 struct clk;
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 7e1d9a2e7733..a469a52b2f8f 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -915,7 +915,7 @@ i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
 		 */
 		for (cnt = 1; ; cnt++) {
 			if (!i2c_dw_msg_is_valid(dev, msgs_part, cnt - 1)) {
-				ret = -EINVAL;
+				ret = -EOPNOTSUPP;
 				break;
 			}
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261025-i2c-designware-fixes-35d79db08689

Best regards,
--  
Dmitry Guzman <Dmitry.Guzman@mobileye.com>

