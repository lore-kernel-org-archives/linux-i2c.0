From: Hans de Goede <hdegoede@redhat.com>
Subject: Linux irq subsys i2c interaction question
Date: Tue, 7 Mar 2017 09:16:54 +0100
Message-ID: <ff19dd32-2e6a-d4a2-a4f0-f11e1316b7c1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Thomas,

I've an "interesting" irq problem. I've an i2c pmic
(Intel Cherry Trail Whiskey Cove) which itself contains
an i2c controller (adapter in Linux terms) and has a
pin dedicated for raising irqs by the external battery
charger ic attached to its i2c-adapter.

To be able to use the irq for the external-charger,
the driver for the PMIC needs to implement an irqchip
and here things get interesting. This irqchip can
NOT use handle_nested_irq, because the i2c-client
driver's irq-handler will want to read/write to
the external-charger which uses the i2c-controller
embedded in the PMIC which requires handling of
new (not arrived when started) PMIC irqs, which
cannot be done if the client irq-handler is running
in handle_nested_irq, because then the PMIC's irq
handler is already / still running and blocked in
the i2c-client's irq-handler which is waiting for
the new interrupt(s) to get processed to signal
completion of the i2c-transaction(s) it is doing.

I've solved this the following way, which works but
I wonder if it is the right way to solve this ?

Note this sits inside the threaded interrupt handler
for the PMIC irq (after reading and acking the irqs):

         /*
          * Do NOT use handle_nested_irq here, the client irq handler will
          * likely want to do i2c transfers and the i2c controller uses this
          * interrupt handler as well, so running the client irq handler from
          * this thread will cause things to lock up.
          */
         if (reg & CHT_WC_EXTCHGRIRQ_CLIENT_IRQ) {
                 /*
                  * generic_handle_irq expects local irqs to be disabled
                  * as normally it is called from interrupt context.
                  */
                 local_irq_disable();
                 generic_handle_irq(adap->client_irq);
                 local_irq_enable();
         }

Not really pretty, but it works well enough. I can
live with this if you can live with it too :)

Regards,

Hans
