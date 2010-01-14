From: Ben Dooks <ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH 0/3] i2c-designware: Allow mixed endianness
Date: Thu, 14 Jan 2010 01:09:05 +0000
Message-ID: <20100114010905.GJ3738@trinity.fluff.org>
References: <20100113193224.753273000@octasic.com> <4B4E6815.9050908@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B4E6815.9050908-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Cc: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 14, 2010 at 09:40:53AM +0900, Shinya Kuribayashi wrote:
> Jean-Hugues Deschenes wrote:
>> Here is patchset for the i2c-designware driver, allowing little
>> endian  machines to use the DW IP instantiated in big endian
>> and vice versa.
>
> In the commit ed5e1dd5 (i2c-designware: Consolidate to use 32-bit
> word accesses), I tried to sort out the I/O endian issue, but it
> seems doesn't work for your environment, R/W data is swapped :-(

I think this one of those weird cases where you have _both_ types of
endianess of peripherals where anything in readl/writel isn't going
to help you out.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
