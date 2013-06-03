From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: drivers/i2c/busses/i2c-intel-mid.c
Date: Mon, 03 Jun 2013 12:01:27 +0300
Message-ID: <1370250087.29283.249.camel@smile>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi, Wolfram.

I remember I send once patch to remove obsolete driver i2c-intel-mid,
but it's still in upstream and community resources are spent to maintain
it. Moorestown support is removed from kernel year ago (?), and Medfield
is supported by i2c-designware-pci.

I'm just wondering what's the plan to i2c-intel-mid driver?
Nevertheless, I'll resend removal patch after this message.


-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
