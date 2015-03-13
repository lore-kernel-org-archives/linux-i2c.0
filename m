From: "Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/5] i2c: recovery: change input parameter to i2c_adapter
 for prepare/unprepare_recovery
Date: Fri, 13 Mar 2015 12:15:54 +0200
Message-ID: <5502B8DA.70504@linaro.org>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com> <1417448047-15236-4-git-send-email-grygorii.strashko@ti.com> <55017943.6040603@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55017943.6040603-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 03/12/2015 01:32 PM, Alexander Sverdlin wrote:
> On 01/12/14 16:34, Grygorii Strashko wrote:
>> This patch changes type of input parameter for .prepare/unprepare_re=
covery()
>> callbacks from struct i2c_bus_recovery_info * to struct i2c_adapter =
*.
>> This allows to simplify implementation of these callbacks and avoid
>> type conversations from i2c_bus_recovery_info to i2c_adapter.
>> The i2c_bus_recovery_info can be simply retrieved from struct i2c_ad=
apter
>> which contains pointer on it.
>>
>> CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>> CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/i2c/i2c-core.c | 4 ++--
>>   include/linux/i2c.h    | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 2f90ac6..72b6e34 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -563,7 +563,7 @@ static int i2c_generic_recovery(struct i2c_adapt=
er *adap)
>>   	int i =3D 0, val =3D 1, ret =3D 0;
>>  =20
>>   	if (bri->prepare_recovery)
>> -		bri->prepare_recovery(bri);
>> +		bri->prepare_recovery(adap);
>>  =20
>>   	/*
>>   	 * By this time SCL is high, as we need to give 9 falling-rising =
edges
>> @@ -588,7 +588,7 @@ static int i2c_generic_recovery(struct i2c_adapt=
er *adap)
>>   	}
>>  =20
>>   	if (bri->unprepare_recovery)
>> -		bri->unprepare_recovery(bri);
>> +		bri->unprepare_recovery(adap);
>>  =20
>>   	return ret;
>>   }
>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>> index b556e0a..cf9380f 100644
>> --- a/include/linux/i2c.h
>> +++ b/include/linux/i2c.h
>> @@ -404,8 +404,8 @@ struct i2c_bus_recovery_info {
>>   	void (*set_scl)(struct i2c_adapter *, int val);
>>   	int (*get_sda)(struct i2c_adapter *);
>>  =20
>> -	void (*prepare_recovery)(struct i2c_bus_recovery_info *bri);
>> -	void (*unprepare_recovery)(struct i2c_bus_recovery_info *bri);
>> +	void (*prepare_recovery)(struct i2c_adapter *);
>> +	void (*unprepare_recovery)(struct i2c_adapter *);
>>  =20
>>   	/* gpio recovery */
>>   	int scl_gpio;
>>
>=20
> Acked-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>=20

Could I ask you to consider this patch for 4.1?
Now my I2C Davinci series is based on it and probably I2C OMAP changes
will need to be based on it too - if Felipe would agree with this of co=
urse.

regards,
-grygorii


--=20
regards,
-grygorii
