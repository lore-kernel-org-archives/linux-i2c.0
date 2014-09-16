From: Fan Du <fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] i2c-ismt: Use minimum descriptor size
Date: Tue, 16 Sep 2014 17:21:03 +0800
Message-ID: <1410859264-7118-2-git-send-email-fan.du@intel.com>
References: <1410859264-7118-1-git-send-email-fan.du@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410859264-7118-1-git-send-email-fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org
Cc: fengyuleidian0615-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fan Du <fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Software is allowed to allocate number of descriptor size from 2 to 256,
this i2c controller could process more descriptor, but for i2c core soft
ware layer, only one i2c transaction is allowed each time.

So here switch to minimum 2 descriptor when initialization.

Signed-off-by: Fan Du <fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-ismt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 9844925..8a0275c 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -81,7 +81,7 @@
 #define PCI_DEVICE_ID_INTEL_S1200_SMT1	0x0c5a
 #define PCI_DEVICE_ID_INTEL_AVOTON_SMT	0x1f15
 
-#define ISMT_DESC_ENTRIES	32	/* number of descriptor entries */
+#define ISMT_DESC_ENTRIES	2	/* number of descriptor entries */
 #define ISMT_MAX_RETRIES	3	/* number of SMBus retries to attempt */
 
 /* Hardware Descriptor Constants - Control Field */
-- 
1.7.9.5
