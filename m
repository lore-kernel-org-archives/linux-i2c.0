From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] powerpc/83xx: Move mcu_mpc8349emitx driver out of  drivers/i2c/chips/
Date: Mon, 12 Jan 2009 09:10:02 -0600
Message-ID: <27159C32-9F05-4E21-98CE-0F157934D14B__28020.6373580315$1231773427$gmane$org@kernel.crashing.org>
References: <20090111165136.GA26096@oksana.dev.rtsoft.ru> <20090111181055.31611474@hyperion.delvare>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090111181055.31611474-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Jan 11, 2009, at 11:10 AM, Jean Delvare wrote:

> Hi Anton,
>
> On Sun, 11 Jan 2009 19:51:36 +0300, Anton Vorontsov wrote:
>> This patch is used to help Jean Delvare to get rid of drivers/i2c/ 
>> chips/
>> directory. The new location suggested by Kumar Gala: as the driver is
>> 83xx specific it's placed into arch/powerpc/platforms/83xx/.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
>
> Thanks for doing this. Do you expect me to take this patch in my i2c
> tree, or will it go in some powerpc tree?

I'll pick this up.

- k
