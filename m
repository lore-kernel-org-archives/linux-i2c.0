From: Bryan Evenson <bevenson@melinkcorp.com>
Subject: RE: Error using at91-i2c driver in kernel 4.4.x
Date: Thu, 25 May 2017 14:23:18 +0000
Message-ID: <DM5PR05MB295427B6F98489CC339B7257BBFF0@DM5PR05MB2954.namprd05.prod.outlook.com>
References: <DM5PR05MB2954708999EFB8F1B593BC93BBFE0@DM5PR05MB2954.namprd05.prod.outlook.com>
 <DM5PR05MB29541B7EC525C8438538352ABBFE0@DM5PR05MB2954.namprd05.prod.outlook.com>
 <20170524230708.GA1456@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:43680
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935055AbdEYOXa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 May 2017 10:23:30 -0400
In-Reply-To: <20170524230708.GA1456@katana>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>


> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: Wednesday, May 24, 2017 7:07 PM
> To: Bryan Evenson <bevenson@melinkcorp.com>
> Cc: linux-i2c@vger.kernel.org; Ludovic Desroches
> <ludovic.desroches@atmel.com>
> Subject: Re: Error using at91-i2c driver in kernel 4.4.x
>=20
> > As usual, five minutes after I ask a question I get further.  I tried
> > changing the ioctl to I2C_SLAVE_FORCE, and now I can talk to my
> > EEPROM.  I'm happy it's now working, but I'm concerned about why I now
> > need to force the slave address.  Is this because I now need to set
> > things up differently, or is it a problem with the driver?
>=20
> From userspace, you cannot access an I2C client which has a kernel
> driver bound to it unless you use I2C_SLAVE_FORCE. And you really should
> not do that because you could confuse the kernel driver.
>=20
> Your old kernel probably did not bind a driver to the EEPROM, so you
> could access it from userspace.
>=20
> Since your DT now describes the EEPROM, why don't you simply access the
> 'eeprom' file in sysfs?

I didn't realize that option now existed for me.  I verified that with my o=
lder kernel the 'eeprom' file doesn't exist in sysfs, but it does with the =
newer kernel.  I'll leave the old method in place as backup but will defaul=
t to reading from the eeprom file.

Thanks,
Bryan
