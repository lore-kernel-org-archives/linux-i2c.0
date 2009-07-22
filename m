From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH/RFC 1/1] recover from davinci i2c time out conditions
Date: Wed, 22 Jul 2009 16:44:35 +0530
Message-ID: <1248261275.4077.4.camel@localhost.localdomain>
References: <1247643267.5981.82.camel@localhost.localdomain>
	 <218571.29671.qm@web50101.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <218571.29671.qm-LK+a5U5w+t2B9c0Qi4KiSl5cfvJIxWXgQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nitin Mahajan <nitinm76-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2009-07-22 at 04:03 -0700, Nitin Mahajan wrote:
> Hello,
> 
> ----- Original Message ----
> > From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
> > To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org; davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> > Sent: Wednesday, July 15, 2009 13:04:27
> > Subject: [PATCH/RFC 1/1] recover from davinci i2c time out conditions
> > 
> > >From dbe7e824d576636bb15b82a20fd2557fddc9a8f7 Mon Sep 17 00:00:00 2001
> > From: Philby John 
> > Date: Tue, 14 Jul 2009 21:46:47 +0530
> > Subject: [PATCH] Reset i2c bus to come out of time out conditions
> > 
> > Get out of i2c time out condition by resetting
> > the i2c bus. The kernel must be robust enough to
> > gracefully recover from i2c bus failure without having
> > to reset the machine. This is done by first NACKing the slave
> > and then resetting the i2c bus after a certain timeout.
> > 
> > Signed-off-by: Philby John 
> 
> I tried this on DM6443 based board with 2.6.18 kernel. The result I am posting below. It gives controller time out again and again.
> 
> dhcppc9 login: i2c_davinci i2c_davinci.1: controller timed out
> i2c_davinci i2c_davinci.1: initiating i2c bus recovery
> i2c_davinci i2c_davinci.1: controller timed out
> i2c_davinci i2c_davinci.1: initiating i2c bus recovery


There is something gravely wrong about this patch and I would submit a
fix shortly incorporating the review comments. But please be aware that
I do not guarantee a definitive time line for a fix cause I have much at
hand at the moment.


Regards,
Philby
