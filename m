From: Douglas Gilbert <dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c-dev: Add support for I2C_M_RECV_LEN
Date: Thu, 05 Apr 2012 20:01:43 -0400
Message-ID: <4F7E3267.9040306@interlog.com>
References: <20120315180835.2e669111@endymion.delvare> <20120331081927.2438ea9e@endymion.delvare> <4F7CD11C.2090801@interlog.com> <20120405092422.453edecf@endymion.delvare>
Reply-To: dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120405092422.453edecf-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 12-04-05 03:24 AM, Jean Delvare wrote:
> Hi Douglas,
>
> On Wed, 04 Apr 2012 18:54:20 -0400, Douglas Gilbert wrote:
>> Sorry about the delay in responding. The patch didn't work
>> in the case of the Sonmicro SM130 RFID but I could see it was close.
>>
>> The correct response (for the SM130) when reading the firmware
>> version is this 10 byte response:
>>     08 81 49 32 43 20 32 2e 38 ff     ["I2C 2.8"]
>> so the count in the first byte excludes itself and the checksum
>> trailing byte. With the I2C_M_RECV_LEN patch I see this response:
>>     08 81 49 32 43 20 32 2e 00 00
>> so the count (leading) byte includes itself and makes no
>> provision for a checksum. [So 8 bytes are returned and the two
>> trailing zeros are just buffer pre-fill.]
>
> What value did you set msg->buf[0] to before calling? You were supposed
> to set it to 2 in your case, exactly because the driver can't guess how
> many extra bytes the chip will return, that aren't included in the byte
> count. Your results suggest that you let msg->buf[0] to 0.
>
> I've improved my patch to properly reject the transaction if buf[0] is
> not set properly. Please test and report.
>
>> You might argue that the I2C_M_RECV_LEN patch is sensible
>> and the SM130 is strange. My solution is to read 32 bytes
>> which is more than I ever expect.
>
> The SM130 is a bit strange but it should be supportable.
>
> * * * * *
>
> As the bus driver side implementation of I2C_M_RECV_LEN is heavily
> tied to SMBus, we can't support received length over 32 bytes, but
> let's at least support that.
>
> In practice, the caller will have to setup a buffer large enough to
> cover the case where received length byte has value 32, so minimum
> 32 + 1 = 33 bytes, possibly more if there is a fixed number of bytes
> added for the specific slave (for example a checksum.)

Jean,
Either I am misunderstanding how to use this new patch or it is
broken. After replacing the original patch with this one, setting
msg->buf[0] to 2, my test program only sees the first two bytes
of expected data:
   08 81
That is down from 8 bytes from the previous patch and 10 bytes
expected from the SM130.

Doug Gilbert


> Signed-off-by: Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Douglas Gilbert<dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
> ---
>   drivers/i2c/i2c-dev.c |   30 ++++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)
>
> --- linux-3.4-rc1.orig/drivers/i2c/i2c-dev.c	2012-04-02 17:16:53.000000000 +0200
> +++ linux-3.4-rc1/drivers/i2c/i2c-dev.c	2012-04-05 09:12:26.385033151 +0200
> @@ -265,19 +265,41 @@ static noinline int i2cdev_ioctl_rdrw(st
>
>   	res = 0;
>   	for (i = 0; i<  rdwr_arg.nmsgs; i++) {
> -		/* Limit the size of the message to a sane amount;
> -		 * and don't let length change either. */
> -		if ((rdwr_pa[i].len>  8192) ||
> -		    (rdwr_pa[i].flags&  I2C_M_RECV_LEN)) {
> +		/* Limit the size of the message to a sane amount */
> +		if (rdwr_pa[i].len>  8192) {
>   			res = -EINVAL;
>   			break;
>   		}
> +
>   		data_ptrs[i] = (u8 __user *)rdwr_pa[i].buf;
>   		rdwr_pa[i].buf = memdup_user(data_ptrs[i], rdwr_pa[i].len);
>   		if (IS_ERR(rdwr_pa[i].buf)) {
>   			res = PTR_ERR(rdwr_pa[i].buf);
>   			break;
>   		}
> +
> +		/*
> +		 * If the message length is received from the slave (similar
> +		 * to SMBus block read), we must ensure that the buffer will
> +		 * be large enough to cope with a message length of
> +		 * I2C_SMBUS_BLOCK_MAX as this is the maximum underlying bus
> +		 * drivers allow. The first byte in the buffer must be
> +		 * pre-filled with the number of extra bytes, which must be
> +		 * at least one to hold the message length, but can be
> +		 * greater (for example to account for a checksum byte at
> +		 * the end of the message.)
> +		 */
> +		if (rdwr_pa[i].flags&  I2C_M_RECV_LEN) {
> +			if (!(rdwr_pa[i].flags&  I2C_M_RD) ||
> +			    rdwr_pa[i].buf[0]<  1 ||
> +			    rdwr_pa[i].len<  rdwr_pa[i].buf[0] +
> +					     I2C_SMBUS_BLOCK_MAX) {
> +				res = -EINVAL;
> +				break;
> +			}
> +
> +			rdwr_pa[i].len = rdwr_pa[i].buf[0];
> +		}
>   	}
>   	if (res<  0) {
>   		int j;
>
>
