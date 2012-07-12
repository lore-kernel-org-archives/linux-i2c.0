From: Emmanuel Deloget <emmanuel.deloget-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-tiny-usb: Adds supports for the Robofuzz OSIF USB/i2c,
 converter
Date: Thu, 12 Jul 2012 10:16:27 +0200
Message-ID: <4FFE87DB.3030204@efixo.com>
Reply-To: emmanuel.deloget-HH44TBFINEIAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Robofuzz OSIF is a generic USB/i2c interface that embeds an ATMega8A
AVR-RISC microcontroler.

The device is based upon Till Harbaum's i2c-tiny-usb and although it
enhances the original design with further functionnalities it still
maintain compatibility with it with respect to the USB/i2c interface.

Signed-off-by: Emmanuel Deloget <logout-GANU6spQydw@public.gmane.org>
---
  drivers/i2c/busses/i2c-tiny-usb.c |    1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index f07307f..0510636 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -143,6 +143,7 @@ static const struct i2c_algorithm usb_algorithm = {
  static const struct usb_device_id i2c_tiny_usb_table[] = {
  	{ USB_DEVICE(0x0403, 0xc631) },   /* FTDI */
  	{ USB_DEVICE(0x1c40, 0x0534) },   /* EZPrototypes */
+	{ USB_DEVICE(0x1964, 0x0001) },   /* Robofuzz OSIF */
  	{ }                               /* Terminating entry */
  };

-- 
1.7.10
