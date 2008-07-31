From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers
	configurable via FDT
Date: Thu, 31 Jul 2008 14:30:34 -0600
Message-ID: <fa686aa40807311330u6858ae60haadf3c4d5996100e@mail.gmail.com>
References: <4889EFFE.2070201@grandegger.com> <489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
	<48921187.1090101@grandegger.com> <48921179.1080403@freescale.com>
	<48921888.3020900@grandegger.com> <48921954.4020103@freescale.com>
	<48921DED.6010403@grandegger.com> <48921E44.7010502@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48921E44.7010502-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 31, 2008 at 2:19 PM, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> Wolfgang Grandegger wrote:
>
>> I'm a bit confused. The frequency of the I2C source clock and the real
>> I2C clock frequency are two different things.
>
> There are two frequencies:
>
> 1) The frequency of the input clock to the I2C device, after it has gone through
> a divider.  This is what I call the "I2C clock frequency" and what I think
> belongs in the clock-frequency property.  This is usually the platform clock
> divided by 1, 2, or 3.
>
> 2) The speed of the I2C bus, as seen by devices on that bus.  This is usually
> 400KHz.

analogous example: serial nodes use two properties; "clock-frequency"
and "current-speed", one for clock frequency routed into the device
and one for the current baud rate.  It is completely relevant to put
the effective clock frequency into the i2c device node.

g.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
