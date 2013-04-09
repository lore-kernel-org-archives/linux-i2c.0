From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: mxs: always end a transfer with a proper STOP
Date: Tue, 9 Apr 2013 10:32:52 +0200
Message-ID: <20130409083252.GA3624@the-dreams.de>
References: <1363261750-26645-1-git-send-email-l.stach@pengutronix.de>
 <20130408172147.GB6865@the-dreams.de>
 <1365492362.4131.9.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1365492362.4131.9.camel-WzVe3FnzCwFR6QfukMTsflXZhhPuCNm+@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

> A restart transfer is when you just repeat the START condition, without
> putting the device address on the bus again.

Well, never heard this term before. Where did you get it from?

> In the MXS driver we put the device address on the bus for every
> transaction we get handed in from the i2c core, so there is never a
> situation where we just repeat the start condition without sending out
> the device address. Before this patch we would not match every
> transaction, but only the last in the list of pending ones, with a STOP
> condition, which is a violation of the spec.

I still don't get it. You can drop a STOP if you replace it with
a repeated start. In fact, this is crucial in multi-master setups,
otherwise another master could break into your transfer containing
multilple messages. So, if MXS does the right thing on sending START
(doing a correct start sequence), we should not send STOP. If it needs
the STOP to create a correct START, then be it. But then, I'd wonder why
it worked so far...

Regards,

   Wolfram
