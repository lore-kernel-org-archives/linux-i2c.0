From: =?ISO-8859-1?Q?H=E5vard_Skinnemoen?= <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-gpio performance issue w/MPC8xx @ 50 MHz
Date: Thu, 5 May 2011 11:42:52 -0700
Message-ID: <BANLkTi=JVadKgX_Lk8kCjSG=ycRB=pZcVg@mail.gmail.com>
References: <BANLkTikaS8yOTcO+OChvutB0syWdVBsh8g@mail.gmail.com>
	<20110501102603.7993da58@endymion.delvare>
	<BANLkTik_mBMHJt-MzcSQfdnAhseBM5KwFg@mail.gmail.com>
	<20110504215049.GX15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110504215049.GX15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 4, 2011 at 2:50 PM, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> On Sun, May 01, 2011 at 03:04:21PM -0700, H=E5vard Skinnemoen wrote:
>> i2c-gpio currently has 225 lines of code. I think it should be
>> possible to write a i2c-platform driver in less than 100 lines.
>> Probably worthwhile for 3x performance, although probably not if the
>> GPIO hardware has concurrency issues.
>
> I suppose this would work, but is it worth the additional code for wh=
at
> may not be much of a win?

3x performance is not much of a win?

Havard
