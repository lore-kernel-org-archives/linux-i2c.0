From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] MAINTAINERS: add i2c tree for embedded platforms
Date: Tue, 26 Jan 2010 16:25:15 +0100
Message-ID: <20100126162515.230bdf36@hyperion.delvare>
References: <1264411234-5400-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100125111055.05ccedf2@hyperion.delvare>
	<20100126143830.GC12774@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754558Ab0AZPZV@vger.kernel.org>
In-Reply-To: <20100126143830.GC12774@fluff.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 26 Jan 2010 14:38:30 +0000, Ben Dooks wrote:
> On Mon, Jan 25, 2010 at 11:10:55AM +0100, Jean Delvare wrote:
> > On Mon, 25 Jan 2010 10:20:34 +0100, Uwe Kleine-K??nig wrote:
> > > Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
> > > Cc: Ben Dooks <ben-linux@fluff.org>
> > > ---
> > > Hello,
> > > 
> > > I wonder if it makes sence to split the "I2C SUBSYSTEM" entry into
> > > something like:
> > > 
> > > 	I2C SUBSYSTEM (PC drivers, core)
> > > 	M:	Jean Delvare <khali@linux-fr.org>
> > > 	L:	...
> > > 	W:	...
> > > 	T:	quilt ...
> > > 	S:	...
> > > 	F:	Documentation/i2c/
> > > 	F:	drivers/i2c/
> > > 	F:	include/linux/i2c.h
> > > 	F:	include/linux/i2c-*.h
> > > 
> > > 	I2C SUBSYSTEM (embedded platforms)
> > > 	M:	Ben Dooks <ben-linux@fluff.org>
> > > 	L:	...
> > > 	W:	...
> > > 	T:	git ...
> > > 	S:	...
> > > 	F:	drivers/i2c/
> > > 	F:	include/linux/i2c-*.h
> > > 
> > > (I'm not entirely sure about the file patterns for the 2nd entry.)
> > 
> > I'm not sure what value it adds, compared to having a single entry as
> > we have today. scripts/get_maintainer.pl will produce the same output,
> > won't it?
> > 
> > This script (and our minds) being directory-driven, I suspect that the
> > only efficient way to split the entries would be to first move all i2c bus
> > driver for embedded platforms to a separate subdirectory. I'm leaving
> > it to Ben and the embedded community to decide whether they want to do
> > that or not.
> 
> I'd much prefer to see just the one directory of i2c drivers, the
> minor point being people silly enough to load modules by explicit path

Never thought of that, but I wouldn't care. There is no good reason to
do this.

> and the second is that having all the drivers in one place makes it
> easier to update them when changing something in the core...

This doesn't seem to be a blocker either. For one thing, i2c
subsystem-wide changes tend to affect chip drivers more than bus
drivers. And even then, looking for drivers in 2 directories doesn't
seem much harder than looking into just one, especially when said 2
directories live next to each other.

So I see no objection to a mass move of all embedded/system i2c bus
drivers to a separate sub-directory.

-- 
Jean Delvare
