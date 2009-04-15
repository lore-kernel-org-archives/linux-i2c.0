From: "Wang, Wen W" <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Questions for submitting driver to I2C subsystem
Date: Wed, 15 Apr 2009 22:23:39 +0800
Message-ID: <0A882F4D99BBF6449D58E61AAFD7EDD610424EB0@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

I'm Wen working on Linux driver for Intel MID platform. I have a couple of questions on submitting drivers into I2C tree. Can you please help on that?

I'm writing Linux I2C controller driver for Intel low power platform of MID. It has been accepted by Moblin and I'm planning to submit this driver to upstream.

1. Is it ok if I submit this I2C driver with specific platform codes in driver?
2. How should I submit this I2C driver if it is dependent on another device driver which is also out of kernel tree?

I can send the driver patch for your preview if it is ok.

Thanks
Wen
