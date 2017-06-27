From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] x86/io: Include asm-generic/io.h to architectural code
Date: Tue, 27 Jun 2017 19:06:41 +0300
Message-ID: <20170627160641.75712-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46034 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751893AbdF0QGs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 27 Jun 2017 12:06:48 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@spreadtrum.com>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

asm-generic/io.h defines few helpers which would be useful in the drivers,
such as writesb() and readsb().

Include it to the asm/io.h in architectural folder.

Note, to apply above we need to define macros for functions which do not have
them yet defined, such as readb() or writeb(). This is done here as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/io.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 7afb0e2f07f4..abb3090a5822 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -69,6 +69,9 @@ build_mmio_write(__writeb, "b", unsigned char, "q", )
 build_mmio_write(__writew, "w", unsigned short, "r", )
 build_mmio_write(__writel, "l", unsigned int, "r", )
 
+#define readb readb
+#define readw readw
+#define readl readl
 #define readb_relaxed(a) __readb(a)
 #define readw_relaxed(a) __readw(a)
 #define readl_relaxed(a) __readl(a)
@@ -76,6 +79,9 @@ build_mmio_write(__writel, "l", unsigned int, "r", )
 #define __raw_readw __readw
 #define __raw_readl __readl
 
+#define writeb writeb
+#define writew writew
+#define writel writel
 #define writeb_relaxed(v, a) __writeb(v, a)
 #define writew_relaxed(v, a) __writew(v, a)
 #define writel_relaxed(v, a) __writel(v, a)
@@ -119,6 +125,7 @@ static inline phys_addr_t virt_to_phys(volatile void *address)
 {
 	return __pa(address);
 }
+#define virt_to_phys virt_to_phys
 
 /**
  *	phys_to_virt	-	map physical address to virtual
@@ -137,6 +144,7 @@ static inline void *phys_to_virt(phys_addr_t address)
 {
 	return __va(address);
 }
+#define phys_to_virt phys_to_virt
 
 /*
  * Change "struct page" to physical address.
@@ -220,6 +228,7 @@ memset_io(volatile void __iomem *addr, unsigned char val, size_t count)
 {
 	memset((void __force *)addr, val, count);
 }
+#define memset_io(dst,c,count) memset_io(dst,c,count)
 
 /**
  * memcpy_fromio	Copy a block of data from I/O memory
@@ -234,6 +243,7 @@ memcpy_fromio(void *dst, const volatile void __iomem *src, size_t count)
 {
 	memcpy(dst, (const void __force *)src, count);
 }
+#define memcpy_fromio(to,from,count) memcpy_fromio(to,from,count)
 
 /**
  * memcpy_toio		Copy a block of data into I/O memory
@@ -248,6 +258,7 @@ memcpy_toio(volatile void __iomem *dst, const void *src, size_t count)
 {
 	memcpy((void __force *)dst, src, count);
 }
+#define memcpy_toio(to,from,count) memcpy_toio(to,from,count)
 
 /*
  * ISA space is 'always mapped' on a typical x86 system, no need to
@@ -341,9 +352,32 @@ BUILDIO(b, b, char)
 BUILDIO(w, w, short)
 BUILDIO(l, , int)
 
+#define inb inb
+#define inw inw
+#define inl inl
+#define inb_p inb_p
+#define inw_p inw_p
+#define inl_p inl_p
+#define insb insb
+#define insw insw
+#define insl insl
+
+#define outb outb
+#define outw outw
+#define outl outl
+#define outb_p outb_p
+#define outw_p outw_p
+#define outl_p outl_p
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
+
 extern void *xlate_dev_mem_ptr(phys_addr_t phys);
 extern void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
 
+#define xlate_dev_mem_ptr xlate_dev_mem_ptr
+#define unxlate_dev_mem_ptr unxlate_dev_mem_ptr
+
 extern int ioremap_change_attr(unsigned long vaddr, unsigned long size,
 				enum page_cache_mode pcm);
 extern void __iomem *ioremap_wc(resource_size_t offset, unsigned long size);
@@ -365,6 +399,8 @@ extern bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 
 #define IO_SPACE_LIMIT 0xffff
 
+#include <asm-generic/io.h>
+
 #ifdef CONFIG_MTRR
 extern int __must_check arch_phys_wc_index(int handle);
 #define arch_phys_wc_index arch_phys_wc_index
-- 
2.11.0
