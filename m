From: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor-v1d7l9VOqKc@public.gmane.org>
Subject: [PATCH 3/5 v4] usb: pci-quirks: Protect the I/O port pair of SB800
Date: Thu, 22 Jun 2017 15:21:32 +0200
Message-ID: <20170622132134.7200-4-zboszor@pr.hu>
References: <20170621035349.4125-1-zboszor@pr.hu>
 <20170622132134.7200-1-zboszor@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170622132134.7200-1-zboszor-v1d7l9VOqKc@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Christian Fetzer <fetzer.ch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Nehal Shah <nehal-bakulchandra.shah-5C7GfCeVMHo@public.gmane.org>, Tim Small <tim-v0yPK6tSSg/10XsdtD+oqA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, kernel-i2qG/+7/Q79eoWH0uzbU5w@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, jlayton-vpEMnDpepFuMZCB2o+C8xQ@public.gmane.org, marc.2377-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cshorler-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, regressions-rCxcAJFjeRkk+I/owrrOrA@public.gmane.org, =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= <zboszor-v1d7l9VOqKc@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch uses the previously introduced macro called
request_declared_muxed_region() to synchronize access to
the I/O port pair 0xcd6 / 0xcd7 on SB800.

These I/O ports are also used by i2c-piix4 and sp5100_tco,
so synchronization is necessary. The other drivers will also
be modified to use the new macro in subsequest patched.

v1: Started with a common mutex in a C source file.

v2: Declared the common mutex in drivers/usb/host/pci-quirks.c
    instead of in a common C file.

v3: Switched to using the new request_declared_muxed_region
    macro.

v4: Fixed checkpatch.pl warnings and use the new
    release_declared_region() macro.

Signed-off-by: Zoltán Böszörményi <zboszor-v1d7l9VOqKc@public.gmane.org>
---
 drivers/usb/host/pci-quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index a9a1e4c..593942a 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -279,6 +279,8 @@ bool usb_amd_prefetch_quirk(void)
 }
 EXPORT_SYMBOL_GPL(usb_amd_prefetch_quirk);
 
+static struct resource sb800_res = DEFINE_RES_IO_NAMED(0xcd6, 2, "SB800 USB");
+
 /*
  * The hardware normally enables the A-link power management feature, which
  * lets the system lower the power consumption in idle states.
@@ -314,11 +316,13 @@ static void usb_amd_quirk_pll(int disable)
 	if (amd_chipset.sb_type.gen == AMD_CHIPSET_SB800 ||
 			amd_chipset.sb_type.gen == AMD_CHIPSET_HUDSON2 ||
 			amd_chipset.sb_type.gen == AMD_CHIPSET_BOLTON) {
+		request_declared_muxed_region(&sb800_res);
 		outb_p(AB_REG_BAR_LOW, 0xcd6);
 		addr_low = inb_p(0xcd7);
 		outb_p(AB_REG_BAR_HIGH, 0xcd6);
 		addr_high = inb_p(0xcd7);
 		addr = addr_high << 8 | addr_low;
+		release_declared_region(&sb800_res);
 
 		outl_p(0x30, AB_INDX(addr));
 		outl_p(0x40, AB_DATA(addr));
-- 
2.9.4

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
