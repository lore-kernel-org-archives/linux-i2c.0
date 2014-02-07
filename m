From: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: Fix locked bus when offload is selected but not used on a message
Date: Fri, 07 Feb 2014 10:09:53 -0800
Message-ID: <7h7g96bxqm.fsf@paris.lan>
References: <1391770588-1344-1-git-send-email-gregory.clement@free-electrons.com>
	<20140207150958.GY8533@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140207150958.GY8533-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org> (Jason Cooper's
	message of "Fri, 7 Feb 2014 10:09:58 -0500")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org> writes:

> On Fri, Feb 07, 2014 at 11:55:54AM +0100, Gregory CLEMENT wrote:
>> Offload can be used only on regular transactions and for 1 to byte
>> transfers. In the other cases we switch back to usual work flow.
>> 
>> In this case we need to call mv64xxx_i2c_prepare_for_io() as this
>> function is not used when we try to use offloading.
>> 
>> This commit adds this missing call when offloading have failed in the
>> MV64XXX_I2C_ACTION_OFFLOAD_SEND_START case.
>> 
>> This fix the timeout seen when the the i2c driver try to access an
>> address where the device is absent on the Armada XP bases board.
>> 
>> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v3.12+
>> Fixes: 930ab3d403ae (i2c: mv64xxx: Add I2C Transaction Generator support)
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> ---
>>  drivers/i2c/busses/i2c-mv64xxx.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> I'd like to get a few tested-by's on this before this is pushed.  We've
> had quite a bit of fixes this round :(  Please test both multi_v7 and
> mvebu defconfigs.
>
> Kevin, I know you're busy with a lot more than us, but if you could
> confirm that this fixes the bus hangs you reported, that would be great.

I applied this patch on top of next-20140207 and tested this on the
armada-xp openblocks ax3, which is where I was seeing the I2C timeouts.

I confirm it fixes the timeouts I was seeing.

Tested-by: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Kevin
