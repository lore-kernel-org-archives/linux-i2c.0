From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Tue, 10 Mar 2009 10:00:07 +0100
Message-ID: <20090310090007.GB3263@buzzloop.caiaq.de>
References: <1235606248-13004-1-git-send-email-daniel@caiaq.de> <20090226094857.50d0710d@hyperion.delvare> <20090306160042.GA17800@buzzloop.caiaq.de> <20090306182432.338b0244@hyperion.delvare> <20090306181409.GA20135@buzzloop.caiaq.de> <20090307115449.32f0ab26@hyperion.delvare> <20090307120631.GA25276@buzzloop.caiaq.de> <20090307130818.367bcaad@hyperion.delvare> <20090309210901.GC31367@buzzloop.caiaq.de> <20090310095655.3850f0d5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090310095655.3850f0d5-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 10, 2009 at 09:56:55AM +0100, Jean Delvare wrote:
> >  Documentation/i2c/chips/isl29003 |   62 +++++
> 
> Err, obviously not. If drivers/i2c/chips is going away, you can easily
> imagine that Documentation/i2c/chips is going away as well...

Agreed. I didn't want to add Documentation/misc just for that single
file, so where would you put it?

(Sorry for causing so much traffic for such a small, dumb driver)

Daniel
