From: "Felipe Balbi" <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: ISP1301_OMAP: New-style i2c driver
	updates, part 2
Date: Tue, 26 Feb 2008 11:22:12 +0200
Message-ID: <31e679430802260122xc30356ayd98fc3c079e613b7@mail.gmail.com>
References: <1199379597-6273-1-git-send-email-me@felipebalbi.com>
	<31e679430802240305o62ec88a9jfcc54f0a3be658ff@mail.gmail.com>
	<31e679430802250046h4df04aa0y6a32005e6d791e65@mail.gmail.com>
	<200802252138.30301.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200802252138.30301.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dsaxena-k7pgMgclrJvR7s880joybQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 26, 2008 at 7:38 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Monday 25 February 2008, Felipe Balbi wrote:
>  > Jean, I'm thinking about introducing include/asm/arch/isp1301.h
>
>  Or maybe isp1301_omap.h to match the driver name.
>
>
>
>  > so I
>  > can introduce struct isp1301_platform_data to pass irq_flags to the
>  > driver.
>
>  Passing irq_flags???  That sounds like nonsense.  Please explain ...

request_irq was using different irq flags depending on the board, so
instead of keeping if (machine_is_*) in the driver just because of irq
flags we could bring it from a platform_data.

>
>
>  By the way, I see why there's no board-h2.c update.  One of
>  the patches in December stripped out most of the tps65010
>  i2c_board info from mainline, replacing some of it with
>  isp1301 stuff ... that can't possibly work in mainline.
>
>  So there are going to be some H2 and H3 regression-fix
>  patches upcoming...

that's true...

-- 
Best Regards,

Felipe Balbi
felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
