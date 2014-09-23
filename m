From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe-Mmb7MZpHnFY@public.gmane.org>
Subject: i2c_transfer & dma
Date: Tue, 23 Sep 2014 21:38:32 +0200
Message-ID: <201409232138.33067.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I was wondering if the buffer in an i2c_msg, passed to i2c_transfer must be 
dma-able i.e. dynamically allocated, like for USB?

The reason why I'm asking is because the e.g. the i2c_robotfuzz_osif usb-to-
i2c adapter passes the incoming data directly to a usb_control_msg which of 
course expects the buffer to be dma-able.

So the question is - does the user of i2c_transfer have to provide a dma-able 
buffer, or is the bus driver (like the robotfuzz one) expected to convert 
incoming buffer into a dma-able buffer?


Thanks,
Peter
