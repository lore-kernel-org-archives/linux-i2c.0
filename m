From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC PATCH 3/8] Philips PCA9536 4 bit I2C GPIO extender
	driver
Date: Sun, 27 Jan 2008 22:18:03 -0800
Message-ID: <200801272218.04137.david-b@pacbell.net>
References: <Pine.LNX.4.64.0801231646090.4932@axis700.grange>
	<Pine.LNX.4.64.0801231820060.4932@axis700.grange>
	<20080127224559.4eed7cea@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080127224559.4eed7cea-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sunday 27 January 2008, Jean Delvare wrote:
> 
> There is a new GPIO subsystem (under driver/gpio), that's where you
> should add this driver.

That should merge soonish into kernel GIT -- Linus is merging up a
storm before LCA starts, but Andrew's not sent it yet -- but it's
easy to grab from current MM.

There's a pca9539 driver there, and ISTR the 9536 is very similar
except it has no IRQ support and only has 8-bit registers.  You
should be able to reuse its platform_data structure.  It has a
registration callback that should let you establish the linkage to
the camera(s) you want to control.

I suspect you'll come across one other issue... one potential fix
being to add a mechanism matching a NOTE in the gpiolib sources.

I think you should consider making one driver that can handle three
chips: the 4-bit pca9536 (8 pins) and pca9537 (10 pins -- add irq and
reset), plus their 8-bit pca9538 sibling (16 pins -- four more GPIOs,
and two address bits).  Their register model is *identical* ... all
that would mean is understanding that for some chips the high nibble
is actually valid.  (And eventually, maybe, that some chips support
input-changed IRQs that can help avoid synchronous register reads.
If the i2c_client doesn't list an IRQ that's of course not an issue.)

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
