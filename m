From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: driver for PCA954x I2C multiplexer series.
Date: Mon, 19 Apr 2010 11:24:10 +0200
Message-ID: <20100419112410.79557466@hyperion.delvare>
References: <4B5D8AFC.5060209@gmx.de>
	<4B5D95E7.1000804@gmx.de>
	<20100416173807.3d86e0d7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100416173807.3d86e0d7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Fri, 16 Apr 2010 17:38:07 +0200, Jean Delvare wrote:
> As I don't have any hardware to test your code, I will try adding a
> special mode to i2c-stub where it would instantiate a virtual PCA9540
> chip, and present 3 adapters to the user instead of 1. That way I
> should be able to preform some testing on my own.

I've done this, and the tests results so far look good. If you can
submit updated patches addressing my concerns, they should be ready to
go in kernel 2.6.35. Further improvements and fixes can happen later.

Thanks,
-- 
Jean Delvare
