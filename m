From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: mxs: always end a transfer with a proper STOP
Date: Tue, 09 Apr 2013 09:26:02 +0200
Message-ID: <1365492362.4131.9.camel@weser.hi.pengutronix.de>
References: <1363261750-26645-1-git-send-email-l.stach@pengutronix.de>
	 <20130408172147.GB6865@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130408172147.GB6865-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Am Montag, den 08.04.2013, 19:21 +0200 schrieb Wolfram Sang:
> On Thu, Mar 14, 2013 at 12:49:08PM +0100, Lucas Stach wrote:
> > Our transfers always start with the device address, so there is never a
> > situation where we just do a restart transfer. Full blown transfers should
> > always end with a STOP as per i2c spec.
> 
> ? I don't get the description. Does "restart transfer" mean repeated
> start? What has the device address to do with it?
> 

A restart transfer is when you just repeat the START condition, without
putting the device address on the bus again.

In the MXS driver we put the device address on the bus for every
transaction we get handed in from the i2c core, so there is never a
situation where we just repeat the start condition without sending out
the device address. Before this patch we would not match every
transaction, but only the last in the list of pending ones, with a STOP
condition, which is a violation of the spec.

If there are no other comments, I'll send out a V2 today, to take in
Marek's remarks.
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
