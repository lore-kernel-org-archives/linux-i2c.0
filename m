From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: [PATCH v5 1/4] Move Intel SNB device ids from sb_edac to pci_ids.h
Date: Fri, 27 Sep 2013 18:02:40 -0700
Message-ID: <c55dc999afc63adb54ec73d5346d23603facca9e.1380315959.git.luto@amacapital.net>
References: <cover.1380315959.git.luto@amacapital.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1380315959.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
In-Reply-To: <cover.1380315959.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
References: <cover.1380315959.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c_imc driver will use two of them, and moving only part of
the list seems messier.

Cc: Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
---
 drivers/edac/sb_edac.c  | 30 ------------------------------
 include/linux/pci_ids.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index e04462b..4fac6f5 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -52,36 +52,6 @@ static int probed;
 #define GET_BITFIELD(v, lo, hi)	\
 	(((v) & ((1ULL << ((hi) - (lo) + 1)) - 1) << (lo)) >> (lo))
 
-/*
- * sbridge Memory Controller Registers
- */
-
-/*
- * FIXME: For now, let's order by device function, as it makes
- * easier for driver's development process. This table should be
- * moved to pci_id.h when submitted upstream
- */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD0	0x3cf4	/* 12.6 */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD1	0x3cf6	/* 12.7 */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_BR		0x3cf5	/* 13.6 */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_HA0	0x3ca0	/* 14.0 */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TA	0x3ca8	/* 15.0 */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_RAS	0x3c71	/* 15.1 */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD0	0x3caa	/* 15.2 */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD1	0x3cab	/* 15.3 */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD2	0x3cac	/* 15.4 */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD3	0x3cad	/* 15.5 */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_DDRIO	0x3cb8	/* 17.0 */
-
-	/*
-	 * Currently, unused, but will be needed in the future
-	 * implementations, as they hold the error counters
-	 */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_ERR0	0x3c72	/* 16.2 */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_ERR1	0x3c73	/* 16.3 */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_ERR2	0x3c76	/* 16.6 */
-#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_ERR3	0x3c77	/* 16.7 */
-
 /* Devices 12 Function 6, Offsets 0x80 to 0xcc */
 static const u32 dram_rule[] = {
 	0x80, 0x88, 0x90, 0x98, 0xa0,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d1fe5d0..fb8932b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2811,7 +2811,22 @@
 #define PCI_DEVICE_ID_INTEL_UNC_R2PCIE	0x3c43
 #define PCI_DEVICE_ID_INTEL_UNC_R3QPI0	0x3c44
 #define PCI_DEVICE_ID_INTEL_UNC_R3QPI1	0x3c45
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_RAS	0x3c71	/* 15.1 */
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_ERR0	0x3c72	/* 16.2 */
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_ERR1	0x3c73	/* 16.3 */
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_ERR2	0x3c76	/* 16.6 */
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_ERR3	0x3c77	/* 16.7 */
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_HA0	0x3ca0	/* 14.0 */
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TA	0x3ca8	/* 15.0 */
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD0	0x3caa	/* 15.2 */
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD1	0x3cab	/* 15.3 */
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD2	0x3cac	/* 15.4 */
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD3	0x3cad	/* 15.5 */
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_DDRIO	0x3cb8	/* 17.0 */
 #define PCI_DEVICE_ID_INTEL_JAKETOWN_UBOX	0x3ce0
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD0	0x3cf4	/* 12.6 */
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_BR		0x3cf5	/* 13.6 */
+#define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD1	0x3cf6	/* 12.7 */
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
 #define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
 #define PCI_DEVICE_ID_INTEL_5100_19	0x65f3
-- 
1.8.3.1
