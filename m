From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: i2c-i801 driver quit working in 3.8.11
Date: Wed, 5 Nov 2014 11:22:17 +0100
Message-ID: <20141105112217.0e1925f3@endymion.delvare>
References: <CANQojO4jbSM=03WfJtw-iSNfexBNSt6GwRLpVSmBx_KrAa0bWQ@mail.gmail.com>
	<20130806192228.GB8246@roeck-us.net>
	<CANQojO74882h+oFJDrq2dsSC71NZHuyf2sjTzCr4a+VmPMLyVA@mail.gmail.com>
	<52026530.2080301@roeck-us.net>
	<CANQojO5B+7c+J=fxV-_mT=Y19Uy=4cW-83vnrphPkN5pmgc2YQ@mail.gmail.com>
	<20130807174801.GB1862@roeck-us.net>
	<CANQojO5QuoGSmmNYxxZ=0MhbZt0mEW-8n6kTxVSWuZ4p6NFw5Q@mail.gmail.com>
	<20130807192556.GA31395@roeck-us.net>
	<20140807101147.34087264@endymion.delvare>
	<CANQojO4sCTmPaV7joQS4=XdifRx61q1Ac0xcdgJ-MW_URN1A=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANQojO4sCTmPaV7joQS4=XdifRx61q1Ac0xcdgJ-MW_URN1A=A@mail.gmail.com>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Soren Harward <stharward-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Soren,

On Tue, 4 Nov 2014 22:27:29 -0500, Soren Harward wrote:
> On Thu, Aug 7, 2014 at 4:11 AM, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> wrote:
> > Also I had one report of a problem with the same chipset you are using,
> > and the reporter claims that kernel v3.16 no longer has the problem. We
> > don't know why yet, but it might be worth a try.
> 
> Gentoo stabilized 3.16 a couple weeks ago, and I just realized "oh
> yeah, I forgot to follow up with the i2c guys".  3.16.5 works without
> reverting commit 6676a847.

Thanks for the report, very appreciated. There were no significant
change to the i2c-i801 driver between kernel versions 3.14 and 3.16, so
something else must have fixed it. If we knew which commit that was, we
could backport it to stable kernels. So if you have the expertise and
time to kill, it would be wonderful if you could bisect the kernel from
3.14 to 3.16 to find out the commit that fixed the problem (beware that
git bisect assumes you are looking for a regression, not a fix, so bad
will mean good and good will mean bad.) If you can't, no worry, your
success report was already very valuable.

The only change specific to the Intel 5400 chipset I could find during
that timeframe was:

commit c2e650c49a1795238895a474873a12c6c5662833
Author: Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Thu Jan 16 11:20:21 2014 -0500

    i5400_edac: Disable device when unloading module

but I very much doubt this is related.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
