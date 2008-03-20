From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] I2C: ISP1301_OMAP: New-style i2c driver updates,
	part 2
Date: Thu, 20 Mar 2008 02:44:10 -0700
Message-ID: <200803200244.10617.david-b@pacbell.net>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
	<31e679430803180606w51e5538ar1df7fbdfa5a0e894@mail.gmail.com>
	<20080318142716.74d65ba1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080318142716.74d65ba1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> > The board specific code was regarding gpio interrupts, and we now get
> > the correct gpio irq from i2c_board_info so when I free_irq() i'm
> > already freeing the gpio, right ? 

Freeing an IRQ is not the same as freeing a GPIO; of course not.

I'd have to grab the latest version of this patch to see if this
all makes sense.

- Dave

 
> You aren't asking me, are you? I don't have any idea. I don't know
> anything about embedded stuff, let alone omap in particular. Someone
> else will have to answer this question.



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
