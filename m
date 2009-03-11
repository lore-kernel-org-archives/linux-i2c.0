From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Wed, 11 Mar 2009 09:32:52 +0100
Message-ID: <20090311083252.GB25824@buzzloop.caiaq.de>
References: <20090306181409.GA20135@buzzloop.caiaq.de> <20090307115449.32f0ab26@hyperion.delvare> <20090307120631.GA25276@buzzloop.caiaq.de> <20090307130818.367bcaad@hyperion.delvare> <20090309210901.GC31367@buzzloop.caiaq.de> <49B666F9.50209@cam.ac.uk> <20090310151542.GE9564@buzzloop.caiaq.de> <49B6A843.3090902@cam.ac.uk> <20090311003155.GB21160@buzzloop.caiaq.de> <20090310212826.7d8b3d4e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090310212826.7d8b3d4e.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 10, 2009 at 09:28:26PM -0700, Andrew Morton wrote:
> On Wed, 11 Mar 2009 01:31:55 +0100 Daniel Mack <daniel-rDUAYElUppE@public.gmane.org> wrote:
> > > All looks fine to me.
> > > 
> > > Acked-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> 
> I cannot find this review which Jonathan performed.  Fumbled
> reply-to-all, or did vger break?

Jonathan replied to the posting on linux-i2c and linux-kernel wasn't in
the loop, sorry. Find his posting here:

	http://marc.info/?l=linux-i2c&m=123669064909549&w=2

> I can take care of it.
> 
> Was any thought given to the CONFIG_SYSFS=n situation?

You're right, it should depend on that. You want me so send a patch on
top of the other or one that replaces it?

Thanks,
Daniel
