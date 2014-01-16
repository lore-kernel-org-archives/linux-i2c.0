From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] i2c: Re-instate body of i2c_parent_is_i2c_adapter()
Date: Thu, 16 Jan 2014 10:25:31 -0700
Message-ID: <52D8160B.7090205@wwwdotorg.org>
References: <1389648544-4201-1-git-send-email-swarren@wwwdotorg.org> <20140114161254.GA6442@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140114161254.GA6442@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Phil Carmody <phil.carmody-GrGkmOP51GdLN7c7dRTbYkEOCMrvLtNR@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 01/14/2014 09:12 AM, Wolfram Sang wrote:
> On Mon, Jan 13, 2014 at 02:29:04PM -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> The body of i2c_parent_is_i2c_adapter() is currently guarded by
>> CONFIG_I2C_MUX instead.
> 
> This paragraph sounds strange to me. I'll update it a little. After that
> I'll go looking for a brown paper bag...
> 
>> Among potentially other problems, this resulted in i2c_lock_adapter()
>> only locking I2C mux child adapters, and not the parent adapter. In
>> turn, this could allow inter-mingling of mux child selection and I2C
>> transactions, which could result in I2C transactions being directed to
>> the wrong I2C bus, and possibly even switching between busses in the
>> middle of a transaction.
>>
>> One concrete issue caused by this bug was corrupted HDMI EDID reads
>> during boot on the NVIDIA Tegra Seaboard system, although this only
>> became apparent in recent linux-next, when the boot timing was changed
>> just enough to trigger the race condition.
>>
>> Fixes: 3923172b3d70 ("i2c: reduce parent checking to a NOOP in non-I2C_MUX case")
>> Cc: Phil Carmody <phil.carmody-GrGkmOP51GdLN7c7dRTbYkEOCMrvLtNR@public.gmane.org>
>> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Applied to for-current, thanks for catching this one!

I do see this in for-current, but it looks like that branch isn't part
of linux-next. Should it be, or perhaps for-current should be merged
into for-next?
