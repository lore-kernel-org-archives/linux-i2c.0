From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: PMBus support in Linux
Date: Fri, 28 May 2010 21:42:39 -0700
Message-ID: <20100529044239.GA19155@ericsson.com>
References: <1275063391.2631.137.camel@groeck-laptop>
	<20100529023401.GB12507@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lm-sensors-bounces@lm-sensors.org>
Content-Disposition: inline
In-Reply-To: <20100529023401.GB12507@pengutronix.de>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/options/lm-sensors>,
	<mailto:lm-sensors-request@lm-sensors.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/lm-sensors/>
List-Post: <mailto:lm-sensors@lm-sensors.org>
List-Help: <mailto:lm-sensors-request@lm-sensors.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/lm-sensors>,
	<mailto:lm-sensors-request@lm-sensors.org?subject=subscribe>
Sender: lm-sensors-bounces@lm-sensors.org
Errors-To: lm-sensors-bounces@lm-sensors.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, May 28, 2010 at 10:34:01PM -0400, Wolfram Sang wrote:
> 
> CCing lm-sensors and David...
> 
> On Fri, May 28, 2010 at 09:16:31AM -0700, Guenter Roeck wrote:
> 
> > does anyone know if there is an effort to add infrastructure for PMBus
> > support (or support for specific PMBus devices) to Linux ?
> 
> I found this:
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022969.html
> 
I found that as well, but that was about it. Not sure if I want to use it
as a starting point or even for reference since it is gplv3.
Probably useful for debugging, though.

> Hmm, sitting ontop of SMBus, it makes perfect sense to use i2c-dev (David knows
> what he is doing, of course ;)). But having no repo and all, it is hard to
> maintain this utility. Is there any chance to pick it up in the kernel-tree?
> tools/i2c/ or such? Hmm, it's GPL v3...
> 
Maybe there is now more interest in kernel driver support - looks like there
are several PMBus chips available today.

If there is no activity yet, question is if I should write individual drivers or 
if I should define a PMBus infrastructure on top of i2c/smbus first.
Any thoughts on which approach would be more likely to be accepted into the kernel ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
