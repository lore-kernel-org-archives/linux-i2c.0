From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 02/12] x86/platform/intel/iosf_mbi: Add a PMIC bus access notifier
Date: Fri, 24 Feb 2017 10:29:02 +0100
Message-ID: <20170224092912.10685-3-hdegoede@redhat.com>
References: <20170224092912.10685-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbdBXJ3X (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 24 Feb 2017 04:29:23 -0500
In-Reply-To: <20170224092912.10685-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

Some drivers may need to acquire P-Unit managed resources from interrupt
context, where they cannot call iosf_mbi_punit_acquire().

This commit adds a notifier chain which allows a driver to get notified
(in a process context) before other drivers start accessing the PMIC bus,
so that the driver can acquire any resources, which it may need during
the window the other driver is accessing the PMIC, before hand.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: tagorereddy <tagore.chandan@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes in v2:
-Spelling: P-Unit, PMIC
-Adjust for iosf_mbi_punit_lock/_unlock to _acquire/_release rename
Changes in v4:
-Include <linux/notifier.h> from asm/iosf_mbi.h
---
 arch/x86/include/asm/iosf_mbi.h    | 56 ++++++++++++++++++++++++++++++++++++++
 arch/x86/platform/intel/iosf_mbi.c | 36 ++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/arch/x86/include/asm/iosf_mbi.h b/arch/x86/include/asm/iosf_mbi.h
index f6119d0..c313cac 100644
--- a/arch/x86/include/asm/iosf_mbi.h
+++ b/arch/x86/include/asm/iosf_mbi.h
@@ -5,6 +5,8 @@
 #ifndef IOSF_MBI_SYMS_H
 #define IOSF_MBI_SYMS_H
 
+#include <linux/notifier.h>
+
 #define MBI_MCR_OFFSET		0xD0
 #define MBI_MDR_OFFSET		0xD4
 #define MBI_MCRX_OFFSET		0xD8
@@ -47,6 +49,10 @@
 #define QRK_MBI_UNIT_MM		0x05
 #define QRK_MBI_UNIT_SOC	0x31
 
+/* Action values for the pmic_bus_access_notifier functions */
+#define MBI_PMIC_BUS_ACCESS_BEGIN	1
+#define MBI_PMIC_BUS_ACCESS_END		2
+
 #if IS_ENABLED(CONFIG_IOSF_MBI)
 
 bool iosf_mbi_available(void);
@@ -115,6 +121,38 @@ void iosf_mbi_punit_acquire(void);
  */
 void iosf_mbi_punit_release(void);
 
+/**
+ * iosf_mbi_register_pmic_bus_access_notifier - Register PMIC bus notifier
+ *
+ * This function can be used by drivers which may need to acquire P-Unit
+ * managed resources from interrupt context, where iosf_mbi_punit_acquire()
+ * can not be used.
+ *
+ * This function allows a driver to register a notifier to get notified (in a
+ * process context) before other drivers start accessing the PMIC bus.
+ *
+ * This allows the driver to acquire any resources, which it may need during
+ * the window the other driver is accessing the PMIC, before hand.
+ *
+ * @nb: notifier_block to register
+ */
+int iosf_mbi_register_pmic_bus_access_notifier(struct notifier_block *nb);
+
+/**
+ * iosf_mbi_register_pmic_bus_access_notifier - Unregister PMIC bus notifier
+ *
+ * @nb: notifier_block to unregister
+ */
+int iosf_mbi_unregister_pmic_bus_access_notifier(struct notifier_block *nb);
+
+/**
+ * iosf_mbi_call_pmic_bus_access_notifier_chain - Call PMIC bus notifier chain
+ *
+ * @val: action to pass into listener's notifier_call function
+ * @v: data pointer to pass into listener's notifier_call function
+ */
+int iosf_mbi_call_pmic_bus_access_notifier_chain(unsigned long val, void *v);
+
 #else /* CONFIG_IOSF_MBI is not enabled */
 static inline
 bool iosf_mbi_available(void)
@@ -146,6 +184,24 @@ int iosf_mbi_modify(u8 port, u8 opcode, u32 offset, u32 mdr, u32 mask)
 static inline void iosf_mbi_punit_acquire(void) {}
 static inline void iosf_mbi_punit_release(void) {}
 
+static inline
+int iosf_mbi_register_pmic_bus_access_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline
+int iosf_mbi_unregister_pmic_bus_access_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline
+int iosf_mbi_call_pmic_bus_access_notifier_chain(unsigned long val, void *v)
+{
+	return 0;
+}
+
 #endif /* CONFIG_IOSF_MBI */
 
 #endif /* IOSF_MBI_SYMS_H */
diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index ed24fa9f..a952ac1 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -35,6 +35,7 @@
 static struct pci_dev *mbi_pdev;
 static DEFINE_SPINLOCK(iosf_mbi_lock);
 static DEFINE_MUTEX(iosf_mbi_punit_mutex);
+static BLOCKING_NOTIFIER_HEAD(iosf_mbi_pmic_bus_access_notifier);
 
 static inline u32 iosf_mbi_form_mcr(u8 op, u8 port, u8 offset)
 {
@@ -203,6 +204,41 @@ void iosf_mbi_punit_release(void)
 }
 EXPORT_SYMBOL(iosf_mbi_punit_release);
 
+int iosf_mbi_register_pmic_bus_access_notifier(struct notifier_block *nb)
+{
+	int ret;
+
+	/* Wait for the bus to go inactive before registering */
+	mutex_lock(&iosf_mbi_punit_mutex);
+	ret = blocking_notifier_chain_register(
+				&iosf_mbi_pmic_bus_access_notifier, nb);
+	mutex_unlock(&iosf_mbi_punit_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(iosf_mbi_register_pmic_bus_access_notifier);
+
+int iosf_mbi_unregister_pmic_bus_access_notifier(struct notifier_block *nb)
+{
+	int ret;
+
+	/* Wait for the bus to go inactive before unregistering */
+	mutex_lock(&iosf_mbi_punit_mutex);
+	ret = blocking_notifier_chain_unregister(
+				&iosf_mbi_pmic_bus_access_notifier, nb);
+	mutex_unlock(&iosf_mbi_punit_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL(iosf_mbi_unregister_pmic_bus_access_notifier);
+
+int iosf_mbi_call_pmic_bus_access_notifier_chain(unsigned long val, void *v)
+{
+	return blocking_notifier_call_chain(
+				&iosf_mbi_pmic_bus_access_notifier, val, v);
+}
+EXPORT_SYMBOL(iosf_mbi_call_pmic_bus_access_notifier_chain);
+
 #ifdef CONFIG_IOSF_MBI_DEBUG
 static u32	dbg_mdr;
 static u32	dbg_mcr;
-- 
2.9.3
