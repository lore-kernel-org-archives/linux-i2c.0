From: "Felipe Balbi" <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: ISP1301_OMAP: New-style i2c driver
	updates, part 2
Date: Thu, 28 Feb 2008 23:53:18 +0200
Message-ID: <31e679430802281353s43ecb4d6ue900a77394cf9de0@mail.gmail.com>
References: <1199379597-6273-1-git-send-email-me@felipebalbi.com>
	<200802231010.40108.david-b@pacbell.net>
	<20080223202832.4a953910@hyperion.delvare>
	<200802231153.04011.david-b@pacbell.net>
	<20080224103052.66da6803@hyperion.delvare>
	<31e679430802240305o62ec88a9jfcc54f0a3be658ff@mail.gmail.com>
	<31e679430802250046h4df04aa0y6a32005e6d791e65@mail.gmail.com>
	<20080228225032.61f07a18@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080228225032.61f07a18-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dsaxena-k7pgMgclrJvR7s880joybQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Thu, Feb 28, 2008 at 11:50 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Felipe,
>
>
>  On Mon, 25 Feb 2008 10:46:21 +0200, Felipe Balbi wrote:
>  > Jean, I'm thinking about introducing include/asm/arch/isp1301.h so I
>  > can introduce struct isp1301_platform_data to pass irq_flags to the
>  > driver.
>  > What do you think ?
>
>  This would rather be include/linux/i2c/isp1301_omap.h, now that we have
>  created this directory.

Thanks Jean, I'll try to address this issue during this week and ask
someone in linux-omap ML to try the patches agains linux-mainline :-)

Have a nice day

>
>  --
>  Jean Delvare
>



-- 
Best Regards,

Felipe Balbi
felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
