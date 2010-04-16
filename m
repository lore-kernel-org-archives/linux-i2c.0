From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Multiplexed I2C bus core support.
Date: Fri, 16 Apr 2010 15:10:11 +0200
Message-ID: <4BC861B3.3090806@gmx.de>
References: <4B5D8AFC.5060209@gmx.de>	<20100415144906.2a20588d@hyperion.delvare> <20100416132144.5ea8b0b1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100416132144.5ea8b0b1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> One thing I forgot:
> 
>> > +		result = i2c_check_clients(to_i2c_adapter(adapter->dev.parent), addr);
>> > +	
>> > +	return result;
>> > +}
> 
> As discussed some weeks ago, this isn't actually sufficient. You don't
> only need to check the parent segments for address business, you also
> need to check all child segments, recursively. If any child segment has
> a device using the address in question, then you can't use it.
> 
> This may be more difficult to implement. In particular, you'll have to
> pay attention to locking.
> 
:-) This can't happen if we keep the part you commented on in the other
mail about probing for client one level above. Then this situation can't
arise.

-- 
KR
Michael
