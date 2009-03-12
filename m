From: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Let checkpatch shout on users of the legacy model
Date: Thu, 12 Mar 2009 12:32:04 -0300
Message-ID: <20090312123204.7d093fca@pedra.chehab.org>
References: <20090312161551.51ee067f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090312161551.51ee067f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Thu, 12 Mar 2009 16:15:51 +0100
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> As suggested by Mauro Carvalho Chehab.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> ---
>  Documentation/feature-removal-schedule.txt |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.29-rc7.orig/Documentation/feature-removal-schedule.txt	2009-03-12 08:48:06.000000000 +0100
> +++ linux-2.6.29-rc7/Documentation/feature-removal-schedule.txt	2009-03-12 16:07:35.000000000 +0100
> @@ -311,7 +311,8 @@ Who:  Krzysztof Piotr Oledzki <ole@ans.p
>  ---------------------------
>  
>  What:	i2c_attach_client(), i2c_detach_client(), i2c_driver->detach_client()
> -When:	2.6.29 (ideally) or 2.6.30 (more likely)
> +When:	2.6.30

There are still some legacy v4l drivers that uses those functions. I'm not sure
if there are enough time to convert all of them in time for 2.6.30 merge
window.

Those directly references i2c_attach_client:
	ir-kbd-i2c.c, ov7670.c, v4l2-common.c

And those are using the legacy I2C header, created by Hans:
	cs53l32a.c, cx25840-core.c, msp3400-driver.c, saa6588.c, saa7115.c, tda7432.c
	tda9875.c, tuner-core.c, tvaudio.c, tvp5150.c, wm8775.c

This plus the I2C buses that requires those drivers.

Depending on the time Linus releases 2.6.29, it would probably be more
realistic to schedule it to 2.6.31.

> +Check:	i2c_attach_client i2c_detach_client

OK.

Cheers,
Mauro
