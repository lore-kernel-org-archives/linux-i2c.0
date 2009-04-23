From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c algo bit timeout question
Date: Thu, 23 Apr 2009 08:57:28 +0200
Message-ID: <20090423085728.18d0c9cf@hyperion.delvare>
References: <21d7e9970904221619v7d7990bfq697cfca64a7ed6d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <21d7e9970904221619v7d7990bfq697cfca64a7ed6d2-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Dave,

On Thu, 23 Apr 2009 09:19:21 +1000, Dave Airlie wrote:
> Hi to any i2c people,

i2c people tend to live on the linux-i2c list, Cc'd.

> So I've been debugging some EDID fetching failures and wanted to ask
> about the use of time_after_eq in the i2c bit banging code.
> 
> EDID specification recommends 2ms timeout for the ack on the initial
> read, so we set the timeout in our code to usecs_to_jiffies(2200) (10%
> margin of error). On my systems this ends up as 1, and we seem to fail
> to retrieve EDID one in 10-20 times. Changing the value to 2, always
> gets me the EDID I want.
> 
> So looking at drivers/i2c/algos/i2c-algo-bit.c it appears it uses
> time_after_eq on jiffies, start + timeout value. So if we have a 10ms
> jiffie resolution and enter this at the 9ms point in the 10ms window,
> we will seem to exit the loop after 1ms instead of the minimum which I
> asked for which is 2.2ms. Should this code use time_after instead of
> time_after_eq?

Yes, I think it should. This bug has been there pretty much since
forever. I suppose people didn't notice because they usually use a
large timeout value.

Please send a patch fixing this and I'll apply it.

-- 
Jean Delvare
