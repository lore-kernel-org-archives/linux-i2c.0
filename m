From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Wed, 22 Oct 2008 14:04:52 -0700
Message-ID: <200810221404.52798.david-b@pacbell.net>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081022104606.GA510@oksana.dev.rtsoft.ru>
	<20081022183218.GA19025@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20081022183218.GA19025@oksana.dev.rtsoft.ru>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: avorontsov@ru.mvista.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 22 October 2008, Anton Vorontsov wrote:
> 
> > > The board info has another problem though. We can't remove it, thus
> > > we can't implement module_exit() for the 'OF glue'.

That's not a problem.  Why would you want to remove it?


> > And try to solve this problem... maybe then things will begin to
> > move forward.
> 
> There is another problem: board infos are scanned at the controller
> registration time only.

Right.  Such board description data should be made available
early in boot.  As a rule:  before arch_initcall() finishes,
so that subsys_initcall() code can use the associated GPIOs.

(It's fairly well acknowledged that init dependency handling
has a lot of problems.  Until that's fixed ... for GPIOs, the
general advice is to make sure everything is available by
subsys_initcall time,  so the subsystems which rely on GPIOs
to initialize -- power switches, resets, etc -- can initialize.
That can require i2c adapter drivers to use subsys_initcall,
for example.)


> So if we register the board infos after 
> the controller registered, then nobody will probe the board infos.

See above.  If you're doing it right, there's no problem.
That is, scan the OF tables early.  Just like PNP tables
get scanned early, for example.

- Dave
