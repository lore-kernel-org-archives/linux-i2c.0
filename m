From: Andrew Worsley <amworsley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-ocores timeout bug
Date: Thu, 30 Jun 2011 08:55:42 +1000
Message-ID: <BANLkTino1RYuDDjcXZYdJ1LyeSHz6h=ACw@mail.gmail.com>
References: <BANLkTikEESnV9+hc=VFg=qFGOXeg4o0sOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTikEESnV9+hc=VFg=qFGOXeg4o0sOQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

So far no response on this bug I reported about 2 weeks ago that
includes a proposed fix.

Could some one consider adding in the fix into the relevant tree?

On 15 June 2011 08:33, Andrew Worsley <amworsley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi, I have hit upon a bug in this driver in the 2.6.32 which caused
> memory corrupt and crash in my kernel. It appears to be still present
> in 3.0-rc3

http://thread.gmane.org/gmane.linux.drivers.i2c/8543

I have since identified the cause of the problem was the wrong clock
frequency for the FPGA. I mis-understood the clock frequency to
be the i2c bus frequency - but it is actually an FPGA clock frequency.
Perhaps others will make the same mistake as well.

In fact as it stands there is no module parameter to change your i2c
bus frequency - other than by fiddling your FPGA clock frequency.
Better would be a separate parameters for each with a clearer names.

Andrew
