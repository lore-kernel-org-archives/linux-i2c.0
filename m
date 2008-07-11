From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319,
 MAX7320-7327 I2C Port Expanders
Date: Fri, 11 Jul 2008 11:54:36 +0200
Message-ID: <20080711115436.22134ce7@hyperion.delvare>
References: <4875A893.3090402@gmail.com>
	<20080711102952.31d2d943@hyperion.delvare>
	<f17812d70807110157p5e421222sc9ef420ceb80970c@mail.gmail.com>
	<20080711113114.79d80212@hyperion.delvare>
	<f17812d70807110239q6c175f5cn70db966681ae387d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <f17812d70807110239q6c175f5cn70db966681ae387d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Fri, 11 Jul 2008 17:39:50 +0800, eric miao wrote:
> >
> > Oh, and one more thing as I just notice it:
> >
> >> +static inline int is_group_a(struct max732x_chip *chip, unsigned off)
> >> +{
> >> +     return (1u << off) & chip->mask_group_a;
> >> +}
> >
> > Given the way you use it, can't you just define this function as:
> >
> > static inline int is_group_a(struct max732x_chip *chip, unsigned off)
> > {
> >        return (off < 8);
> > }
> >
> > ? As this is the only place where you use chip->mask_group_a, you would
> > be able to get rid of it.
> >
> 
> I want to get rid of it either but I'm afraid not. (off < 8) doesn't necessarily
> mean it's in group_a, max7320 is an exception.

I didn't look into the details (and won't have the time to) but my
feeling is that it only depends on how you decide to handle the
max7320. If you want to make it fit with the rest of the supported
chips, I see no reason why it wouldn't work.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
