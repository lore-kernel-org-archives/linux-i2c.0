From: Yadi Hu <yadi.hu@windriver.com>
Subject: RESEND: V3 i2c-eg20t:fix race between i2c init and interrupt enable
Date: Sun, 18 Sep 2016 18:52:30 +0800
Message-ID: <1474195951-7238-1-git-send-email-yadi.hu@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:56046 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754693AbcIRKwt (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 18 Sep 2016 06:52:49 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: yadi.hu@windriver.com, wsa@the-dreams.de, jdelvare@suse.de
Cc: linux-i2c@vger.kernel.org

the eg20t driver call request_irq() function before the pch_base_address,
base address of i2c controller's register, isassigned an effective value.

there is one possible scenario that an interrupt which isn't inside eg20t
arrives immediately after request_irq() is executed when i2c controller
shares an interrupt number with others.  since the interrupt handler
pch_i2c_handler() has already active as shared action, it will be called
and read its own register to determine if this interrupt is from itself.

At that moment, since base address of i2c registers is not remapped
in kernel space yet,so the INT handler will access an illegal address
and then a error occurs.

Bad IO access at port 0x18 (return inl(port))
 Call Trace:
  [<c102c733>] warn_slowpath_common+0x73/0xa0
  [<c13109f5>] ? bad_io_access+0x45/0x50
  [<c13109f5>] ? bad_io_access+0x45/0x50
  [<c102c804>] warn_slowpath_fmt+0x34/0x40
  [<c13109f5>] bad_io_access+0x45/0x50
  [<c1310b62>] ioread32+0x22/0x40
  [<c14c60db>] pch_i2c_handler+0x3b/0x120
  [<c1092f34>] handle_irq_event_percpu+0x64/0x330
  [<c109323b>] handle_irq_event+0x3b/0x60
  [<c1095b50>] ? unmask_irq+0x30/0x30
  [<c1095ba0>] handle_fasteoi_irq+0x50/0xe0
  <IRQ>  [<c16e7e78>] ? do_IRQ+0x48/0xc0
  [<c16e7f6f>] ? smp_apic_timer_interrupt+0x7f/0x17a
  [<c16e7da9>] ? common_interrupt+0x29/0x30
  [<c1008ebb>] ? mwait_idle+0x8b/0x2c0
  [<c1009e8e>] ? cpu_idle+0x9e/0xc0
  [<c16be408>] ? rest_init+0x6c/0x74
  [<c19f770a>] ? start_kernel+0x311/0x318
  [<c19f7231>] ? repair_env_string+0x51/0x51
  [<c19f7078>] ? i386_start_kernel+0x78/0x7d
 ---[ end trace eb3a1028f468a140 ]---
 i2c_eg20t 0000:05:0c.2: pch_i2c_handler :I2C-3 mode(0) is not supported


Yadi Hu (1)
    i2c-eg20t: fix race between i2c init and interrupt enable

drivers/i2c/busses/i2c-eg20t.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)
