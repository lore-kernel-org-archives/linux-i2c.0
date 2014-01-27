From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: rename Blackfin TWI I2C driver to i2c-adi-twi.c
Date: Mon, 27 Jan 2014 18:15:37 +0800
Message-ID: <CAJxxZ0PjCYMgsyJ5qPu077EBoEBs_BUqbg0vQ4k0ST_KDfynnA@mail.gmail.com>
References: <1390720607-447-1-git-send-email-sonic.adi@gmail.com>
	<20140126102859.GA2579@katana>
	<CAJxxZ0PW+QHZqgo+7HCTt_s-Vbp=R4xX8a967qT84VnfZt3MAg@mail.gmail.com>
	<20140127092838.GA2633@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140127092838.GA2633@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, Jan 27, 2014 at 5:28 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>
>> > You describe what you do, yet the commit message should describe WHY the
>> > change is needed. This applies for the other patches as well.
>>
>> OK, I will add WHY in 2nd version. The ADI TWI peripheral is not
>> binding to the Blackfin processor only. It is better to use a more
>> generic name for this driver.
>
> Oh, this is the only reason? Then NACK. Names always change, even
> company names. Trying to keep that up-to-date only creates lots of
> changes for no technical gain. It is quite common that drivers keep the
> name of their first incarnation.

This is part of the reason. The other reason is some macro such as
SSYNC is blackfin specific. So, all must have SSYNC should be moved
into the architecture code.

Regards,

Sonic
