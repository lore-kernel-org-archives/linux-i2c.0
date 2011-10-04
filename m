From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-algo-bit: Let user test buses without failing
Date: Tue, 4 Oct 2011 09:22:12 -0400
Message-ID: <CADnq5_MQ4vw8EWCyy+NoDiw6yvFHg-KxaxYzD1XnLXn93a4yvg@mail.gmail.com>
References: <201110041444.51029.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201110041444.51029.jdelvare-l3A5Bk7waGM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 4, 2011 at 8:44 AM, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> wrote:
> Always failing to register I2C buses when the line testing fails is a
> little harsh. While such a failure is definitely a bug in the driver
> that exposes the affected I2C bus, things may still work fine if the
> missing initialization steps are done later, before the I2C bus is
> used. So it seems a better debugging tool to just report the test
> failure by default. I introduce bit_test=3D2 if anyone really misses =
the
> original behavior of bit_test=3D1.
>
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Reviewed-by: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


> ---
> =A0drivers/i2c/algos/i2c-algo-bit.c | =A0 =A06 +++---
> =A01 file changed, 3 insertions(+), 3 deletions(-)
>
> --- linux-3.0.orig/drivers/i2c/algos/i2c-algo-bit.c =A0 =A0 2011-07-2=
2 04:17:23.000000000 +0200
> +++ linux-3.0/drivers/i2c/algos/i2c-algo-bit.c =A02011-10-02 10:29:51=
=2E000000000 +0200
> @@ -47,8 +47,8 @@
> =A0/* ----- global variables ----------------------------------------=
----- =A0 =A0 =A0 =A0*/
>
> =A0static int bit_test; =A0 /* see if the line-setting functions work=
 =A0 =A0 =A0 */
> -module_param(bit_test, bool, 0);
> -MODULE_PARM_DESC(bit_test, "Test the lines of the bus to see if it i=
s stuck");
> +module_param(bit_test, bool, S_IRUGO);
> +MODULE_PARM_DESC(bit_test, "lines testing - 0 off; 1 report; 2 fail =
if stuck");
>
> =A0#ifdef DEBUG
> =A0static int i2c_debug =3D 1;
> @@ -624,7 +624,7 @@ static int __i2c_bit_add_bus(struct i2c_
>
> =A0 =A0 =A0 =A0if (bit_test) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D test_bus(adap);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bit_test >=3D 2 && ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
>
>
> --
> Jean Delvare
> Suse L3
>
