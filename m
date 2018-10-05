From: "George G. Davis" <ggdavisiv@gmail.com>
Subject: Re: [PATCH] i2c: core: squelch error: uninitialized symbol 'ret'
Date: Fri, 5 Oct 2018 16:55:29 -0400
Message-ID: <20181005205529.GA3332@gandalf.middle.earth.net>
References: <20181005161826.2455-1-george_davis@mentor.com>
 <20181005162841.wy4uyespwcvffkpc@ninjato>
 <20181005164520.GA2617@gandalf.middle.earth.net>
 <20181005174301.GA964@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005174301.GA964@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "George G. Davis" <george_davis@mentor.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 05, 2018 at 07:43:01PM +0200, Wolfram Sang wrote:
> 
> > Feel free to ignore if this is a topic already discussed in other
> > threads. To be honest, I did not search the mailing list to determine if
> > this particular issue was already discussed.  
> 
> Not this particular issue, but in general we usually don't change
> working code to silence false positives in code checkers.

Ok.

> But thanks for letting me know this is a false positive!

No worries. Thanks for having a look.

> BTW next time CC Dan Carpenter, he might be interested to fix the issue
> in smatch.

I'll try to remember this in the future.

Thanks again!

--
Regards,
George
