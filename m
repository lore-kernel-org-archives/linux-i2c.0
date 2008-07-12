From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
	MAX7320-7327 I2C Port Expanders
Date: Sat, 12 Jul 2008 00:46:29 -0700
Message-ID: <200807120046.29389.david-b@pacbell.net>
References: <4875A893.3090402@gmail.com>
	<200807111425.00961.david-b@pacbell.net>
	<20080712091610.4ec242c3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080712091610.4ec242c3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Saturday 12 July 2008, Jean Delvare wrote:
> > > +#include <linux/i2c.h>
> > > +#include <linux/i2c/max732x.h>
> > > +
> > > +#include <asm/gpio.h>
> > 
> > For consistency, make that <linux/gpio.h> and put it up above.
> > I like to see blank lines delineating groups, like <linux/*>
> > and <linux/i2c/*>, too.
> 
> You probably want to fix all gpio drivers to do the same then,
> otherwise contributors will keep copying the wrong practice.

When I get time.  ;)


> > > +	chip->client[0] = client;
> > > +
> > > +	switch (client->addr & 0x70) {
> > > +	case 0x60:
> > > +		chip->client[1] = i2c_new_dummy(client->adapter,
> > > +					(client->addr & 0x0f) | 0x50);
> > > +		chip->client_group_a = chip->client[0];
> > > +		chip->client_group_b = chip->client[1];
> > > +		break;
> > > +	case 0x50:
> > > +		chip->client[1] = i2c_new_dummy(client->adapter,
> > > +					(client->addr & 0x0f) | 0x60);
> > > +		chip->client_group_a = chip->client[1];
> > > +		chip->client_group_b = chip->client[0];
> > > +		break;
> > 
> > Why not just insist the 0x5x address be registered/probed?  This
> > extra stuff is needless and confusing.
> 
> Because some of the chips supported by this driver (max7319, max7321,
> max7322 and max7323) only use address 0x6x.

That's not the behavior implemented here though ... it's always
creating a dummy, even when it's not needed.


> I agree that the way the two clients are handled seems to be more
> complex than it needs to be, but the diversity of supported chips is
> such that even simplifying it as much as possible will still result in
> non-trivial code.

For what it *does* it **IS** more complex than it needs to be.
There's no "seems" about it.

For what was *intended*, it's evidently not yet complex enough.  :(

- Dave



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
