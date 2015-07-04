From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: i2c: i2c-mv64xxx: rework offload support to fix several
 problems
Date: Sat, 4 Jul 2015 10:15:25 +0200
Message-ID: <20150704101525.77bf8d32@free-electrons.com>
References: <20150704095908.18a15912ceff03764ed15ff1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150704095908.18a15912ceff03764ed15ff1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antony Pavlov <antonynpavlov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gregory =?UTF-8?B?Q2zDqW1lbnQ=?= <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Antony Pavlov,

On Sat, 4 Jul 2015 09:59:08 +0300, Antony Pavlov wrote:

> I have found your commit in the linux kernel mainline
> 
>   commit 00d8689b85a7bb37cc57ba4c40bd46325f51ced4
>   Author: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>   Date:   Thu Dec 11 17:33:46 2014 +0100
> 
>       i2c: mv64xxx: rework offload support to fix several problems
> 
> see also https://patchwork.ozlabs.org/patch/420180/
> 
> Here is a fragment:
> 
> +static bool
> +mv64xxx_i2c_can_offload(struct mv64xxx_i2c_data *drv_data)
> +{
> +	struct i2c_msg *msgs = drv_data->msgs;
> +	int num = drv_data->num_msgs;
> +
> +	return false;
> ^^^^^^^^^^^^^^^^^^^^^

Wow, thanks for spotting. This is indeed a big mistake that has
apparently do been caught at review time. This means I'll have to re-do
some testing to validate that the offload is actually working. We had a
specific device that is making some specific I2C accesses that
triggered the need to rework the offload handling, so I'll have to test
on this platform.

In order to not forget about it, I've added an entry in our Marvell
related bug tracker:
https://github.com/MISL-EBU-System-SW/mainline-public/issues/75.

Thanks for reporting!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
