From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Multiplexed I2C bus core support.
Date: Tue, 20 Apr 2010 09:05:30 +0200
Message-ID: <4BCD523A.5030408@gmx.de>
References: <4B5D8AFC.5060209@gmx.de>	<20100415144906.2a20588d@hyperion.delvare>	<20100416132144.5ea8b0b1@hyperion.delvare>	<4BC861B3.3090806@gmx.de>	<20100416152329.29f3f90d@hyperion.delvare>	<4BCC2277.3090406@gmx.de> <20100419144014.5123b1b4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100419144014.5123b1b4-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> We don't want to do hardware probing at all to determine address
> business. Look at the i2c-core code as it exists today: address
> business is a solely software issue as far as i2c-core is concerned;
> I see no good reason to change that just because we add support for
> multiplexing.
> 
> I hope this clarified my point.
> 
I think you were clear, given the unhappiness I feel :-(

I'll be back...

-- 
Kind Regards,
Michael
