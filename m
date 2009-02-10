From: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: do not allow interruptions when waiting for
  I2C   to complete
Date: Tue, 10 Feb 2009 10:21:04 -0600
Message-ID: <4991A970.70508@freescale.com>
References: <1233928837-3401-1-git-send-email-timur@freescale.com>	<ed82fe3e0902100659p2eec9de6j61f9ffb504d60a89@mail.gmail.com>	<20090210165554.0da8bf7c@hyperion.delvare>	<4991A4F2.8030506@freescale.com> <20090210171000.1f45cc2d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090210171000.1f45cc2d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kumar Gala <kumar.gala-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:

> To the best of my knowledge i2c-mpc falls into the "embedded platforms"
> category and is thus under Ben's responsibility.

I don't see his Signed-off-by on any patch to i2c-mpc.c for the past
three years (at least).  I do see yours, however.  You have directly
applied similar patches in the recent past, so of course I will assume
that you would apply this one.

-- 
Timur Tabi
Linux kernel developer at Freescale
