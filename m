From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Tue, 10 Mar 2009 11:40:11 +0100
Message-ID: <20090310114011.012d3fcc@hyperion.delvare>
References: <20090306160042.GA17800@buzzloop.caiaq.de>
	<20090306182432.338b0244@hyperion.delvare>
	<20090306181409.GA20135@buzzloop.caiaq.de>
	<20090307115449.32f0ab26@hyperion.delvare>
	<20090307120631.GA25276@buzzloop.caiaq.de>
	<20090307130818.367bcaad@hyperion.delvare>
	<20090309210901.GC31367@buzzloop.caiaq.de>
	<20090310095655.3850f0d5@hyperion.delvare>
	<20090310090007.GB3263@buzzloop.caiaq.de>
	<20090310111014.523df33e@hyperion.delvare>
	<20090310102534.GC9564@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090310102534.GC9564-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 10 Mar 2009 11:25:34 +0100, Daniel Mack wrote:
> On Tue, Mar 10, 2009 at 11:10:14AM +0100, Jean Delvare wrote:
> > On Tue, 10 Mar 2009 10:00:07 +0100, Daniel Mack wrote:
> > > Agreed. I didn't want to add Documentation/misc just for that single
> > > file, so where would you put it?
> > 
> > Honestly, I'm not sure. But I wouldn't mind actually creating
> > Documentation/misc or similar for it.
> 
> Ok, will do. Anything else in the code you would like me to change?

I did not have the time to review it and will not have the time in a
near future, sorry.

There is a reason why I am trying to move these misc drivers outside of
my maintenance area... Which basically means that you are totally free,
and actually encouraged, to try to get your driver merged by another
maintainer if I am too slow for you.

-- 
Jean Delvare
