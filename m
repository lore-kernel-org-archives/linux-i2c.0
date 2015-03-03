From: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: Suppress error message if
 platform_get_irq() returns -EPROBE_DEFER
Date: Tue, 3 Mar 2015 16:37:31 +0000
Message-ID: <1425400650.17965.53.camel@synopsys.com>
References: <1425396456-10633-1-git-send-email-abrodkin@synopsys.com>
	 <54F5E120.3090705@alitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54F5E120.3090705-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Content-ID: <D34398AE05722941829A23965FC3863E-z7JfP6tgrtVBCHUSTMH8dZqQE7yCjDx5@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org" <christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>
Cc: "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org" <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Christian,

On Tue, 2015-03-03 at 17:28 +-0100, Christian Ruppert wrote:
+AD4- On 2015-03-03 16:27, Alexey Brodkin wrote:
+AD4- +AD4- There's no point in printing error message if platform+AF8-get+AF8-irq()
+AD4- +AD4- returns -EPROBE+AF8-DEFER because probe deferring subsystem already outputs
+AD4- +AD4- message in bootlog like this:
+AD4- +AD4-  ---+AD4-8---
+AD4- +AD4-  platform e001d000.i2c: Driver i2c+AF8-designware requests probe deferral
+AD4- +AD4-  ---+AD4-8---
+AD4- +AD4- 
+AD4- +AD4- Moreover in case of probe deferral following message may mislead user:
+AD4- +AD4-  ---+AD4-8---
+AD4- +AD4-  i2c+AF8-designware e001d000.i2c: no irq resource?
+AD4- +AD4-  ---+AD4-8---
+AD4- +AD4- even though it's expected that platform+AF8-get+AF8-irq() may return
+AD4- +AD4- -EPROBE+AF8-DEFER.
+AD4- +AD4-  
+AD4- +AD4-  	irq +AD0- platform+AF8-get+AF8-irq(pdev, 0)+ADs-
+AD4- +AD4-  	if (irq +ADw- 0) +AHs-
+AD4- +AD4- -		dev+AF8-err(+ACY-pdev-+AD4-dev, +ACI-no irq resource?+AFw-n+ACI-)+ADs-
+AD4- +AD4- +-		if (irq +ACEAPQ- -EPROBE+AF8-DEFER)
+AD4- +AD4- +-			dev+AF8-err(+ACY-pdev-+AD4-dev, +ACI-no irq resource?+AFw-n+ACI-)+ADs-
+AD4- 
+AD4- Presented like this I wonder if this merits being a dev+AF8-err at all.
+AD4- Wouldn't dev+AF8-dbg be more adequate? This might remove the need for the
+AD4- condition and also avoid bothering everyone if something in the platform
+AD4- device structures or device tree is not right.
+AD4- 
+AD4- +AD4-  		return irq+ADs- /+ACo- -ENXIO +ACo-/
+AD4- +AD4-  	+AH0-

We've just had similar discussion related to DW APB UART with Andy here
https://lkml.org/lkml/2015/3/3/412

So yes probably we may safely remove error message from here completely.

-Alexey
