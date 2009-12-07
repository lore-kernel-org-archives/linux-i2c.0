From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Q: I2C multiplexer support
Date: Mon, 07 Dec 2009 12:37:47 +0100
Message-ID: <4B1CE90B.1010103@gmx.de>
References: <4B1CC5EA.7040902@gmx.de> <20091207105132.6926bf19@hyperion.delvare> <20091207100000.GD3647@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091207100000.GD3647-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Rodolfo Giometti said the following:
> On Mon, Dec 07, 2009 at 10:51:32AM +0100, Jean Delvare wrote:
>> 
>> In all honesty, I did not look at Rodolfo's code at all. When he sent
>> it originally, I didn't have the time, being in the middle of major
>> i2c-core changes and cleanups. After 2.6.31 was released, I finally had
>> the time to look into it. But as I knew the recent i2c-core changes
>> would require Rodolfo's patches to be rebased, I asked him to do that
>> first. But now it's apparently Rodolfo's time to be busy :( If you want
>> to help, you're welcome.
> 
> I should have some spare time during december... however I cannot test
> the code anymore due lack of hardware. :'(
>
I could make my H/W guys to do a little extra job, so I have a mux-tree
board based on PCA9544AD:

 ----mux--mux---------
      |
      +---mux---mux---
      |
      +---mux---------

So if you make a patch, I can give it a try. Until then I will try my
luck for my own.

-- 
Kind Regards,
Michael
