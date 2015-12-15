From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 2/3] i2c: xlr: fix extra read/write at end of rx transfer
Date: Tue, 15 Dec 2015 12:48:06 +0000
Message-ID: <yw1x4mfjho8p.fsf@unicorn.mansr.com>
References: <1446429818-24155-1-git-send-email-mans@mansr.com>
	<1446429818-24155-2-git-send-email-mans@mansr.com>
	<20151215122119.GB1521@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151215122119.GB1521@katana> (Wolfram Sang's message of "Tue,
	15 Dec 2015 13:21:19 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

> On Mon, Nov 02, 2015 at 02:03:37AM +0000, Mans Rullgard wrote:
>> The BYTECNT register holds the transfer size minus one.  Setting it
>> to the correct value requires a dummy read/write only for zero-lengt=
h
>> transfers as it is impossible to request one from the hardware.  If =
a
>> zero-length transfer is requested, changing the length to 1 and sett=
ing
>> "buf" to a dummy location allows making the main loops less convolut=
ed.
>>=20
>> In other words, this patch makes the driver transfer the number of b=
ytes
>> requested unless this is zero, which is not supported by the hardwar=
e,
>> in which case one byte is transferred instead.
>
> Uh, this is wrong, zero byte should really not transfer anything. We
> need to fix that and bail out, so probably something like
>
> 	if (!len)
> 		return -EOPNOTSUPP;

So the existing driver is wrong to allow it.  Makes sense to drop that.

> Also, the xlr_func() should mask out I2C_FUNC_SMBUS_QUICK.

OK.

> Other than that, the patch looks good to me.
>
> Out of curiosity, your first driver had the registers 32bit apart. No=
w
> you can deal with 8bit. Is this configurable on this SoC?

It's all 32 bits.  The XLR driver uses a u32 * to access the registers.

--=20
M=E5ns Rullg=E5rd
