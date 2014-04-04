From: "Du, Wenkai" <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] i2c-designware: Mask interrupts during i2c controller
 enable
Date: Fri, 4 Apr 2014 21:54:33 +0000
Message-ID: <7286EAF50D3F4E4AADE7FEECEBF8B5A537A71351@ORSMSX109.amr.corp.intel.com>
References: <7286EAF50D3F4E4AADE7FEECEBF8B5A537A70E1F@ORSMSX109.amr.corp.intel.com>
 <20140404181613.GB19349@intel.com>
 <7286EAF50D3F4E4AADE7FEECEBF8B5A537A70F8B@ORSMSX109.amr.corp.intel.com>
 <20140404184232.GC19349@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140404184232.GC19349-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Westerberg, Mika" <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>Interrupt masking is done already after each transaction.

At end of transfer, the code uses __i2c_dw_enable(dev, false) to disable adapter. This function doesn't mask interrupts. There is another function i2c_dw_disable that masks and clears interrupts. This could be used, but that means we need to fix in 2 places: 

1. add interrupt masking to i2c_dw_init();
2. change call __i2c_dw_enable(dev, false) to i2c_dw_disable;

I think simply masking interrupt in i2c_dw_xfer_init is cleaner and safer.

>The problem here is that after reset, the interrupt mask register gets 0x8ff value (HW default), which means that most of the interrupts are left unmasked.
>That is the reason why this only happens right after we resume from system sleep. Masking interrupts on that path fixes the problem.

The time out also happened in case of going into suspend and during normal operations. But at much less occurrence at 1-2 per 1000 cycles. 
