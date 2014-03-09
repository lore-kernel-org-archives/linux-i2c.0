From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: i2c-tools-4: timeline?
Date: Sun, 9 Mar 2014 23:06:57 +0100
Message-ID: <20140309230657.15fd4139@endymion.delvare>
References: <CAAXf6LX1-0k91sUQ5CpZQ1J37hNt-JQWJrDukHYo26kLa-9yyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAXf6LX1-0k91sUQ5CpZQ1J37hNt-JQWJrDukHYo26kLa-9yyA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas De Schampheleire <patrickdepinguin+linuxi2c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Thomas,

On Tue, 4 Mar 2014 16:42:11 +0100, Thomas De Schampheleire wrote:
> Hi Jean, all,
> 
> Wiki page 'Plan for i2c-tools 4' [1] describes four steps to fix the
> 'i2c-dev.h' problem:
> 
> Step 1: Cleaning up i2c-dev.h
> Step 2: Creating a library for i2c_smbus_* functions
> Step 3: Extending the library
> Step 4: Documentation
> 
> According to this page, some of these steps have already been
> implemented in several commits. These changes date from April 2012.

Indeed, steps 1 and 2 are done. I started step 3 but I didn't go far
enough to commit it.

> Very recently (February 2014), i2c-tools-3.1.1 has been released, but
> these changes are not part of that release.

No, release 3.1.1 was only a bug fix release on top of 3.1.0. I decided
to do that because 3.1.0 was getting old and a few important fixes had
accumulated over time. This is essentially unrelated to the i2c-tools 4
plan.

> My question is: is there any update regarding i2c-tools 4? Do you have
> an approximate timeframe in which we could expect this release?

No time frame I'm afraid. This is on my to-do list, and it has been for
a long time now. However it's rather far away from the top, so I really
have no idea when I will be able to work on it again.

I was wondering if anyone was actually paying attention to my work on
i2c-tools 4. I'm glad to finally see some interest in it. Apparently
you are waiting for it to be done and released? Are you writing some
tool or application that would benefit from libi2c?

In case you are interested, the patches I currently have for step 3 of
the plan are available here:
  http://jdelvare.nerim.net/devel/i2c/libi2c/

Basically the idea is to move the code that was common to i2cdump,
i2cset, i2cget and i2cdetect to libi2c, under the assumption that it
would probably be useful for other tools and applications and would
thus make libi2c more valuable. However this would make these functions
before part of the library's API, so some care must be taken to only
include what's really needed, that the naming and parameters are right,
etc. That's what I did not have enough time for until now. If you want
to help with that, that would be great.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
