From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: clock driver
Date: Tue, 26 May 2015 12:12:11 -0700
Message-ID: <5564C58B.9050400@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, andrey-MoRZu3FOBbXQT0dZR+AlfA@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rabeeh-UBr1pzP51AyaMJb+Lgu22Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Linux experts,

I have rewritten a driver for Silicon Labs SI5338 programmable clock chip. The
original driver was written by Andrey (CC'ed), but was floatingn outside of the
kernel. The driver was written to use sysfs as the interface, not the common
clock framework. I wonder if I have to rewrite the driver following common clock
framework. One concern is to support a feature to accept ClockBuilder (TM)
output on sysfs. I don't see sysfs support on common clock framework. Please
correct me if I am wrong.

If not using common clock framework is acceptable, I would like to send a RFC
patch for review.

Regards,

York
