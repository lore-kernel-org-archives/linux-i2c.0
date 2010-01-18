From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] Allow mixed endianness accesses
Date: Mon, 18 Jan 2010 19:00:14 +0900
Message-ID: <4B54312E.9030106@necel.com>
References: <20100113193224.753273000@octasic.com> <20100113193421.212989000@octasic.com> <4B4FB03E.1070708@necel.com> <4B5075ED.8020307@octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B5075ED.8020307-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean-Hugues Deschenes wrote:
>> so I'm not sure it works or not there.
>> I hope this works with the latest LMO tree.
> I'll download a MIPS toolchain and give it a try.

Thanks.  I've also checked it builds with the latest LMO tree.

>> Then I wonder is there any way to statically optimize them?
> Humm... Configuration options (controlling #ifdefs) are a possibility, 
> although I must admit I'm not so fond of this option, because it's error 
> prone.

Ok, fine with me.

> I believe the problem is not with the automatic detection per se (which 
> is done at init, where performance is not so much an issue), but with 
> the extra IFs at each memory access...

Exactly, that's what I'm concerned about!

> There, the other option I can 
> think of is having 2 sets of accessors, 
> dw_readl_[bl]e()/dw_writel_[bl]e() and have them accessed via function 
> pointers (set at init, following the auto-detection). But I'm not sure 
> that loosing the option of inlining the accessor funtion (since they 
> would now have to be accessed via function pointers) would really result 
> in a performance gain...

Looking around more, and now I'm not going to be nervous about
I/O cost, as I2C is enough slow.  It would be nice we could have
statically optimized one of course, but is not indispensable.

-- 
Shinya Kuribayashi
NEC Electronics
