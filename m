From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: Driver for pca9541 bus master selector
Date: Thu, 30 Sep 2010 00:48:47 -0700
Message-ID: <20100930074847.GA17693@ericsson.com>
References: <20100928143302.GA7593@ericsson.com>
 <20100928171607.395f7736@endymion.delvare>
 <20100928160746.GB7976@ericsson.com>
 <20100928184215.00f82717@endymion.delvare>
 <20100928171627.GA8415@ericsson.com>
 <20100929091928.16256bb7@endymion.delvare>
 <20100929135401.GA11771@ericsson.com>
 <4CA42750.5020500@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4CA42750.5020500-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 30, 2010 at 01:59:44AM -0400, Michael Lawnick wrote:
[ ... ]

> I only took a rough look, but it seemed to me that the pca is part of
> the main device.

Yes

> From abstraction side of view your problem seems a matter of
> synchronization of two independent computer systems. You will need a
> shared resource. The access to it could either be part of driver code or
> by introducing a 'one-channel multiplexer' as you did. But the sync
> needs to be done by your code via a shared data object.
> 
Actually, the pca9541 has a bit in its register set which I can use.
See NTESTON in its control register. That is visible as interrupt status
at the other master. That is all I need, and reduces complexity significantly.

Thanks,
Guenter
