From: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: Re: [PATCH 3/7] i2c-eg20t: delete 10bit access processing
Date: Tue, 27 Sep 2011 09:05:12 +0900
Message-ID: <4E811338.2030005@dsn.okisemi.com>
References: <1316591509-4433-1-git-send-email-tomoya-linux@dsn.okisemi.com> <1316591509-4433-3-git-send-email-tomoya-linux@dsn.okisemi.com> <B6A520E9CD57404AAFC0831E4FB39541A98073AC7E@IRVEXCHCCR02.corp.ad.broadcom.com> <4E7A7DBA.3020406@dsn.okisemi.com> <B6A520E9CD57404AAFC0831E4FB39541A98073AF26@IRVEXCHCCR02.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B6A520E9CD57404AAFC0831E4FB39541A98073AF26-4wnuKdaqIVJdD26/7+am4baTQr+y5IJFqs7JOtOhHmkAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jeffrey (Sheng-Hui) Chu" <jeffchu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org" <toshiharu-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, Aaron Smith <aarons-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

(2011/09/23 2:49), Jeffrey (Sheng-Hui) Chu wrote:
> The device is BCM20791.  Please contact Aaron Smith (aarons-dY08KVG/lbpWk0Htik3J/w@public.gmane.org) for evaluation.
Though googling the device, I can't find the device.
Broadcom website too.

>
> By the way, the existing handling of 10-bit address in the patch you intended to delete does not work.  You'll need to fix that before you can test with the device successfully.
>
> For the write operation, it's a easy fix:
>
> @@ -410,25 +408,16 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
>   	}
>
>   	if (msgs->flags&  I2C_M_TEN) {
> -		addr_2_msb = ((addr&  I2C_MSB_2B_MSK)>>  7);
> +		addr_2_msb = ((addr&  I2C_MSB_2B_MSK)>>  7)&  0x06;
>
>
> For the read operation, static s32 pch_i2c_readbytes(), you'll need to do a write followed by a restart and a read...  please refer to the i2c spec...
>
> Regards,

Thank you for your indication.
We will update this after supporting 10bit access.

Thanks,
tomoya
