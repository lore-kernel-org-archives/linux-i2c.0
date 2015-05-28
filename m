From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Common clock framework examples
Date: Thu, 28 May 2015 15:52:28 -0700
Message-ID: <55679C2C.2080100@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Michael,

Let me start a new thread for more questions regarding common clock framework.

Following yours and other experts' suggestion, I start to write a new driver for
SI5338. As I explained earlier, I have multiple clock chips. They may have
different clock sources. I haven't figured out how to put them into device tree
because the clocks chips are on PCIe cards.

Let's say I want to initialize without device tree. Is there an example to setup
platform data structure so I can put in the clock rate of xtal or clk_in?

York
