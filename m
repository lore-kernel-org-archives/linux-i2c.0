From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 1/4] x86/platform/intel/iosf_mbi: Add a mutex for punit access
Date: Sun,  1 Jan 2017 21:14:00 +0100
Message-ID: <20170101201403.12132-2-hdegoede@redhat.com>
References: <20170101201403.12132-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932229AbdAAUOJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 1 Jan 2017 15:14:09 -0500
In-Reply-To: <20170101201403.12132-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>

The punit on baytrail / cherrytrail systems is not only accessed through
the iosf_mbi functions, but also by the i915 code. Add a mutex to protect
the punit against simultaneous accesses and 2 functions to lock / unlock
this mutex.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/include/asm/iosf_mbi.h    | 19 +++++++++++++++++++
 arch/x86/platform/intel/iosf_mbi.c | 13 +++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/iosf_mbi.h b/arch/x86/include/asm/iosf_mbi.h
index b41ee16..02963bd 100644
--- a/arch/x86/include/asm/iosf_mbi.h
+++ b/arch/x86/include/asm/iosf_mbi.h
@@ -88,6 +88,21 @@ int iosf_mbi_write(u8 port, u8 opcode, u32 offset, u32 mdr);
  */
 int iosf_mbi_modify(u8 port, u8 opcode, u32 offset, u32 mdr, u32 mask);
 
+/**
+ * iosf_mbi_punit_lock() - Lock the punit mutex
+ *
+ * This function must be called before accessing the punit or the pmic, be it
+ * through iosf_mbi_* or through other means.
+ *
+ * This function locks a mutex, as such it may sleep.
+ */
+void iosf_mbi_punit_lock(void);
+
+/**
+ * iosf_mbi_punit_unlock() - Unlock the punit mutex
+ */
+void iosf_mbi_punit_unlock(void);
+
 #else /* CONFIG_IOSF_MBI is not enabled */
 static inline
 bool iosf_mbi_available(void)
@@ -115,6 +130,10 @@ int iosf_mbi_modify(u8 port, u8 opcode, u32 offset, u32 mdr, u32 mask)
 	WARN(1, "IOSF_MBI driver not available");
 	return -EPERM;
 }
+
+static inline void iosf_mbi_punit_lock(void) {}
+static inline void iosf_mbi_punit_unlock(void) {}
+
 #endif /* CONFIG_IOSF_MBI */
 
 #endif /* IOSF_MBI_SYMS_H */
diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index edf2c54..75d8135 100644
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
 
+void iosf_mbi_punit_lock(void)
+{
+	mutex_lock(&iosf_mbi_punit_mutex);
+}
+EXPORT_SYMBOL(iosf_mbi_punit_lock);
+
+void iosf_mbi_punit_unlock(void)
+{
+	mutex_unlock(&iosf_mbi_punit_mutex);
+}
+EXPORT_SYMBOL(iosf_mbi_punit_unlock);
+
 #ifdef CONFIG_IOSF_MBI_DEBUG
 static u32	dbg_mdr;
 static u32	dbg_mcr;
-- 
2.9.3
