From: arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org (Arnaud Ebalard)
Subject: Re: [BUG] mv64xxx i2c bus lock w/ commit eda6bee6c7
Date: Tue, 25 Jun 2013 23:09:26 +0200
Message-ID: <87mwqdnbi1.fsf@natisbad.org>
References: <87a9mkttxr.fsf@natisbad.org>
	<20130623153931.GD7626@kw.sim.vm.gnt>
	<20130623160659.GB17536@roeck-us.net> <87fvw8ehne.fsf@natisbad.org>
	<20130624183006.GA3129@katana> <87wqpjkxfz.fsf@natisbad.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Simon Guinot <simon.guinot-jKBdWWKqtFpg9hUCZPvPmw@public.gmane.org>, "Mark A. Greer" <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, Mauro Barella <mbarella-RSoB1PSltFvQT0dZR+AlfA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org (Arnaud Ebalard) writes:

> Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> writes:
>
>>> does nothing fancy either. While debugging I ended up on Debian bug
>>> #622325 (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=622325) which
>>> made the driver a little less suspect when a revert of commit eda6bee6c7
>>> fixed the issue for me.
>>
>> Either wait for 3.11 or pick 4243fa0bad551b8c8d4ff7104e8fd557ae848845
>> "(I2C: mv64xxx: fix race between FSM/interrupt and process context")
>> from my for-next branch. (Note the other patches from Russell, probably
>> all worth to pick).
>
> Thanks for the tip. Will try it tomorrow.

Done. It works as expected, i.e. no i2c lock at boot on my ReadynNAS
102 once applied. Note that I had to also apply other patches from
Russel on which this specific commit somewhat depends.

>> Would be nice if you could pass the info to the Debian bug as well.

Done as well. I put you in the Cc: list.

Thanks for your work,

Cheers,

a+
