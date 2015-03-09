From: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: Suppress error message if
 platform_get_irq() returns -EPROBE_DEFER
Date: Mon, 9 Mar 2015 08:29:24 +0000
Message-ID: <1425889764.5234.13.camel@synopsys.com>
References: <1425396456-10633-1-git-send-email-abrodkin@synopsys.com>
	 <54F5E120.3090705@alitech.com> <1425400650.17965.53.camel@synopsys.com>
	 <20150307002447.GE993@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150307002447.GE993@katana>
Content-Language: en-US
Content-ID: <447ECB29E691F14498D8DEDD7439B3BF-z7JfP6tgrtVBCHUSTMH8dZqQE7yCjDx5@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org" <christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org" <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Sat, 2015-03-07 at 01:24 +-0100, Wolfram Sang wrote:
+AD4- +AD4- +AD4- Presented like this I wonder if this merits being a dev+AF8-err at all.
+AD4- +AD4- +AD4- Wouldn't dev+AF8-dbg be more adequate? This might remove the need for the
+AD4- +AD4- +AD4- condition and also avoid bothering everyone if something in the platform
+AD4- +AD4- +AD4- device structures or device tree is not right.
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4-  		return irq+ADs- /+ACo- -ENXIO +ACo-/
+AD4- +AD4- +AD4- +AD4-  	+AH0-
+AD4- +AD4- 
+AD4- +AD4- We've just had similar discussion related to DW APB UART with Andy here
+AD4- +AD4- https://lkml.org/lkml/2015/3/3/412
+AD4- +AD4- 
+AD4- +AD4- So yes probably we may safely remove error message from here completely.
+AD4- 
+AD4- So, do you want to send a V2?

Sorry for this delay - I was away for last few days.
I'm about to send v2 with removal of error message completely.

-Alexey
