From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Tue, 10 Mar 2009 09:56:55 +0100
Message-ID: <20090310095655.3850f0d5@hyperion.delvare>
References: <20090225212119.67402391@hyperion.delvare>
	<1235606248-13004-1-git-send-email-daniel@caiaq.de>
	<20090226094857.50d0710d@hyperion.delvare>
	<20090306160042.GA17800@buzzloop.caiaq.de>
	<20090306182432.338b0244@hyperion.delvare>
	<20090306181409.GA20135@buzzloop.caiaq.de>
	<20090307115449.32f0ab26@hyperion.delvare>
	<20090307120631.GA25276@buzzloop.caiaq.de>
	<20090307130818.367bcaad@hyperion.delvare>
	<20090309210901.GC31367@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090309210901.GC31367-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 9 Mar 2009 22:09:01 +0100, Daniel Mack wrote:
> On Sat, Mar 07, 2009 at 01:08:18PM +0100, Jean Delvare wrote:
> > > > Please post new patches, I'll review and apply them.
> > > 
> > > Oh, I thought we agreed now to Jonathan Cameron's idea to merge this
> > > driver into the IIO framework and put it mainline sooner or later? No
> > > extra steps needed from my side - this driver certainly doesn't hurry :)
> > 
> > Both ways are equally fine with me.
> 
> Ok, nevermind, just to be sure :) As soon as IIO is merged, I'll send a
> patch to (re)move it again ...
> 
> Thanks,
> Daniel
> 
> 
> From 48f05c0df089909928bf65a3cef29c5cff7ffb28 Mon Sep 17 00:00:00 2001
> From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
> Date: Mon, 9 Mar 2009 22:02:23 +0100
> Subject: [PATCH] Added driver for ISL29003 ambient light sensor
> 
> This patch adds a driver for Intersil's ISL29003 ambient light sensor
> device plus some documentation. Inspired by tsl2550.c, a driver for a
> similar device.
> 
> It is put to drivers/misc for now until the industrial I/O framework
> gets merged.
> 
> Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> ---
>  Documentation/i2c/chips/isl29003 |   62 +++++

Err, obviously not. If drivers/i2c/chips is going away, you can easily
imagine that Documentation/i2c/chips is going away as well...

>  drivers/misc/Kconfig             |   10 +
>  drivers/misc/Makefile            |    1 +
>  drivers/misc/isl29003.c          |  486 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 559 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/i2c/chips/isl29003
>  create mode 100644 drivers/misc/isl29003.c

-- 
Jean Delvare
