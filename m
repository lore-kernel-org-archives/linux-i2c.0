From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: FW: HELP ME! DM355 EVM MT9T001 question!
Date: Tue, 2 Sep 2008 09:15:32 +0200
Message-ID: <20080902091532.0f4319ad@hyperion.delvare>
References: <rUwzhhPSZ00096e49@blu0-omc2-s21.blu0.hotmail.com>
	<BLU111-W21AE70F6BF9A6CFACB1D7AB7600@phx.gbl>
	<AEA06231B7D16F4CA77C0C1550F3D73005DDD727@sin2apfpew01.ap.sanm.corp>
	<BLU111-W438DFF6CC1D3E1028E9BB1B7600@phx.gbl>
	<bfd52c5b0808280642o5d30b0f1g77240bd5e0165b16@mail.gmail.com>
	<BLU111-W4910427AB2C320E39BF04CB75C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <BLU111-W4910427AB2C320E39BF04CB75C0-MsuGFMq8XAE@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: xiaowinky <nanguangzhixing-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2 Sep 2008 01:35:00 +0800, xiaowinky wrote:
> hi,all!
>   I use the i2c-tools-3.0.1 tool to compile and  install in DM355 EVM kernel,

Which kernel version are you using?

> For example with orders #i2cdetect 0,
> prompts following information:
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c/0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]

What is the output of this command?

> Then the basis bus address range 0x03-0x07,orders the test with below:
> #i2cdump 0 0x03-0x77,
> only 0x5D and 0x1B two bus addresses are effective, For example # i2cdump 0 0x5d
> prompt the information to be as follows:
> No size specified (using byte-data access)
> Error: Could not set address to 0x5d: Device or resource busy

This means that there's already a kernel driver bound to this device.
To find out which it is, you can follow the driver link
in /sys/bus/i2c/devices/0-005d.

To solve this, you can either unload the driver in question (with
rmmod), or you can pass option "-f" to i2cdump to force i2c-dev to
access the device even though it is busy. But beware that this might
confuse the kernel driver that is bound to the device, so this is
generally discouraged.

>  
> Other bus address is invalid, For example : # i2cdump 0 0x3a
> prompts the information to be as follows:
>  No size specified (using byte-data access)
>  WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c/0, address 0x3a, mode byte
> Continue? [Y/n]
>  
> Whether only  0x5D and the 0xB1 two device address  hang on the I2C bus ???

I don't understand this question, sorry. Please rephrase in proper
English.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
