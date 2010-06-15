From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: Multiplexed I2C bus core support
Date: Tue, 15 Jun 2010 10:53:37 +0200
Message-ID: <4C173F91.60307@gmx.de>
References: <4BE01741.1010909@gmx.de>	<20100610152411.5497461c@hyperion.delvare>	<4C11D85F.7010604@gmx.de> <20100611114003.01c15f62@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100611114003.01c15f62-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

Jean Delvare said the following:
> > Hi Michael,
...
> > I would walk the device tree maintained by the driver core (using
> > device_for_each_child) and filtering out irrelevant devices. Basically
> > filtering on dev->type == &i2c_adapter_type should do the trick,
> > methinks.
> >
You are right, I missed that somehow when investigating for a solution.
Until your post I was convinced that the adapters are all registered to
bus only. I now rechecked by some small code and found that I can throw
away these awefull lists.

Iteration will follow.

-- KR Michael
