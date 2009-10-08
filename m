From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] i2c-bfin-twi: add debug output for error status
Date: Wed,  7 Oct 2009 23:38:16 -0400
Message-ID: <1254973096-4391-2-git-send-email-vapier@gentoo.org>
References: <1254973096-4391-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1254973096-4391-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Add some debug() code to decode the error register.

Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index bbce6bd..be85e3d 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -156,6 +156,18 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface)
 		write_MASTER_CTL(iface, 0);
 		SSYNC();
 		iface->result = -EIO;
+
+		if (mast_stat & LOSTARB)
+			dev_dbg(&iface->adap.dev, "Lost Arbitration\n");
+		if (mast_stat & ANAK)
+			dev_dbg(&iface->adap.dev, "Address Not Acknowledged\n");
+		if (mast_stat & DNAK)
+			dev_dbg(&iface->adap.dev, "Data Not Acknowledged\n");
+		if (mast_stat & BUFRDERR)
+			dev_dbg(&iface->adap.dev, "Buffer Read Error\n");
+		if (mast_stat & BUFWRERR)
+			dev_dbg(&iface->adap.dev, "Buffer Write Error\n");
+
 		/* if both err and complete int stats are set, return proper
 		 * results.
 		 */
-- 
1.6.5.rc2
