From: Nicholas Mc Guire <der.herr-kA1LtwSENNE@public.gmane.org>
Subject: Re: [PATCH RFC] i2c: octeon: allow receiving of signals.
Date: Thu, 11 Jun 2015 15:55:19 +0200
Message-ID: <20150611135519.GA28420@opentech.at>
References: <1434029032-8811-1-git-send-email-hofrat@osadl.org> <20150611134435.GA6143@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150611134435.GA6143@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 11 Jun 2015, Wolfram Sang wrote:

> On Thu, Jun 11, 2015 at 03:23:52PM +0200, Nicholas Mc Guire wrote:
> > Change wait_event_timeout() to wait_event_interruptible_timeout() allowing
> > signals to be received while waiting on event (task state set to 
> > TASK_INTERRUPTIBLE) as the dev_dbg() string indicates that signals
> > are expected to be possible. While at it fix the type to long (as returned
> > by schedule_timeout(). 
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
> > ---
> > 
> > From the dev_dbg string "wait interrupted" it seems that interrupts are
> > expected to be on - so most likely this should be
> > wait_event_interruptible_timeout() and not wait_event_timeout() as the
> > later return >= 0 always and sets the task state to TASK_UNINTERRUPTIBLE.
> > Someone that knows the details of this driver needs to confirm this though.
> 
> Use 'git log drivers/i2c/busses/i2c-octeon.c' and you will find commit
> 2637e5fd232d421b680757944f613d4b1a36ae26 which disabled the signals.
> For further digging, you could do
> 'git log --grep="interruptible" drivers/i2c/busses' to find that signals
> cause a lot of problems with i2c transactions.
> 
> Summary: The code still handling signal code simply needs to go.
>
thanks - the output of 'git log --grep="interruptible" drivers/i2c/busses' 
really make it very clear - sorry for the noise - I had only been looking at
the code of this driver to figure out how to resolve the obvious API
inconsistency but did not check the broader scope.

will fix it up and resend.

thx!
hofrat
