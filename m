From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Frame buffers and early i2c
Date: Tue, 10 Jun 2008 08:25:27 +0200
Message-ID: <20080610082527.0e6d643a@hyperion.delvare>
References: <200806091647.42757.u.luckas@road.de>
	<20080609205212.4b0f1ba6@hyperion.delvare>
	<200806092359.36080.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754787AbYFJG0T@vger.kernel.org>
In-Reply-To: <200806092359.36080.u.luckas@road.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uli Luckas <u.luckas@road.de>
Cc: linux-kernel@vger.kernel.org, adaplas@gmail.com, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

Hi Uli,

On Mon, 9 Jun 2008 23:59:35 +0200, Uli Luckas wrote:
> On Monday 09 June 2008, Jean Delvare wrote:
> > Why don't you ask on the i2c mailing list? Cc added.
>
> I wanted to get i2c developers plus frame buffer and other i2c client 
> developers involved. Crossposting to more then 2 lists seemed wrong.

So you prefer to post to one random list than the two lists where your
target audience is? Interesting approach. If you really don't want to
post to two lists at once, just send two separate posts?

> > Interestingly enough, they appear to do fine, despite the linking
> > order. Maybe because i2c_init is a subsys_initcall() while framebuffer
> > drivers are initialized with module_init()? Then I'm not sure why your
> > own driver has a problem there.
> >
> Well, this is only very partially true. Try:
> rgrep -l subsys_initcall drivers/i2c/
> rgrep -l module_init drivers/i2c/
> 
> The last of which gives drivers/i2c/busses/i2c-pxa.c for example.

Sorry, I didn't understand what you wanted originally. I thought you
only wanted the i2c-core up before pxafb (which is in fact already the
case) while what you actually want it i2c-pxa up before pxafb (which
isn't yet the case.)

> I'll change the pxa i2c driver to subsys_initcall and try if that works when I 
> get back to my desk tomorrow.

I expect it to work, as apparently other platforms are doing exactly
that already.

-- 
Jean Delvare
