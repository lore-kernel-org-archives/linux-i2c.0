From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
 MAX7320-7327 I2C Port Expanders
Date: Fri, 11 Jul 2008 11:31:14 +0200
Message-ID: <20080711113114.79d80212@hyperion.delvare>
References: <4875A893.3090402@gmail.com>
	<20080711102952.31d2d943@hyperion.delvare>
	<f17812d70807110157p5e421222sc9ef420ceb80970c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <f17812d70807110157p5e421222sc9ef420ceb80970c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: eric miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Jack Ren <jack.ren-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 11 Jul 2008 16:57:36 +0800, eric miao wrote:
> On Fri, Jul 11, 2008 at 4:29 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > On Thu, 10 Jul 2008 14:13:39 +0800, Eric Miao wrote:
> >> + *   - Group A : by I2C address 0b'110xxxx
> >> + *   - Group B : by I2C address 0b'101xxxx
> >> + *
> >> + * where 'xxxx' is decided by the connections of pin AD2/AD0.
> >
> > AD2-AD0 (assuming there there is an AD1 pin)
> 
> Unfortunately, no AD1 pin

Ah, these are 2 four-state address pins, I get it now.

> >> (...)
> >> +#define PORT_NONE    0x0     /* '/' No Port */
> >
> > You don't use this define anywhere.
> 
> Just defined here to illustrate the purpose of the "0" here means
> NO PORT exist in that bit position, it helps people to better
> understand the port organization and initialization sequence

Could be a comment rather than a define, but up to you.

> >> (...)
> >> +     nr_port = port;
> >
> > Why do you need 2 variables for that?
> 
> Again, better readability :-)
> 
> I can remove that if you mind.

Personally I tend to think that it makes the readability worse not
better. Looking at just the end of the function, I see:

	if (nr_port > 7) {
(...)
	gc->ngpio = port;

And I have to scroll up a bit to find out that "nr_port" and "port"
always have the same value by construction. So indeed I would suggest
to drop "port" and use "nr_port" everywhere for clarity.

Oh, and one more thing as I just notice it:

> +static inline int is_group_a(struct max732x_chip *chip, unsigned off)
> +{
> +	return (1u << off) & chip->mask_group_a;
> +}

Given the way you use it, can't you just define this function as:

static inline int is_group_a(struct max732x_chip *chip, unsigned off)
{
	return (off < 8);
}

? As this is the only place where you use chip->mask_group_a, you would
be able to get rid of it.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
