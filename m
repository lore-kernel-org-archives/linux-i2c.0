From: Minkyu Kang <promsoft-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] add MAX17040 Fuel Gauge driver
Date: Thu, 4 Jun 2009 19:55:13 +0900
Message-ID: <1f3430fb0906040355y21d5c8d1u4133dd8f7f4e9d70@mail.gmail.com>
References: <4A278C08.5000206@samsung.com>
	 <5d5443650906040216h2314b7bbt1ae2e89c709b566e@mail.gmail.com>
	 <20090604113504.5370775b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090604113504.5370775b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear, Jean Delvare

>
> In case of error, this will wrap the error code into a u8 and the
> caller won't notice. So you'll return a random value, depending on th=
e
> actual error which happened. No good.
>
> You should either return an int there, and have the caller check for
> errors, or if you don't want to care about errors, return an arbitrar=
y
> value on error (e.g. 0.)
>

Yes, I missed it.

>> > + =A0 =A0 =A0 ret =3D power_supply_register(&client->dev, &bat_ps)=
;
>> > + =A0 =A0 =A0 if (ret) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&max17040->client->dev,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "fai=
led: power supply register\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&chip->work);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(chip);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max17040 =3D NULL;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>
> Please come up with a better error code.
>

Ok, many thanks :)

--=20
from. prom.
promsoft.net
