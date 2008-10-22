From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Wed, 22 Oct 2008 05:03:47 +0400
Message-ID: <20081022010347.GA7377@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<200810171324.42650.david-b@pacbell.net>
	<20081017212942.GA1919@oksana.dev.rtsoft.ru>
	<200810200029.58312.david-b@pacbell.net>
	<20081020154835.GA3234@oksana.dev.rtsoft.ru>
	<1224635360.7654.294.camel@pasglop>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
Content-Disposition: inline
In-Reply-To: <1224635360.7654.294.camel@pasglop>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 22, 2008 at 11:29:20AM +1100, Benjamin Herrenschmidt wrote:
> 
> > But it doesn't work as a module (i.e. OF-specific bits should be
> > always in-kernel).
> 
> Why not ?

If say "X" driver loads prior to bus-notifier module (where we fill
the platform data), then X.0 device will try to probe w/o platform
data and will fail. The only way to re-probe things is to rmmod X &&
insmod of_pdata_filler_X && insmod X. So things depend on the module
load order.

The obvious solution is to link the OF stuff into the module, but
this also won't work, since modules have only one entry (and exit)
point. So there is no way* to hook our OF helpers into the module.

* Well, there is one solution to this problem. We can implement
arch-specific init_module and cleanup_module entry/exit points,
where we can load/unload the OF hooks. This is quite easy, but
may look ugly. I could show the drafts.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
