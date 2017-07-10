From: Jan Kandziora <jjj@gmx.de>
Subject: [PATCH v4 1/2] wire: export w1_touch_bit
Date: Tue, 11 Jul 2017 00:59:56 +0200
Message-ID: <4aa9d196-1e31-de86-4ba7-752a0a04122c@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:53655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754952AbdGJW76 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 10 Jul 2017 18:59:58 -0400
Content-Language: de-DE
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Evgeniy Polyakov <zbr@ioremap.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Changes in v4 against v3 in this subpatch:
  - adapted to linux-4.12.0

No changes in v3 against v2,v1 in this subpatch.

The w1_ds28e17 driver from the next part of this patch needs to emit
single-bit read timeslots to the DS28E17. The w1 subsystem already
has this function but it is not exported outside drivers/w1/w1_io.c

This subpatch exports the w1_touch_bit symbol with EXPORT_SYMBOL_GPL,
same as the other exported symbols in drivers/w1/w1_io.c

May be also useful later for writing drivers for other Onewire chips
which do single-bit communication.


Signed-off-by: Jan Kandziora <jjj@gmx.de>
---
>From 6aedd1b890bd77bfe788f6af7a38724c16934ab0 Mon Sep 17 00:00:00 2001
From: Jan Kandziora <jjj@gmx.de>
Date: Sat, 8 Jul 2017 21:14:27 +0200
Subject: [PATCH 1/2] wire: export w1_touch_bit

---
 drivers/w1/w1.h    | 1 +
 drivers/w1/w1_io.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
index 758a7a6..e7af855 100644
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -295,6 +295,7 @@ int w1_attach_slave_device(struct w1_master *dev,
struct w1_reg_num *rn);
 int w1_slave_detach(struct w1_slave *sl);
  u8 w1_triplet(struct w1_master *dev, int bdir);
+u8 w1_touch_bit(struct w1_master *dev, int bit);
 void w1_write_8(struct w1_master *, u8);
 u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
index 1134e6b..4bb77a1 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -58,7 +58,7 @@ static u8 w1_read_bit(struct w1_master *dev);
  * @dev:	the master device
  * @bit:	0 - write a 0, 1 - write a 0 read the level
  */
-static u8 w1_touch_bit(struct w1_master *dev, int bit)
+u8 w1_touch_bit(struct w1_master *dev, int bit)
 {
 	if (dev->bus_master->touch_bit)
 		return dev->bus_master->touch_bit(dev->bus_master->data, bit);
@@ -69,6 +69,7 @@ static u8 w1_touch_bit(struct w1_master *dev, int bit)
 		return 0;
 	}
 }
+EXPORT_SYMBOL_GPL(w1_touch_bit);
  /**
  * w1_write_bit() - Generates a write-0 or write-1 cycle.
-- 
2.13.1
