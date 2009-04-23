From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Handling of i2c arbitration loss
Date: Thu, 23 Apr 2009 14:24:21 +0200
Message-ID: <20090423142421.049a8bc7@hyperion.delvare>
References: <200901081155.27866.david-b@pacbell.net>
	<20090109100145.GA12376@clifford.at>
	<20090214121745.39dfddf9@hyperion.delvare>
	<20090214180014.GA19352@clifford.at>
	<20090215113122.5bcc3f3d@hyperion.delvare>
	<20090216131026.GA17437@clifford.at>
	<20090219172605.7e70a797@hyperion.delvare>
	<20090219212325.GC16107@clifford.at>
	<20090220124546.193e49f2@hyperion.delvare>
	<20090409084726.3f2bd193@hyperion.delvare>
	<20090409083553.GA20058@clifford.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090409083553.GA20058-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 9 Apr 2009 10:35:53 +0200, Clifford Wolf wrote:
> Hi Jean,
> 
> On Thu, Apr 09, 2009 at 08:47:26AM +0200, Jean Delvare wrote:
> > Clifford, any news? I didn't get any update for this patch. If I don't
> > get one soon, I'll have to just discard it.
> 
> oops. has been pretty busy the last weeks...

Same here, as you can see :(

> 
> here is an updated version of the patch (based on the current linus git
> tree). The only change is that I have moved the initialization of the
> orig_jiffies variables. Afair we agreed on having adapter->timeout in
> jiffies and I remeber that you also have made already a patch to unify this
> for the entire i2c subsystem..
> 
> I can't test it until next week, but the changes are trivial. I also have
> on my todo list for next week to cleanup my i2c-mpc patches and send those
> parts which are still required after the changes in i2c-core again (I think
> they have all been removed from the -mm tree already)..
> 
> yours,
>  - clifford
> 
> --snip--
> 
> i2c: Retry automatically on arbitration loss
> 
> some small changes in i2c core to retry i2c xfers until eighter the
> maximum number of retries or the timeout is hit.
> 
> Signed-of-by: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>

It's "off" not "of" ;)

> ---
>  drivers/i2c/i2c-core.c |   29 +++++++++++++++++++++++++----
>  1 files changed, 25 insertions(+), 4 deletions(-)

Patch applied, thanks. It's in linux-next for now, will go in 2.6.31 if
no problem is reported.

-- 
Jean Delvare
