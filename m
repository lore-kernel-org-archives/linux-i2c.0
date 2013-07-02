From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c_mxs: Set ACK_MODE bit
Date: Tue, 2 Jul 2013 15:45:37 -0300
Message-ID: <51D31FD1.4080002@freescale.com>
References: <1372780860-12972-1-git-send-email-fabio.estevam@freescale.com> <20130702181115.GR27010@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130702181115.GR27010-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, cb-/RsSufbtIHM@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

On 07/02/2013 03:11 PM, Uwe Kleine-K=F6nig wrote:
> On Tue, Jul 02, 2013 at 01:01:00PM -0300, Fabio Estevam wrote:
>> According to mx23 erratum 2727:
>>
>> "2727 : I2C 9th Clock Pulse (ACK) not generated when RETAIN_CLOCK se=
t.
>>
>> Description:
>>
>> When RETAIN_CLOCK is set, the ninth clock pulse (ACK) is not generat=
ed.
>> However, the SDA line is read at the proper timing interval. If
>> RETAIN_CLOCK is cleared, the ninth clock pulse is generated.
>> Also, the HW_I2C_VERSION register incorrectly states the version is =
1.2.
>> It should be 1.3.
>>
>> Workaround:
>> HW_I2C_CTRL1[ACK_MODE] has default value of 0. It should be set to 1=
 to
>> enable the fix for this issue."
>>
>> It has also been noticed that mx28 needs to implement this fix in or=
der to have
>> SMBus to work properly.
>>
>> Reported-by: Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>
>> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Did you see this making the driver handle some situations that caused
> failure before?

No, I haven't. I saw the report from Christoph in the linux-arm-kernel
mailing list:
http://marc.info/?l=3Dlinux-arm-kernel&m=3D137277422127826&w=3D2

And thought it could be nice if we could get it fixed for mx23 and mx28=
=2E

>
>> ---
>>   drivers/i2c/busses/i2c-mxs.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-m=
xs.c
>> index 6d8094d..ce7ac86 100644
>> --- a/drivers/i2c/busses/i2c-mxs.c
>> +++ b/drivers/i2c/busses/i2c-mxs.c
>> @@ -56,6 +56,7 @@
>>   #define MXS_I2C_CTRL1_CLR	(0x48)
>>
>>   #define MXS_I2C_CTRL1_CLR_GOT_A_NAK		0x10000000
>> +#define MXS_I2C_CTRL1_ACK_MODE			0x08000000
>>   #define MXS_I2C_CTRL1_BUS_FREE_IRQ		0x80
>>   #define MXS_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ	0x40
>>   #define MXS_I2C_CTRL1_NO_SLAVE_ACK_IRQ		0x20
>> @@ -140,6 +141,14 @@ static void mxs_i2c_reset(struct mxs_i2c_dev *i=
2c)
>>   	writel(0x00300030, i2c->regs + MXS_I2C_TIMING2);
>>
>>   	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
>> +
>> +	/*
>> +	 * According to mx23 erratum 2727:
>> +	 * "I2C 9th Clock Pulse (ACK) not generated when RETAIN_CLOCK set"
>> +	 *
>> +	 * HW_I2C_CTRL1[ACK_MODE] needs to be set when RETAIN_CLOCK is set=
=2E
>> +	 */
>> +	writel(MXS_I2C_CTRL1_ACK_MODE, i2c->regs + MXS_I2C_CTRL1_SET);
> So you set this bis in the reset routine. The first thing in
> mxs_i2c_pio_setup_xfer is however:
>
> 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_CLR);
>
> which unsets the ACK_MODE bit. Also when reading the docs I couldn't

Not really. This write is via MXS_I2C_CTRL1_CLR register and does not=20
touch the ACK_MODE bit. Keep in mind that mxs has separate registers=20
from write and read to same register.

> find out the motivation to set RETAIN_CLOCK at all in the select
> command.

I tried to not set RETAIN_CLOCK bit and the sgtl5000 codec failed to pr=
obe.

Regards,

=46abio Estevam
