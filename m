From: Matt Fleming <matt-mF/unelCI9GS6iBeEJttW/XRex20P6io@public.gmane.org>
Subject: Regression in v4.2-rc1 caused by hierarchical irqdomain changes
Date: Mon, 27 Jul 2015 16:21:07 +0100
Message-ID: <20150727152107.GA3571@codeblueprint.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

A git bisect just pointed me at commit d32932d02e18 ("x86/irq: Convert
IOAPIC to use hierarchical irqdomain interfaces") as the reason for why
the trackpad on my Dell XPS13 is no longer working with v4.2-rc1.

I'm now seeing the following errors when booting,

[    1.615017] i2c_designware INT3433:00: controller timed out
[    1.642496] i2c_designware INT3433:00: timeout in disabling adapter        
[    1.642500] i2c_hid i2c-DLL0665:01: hid_descr_cmd failed

I tried commit d32932d02e18~1, which works, and things definitely break
starting with commit d32932d02e18.

Any suggestions or requests to try and diagnose why the irqdomain
changes broke this i2c controller driver?

-- 
Matt Fleming, Intel Open Source Technology Center
