From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] assign a default class to MPC adapter
Date: Thu, 16 Apr 2009 13:01:50 +0200
Message-ID: <49E7101E.6070806@gmx.de>
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

Beside my first answer, in your commit
0a346dacee18ff69f6162d9860d723a058f47321 you say:
> Might need updates to dts files using it.

Could you please elaborate?

-- 
Kind Regards,
Michael
