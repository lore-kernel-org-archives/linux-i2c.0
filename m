From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 01/12] x86/platform/intel/iosf_mbi: Add a mutex for P-Unit access
Date: Fri, 24 Feb 2017 10:29:01 +0100
Message-ID: <20170224092912.10685-2-hdegoede@redhat.com>
References: <20170224092912.10685-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbdBXJ3U (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 24 Feb 2017 04:29:20 -0500
In-Reply-To: <20170224092912.10685-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

One some systems the P-Unit accesses the PMIC to change various voltages
through the same bus as other kernel drivers use for e.g. battery
monitoring.

If a driver sends requests to the P-Unit which require the P-Unit to access
the PMIC bus while another driver is also accessing the PMIC bus various
bad things happen.

This commit adds a mutex to protect the P-Unit against simultaneous
accesses and 2 functions to lock / unlock this mutex.

Note on these systems the i2c-bus driver will request a sempahore from the
P-Unit for exclusive access to the PMIC bus when i2c drivers are accessing
it, but this does not appear to be sufficient, we still need to avoid
making certain P-Unit requests during the access window to avoid problems.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=155241
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: tagorereddy <tagore.chandan@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes in v2:
-Rename iosf_mbi_punit_lock/_unlock to _acquire/_release rename
-Spelling: P-Unit, PMIC
---
 arch/x86/include/asm/iosf_mbi.h    | 31 +++++++++++++++++++++++++++++++
 arch/x86/platform/intel/iosf_mbi.c | 13 +++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/x86/include/asm/iosf_mbi.h b/arch/x86/include/asm/iosf_mbi.h
index b41ee16..f6119d0 100644
--- a/arch/x86/include/asm/iosf_mbi.h
+++ b/arch/x86/include/asm/iosf_mbi.h
@@ -88,6 +88,33 @@ int iosf_mbi_write(u8 port, u8 opcode, u32 offset, u32 mdr);
  */
 int iosf_mbi_modify(u8 port, u8 opcode, u32 offset, u32 mdr, u32 mask);
 
+/**
+ * iosf_mbi_punit_acquire() - Acquire access to the P-Unit
+ *
+ * One some systems the P-Unit accesses the PMIC to change various voltages
+ * through the same bus as other kernel drivers use for e.g. battery monitoring.
+ *
+ * If a driver sends requests to the P-Unit which require the P-Unit to access
+ * the PMIC bus while another driver is also accessing the PMIC bus various bad
+ * things happen.
+ *
+ * To avoid these problems this function must be called before accessing the
+ * P-Unit or the PMIC, be it through iosf_mbi* functions or through other means.
+ *
+ * Note on these systems the i2c-bus driver will request a sempahore from the
+ * P-Unit for exclusive access to the PMIC bus when i2c drivers are accessing
+ * it, but this does not appear to be sufficient, we still need to avoid making
+ * certain P-Unit requests during the access window to avoid problems.
+ *
+ * This function locks a mutex, as such it may sleep.
+ */
+void iosf_mbi_punit_acquire(void);
+
+/**
+ * iosf_mbi_punit_release() - Release access to the P-Unit
+ */
+void iosf_mbi_punit_release(void);
+
 #else /* CONFIG_IOSF_MBI is not enabled */
 static inline
 bool iosf_mbi_available(void)
@@ -115,6 +142,10 @@ int iosf_mbi_modify(u8 port, u8 opcode, u32 offset, u32 mdr, u32 mask)
 	WARN(1, "IOSF_MBI driver not available");
 	return -EPERM;
 }
+
+static inline void iosf_mbi_punit_acquire(void) {}
+static inline void iosf_mbi_punit_release(void) {}
+
 #endif /* CONFIG_IOSF_MBI */
 
 #endif /* IOSF_MBI_SYMS_H */
diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index edf2c54..ed24fa9f 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -34,6 +34,7 @@
 
 static struct pci_dev *mbi_pdev;
 static DEFINE_SPINLOCK(iosf_mbi_lock);
+static DEFINE_MUTEX(iosf_mbi_punit_mutex);
 
 static inline u32 iosf_mbi_form_mcr(u8 op, u8 port, u8 offset)
 {
@@ -190,6 +191,18 @@ bool iosf_mbi_available(void)
 }
 EXPORT_SYMBOL(iosf_mbi_available);
 
+void iosf_mbi_punit_acquire(void)
+{
+	mutex_lock(&iosf_mbi_punit_mutex);
+}
+EXPORT_SYMBOL(iosf_mbi_punit_acquire);
+
+void iosf_mbi_punit_release(void)
+{
+	mutex_unlock(&iosf_mbi_punit_mutex);
+}
+EXPORT_SYMBOL(iosf_mbi_punit_release);
+
 #ifdef CONFIG_IOSF_MBI_DEBUG
 static u32	dbg_mdr;
 static u32	dbg_mcr;
-- 
2.9.3
