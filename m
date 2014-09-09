From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-mxs: fixed PIO NACK error instead of timeout
Date: Tue, 09 Sep 2014 11:27:36 +0200
Message-ID: <540EC808.6060407@elproma.com.pl>
References: <540DEFA6.9030600@elproma.com.pl> <540DF014.5000508@elproma.com.pl> <201409082033.58959.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201409082033.58959.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

W dniu 2014-09-08 20:33, Marek Vasut pisze:
> On Monday, September 08, 2014 at 08:06:12 PM, Janusz U=C5=BCycki wrot=
e:
>> Subject: [PATCH 2/2] i2c-mxs: fixed PIO NACK error instead of timeou=
t
>>    (1000ms)
>>
>> i2cdetect scanned i2c bus very slow if address was not occupied by a=
ny
>> device.
> Shouldn't this check be used only after the 'SELECT' command ?
It looks |||mxs_i2c_isr()| for DMA transfer does not differentiate=20
commands also
and does not mask irqs for each command.

|STAT_GOT_A_NAK|  is a separate bit.|CTRL1_NO_SLAVE_ACK_IRQ can be set
both after SELECT and WRITE command. Should we differentiate?
|

|Checking CTRL1_NO_SLAVE_ACK_IRQ |bit for SELECT command will increase=20
code size only
without special profit. Current PIO implementation also gathers all err=
ors
together and reads them on the end by mxs_i2c_pio_check_error_state().
Probably mxs_i2c_pio_check_error_state() call or
enabling interrupt masks for PIO could be better than
direct |CTRL1_NO_SLAVE_ACK_IRQ |bit checking for clear code.
It also could support multimaster for PIO (MASTER_LOSS).

best regards
Janusz

Signed-off-by: Janusz Uzycki <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
---
   drivers/i2c/busses/i2c-mxs.c | 3 +++
   1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.=
c
index 87ee72d..b498708 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -307,6 +307,9 @@ static int mxs_i2c_pio_wait_xfer_end(struct
mxs_i2c_dev *i2c)
          unsigned long timeout =3D jiffies + msecs_to_jiffies(1000);

          while (readl(i2c->regs + MXS_I2C_CTRL0) & MXS_I2C_CTRL0_RUN) =
{
+               /*int ret =3D mxs_i2c_pio_check_error_state(i2c);*/
+               if (readl(i2c->regs + MXS_I2C_CTRL1) & MXS_I2C_CTRL1_NO=
_SLAVE_ACK_IRQ)
+                       return -ENXIO;
                  if (time_after(jiffies, timeout))
                          return -ETIMEDOUT;
                  cond_resched();
--
1.7.11.3
