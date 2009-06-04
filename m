From: Minkyu Kang <promsoft-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] add MAX17040 Fuel Gauge driver
Date: Thu, 4 Jun 2009 19:47:43 +0900
Message-ID: <1f3430fb0906040347m1079def5j7d820e18a9375eaa@mail.gmail.com>
References: <4A278C08.5000206@samsung.com>
	 <5d5443650906040216h2314b7bbt1ae2e89c709b566e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5d5443650906040216h2314b7bbt1ae2e89c709b566e-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi, Trilok

> Adding linux-i2c mailing list, so not deleting any code.

Ok, I will.

>> +static struct max17040_chip *max17040;
>> +static struct max17040_platform_data *pdata;
>
> May be you want to move this pdata under chip structure.
>
>> +       i2c_set_clientdata(client, chip);
>
> Please add i2c_check_functionality check before doing any smbus
> read/write operations.
>

Ok, that's better.

>> + =A0 =A0 =A0 max17040 =3D chip;
>
> This means that we support only one instance of this chip, right?
>

Yes right.. but, I think that is not a good way.
I'll modify it, too. thanks :)


--=20
from. prom.
promsoft.net
