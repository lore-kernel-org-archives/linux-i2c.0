From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH]I2C device - release cleanup
Date: Tue, 23 Mar 2010 17:21:43 +0100
Message-ID: <20100323172143.6b078b2e@hyperion.delvare>
References: <20100323135410.47276f58@hyperion.delvare>
	<0016e6d64c23d0770e0482776d51@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0016e6d64c23d0770e0482776d51-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Michel Hautbois <jhautbois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 23 Mar 2010 13:02:41 +0000, jhautbois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> Hi Jean,
> 
> < snip >
> > Did you test your patch? I am very skeptical that calling
> 
> > single_release() out of the blue is the right thing to do. My instinct
> 
> > tells me that single_release() is only meant for callers of
> 
> > single_open().
> 
> Well, using this call works fine with my hardware.
> I would say, as before :).
> Looking at the source code of single_release, this is very similar to what  
> is done today.
> 
> But yes, it would also be interesting to use single_open in the open()  
> syscall.
> I think this would be nicer to use only single_*() functions.
> 
> Maybe is it interesting to submit a patch that does a cleanup for all the  
> i2c-dev file ? And not only the release function ?

Yes, that would be better. If you do that, please make sure to run your
patch through scripts/checkpatch.pl before sending it.

-- 
Jean Delvare
