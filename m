From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Multiplexed I2C bus core support.
Date: Tue, 2 Mar 2010 16:05:27 +0100
Message-ID: <20100302160527.7f48f49c@hyperion.delvare>
References: <4B5D8AFC.5060209@gmx.de>
	<4B8D2285.6020203@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B8D2285.6020203-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

On Tue, 02 Mar 2010 15:36:53 +0100, Michael Lawnick wrote:
> Michael Lawnick said the following:
> > Subject: [PATCH 1/2] i2c: Multiplexed I2C bus core support.
>
> Ping.
> 
> (I dream to see it in .34)

This isn't going to happen, sorry. The new i2c feature in 2.6.34 will
be SMBus alert support, which had been waiting for about 2 years.
Multiplexing support will have to wait for the next merge window. Right
now I am working on flushing my patch queues as much as I can. Even if
I had the time to look into your patches this week (and honestly it
doesn't seem realistic) it would be too late to make it into this merge
window. Your patches will need some testing which can't realistically
be achieved in a couple days.

I understand that you are getting impatient and I would be as well if I
were you, but I'm doing the best I can with the limited time I have.

-- 
Jean Delvare
