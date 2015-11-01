From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 2/2] i2c: add driver for Sigma Designs SMP8642 I2C master
Date: Sun, 01 Nov 2015 13:12:11 +0000
Message-ID: <yw1x4mh5c190.fsf@unicorn.mansr.com>
References: <1446312957-18744-1-git-send-email-mans@mansr.com>
	<1446312957-18744-2-git-send-email-mans@mansr.com>
	<20151101064228.GA2010@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:38366 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895AbbKANMU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 1 Nov 2015 08:12:20 -0500
In-Reply-To: <20151101064228.GA2010@katana> (Wolfram Sang's message of "Sun, 1
	Nov 2015 07:42:29 +0100")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

> On Sat, Oct 31, 2015 at 05:35:57PM +0000, Mans Rullgard wrote:
>> This adds a driver for the Sigma Designs SMP8642 built-in I2C master
>> controller.  The hardware is very similar to the I2C controller in t=
he
>> Ralink RT3050 chip with the addition of interrupt generation and an
>> inverted busy/idle status bit.  There are typically two controllers =
with
>> a shared IRQ.
>>=20
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>
> Thanks for the driver. Same answer as here, though:
>
> http://www.spinics.net/lists/linux-i2c/msg17001.html
>
>> +#define TANGOX_I2C_CONFIG		0x00
>> +#define TANGOX_I2C_CLKDIV		0x04
>> +#define TANGOX_I2C_DEVADDR		0x08
>> +#define TANGOX_I2C_ADDR			0x0c
>> +#define TANGOX_I2C_DATAOUT		0x10
>> +#define TANGOX_I2C_DATAIN		0x14
>> +#define TANGOX_I2C_STATUS		0x18
>> +#define TANGOX_I2C_STARTXFER		0x1c
>> +#define TANGOX_I2C_BYTECNT		0x20
>> +#define TANGOX_I2C_INT_EN		0x24
>> +#define TANGOX_I2C_INT_STAT		0x28
>
> The register set looks like the one from i2c-xlr.c, only that they ar=
e
> 32 bit apart instead of 8. Can you check if you can reuse that driver=
?

It does look very similar indeed.  I thought I'd checked for an existin=
g
driver, but apparently I missed that one.  I'll modify the xlr driver t=
o
handle this hardware as well instead.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
