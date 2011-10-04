From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-algo-bit: Be verbose on bus testing failure
Date: Tue, 4 Oct 2011 09:22:31 -0400
Message-ID: <CADnq5_MeOx3MT7B8d_2bkQyoeG6Z9FvixwdQO1cpWL=mttmtTw@mail.gmail.com>
References: <201110041445.57054.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201110041445.57054.jdelvare-l3A5Bk7waGM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 4, 2011 at 8:45 AM, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> wrote:
> If bus testing fails due to the bus being seen as busy, it might be
> helpful for developers to know which line is unexpectedly low.
>
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Reviewed-by: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
> =A0drivers/i2c/algos/i2c-algo-bit.c | =A0 =A04 +++-
> =A01 file changed, 3 insertions(+), 1 deletion(-)
>
> --- linux-3.0.orig/drivers/i2c/algos/i2c-algo-bit.c =A0 =A0 2011-10-0=
3 18:50:34.000000000 +0200
> +++ linux-3.0/drivers/i2c/algos/i2c-algo-bit.c =A02011-10-03 18:55:14=
=2E000000000 +0200
> @@ -250,7 +250,9 @@ static int test_bus(struct i2c_adapter *
> =A0 =A0 =A0 =A0sda =3D getsda(adap);
> =A0 =A0 =A0 =A0scl =3D (adap->getscl =3D=3D NULL) ? 1 : getscl(adap);
> =A0 =A0 =A0 =A0if (!scl || !sda) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: bus seems to b=
e busy\n", name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s: bus seems to be bus=
y (scl=3D%d, sda=3D%d)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name, scl, sda);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto bailout;
> =A0 =A0 =A0 =A0}
>
>
> --
> Jean Delvare
> Suse L3
>
