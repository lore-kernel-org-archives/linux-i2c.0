From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-algo-bit: Cleanup bus_test calling convention
Date: Fri, 15 Apr 2011 11:57:46 -0400
Message-ID: <BANLkTikBTN-3n0AUUxM2bgMKzME8zznycg@mail.gmail.com>
References: <20110415111323.51bef2ac@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110415111323.51bef2ac-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 15, 2011 at 5:13 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> Now that we pass the i2c_adapter as the first parameter, it makes
> little sense to pass its name separately as the second.
>
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Alex, I think it would make sense to merge this into your own patch?
>

Yeah, looks good to me.  Do you want to merge them or do you want me
to send new patch?

Reviewed-by: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> =A0drivers/i2c/algos/i2c-algo-bit.c | =A0 =A05 +++--
> =A01 file changed, 3 insertions(+), 2 deletions(-)
>
> --- linux-2.6.39-rc3.orig/drivers/i2c/algos/i2c-algo-bit.c =A0 =A0 =A0=
2011-04-15 10:47:39.000000000 +0200
> +++ linux-2.6.39-rc3/drivers/i2c/algos/i2c-algo-bit.c =A0 2011-04-15 =
11:05:09.000000000 +0200
> @@ -232,9 +232,10 @@ static int i2c_inb(struct i2c_adapter *i
> =A0* Sanity check for the adapter hardware - check the reaction of
> =A0* the bus lines only if it seems to be idle.
> =A0*/
> -static int test_bus(struct i2c_adapter *i2c_adap, char *name)
> +static int test_bus(struct i2c_adapter *i2c_adap)
> =A0{
> =A0 =A0 =A0 =A0struct i2c_algo_bit_data *adap =3D i2c_adap->algo_data=
;
> + =A0 =A0 =A0 const char *name =3D i2c_adap->name;
> =A0 =A0 =A0 =A0int scl, sda, ret;
>
> =A0 =A0 =A0 =A0if (adap->pre_xfer) {
> @@ -622,7 +623,7 @@ static int __i2c_bit_add_bus(struct i2c_
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0if (bit_test) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D test_bus(adap, adap->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D test_bus(adap);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
>
>
> --
> Jean Delvare
>
