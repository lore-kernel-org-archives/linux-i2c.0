From: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: Fwd: [PATCH 3/4] i2c/au1550: increase timeout limit
Date: Mon, 18 Jul 2011 13:12:09 +0200
Message-ID: <CAOLZvyHy+GF+Aye6Ytw34dKx9zQs_-wXvrPwP-3AE-m3MPBZbA@mail.gmail.com>
References: <1310633815-18817-1-git-send-email-manuel.lauss@googlemail.com>
	<1310633815-18817-4-git-send-email-manuel.lauss@googlemail.com>
	<CAM=Q2csugEfNxLQ=byjqgWb4y34_AXqJJJay_kP6dfTHLUZTeA@mail.gmail.com>
	<4E23FD8A.50600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E23FD8A.50600-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 18, 2011 at 11:31 AM, Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> wr=
ote:
> Hi Manuel,
>>
>> From: *Manuel Lauss* <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
>> <mailto:manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>>
>> Date: Thu, Jul 14, 2011 at 2:26 PM
>> Subject: [PATCH 3/4] i2c/au1550: increase timeout limit
>> To: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> <mailto:linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
>> <mailto:ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>>
>> Cc: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
>> <mailto:manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>>
>>
>>
>> The timeout waiting for various events to occur is tailored for
>> a module clock of 50MHz. =A0On the DB1300 board only 48MHz can be
>> supplied to the i2c module, which results in the timeout aborting
>> complex transfers to slaves slightly too early if they employ
>> for example clock stretching.
>>
>> With this change the WM8731 codec on the DB1300 board is correctly
>> detected and initialized.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
>> <mailto:manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>>
>> ---
>> =A0drivers/i2c/busses/i2c-au1550.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-au1550.c
>> b/drivers/i2c/busses/i2c-au1550.c
>> index 98ee11a..36d1b29 100644
>> --- a/drivers/i2c/busses/i2c-au1550.c
>> +++ b/drivers/i2c/busses/i2c-au1550.c
>> @@ -344,7 +344,7 @@ i2c_au1550_probe(struct platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_map;
>> =A0 =A0 =A0 }
>> - =A0 =A0 =A0 priv->xfer_timeout =3D 200;
>> + =A0 =A0 =A0 priv->xfer_timeout =3D 400;
>
> What is the unit of the timeout. If it is in usec then how is it depe=
ndent
> on the clock
> supplied to the i2c module.
>
> Am I missing something.

It's used as a loop counter, with udelay()s in the various loops.
On the DB1300 board I observed that the function "wait_master_done()"
returns an error due to the loop counter reaching zero when accessing
the WM8731; an adm1025 hwmon actually works without this patch.
That timeout is more or less a safeguard against busy waiting forever
on various event bits.

Manuel
