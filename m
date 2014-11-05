From: Soren Harward <stharward-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-i801 driver quit working in 3.8.11
Date: Tue, 4 Nov 2014 22:27:29 -0500
Message-ID: <CANQojO4sCTmPaV7joQS4=XdifRx61q1Ac0xcdgJ-MW_URN1A=A@mail.gmail.com>
References: <CANQojO4jbSM=03WfJtw-iSNfexBNSt6GwRLpVSmBx_KrAa0bWQ@mail.gmail.com>
	<20130806192228.GB8246@roeck-us.net>
	<CANQojO74882h+oFJDrq2dsSC71NZHuyf2sjTzCr4a+VmPMLyVA@mail.gmail.com>
	<52026530.2080301@roeck-us.net>
	<CANQojO5B+7c+J=fxV-_mT=Y19Uy=4cW-83vnrphPkN5pmgc2YQ@mail.gmail.com>
	<20130807174801.GB1862@roeck-us.net>
	<CANQojO5QuoGSmmNYxxZ=0MhbZt0mEW-8n6kTxVSWuZ4p6NFw5Q@mail.gmail.com>
	<20130807192556.GA31395@roeck-us.net>
	<20140807101147.34087264@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140807101147.34087264-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 7, 2014 at 4:11 AM, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> wrote:
> Also I had one report of a problem with the same chipset you are using,
> and the reporter claims that kernel v3.16 no longer has the problem. We
> don't know why yet, but it might be worth a try.

Gentoo stabilized 3.16 a couple weeks ago, and I just realized "oh
yeah, I forgot to follow up with the i2c guys".  3.16.5 works without
reverting commit 6676a847.

-- 
Soren Harward
