From: Jan Kandziora <jjj@gmx.de>
Subject: [PATCH v5 1/2] wire: export w1_touch_bit
Date: Wed, 20 Sep 2017 23:52:45 +0200
Message-ID: <20170920215246.5821-1-jjj@gmx.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:63804 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbdITVww (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 20 Sep 2017 17:52:52 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: GregKH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Evgeniy Polyakov <zbr@ioremap.net>, Linux-I2C <linux-i2c@vger.kernel.org>

The w1_ds28e17 driver from the next part of this patch needs to emit
single-bit read timeslots to the DS28E17. The w1 subsystem already
has this function but it is not exported outside drivers/w1/w1_io.c

This subpatch exports the w1_touch_bit symbol with EXPORT_SYMBOL_GPL,
same as the other exported symbols in drivers/w1/w1_io.c

May be also useful later for writing drivers for other Onewire chips
which do single-bit communication.

Signed-off-by: Jan Kandziora <jjj@gmx.de>
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
---
Changes in v5 against v4 in this subpatch:
  - adapted to linux-4.14-rc1

Changes in v4 against v3 in this subpatch:
  - adapted to linux-4.12.0

No changes in v3 against v2,v1 in this subpatch.

 drivers/w1/w1_io.c | 3 ++-
 include/linux/w1.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
index d191e1f..075d120 100644
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
diff --git a/include/linux/w1.h b/include/linux/w1.h
index 5b29729..694101f 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -293,6 +293,7 @@ void w1_unregister_family(struct w1_family *family);
 			w1_unregister_family)
 
 u8 w1_triplet(struct w1_master *dev, int bdir);
+u8 w1_touch_bit(struct w1_master *dev, int bit);
 void w1_write_8(struct w1_master *, u8);
 u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
-- 
2.13.3
