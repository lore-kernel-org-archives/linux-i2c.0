From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa: fix unbinding/rebinding of the device
Date: Tue, 15 Feb 2011 16:59:28 +0300
Message-ID: <AANLkTimO1KFNm5xZ+2qJoGQq-ndVg0ER3KKwf0RYYOLK@mail.gmail.com>
References: <20110106124028.GX25121@pengutronix.de>
	<1294502804-6580-1-git-send-email-dbaryshkov@gmail.com>
	<20110108161828.GC8237@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110108161828.GC8237-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello, all

2011/1/8 Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> On Sat, Jan 08, 2011 at 07:06:44PM +0300, Dmitry Eremin-Solenikov wro=
te:
>> When a "pxa2xx-i2c" device was unbound (e.g. via sysfs) the remove
>> callback was not called because it was discarded when linking the
>> kernel. =A0Because of that the resources allocated in probe were not
>> freed and so a clean unbind/rebind was impossible.
>>
>> Fix that by moving the remove callback to .devexit.text.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

I see this patch is still not pushed to neither linus nor linux-next.
Should I put it into rmk's patch system? Or will it find it's way to ma=
in kernel
via other paths?

>
> Thanks
> Uwe
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Uwe Kleine-K=F6nig =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>



--=20
With best wishes
Dmitry
