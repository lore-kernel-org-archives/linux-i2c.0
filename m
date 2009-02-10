From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: do not allow interruptions when waiting for
 I2C   to complete
Date: Tue, 10 Feb 2009 17:10:00 +0100
Message-ID: <20090210171000.1f45cc2d@hyperion.delvare>
References: <1233928837-3401-1-git-send-email-timur@freescale.com>
	<ed82fe3e0902100659p2eec9de6j61f9ffb504d60a89@mail.gmail.com>
	<20090210165554.0da8bf7c@hyperion.delvare>
	<4991A4F2.8030506@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4991A4F2.8030506-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kumar Gala <kumar.gala-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 10 Feb 2009 10:01:54 -0600, Timur Tabi wrote:
> Jean Delvare wrote:
> 
> > No, that's something for either Ben Dooks (Cc'd) or the powerpc tree.
> 
> This patch has nothing to do with ARM, so Kumar will pick it up, if you
> ACK it.

Why are you mentioning ARM?

>From MAINTAINERS:

I2C SUBSYSTEM
P:      Jean Delvare (PC drivers, core)
M:      khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
P:      Ben Dooks (embedded platforms)
M:      ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org

To the best of my knowledge i2c-mpc falls into the "embedded platforms"
category and is thus under Ben's responsibility.

Thanks,
-- 
Jean Delvare
