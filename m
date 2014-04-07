From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: Mask interrupts during i2c controller
 enable
Date: Mon, 7 Apr 2014 15:42:52 +0100
Message-ID: <20140407154252.6b8f0f7e@alan.etchedpixels.co.uk>
References: <7286EAF50D3F4E4AADE7FEECEBF8B5A537A70E1F@ORSMSX109.amr.corp.intel.com>
	<20140404181613.GB19349@intel.com>
	<7286EAF50D3F4E4AADE7FEECEBF8B5A537A70F8B@ORSMSX109.amr.corp.intel.com>
	<20140404184232.GC19349@intel.com>
	<7286EAF50D3F4E4AADE7FEECEBF8B5A537A71351@ORSMSX109.amr.corp.intel.com>
	<20140405061316.GF19349@intel.com>
	<20140406185818.3aaca03d@alan.etchedpixels.co.uk>
	<20140407090403.GG19349@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140407090403.GG19349-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Westerberg, Mika" <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Du, Wenkai" <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> I had to check BYT specs about that and I couldn't find if it does
> posted-writes. 

Then I would assume it does unless you can find a hardware engineer to
sign a statement in blood to that effect 8)

> Actually the following patch should fix the problem as well. Just move the
> HW enable to happen last. That way we can make sure that there is a valid
> interrupt mask programmed before the controller is enabled.

This fixes the init case, it doesn't fix the question about returning
from the IRQ before the mask write takes effect and thus taking another
interrupt.

Alan
