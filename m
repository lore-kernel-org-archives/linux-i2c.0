From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Tue, 10 Mar 2009 21:28:26 -0700
Message-ID: <20090310212826.7d8b3d4e.akpm@linux-foundation.org>
References: <20090306160042.GA17800@buzzloop.caiaq.de>
	<20090306182432.338b0244@hyperion.delvare>
	<20090306181409.GA20135@buzzloop.caiaq.de>
	<20090307115449.32f0ab26@hyperion.delvare>
	<20090307120631.GA25276@buzzloop.caiaq.de>
	<20090307130818.367bcaad@hyperion.delvare>
	<20090309210901.GC31367@buzzloop.caiaq.de>
	<49B666F9.50209@cam.ac.uk>
	<20090310151542.GE9564@buzzloop.caiaq.de>
	<49B6A843.3090902@cam.ac.uk>
	<20090311003155.GB21160@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090311003155.GB21160-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 11 Mar 2009 01:31:55 +0100 Daniel Mack <daniel-rDUAYElUppE@public.gmane.org> wrote:

> On Tue, Mar 10, 2009 at 05:49:55PM +0000, Jonathan Cameron wrote:
> > >>From 8ee5021834900f312ff26cd2586c18e99af31a5d Mon Sep 17 00:00:00 2001
> > > From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
> > > Date: Tue, 10 Mar 2009 16:13:07 +0100
> > > Subject: [PATCH] Added driver for ISL29003 ambient light sensor
> > > 
> > > This patch adds a driver for Intersil's ISL29003 ambient light sensor
> > > device plus some documentation. Inspired by tsl2550.c, a driver for a
> > > similar device.
> > > 
> > > It is put to drivers/misc for now until the industrial I/O framework
> > > gets merged.
> > > 
> > > Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
> 
> [...]
> 
> > All looks fine to me.
> > 
> > Acked-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>

I cannot find this review which Jonathan performed.  Fumbled
reply-to-all, or did vger break?

> Ok, wonderful :)
> 
> What's the merge path for that, who'll queue it?

I can take care of it.

Was any thought given to the CONFIG_SYSFS=n situation?
