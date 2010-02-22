From: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Mon, 22 Feb 2010 18:12:41 +0200
Message-ID: <af0693f01002220812n5a6060cejc00d1ebbd7b9424d@mail.gmail.com>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	 <20100128085904.4e202de1@hyperion.delvare>
	 <af0693f01001280132l4002af0fgf3137fa27ce8555e@mail.gmail.com>
	 <20100128105340.41aecf64@hyperion.delvare>
	 <af0693f01002182310i6678e4b5h80feb14b24b37742@mail.gmail.com>
	 <20100219105841.2bd8b16c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100219105841.2bd8b16c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean/i2c guys,

I'm having hard time to send straight I2C transaction of arbitrary leng=
th.
I use i2c_smbus_write_i2c_block_data(fd, buf[0], datac - 1, &buf[1]);
from user-space to send the aforementioned transaction, but I get
operation not permitted as a result.
I tried to understand what's going on in the driver and found out that
timeout occurs.

As a consequence, I'd like to get something clear to me:
Since ICH9 supports 32-Byte Buffer (E32B) and according to the data
sheet the DS bit of the HST_STS is meaningless when E32B is enabled
and it's (E32B) enabled by the i801 driver.
On the other hand, in i801_check_pre called (from
i801_block_transaction_by_block) the macro STATUS_FLAGS verifies the
DS bit (designated as SMBHSTSTS_BYTE_DONE in the code).
Looking at the previous version of the driver, like in 2.5.25 there
was a mask 0x1f but it has gone since.
Is this behavior correct?

And another question related. Have you/anyone tried to output I2C
write transaction of arbitrary length, i.e. DATA0 is not sent on the
bus, from ICH9?

Thank you in advance,
=46elix R.


On Fri, Feb 19, 2010 at 11:58 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wro=
te:
> Hi Felix,
>
> On Fri, 19 Feb 2010 09:10:03 +0200, Felix Rubinstein wrote:
>> Does ICHx support straight I2C read of arbitrary length, i.e. withou=
t doing
>> write first?
>
> No, it doesn't. The only straight read lengths supported are 0 byte
> (SMBus quick command) and 1 byte (SMBus receive byte).
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
