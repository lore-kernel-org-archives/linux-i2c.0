From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/5] gpio: implement x86 gpio_to_irq convert function
Date: Thu, 17 Jun 2010 15:05:15 +0100
Message-ID: <20100617140513.17861.73723.stgit@localhost.localdomain>
References: <20100617140352.17861.29664.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100617140352.17861.29664.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Signed-off-by: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 arch/x86/include/asm/gpio.h |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)


diff --git a/arch/x86/include/asm/gpio.h b/arch/x86/include/asm/gpio.h
index 49dbfdf..91d915a 100644
--- a/arch/x86/include/asm/gpio.h
+++ b/arch/x86/include/asm/gpio.h
@@ -38,12 +38,9 @@ static inline int gpio_cansleep(unsigned int gpio)
 	return __gpio_cansleep(gpio);
 }
 
-/*
- * Not implemented, yet.
- */
 static inline int gpio_to_irq(unsigned int gpio)
 {
-	return -ENOSYS;
+	return __gpio_to_irq(gpio);
 }
 
 static inline int irq_to_gpio(unsigned int irq)
