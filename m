From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe-Mmb7MZpHnFY@public.gmane.org>
Subject: I2C Master with limited transmission sizes
Date: Sat, 16 Nov 2013 04:38:36 +0100
Message-ID: <201311160438.36636.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I'm currently writing a driver for a cheap usb-to-i2c master device, which 
unfortunately can only write 31 bytes (+slave addr) and read 32 bytes.

What is the correct behavior if a user requests larger read/writes?
Simply set i2c_msg.len to the bytes transmitted?
(in this case i2cdump -i doesn't honor this length ?)

Or should the master try to split up the requests?
but if so how, as some devices don't support continuous reads.

Thanks,
Peter
