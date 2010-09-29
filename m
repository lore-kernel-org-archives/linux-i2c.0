From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Driver for pca9541 bus master selector
Date: Wed, 29 Sep 2010 09:19:28 +0200
Message-ID: <20100929091928.16256bb7@endymion.delvare>
References: <20100928143302.GA7593@ericsson.com>
	<20100928171607.395f7736@endymion.delvare>
	<20100928160746.GB7976@ericsson.com>
	<20100928184215.00f82717@endymion.delvare>
	<20100928171627.GA8415@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100928171627.GA8415-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 28 Sep 2010 10:16:27 -0700, Guenter Roeck wrote:
> On Tue, Sep 28, 2010 at 12:42:15PM -0400, Jean Delvare wrote:
> > Oh, my bad. I had not noticed the PCA9541 was of a totally different kind.
>
> Actually, I fell into the same trap. I was quite happy that someone else wrote 
> the driver for me ... until I realized that the chips solve the opposite problem.
> 
> Time goes by ... have a look at
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2004-June/008023.html

I didn't remember that discussion (unsurprisingly.)

> I wasn't sure if you (or someone else) ever had a driver for 9541, or if you referred
> to 9540 in above post. The links in the post don't work anymore.

I was speaking of the PCA9540. I don't think anyone ever wrote a driver
for the PCA9541. And in all honestly I don't think the new i2c-mux
infrastructure is ready for this. It was written with single-master
topologies in mind. You'll have to rethink a lot of things if you want
to add support for "inverted" multiplexers. And I don't have the time
to help, sorry.

I don't quite see the point of such chips, BTW. I2C supports
multi-master already, so two masters talking to the same slave
sequentially is already supported.

-- 
Jean Delvare
