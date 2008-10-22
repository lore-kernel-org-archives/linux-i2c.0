From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Tue, 21 Oct 2008 22:20:22 -0600
Message-ID: <20081022042022.GB7176@secretlab.ca>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru> <200810171324.42650.david-b@pacbell.net> <20081017212942.GA1919@oksana.dev.rtsoft.ru> <200810200029.58312.david-b@pacbell.net> <20081020154835.GA3234@oksana.dev.rtsoft.ru> <1224635360.7654.294.camel@pasglop> <20081022010347.GA7377@oksana.dev.rtsoft.ru> <20081022014243.GA19362@oksana.dev.rtsoft.ru> <1224642497.7654.319.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752683AbYJVEUf@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1224642497.7654.319.camel@pasglop>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: avorontsov@ru.mvista.com, David Brownell <david-b@pacbell.net>, David Brownell <dbrownell@users.sourceforge.net>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 22, 2008 at 01:28:17PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2008-10-22 at 05:42 +0400, Anton Vorontsov wrote:
> > 
> > Thinking about it more, I started recalling other issues. The bus
> > notifier chain doesn't replay previous events, so we also have to
> > register the notifier before the _devices_ are registered. And this
> > ruins the whole approach. :-/ Yeah, that's why I abandoned the bus
> > notifier idea.
> 
> The notifier can be registered before the devices, though it's a little
> bit fishy and fragile.
> 
> Easier I suppose to just have OF specific hooks in the bus code.

Every time I think about the problem, this is the conclusion that I come
to.  Either have OF specific hooks in the probe/remove functions; or
have separate probe/remove for OF created instances of a device.

g.
