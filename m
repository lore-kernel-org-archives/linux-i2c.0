From: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] I2C: mpc: insert DR read in i2c_fixup()
Date: Tue, 03 Jun 2014 10:45:20 +0200
Message-ID: <538D8B20.3010705@keymile.com>
References: <1400247398-23778-1-git-send-email-valentin.longchamp@keymile.com> <20140602162719.GI2654@katana> <538D7017.40908@keymile.com> <20140603071114.GA2653@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140603071114.GA2653@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Cox <adrian-nKrwMtk+6Wm9FHfhHBbuYA@public.gmane.org>, "Boschung, Rainer" <Rainer.Boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 06/03/2014 09:11 AM, Wolfram Sang wrote:
>>>> --- a/drivers/i2c/busses/i2c-mpc.c
>>>> +++ b/drivers/i2c/busses/i2c-mpc.c
>>>> @@ -107,6 +107,7 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
>>>>  static void mpc_i2c_fixup(struct mpc_i2c *i2c)
>>>>  {
>>>>  	int k;
>>>> +	u8 dr;
>>>
>>> Looks like we can drop this variable since the value read is not used?
>>
>> That's correct it is not used. I have added it to make sure that this is not
>> "optimized" out but I guess the readb call is enough for this purpose ?
> 
> I'd think so, but it needs your test :)
> 

I have just tested it and it's OK without the dr variable as well. Sending V2
right now.

Valentin
