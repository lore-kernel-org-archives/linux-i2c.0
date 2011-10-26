From: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] rtc-isl1208: Use SMBus functions if I2C isn't available
Date: Wed, 26 Oct 2011 07:55:22 -0500
Message-ID: <CAE7DoPZCC5H3C_5BP2f9PDEXgEqga2pqcVR5ANrRF=NpPQo3Ug@mail.gmail.com>
References: <1319596228-23318-1-git-send-email-gardner.ben@gmail.com>
	<4EA7C782.205@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4EA7C782.205-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jonathan,

Thanks for the review.

On Wed, Oct 26, 2011 at 3:40 AM, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org> wro=
te:
> On 10/26/11 03:30, Ben Gardner wrote:
>> The rtc-isl1208 driver currently depends on raw I2C functionality.
>> This patch adds a fall-back to SMBus functions so that the driver ca=
n be
>> used on a SMBus-only platforms, such as i2c-isch.
>>
> Perhaps a summary of how bad things would be if smbus were all that i=
s used?
> Afterall it is emulated on i2c buses if they don't support it directl=
y.

Read and writes to the RTC chip should be a very rare thing, so saving
a few cycles by using the native I2C block read/write seems less
important than being compatible.
Perhaps I should just switch it to using SMBus functions and eliminate
the I2C block ops altogether?

Anyone else have an opinion on this?

>> - =A0 =A0 ret =3D i2c_transfer(client->adapter, msgs, 2);
>> - =A0 =A0 if (ret > 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> It's a bit early in the morning, but at least at first glance I think
> this is an i2c_smbus_i2c_read_block_data reimplementation?

Do you mean i2c_smbus_read_i2c_block_data()?
That function is a bit different - it uses i2c_transfer() to emulate
the SMBus block read.
I'm not aware of any SMBus emulation of a I2C block read.

>> + =A0 =A0 if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)=
) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 u8 reg_addr[1] =3D { reg };
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct i2c_msg msgs[2] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {client->addr, 0, sizeof(r=
eg_addr), reg_addr}
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ,
> Odd spacing.

Sure is. It was that way in the original, but I guess I'll fix it. Or
eliminate it, if I remove I2C ops in the next version.

I'll await further comments and then repost in a day or so.

Thanks,
Ben
