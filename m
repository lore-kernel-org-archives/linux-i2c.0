From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: ISP1301_OMAP: New-style i2c driver
	updates, part 2
Date: Fri, 7 Mar 2008 12:20:09 -0800
Message-ID: <200803071220.10744.david-b@pacbell.net>
References: <1199379597-6273-1-git-send-email-me@felipebalbi.com>
	<200802252138.30301.david-b@pacbell.net>
	<31e679430802260122xc30356ayd98fc3c079e613b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <31e679430802260122xc30356ayd98fc3c079e613b7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Felipe Balbi <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dsaxena-k7pgMgclrJvR7s880joybQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 26 February 2008, Felipe Balbi wrote:
> >
> > =A0Passing irq_flags??? =A0That sounds like nonsense. =A0Please explain=
 ...
> =

> request_irq was using different irq flags depending on the board, so
> instead of keeping if (machine_is_*) in the driver just because of irq
> flags we could bring it from a platform_data.

Just use the resource type flags ... IORESOURCE_IRQ can
be combined with =


#define IORESOURCE_IRQ_HIGHEDGE         (1<<0)
#define IORESOURCE_IRQ_LOWEDGE          (1<<1)
#define IORESOURCE_IRQ_HIGHLEVEL        (1<<2)
#define IORESOURCE_IRQ_LOWLEVEL         (1<<3)
#define IORESOURCE_IRQ_SHAREABLE        (1<<4)

I'd presume "highedge" means "rising", etc.

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
