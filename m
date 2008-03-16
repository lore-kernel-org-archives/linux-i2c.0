From: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] [I2C] ID: add I2C Blackfin HW ID
Date: Sun, 16 Mar 2008 09:06:17 +0800
Message-ID: <386072610803151806s1cf6446ds31e5acf83fc61c12@mail.gmail.com>
References: <1201687796-987-1-git-send-email-bryan.wu@analog.com>
	<1201687796-987-4-git-send-email-bryan.wu@analog.com>
	<20080315133958.6939931f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080315133958.6939931f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Mar 15, 2008 at 8:39 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Wed, 30 Jan 2008 18:09:56 +0800, Bryan Wu wrote:
>  > Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>  > ---
>  >  include/linux/i2c-id.h |    1 +
>  >  1 files changed, 1 insertions(+), 0 deletions(-)
>  >
>  > diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
>  > index 6748bd2..402d21d 100644
>  > --- a/include/linux/i2c-id.h
>  > +++ b/include/linux/i2c-id.h
>  > @@ -163,6 +163,7 @@
>  >  #define I2C_HW_B_CX2341X     0x010020 /* Conexant CX2341X MPEG encoder cards */
>  >  #define I2C_HW_B_INTELFB     0x010021 /* intel framebuffer driver */
>  >  #define I2C_HW_B_CX23885     0x010022 /* conexant 23885 based tv cards (bus1) */
>  > +#define I2C_HW_B_BLACKFIN    0x010023 /* ADI Blackfin I2C TWI driver */
>  >
>  >  /* --- PCF 8584 based algorithms                                     */
>  >  #define I2C_HW_P_ELEK                0x020002 /* Elektor ISA Bus inteface card */
>
>  Why do you need this ID? In general we are trying to get rid of them,
>  as the new-style i2c drivers make them obsolete.
>

Yes, please ignore this patch, that's for the old-style i2c driver.

Thanks,
-Bryan

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
