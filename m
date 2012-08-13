From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: (i2c-diolan-u2c) Fix master_xfer return code
Date: Mon, 13 Aug 2012 11:57:15 +0530
Message-ID: <CAM=Q2ctzBg+o-3On8-i-T49Dg9H=_2Tv7Z9iZba6iErTQoLVXw@mail.gmail.com>
References: <1344527240-18266-1-git-send-email-linux@roeck-us.net>
	<CAM=Q2ctnrO6hJkPDa_daDRFNyig3+GVDkgW_MGMjV24jEM8T5Q@mail.gmail.com>
	<20120810170624.GC29281@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120810170624.GC29281-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 10, 2012 at 10:36 PM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
[...]
>>
>> However if only a few go through should we return the number of
>> successful transactions
>> instead of error?
>>
> Most other I2C bus drivers do the same, so I decided to not make the code
> more complicated than necessary and do it the same way. Also, I prefer to have
> the actual error code returned to the caller, not "I transferred x of your y
> messages, but I won't tell you what went wrong with the rest".

depends on what the user decides however if ever his algo is that resend only
the remaining it would never work. Anyways thats a different story.

>
> If that prevents it from getting integrated, I'll be happy to change it.

I have no objections to the patch getting integrated.
Afterall anything that helps, helps:-)


>
> Thanks,
> Guenter
