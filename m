From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: ISP1301_OMAP: New-style i2c driver
	updates, part 2
Date: Mon, 25 Feb 2008 21:38:29 -0800
Message-ID: <200802252138.30301.david-b@pacbell.net>
References: <1199379597-6273-1-git-send-email-me@felipebalbi.com>
	<31e679430802240305o62ec88a9jfcc54f0a3be658ff@mail.gmail.com>
	<31e679430802250046h4df04aa0y6a32005e6d791e65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <31e679430802250046h4df04aa0y6a32005e6d791e65-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Monday 25 February 2008, Felipe Balbi wrote:
> Jean, I'm thinking about introducing include/asm/arch/isp1301.h

Or maybe isp1301_omap.h to match the driver name.


> so I 
> can introduce struct isp1301_platform_data to pass irq_flags to the
> driver.

Passing irq_flags???  That sounds like nonsense.  Please explain ...


By the way, I see why there's no board-h2.c update.  One of
the patches in December stripped out most of the tps65010
i2c_board info from mainline, replacing some of it with
isp1301 stuff ... that can't possibly work in mainline.

So there are going to be some H2 and H3 regression-fix
patches upcoming...

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
