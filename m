From: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Request for Clarification: old - legacy - new driver model
Date: Tue, 10 Mar 2009 07:45:22 +0100
Message-ID: <gp52a3$l6u$1@ger.gmane.org>
References: <gngvea$eqj$1@ger.gmane.org>	<20090218173645.GD3049@pengutronix.de>	<gnjplc$hqd$1@ger.gmane.org>	<20090220135300.353cd53a@hyperion.delvare>	<go12jd$ec4$1@ger.gmane.org>	<20090225090002.2c31dbf1@hyperion.delvare>	<go5ta2$rtu$1@ger.gmane.org>	<20090226142854.2b6f72e4@hyperion.delvare>	<go8c65$o7g$1@ger.gmane.org>	<20090305155713.46ac1968@hyperion.delvare>	<gp385s$a2i$1@ger.gmane.org> <20090309153851.6d92729e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090309153851.6d92729e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
> On Mon, 09 Mar 2009 15:13:16 +0100, Michael Lawnick wrote:
>> Hi Jean,
>> 
>> I have now got a 2.6.28.7 Kernel to play with on my board. I assume
>> I have to patch some files to get the same play ground as you, 
>> right? Could you give me the msgIds/links?
> 
> Sorry but I don't quire follow you here. What play ground are you 
> talking about?
>
I was talking about the version of I2C sub system you are currently
working on ...
Oh, I see, the patches of July are already in Kernel 2.6.28.7.

>> I'm currently thinking about making a module that allows to trigger
>>  probing of buses, something like insmod i2cDevProbe.ko
>> "modname",busNo,devNo Could finally be integrated into subsystem if
>> there are more folks that like it.
> 
> I don't like the idea at all.

I know :-D

> Module parameters are not exactly a convenient interface. As a matter
> of fact this is what we have today, with the difference that the
> parameters are passed to relevant driver directly rather than to a
> dedicated module (see the I2C_CLIENT_INSMOD* macros in
> include/linux/i2c.h), and we are trying to move away from it because
> they are highly user-unfriendly. What you propose is slightly better
> than what we have in some respects, but that's not a significant 
> enough improvement to justify the move.
> 
> And your proposal has many drawbacks/lacks, too. For example, how do 
> you remove a device instance which you have created by mistake? How
> do you create a new device instance when the i2cDevProbe.ko module is
>  already loaded? Just two problems off the top of my head, but there
> are probably more.
> 
Well, I currently don't see user space support in the way I need.
My module i2cDevProbe will do the probe/attach, a i2cDevDetach will do a
remove. Just as a first test version. The idea of module parameters was
not meant as the final solution.

> I definitely prefer a sysfs-based approach as I initially mentioned, 
> this is much more flexible. If you have an urgent need for this 
> feature, we can add an action point to the wiki and start working on
> an implementation. I suggest you start with creating your wiki
> account then.
> 
Incorporating such methods into subsystem would be much better of
course. Probably as a sysFs entry automatically added to every adapter
in /sys/class/i2c-adapter/i2c-x
AFAICS I will do this in the next weeks. Regarding wiki the other
question is whether I can take some official responsibility for such a
patch. I'm doing it as a professional, bound to a project. Further
development because of kernel changes in future wouldn't be supported in
sufficient way :-(

-- 
Regards,
Michael
