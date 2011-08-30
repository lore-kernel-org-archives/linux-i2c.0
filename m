From: Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] misc: Remove obsolete cleanup for clientdata
Date: Tue, 30 Aug 2011 09:47:56 +0900
Message-ID: <CAH9JG2XD_8_Vj9t-yN57VsPtCgo84FDLD7VmVwTM3+cNzKvAug@mail.gmail.com>
References: <1314269645-18607-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1314269645-18607-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Donggeun Kim <dg77.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Acked-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

On Thu, Aug 25, 2011 at 7:54 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> w=
rote:
> A few new i2c-drivers came into the kernel which clear the clientdata=
-pointer
> on exit or error. This is obsolete meanwhile, the core will do it.
>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
> Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Donggeun Kim <dg77.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> =A0drivers/misc/fsa9480.c | =A0 =A02 --
> =A01 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/fsa9480.c b/drivers/misc/fsa9480.c
> index 5325a7e..22e22ad 100644
> --- a/drivers/misc/fsa9480.c
> +++ b/drivers/misc/fsa9480.c
> @@ -457,7 +457,6 @@ fail2:
> =A0 =A0 =A0 =A0if (client->irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(client->irq, NULL);
> =A0fail1:
> - =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
> =A0 =A0 =A0 =A0kfree(usbsw);
> =A0 =A0 =A0 =A0return ret;
> =A0}
> @@ -467,7 +466,6 @@ static int __devexit fsa9480_remove(struct i2c_cl=
ient *client)
> =A0 =A0 =A0 =A0struct fsa9480_usbsw *usbsw =3D i2c_get_clientdata(cli=
ent);
> =A0 =A0 =A0 =A0if (client->irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(client->irq, NULL);
> - =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
>
> =A0 =A0 =A0 =A0sysfs_remove_group(&client->dev.kobj, &fsa9480_group);
> =A0 =A0 =A0 =A0device_init_wakeup(&client->dev, 0);
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
