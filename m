From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [linux-pm] [PATCH] i2c: Hook up runtime PM support
Date: Fri, 5 Feb 2010 10:39:15 +0000
Message-ID: <20100205103915.GA2600@sirena.org.uk>
References: <1265203367-21344-1-git-send-email-broonie@opensource.wolfsonmicro.com> <201002042257.27145.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201002042257.27145.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, pm list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 04, 2010 at 10:57:27PM +0100, Rafael J. Wysocki wrote:
> On Wednesday 03 February 2010, Mark Brown wrote:
> > Allow I2C drivers to make use of the runtime PM framework by adding
> > bus implementations of the runtime PM operations. These simply
> > immediately suspend when the device is idle.

> Perhaps it would be a good idea to give the driver a chance to veto
> the suspend by calling its _idle callback?  We do that for PCI and turns out to
> be quite useful.

Hrm, I guess.  It seems an odd thing to want to use - for a bus like I2C
there's nothing other than the driver involved so the request that is
being vetoed will have been initiated by the driver which seems wrong.
Out of interest do you have any pointers to drivers using this (my greps
aren't turning anything up in -next)?
