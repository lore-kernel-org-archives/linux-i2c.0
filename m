From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH]i2c: Make test for force on client probe possible
Date: Fri, 20 Mar 2009 09:44:44 +0100
Message-ID: <20090320094444.18104e6a@hyperion.delvare>
References: <49BA325D.7030308@gmx.de>
	<20090313130942.5addd79e@hyperion.delvare>
	<49C34D97.1010603@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49C34D97.1010603-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <nospam_lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 20 Mar 2009 09:02:31 +0100, Michael Lawnick wrote:
> Jean Delvare said the following:
> > On Fri, 13 Mar 2009 11:15:57 +0100, Michael Lawnick wrote:
> >> in new driver model 'kind' is no more provided for client's probe
> >> function. The driver frame work creates the path
> >> sys/bus/i2c/devices/[bus]-[dev]/ and populates it with the entries
> >> modalias, name, subsystem@ and uevent. If probe fails (because the
> >> device is not on bus at the moment) the client's sysFs-entries are not
> >> created, but the entries above remain.
> > 
> > This is correct, and this is by design. This is how the Linux device
> > driver model works, BTW, nothing i2c-specific there.
>
> Even if this is by (current linux) design, I think it is not ok ;-)
> It leaves an inconsistent (not instable) system. IMHO either the entries
> should be completely removed or completely created but not that half the
> way.
> Should we CC another list?

Feel free to go discuss this on LKML, but don't even bother Cc'ing me.
I really do not have time to waste on a discussion which will not lead
anywhere. I don't mean to offend you here but really, the Linux 2.6
device driver model has been carefully designed and has proved its
strength for 5 years or so, and it's not going to be changed just to
please your expectations.

The only thing I would blame the model for is that the probe() and
remove() methods should really have been named bind() and unbind().
Other than that it's really great.

-- 
Jean Delvare
