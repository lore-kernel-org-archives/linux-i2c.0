From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,
	remove} calls
Date: Wed, 22 Oct 2008 13:27:14 +1100
Message-ID: <1224642434.7654.317.camel@pasglop>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<200810171324.42650.david-b@pacbell.net>
	<20081017212942.GA1919@oksana.dev.rtsoft.ru>
	<200810200029.58312.david-b@pacbell.net>
	<20081020154835.GA3234@oksana.dev.rtsoft.ru>
	<1224635360.7654.294.camel@pasglop>
	<20081022010347.GA7377@oksana.dev.rtsoft.ru>
Reply-To: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081022010347.GA7377-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2008-10-22 at 05:03 +0400, Anton Vorontsov wrote:
> If say "X" driver loads prior to bus-notifier module (where we fill
> the platform data), then X.0 device will try to probe w/o platform
> data and will fail. The only way to re-probe things is to rmmod X &&
> insmod of_pdata_filler_X && insmod X. So things depend on the module
> load order.
> 
> The obvious solution is to link the OF stuff into the module, but
> this also won't work, since modules have only one entry (and exit)
> point. So there is no way* to hook our OF helpers into the module.

Well, right, we need the bus notifier to be registered before any
device gets added ... which mean from the same module_init that
registers the bus itself. A bit annoying ...

> * Well, there is one solution to this problem. We can implement
> arch-specific init_module and cleanup_module entry/exit points,
> where we can load/unload the OF hooks. This is quite easy, but
> may look ugly. I could show the drafts.

Yuck :-)

Cheers,
Ben.



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
