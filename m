From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus driver)
Date: Thu, 2 Oct 2008 16:53:44 +0200
Message-ID: <20081002165344.4c01b392@hyperion.delvare>
References: <6601CF63C167F44A9A9E97E41EE4B16C902D37@CLUSTEREX.corporate.local>
	<20080926092846.63ac885a@hyperion.delvare>
	<6601CF63C167F44A9A9E97E41EE4B16C90304B@CLUSTEREX.corporate.local>
	<20080930092458.1c40edce@hyperion.delvare>
	<6601CF63C167F44A9A9E97E41EE4B16C90343A@CLUSTEREX.corporate.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <6601CF63C167F44A9A9E97E41EE4B16C90343A-5t2rvgrEeX4DiO1sSoDvakTPyXqlV3SlZkel5v8DVj8@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "Mortha, Prakash" <pmortha-UATguYvZg3tBDgjK7y7TUQ@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Prakash,

On Thu, 2 Oct 2008 09:52:42 -0400, Mortha, Prakash wrote:
> In the patch I sent to you, I used the approach where I need to send
> MSByte first and then LSByte for I2C_SMBUS_PROC_CALL case.
> 
> If we need to keep this in accordance with other cases, We need to
> interchange the below lines: ( in i2c-viapro.patch)
> 		outb_p((data->word & 0xff00) >> 8, SMBHSTDAT0);
> 		outb_p(data->word & 0xff, SMBHSTDAT1);

The SMBus specification says that LSB always goes first when sending or
receiving a 16-byte word. i2c-core and individual i2c bus drivers must
follow this specification, even though most I2C slave devices actually
transmit the MSB first. It is the responsibility of the I2C chip driver
(or user-space in the case of i2c-dev) to swap the bytes if needed. See
for example the lm75 driver.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
