From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/3] Allow mixed endianness accesses
Date: Fri, 15 Jan 2010 10:16:56 -0500
Message-ID: <4B5086E8.9090409@octasic.com>
References: <20100113193224.753273000@octasic.com> <20100113193421.212989000@octasic.com> <4B4FB03E.1070708@necel.com> <4B5075ED.8020307@octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B5075ED.8020307-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Jean-Hugues Deschenes wrote:
>
> I'll download a MIPS toolchain and give it a try.
>
I've built this driver with the patch as it has been submitted, for 
MIPS, on both the vanilla and LMO trees and there are no errors nor 
warnings. I noticed in your build output that the include files are 
taken fom an "include2" directory, rather than an "include" directory. 
Could that have something to do with it?

jh
