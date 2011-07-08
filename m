From: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] power: Remove obsolete cleanup for clientdata
Date: Fri, 8 Jul 2011 13:28:03 +0400
Message-ID: <20110708092803.GA18158@oksana.dev.rtsoft.ru>
References: <1308603674-19264-1-git-send-email-w.sang@pengutronix.de>
 <1308603674-19264-3-git-send-email-w.sang@pengutronix.de>
 <20110621105456.05839025@endymion.delvare>
 <20110708091556.GE2048@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110708091556.GE2048-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 08, 2011 at 11:15:56AM +0200, Wolfram Sang wrote:
> On Tue, Jun 21, 2011 at 10:54:56AM +0200, Jean Delvare wrote:
> > On Mon, 20 Jun 2011 23:01:14 +0200, Wolfram Sang wrote:
> > > A few new i2c-drivers came into the kernel which clear the clientdata-pointer
> > > on exit or error. This is obsolete meanwhile, the core will do it.
> > > 
> > > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > Cc: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > > Cc: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > 
> > Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> 
> Anton, can you pick it for 3.1?

Will do. Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
