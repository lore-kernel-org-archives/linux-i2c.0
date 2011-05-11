From: =?ISO-8859-1?Q?H=E5vard_Skinnemoen?= <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Adding the i2c-bit-platform bus
Date: Wed, 11 May 2011 10:10:33 -0700
Message-ID: <BANLkTi=OFhMwRRnYiHZyDBKB1QiG-0T6Tw@mail.gmail.com>
References: <BANLkTi=JtYdJr+0Dv32r-sCTgE-Eom2CJQ@mail.gmail.com>
	<20110510223556.GD634@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110510223556.GD634-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, May 10, 2011 at 3:35 PM, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> On Sat, May 07, 2011 at 02:53:05PM +0300, Eran Duchan wrote:
>> +static int __devinit i2c_bit_platform_probe(struct platform_device =
*pdev)
>> +{
>> + =A0 =A0 struct i2c_algo_bit_data *bit_data;
>> + =A0 =A0 struct i2c_adapter *adap;
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 if (pdev->dev.platform_data =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;
>
> minor point, this will probably not get shown by the bus layer.
> Not sure what's best here, some people don't like -ENOENT here.

I think ENXIO is fine though. Many drivers use it to indicate "I don't
have enough information to initialize this device".

Havard
