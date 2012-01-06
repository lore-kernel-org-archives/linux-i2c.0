From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/3 v2] i2c: i801: enable irq
Date: Fri,  6 Jan 2012 18:58:19 +0800
Message-ID: <1325847502-17841-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org, David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is a second version of a set of patches enables the Intel PCH SMBus
controller interrupt.  It refactors the second two patches a little bit by
relying on DEV_ERR interrupt for timeouts, instead of using an explicit
wait_event_timeout.

The first attempt received absolutely no response. Maybe this time someone
will be interested.

The SMBus Host Controller Interrupt can signify:
 INTR - the end of a complete transaction
 DEV_ERR - that a device did not ACK a transaction
 BYTE_DONE - the completion of a single byte during a byte-by-byte transaction

This patchset arrives with the following caveats:

 1)  It has only been tested with a Cougar Point (Intel 6 Series PCH) SMBus
controller, so the irq is only enabled for that chip type.

 2) It has not been tested with any devices that do transactions that use the
    PEC.  In fact, I believe that an additional small patch would be required
    to the driver working correctly in interrupt mode with PEC.

 3) It has not been tested in SMBus Slave mode.

 4) It has not been tested with SMI#-type interrupts.

 5) The BIOS has to configure the PCH SMBus IRQ properly.

 6) It has not been tested with a device that does byte-by-byte smbus (non-i2c)
    reads.

 7) It has not been tested with smbus 'process call' transactions.

If would be very helpful if somebody could help test on other chipsets, with
a PEC device, or on additional BIOS that woudl be very helpful.

In the meantime, the interrupt behavior is only enabled on the Cougar Point,
and even here, it can be completely disabled with the "Interrupt" feature like
other advanced features of the driver.

Daniel Kurtz (3):
  i2c: i801: refactor i801_block_transaction_byte_by_byte
  i2c: i801: enable irq for i801 smbus transactions
  i2c: i801: enable irq for byte_by_byte transactions

 drivers/i2c/busses/i2c-i801.c |  199 ++++++++++++++++++++++++++++++++++++-----
 1 files changed, 175 insertions(+), 24 deletions(-)

-- 
1.7.3.1
