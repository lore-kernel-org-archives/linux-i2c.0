From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH 4/8] i2c: i2c-bfin-twi: Tighten condition when failing
 I2C transfer if MEN bit is reset unexpectedly.
Date: Thu, 17 May 2012 22:41:21 -0400
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D16F64F8527E@NWD2CMBX1.ad.analog.com>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
	<1337152826-9850-4-git-send-email-sonic.zhang@analog.com>
 <CAM=Q2cta_a2XcOLoOnnUUjZOpj1phUH99xfgZnh4nhxG8QX3-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAM=Q2cta_a2XcOLoOnnUUjZOpj1phUH99xfgZnh4nhxG8QX3-Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>
List-Id: linux-i2c@vger.kernel.org



>-----Original Message-----
>From: Shubhrajyoti Datta [mailto:omaplinuxkernel@gmail.com]
>Sent: Thursday, May 17, 2012 7:31 PM
>To: Zhang, Sonic
>Cc: Ben Dooks; Wolfram Sang; linux-i2c@vger.kernel.org; LKML; uclinux-dist-
>devel@blackfin.uclinux.org
>Subject: Re: [PATCH 4/8] i2c: i2c-bfin-twi: Tighten condition when failing I2C
>transfer if MEN bit is reset unexpectedly.
>
>On Wed, May 16, 2012 at 12:50 PM,  <sonic.zhang@analog.com> wrote:
>> From: Sonic Zhang <sonic.zhang@analog.com>
>>
>> Correct I2C transfer may fail because interrupt status bits XMTSERV and
>> RCVSERV are not checked when MCOMP interrupt is handled.
>>
>Could you expand MCOMP?

Master transfer complete (MCOMP)
[1] The initiated master transfer has completed. In the absence of a
repeat start, the bus has been released.
[0] The completion of a transfer has not been detected.


Regards,

Sonic
