From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [patch v8 1/1] i2c: add master driver for mellanox systems
Date: Sun, 20 Nov 2016 05:52:56 +0000
Message-ID: <AM5PR0501MB2097315FB75BFEF681512187A2B20@AM5PR0501MB2097.eurprd05.prod.outlook.com>
References: <1479455458-157627-1-git-send-email-vadimp@mellanox.com>
 <20161119210444.GB2856@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0046.outbound.protection.outlook.com ([104.47.2.46]:16608
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750728AbcKTFxB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 20 Nov 2016 00:53:01 -0500
In-Reply-To: <20161119210444.GB2856@katana>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa-dev@sang-engineering.com]
> Sent: Saturday, November 19, 2016 11:05 PM
> To: Vadim Pasternak <vadimp@mellanox.com>
> Cc: wsa@the-dreams.de; linux-i2c@vger.kernel.org; linux-
> kernel@vger.kernel.org; jiri@resnulli.us; Michael Shych
> <michaelsh@mellanox.com>
> Subject: Re: [patch v8 1/1] i2c: add master driver for mellanox systems
>=20
> Hi,
>=20
> looks mostly good. I just found this comment which needs clarification:
>=20
> > +	/*
> > +	 * All upper layers currently are never use transfer with more than
> > +	 * 2 messages.
>=20
> Have you really checked ALL of the upper layers? And even if so, there is=
 the dev-
> interface to userspace which allows for arbitrary I2C transfers using I2C=
_RDWR.
>=20

We are using the next drivers on our switches: max11603, lm75, pmbus, mlxsw=
_minimal (last one is new, I wrote it to support Mellanox ASIC and it's has=
 32 byte limitation for I2C transaction chunk) and at24.

I am planning to add some code in the next patch, for handling bufferizatio=
n for message length greater then data buffer. Allowed by HW.

Possibly I should add validation for "num" parameter at the beginning of ml=
xcpld_i2c_xfer?

> >  Actually, it's also not so relevant in Mellanox systems
> > +	 * because of HW limitation.
>=20
> What kind of HW limitation do you mean here? Can Mellanox send more than
> two messages?
>=20
> > Max size of transfer is o more than 20B
>=20
> "is o more"? Typo?

Typo.
Max size of transfer is not more than 32 bytes.

>=20
> > +	 * in current x86 LPCI2C bridge.
>=20
> What does that mean in result?

In case more than 32 bytes of data length will be set in transaction, such =
message will fail length validation.
The 32 is HW limitation - 32 registers of DATAx.
In new version of LPCI2C logic, there is 64 registers, which can be used fo=
r data, and I am going to support it in next patch for this driver.

>=20
> Regards,
>=20
>    Wolfram

Thanks,

Vadim.
