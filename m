From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] assign a default class to MPC adapter
Date: Thu, 16 Apr 2009 12:55:46 +0200
Message-ID: <49E70EB2.60106@gmx.de>
References: <49E6F4F9.3060705@gmx.de> <20090416092012.GB3052@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090416092012.GB3052-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang said the following:
> On Thu, Apr 16, 2009 at 11:06:01AM +0200, Michael Lawnick wrote:
>> For MPC adapter there is no class assigned as it is done in other
>> adapters. This way no new-style client will ever be instantiated. There
>> should be at least a default class assignment.
> 
> Please have a loot at 618b26d52843c0f85b8eb143cf2695d7f6fd072d
> Therefore, NACK.

AFAICS, this patch related to 2.6.26 and i2c code has changed since.
In i2c-core.c@i2c_detect there is now a check whether the driver is
legacy, if it is the function is left and driver initialization handled
in another way. This was not the case when the patch of Wolfgang
Grandegger was applied.

I still don't think it makes much sense to include code (i2c-mpc.c) that
has no function by default - what in fact is the case since last change
of i2c-core.c

-- 
Kind Regards,
Michael
