From: Sundar <sunder.svit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drivers: misc: ak8974 / ami305 magnetometer driver
Date: Sat, 28 Aug 2010 21:40:55 +0530
Message-ID: <AANLkTim=Zq7Pxixdwe_H-659cLZ2yybediDURGwvoO3=@mail.gmail.com>
References: <1282910083-8629-1-git-send-email-samu.p.onkalo@nokia.com>
	<1282910083-8629-2-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1282910083-8629-2-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Samu,

few minor comments,

On Fri, Aug 27, 2010 at 5:24 PM, Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> =
wrote:
> +
> +struct ak8974_chip {
> + =A0 =A0 =A0 struct miscdevice =A0 =A0 =A0 miscdev;
> + =A0 =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0lock; =A0 /* Serial=
ize access to chip */
> + =A0 =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0users_lock;
> + =A0 =A0 =A0 struct i2c_client =A0 =A0 =A0 *client;
> + =A0 =A0 =A0 struct regulator_bulk_data regs[2];
> + =A0 =A0 =A0 struct work_struct =A0 =A0 =A0work;
> + =A0 =A0 =A0 wait_queue_head_t =A0 =A0 =A0 misc_wait;
> + =A0 =A0 =A0 loff_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0offset;
> +
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_range;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 users;
> +
> + =A0 =A0 =A0 const char =A0 =A0 =A0 =A0 =A0 =A0 =A0*id;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info[2];
> +
> + =A0 =A0 =A0 s16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 x, y, z; /*=
 Latest measurements */
> + =A0 =A0 =A0 s8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0axis_x;
> + =A0 =A0 =A0 s8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0axis_y;
> + =A0 =A0 =A0 s8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0axis_z;
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0valid;
> +
> + =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name[20];
> +};

This can be static ?

> +
> + =A0 =A0 =A0 ak8974_regulators_off(chip);
> +

[..]

> + =A0 =A0 =A0 if (err < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&chip->client->dev, "Device reg=
istration failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
> + =A0 =A0 =A0 }

[..]

> + =A0 =A0 =A0 return 0;
> +fail4:
> + =A0 =A0 =A0 misc_deregister(&chip->miscdev);
> +fail3:
> + =A0 =A0 =A0 ak8974_regulators_off(chip);

in case of fail3, regulators get disabled twice. i think we will have
unbalanced calls to the supplies then.

> +
> +
> +#ifdef CONFIG_PM
> +static int ak8974_suspend(struct i2c_client *client, pm_message_t me=
sg)
> +{
> + =A0 =A0 =A0 struct ak8974_chip *chip =3D i2c_get_clientdata(client)=
;
> + =A0 =A0 =A0 mutex_lock(&chip->users_lock);
> + =A0 =A0 =A0 if (chip->users > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ak8974_enable(chip, AK8974_PWR_OFF);
> + =A0 =A0 =A0 mutex_unlock(&chip->users_lock);
> + =A0 =A0 =A0 return 0;
> +}

Can we disable the regulators here too?

Regards,
Sundar
