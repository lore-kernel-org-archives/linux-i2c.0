From: Jeremy Murphy <jeremy.william.murphy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Monitor's EDID not recognised
Date: Fri, 7 Mar 2008 22:37:36 +1100
Message-ID: <200803072237.36693.jeremy.william.murphy@gmail.com>
References: <200803071923.32035.jeremy.william.murphy@gmail.com>
	<20080307110610.3a48021d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080307110610.3a48021d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 7 Mar 2008 09:06:10 pm Jean Delvare wrote:
>
> What does decode-dimms.pl say? If you have 4 memory modules on this
> system then it is expected that sensors-detect (or i2cdetect) will see
> 4 SPD EEPROMs at 0x50, 0x51, 0x52 and 0x53.

You're absolutely right, they are my DIMMS.  I assumed that was the EDID and 
its shadows because they started at the same address and I'd seen the same 
output on some other nvidia users' reports.  Now I know better, thanks!


> I'm not sure why you would expect the EDID EEPROM on the ICH7 SMBus.
> I've never seen an EDID EEPROM there. The EDID EEPROM is typically
> accessed through an I2C bus on the graphics adapter. You will need a
> driver for this. The binary nvidia X11 driver should work, the nvidiafb
> framebuffer driver should work as well (that's what I am using myself).
> After loading the driver, 2 or 3 additional I2C buses should be listed
> by "i2cdetect -l" (don't forget to load i2c-dev beforehand), and
> decode-edid.pl (or the more user-friendly ddcmon script) should find
> the EDID on one of them.

I'm using nvidia's binary driver v169.07, and yes, the nvidia I2C buses are 
there.  i2cdetect -l:

i2c-3   i2c             NVIDIA i2c adapter                      I2C adapter
i2c-2   i2c             NVIDIA i2c adapter                      I2C adapter
i2c-1   i2c             NVIDIA i2c adapter                      I2C adapter
i2c-0   smbus           SMBus I801 adapter at 0400              SMBus adapter

However, decode-edid.pl and ddcmon both report that an EDID EEPROM is not 
found.

Jeremy

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
