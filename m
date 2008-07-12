From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/1] I2C pxa fast mode (400khz) support
Date: Fri, 11 Jul 2008 19:20:29 -0700
Message-ID: <200807111920.29739.david-b@pacbell.net>
References: <486B9E30.80806@cam.ac.uk> <486C32C4.8050007@gmail.com>
	<20080710132956.GG30539@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080710132956.GG30539-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
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
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 10 July 2008, Ben Dooks wrote:
> On Thu, Jul 03, 2008 at 10:00:36AM +0800, Eric Miao wrote:
> > Jonathan Cameron wrote:
> > > Add fast_mode option to i2c_pxa_platform_data and use it to set the ICR_FM bit
> > > appropriately when i2c_pxa_reset is called. Parameter called fast_mode rather
> > > than frequency as this driver is also used for the i2c_pxa_pwr bus which has
> > > different normal and fast frequencies.
> > 
> > Maybe we should convert that (as well as 'use_pio') to a bit field to save
> > another byte.
> 
> I think use_pio and fast_mode could both be bits.

Or alternatively, "bool" ... which is usually a byte, and
on ARM will let GCC eliminate a comparision instruction.
Just load byte and branch on zero/nonzero, vs needing one
more instruction.  (In odd cases, it can be more important
to conserve the extra seven bits.)

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
