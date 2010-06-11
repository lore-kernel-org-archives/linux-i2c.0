From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: Multiplexed I2C bus core support
Date: Fri, 11 Jun 2010 08:31:59 +0200
Message-ID: <4C11D85F.7010604@gmx.de>
References: <4BE01741.1010909@gmx.de> <20100610152411.5497461c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100610152411.5497461c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

beside all the other issues,

Jean Delvare said the following:
> Hi Michael,
> 
>> +	list_add_tail(&priv->adap.mux_list, &parent->mux_list_head);
> 
> The driver core maintains a device tree already, do you really need to
> keep your own? We've tried hard to remove all redundancy between
> i2c-core and the driver core in the last couple years, so I really would
> like us to not add such redundancy back now.
> 
> If you have a good reason to have your own list, please explain. If
> not, please get rid of it.
> 
this is a core part of mux management. You need it for checking whether
the current client that is to be added is already present.
The problem is to efficiently parse down a mux tree towards the leaves.
Sub-muxes are registered as i2c clients to their upper bus. I found no way
to separate muxes from normal clients. So there were two ideas:
invent a client-type field in i2c-client or to hold a separate list.
The first one e.g. would have the possibility to provide basic info in sysFs
but I feared a general debate. So I decided to go the other way which is
hidden to the outer world.

If you don't like this way, I'd need some ideas how to do it.

-- 
KR
Michael
