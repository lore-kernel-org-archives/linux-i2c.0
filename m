From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: I2C: Fix i2c fail problem when a process is terminated by a signal
 on octeon in 3.8
Date: Tue, 26 Feb 2013 15:07:46 -0800
Message-ID: <512D4042.7060303@caviumnetworks.com>
References: <EC.72.13994.FE02D215@epcpsbgx4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <EC.72.13994.FE02D215-hl5l+cwj/UQ8ySZrqMDKH/pXobYPEAuW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 02/26/2013 12:54 PM, =BC=DB=C0=BA=BA=C0 wrote:
> I've been debugging the abnormal operation of i2c on octeon.
> If a process is terminated by signal in the middle of i2c operation,
> next i2c read operation which is done by another process was failed.
> So i changed to ignore signal in the middle of i2c operation.
> After that the problem was not reproduced.
>=20

This is a known issue.  However I don't think the solution you have is
correct...

> Signed-off-by: EunBong Song <eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org=20
> <mailto:eunb.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>>
>=20
> diff -up drivers/i2c/busses/i2c-octeon.c{.orig,}
> --- drivers/i2c/busses/i2c-octeon.c.orig 2013-02-21 08:09:03.16801884=
3 -0800
> +++ drivers/i2c/busses/i2c-octeon.c 2013-02-21 08:09:38.344018898 -08=
00
> @@ -183,7 +183,7 @@ static irqreturn_t octeon_i2c_isr(int ir
>    struct octeon_i2c *i2c =3D dev_id;
>=20
>    octeon_i2c_int_disable(i2c);
> - wake_up_interruptible(&i2c->queue);
> + wake_up(&i2c->queue);
>=20
>    return IRQ_HANDLED;
>   }
> @@ -206,7 +206,7 @@ static int octeon_i2c_wait(struct octeon
>=20
>    octeon_i2c_int_enable(i2c);
>=20
> - result =3D wait_event_interruptible_timeout(i2c->queue,
> + result =3D wait_event_timeout(i2c->queue,

If the wait is not interruptible, I think you will not be able to 'kill
-9' a userspace process blocked here.

>           octeon_i2c_test_iflg(i2c),
>           i2c->adap.timeout);
>=20

The real solution is to move processing of the I2C protocol to a kernel
thread and communicate between the this thread and userspace via a
command queue mechanism, much like the way it is done in the mmc/host
driver infrastructure.

David Daney
