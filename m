From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [Resend Patch 7/9] I2C/ACPI: Add i2c ACPI operation region support
Date: Wed, 23 Apr 2014 09:53:21 +0800
Message-ID: <53571D11.3070808@intel.com>
References: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com> <1398147855-9868-1-git-send-email-tianyu.lan@intel.com> <1398147855-9868-8-git-send-email-tianyu.lan@intel.com> <20140422113638.GK30677@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20140422113638.GK30677@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: wsa@the-dreams.de, rjw@rjwysocki.net, awilliam@redhat.com, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Mika:
	Thanks a lot for your review.

On 2014=E5=B9=B404=E6=9C=8822=E6=97=A5 19:36, Mika Westerberg wrote:
>> > +
>> > +	client.adapter =3D adapter;
>> > +	client.addr =3D sb->slave_address;
>> > +	client.flags =3D 0;
> I'm not sure if this is the correct way to use struct i2c_client
> (allocating it from stack and passing forward to functions that might
> expect a real i2c_client structure). It has ->dev and all.

I check all i2c_smbus_xxx helper functions and they are simple wrappers
of i2c_smbus_xfer(). Only adapter, addr and flags of struct client are
used in these functions.

>=20
> I'm wondering if you can use i2c_transfer() and i2c_smbus_xfer() here
> instead, passing just the adapter pointer?
>=20

Yes, I can do that but this needs to copy all codes of i2c_smbus_xxx
helper function in the i2c-core.c here. This seems duplicated?

--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
