From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Add support SuperH SH7734 I2C bus controller
Date: Fri, 13 Apr 2012 20:05:52 +0900
Message-ID: <CABMQnVK8Jt1cZZA-w9xnfrMZNvRbe4r+Sjm3YeF3o6utX0g93Q@mail.gmail.com>
References: <1334188641-14641-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <87d37d37ml.wl%kuninori.morimoto.gx@renesas.com> <CABMQnVKQAfdnQ+CfSuYSXQHmOyjQzPzngzTVLm6an2-haQAKZg@mail.gmail.com>
 <87y5q02cv2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87y5q02cv2.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-SH <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

2012/4/13 Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>:
>
> Hi Iwamatsu-san
>
>> Well, the SH-NAVI series hss I2C.
>> However, I assume it support only for SH7734 because bus width and
>> register constitution are different.
>> If you point it out about R-Car, I will examine R-Car. (R-Car is not SH-NAVI).
>
> I guess R-Car is not same as this I2C.
> And sorry, SH7734 seems not same as SH-NAVI.
> Now I'm checking the series.
> Please wait.
>

I already checked SH7775 and SH7776. These are SH-NAVI series.
But these CPU's are constitution unlike I2C of SH7734.

Best regards,
  Nobuhiro
-- 
Nobuhiro Iwamatsu
