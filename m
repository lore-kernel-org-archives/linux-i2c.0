From: Marco Costa <costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
Subject: Re: MAX1236 with smbus (CS5536 ACB0)
Date: Thu, 16 Oct 2008 15:29:48 -0300
Message-ID: <200810161529.48557.costa@gamic.com>
References: <48F2A270.8060307@leipzig.freifunk.net>
	<20081015101736.34e1c11e@hyperion.delvare>
	<gd8070$f4e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <gd8070$f4e$1@ger.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Sorry to intrude, but it seems that it is byte swapped.

> i get this values of channel 0:
>
> OV:	0x00f0 (11110000)
Correct: 0xF000 & ~0xF000 = 0x0000
> 1,6V:	0xaef5 (1010111011110101)
Correct: 0xf5ae & ~0xF000 = 0x05ae
> 3,2V:	0x5efb (101110111111011)
Correct: 0xfb5e & ~0xF000 = 0x0b5e

the second value is almost 2x the first, as I would expect

Regards,

Marco Costa

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
