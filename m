From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Monitor's EDID not recognised
Date: Fri, 7 Mar 2008 11:06:10 +0100
Message-ID: <20080307110610.3a48021d@hyperion.delvare>
References: <200803071923.32035.jeremy.william.murphy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200803071923.32035.jeremy.william.murphy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jeremy Murphy <jeremy.william.murphy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jeremy,

On Fri, 7 Mar 2008 19:23:31 +1100, Jeremy Murphy wrote:
> 
> Apologies for what might be a frequently asked question, but I haven't found 
> an answer on the web yet.
> 
> I have a Sony CPD-G520 (21" CRT monitor) for which I would like to be able to 
> read the EDID.  However, sensors-detect finds SPD EEPROM where the EDID 
> EEPROM probably, and typically, is.
> 
> This is an edit from sensors-detect output:
> 
> Next adapter: SMBus I801 adapter at 0400 (i2c-0)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> 
> It then gives the same output for 0x50 at 0x51, 0x52 and 0x53.  When I load 
> the eeprom module it says that it is handling it.  The problem is that there 
> are no valid EDIDs at those addresses, as reported by decode-edid.pl (it's a 
> 64-bit system so no get-edid).  So I'm not sure whether a) the EDID is 
> corrupt, or b) it's not actually accessing the EDID.  Any ideas?

What does decode-dimms.pl say? If you have 4 memory modules on this
system then it is expected that sensors-detect (or i2cdetect) will see
4 SPD EEPROMs at 0x50, 0x51, 0x52 and 0x53.

> The graphics card is an NVIDIA 7600GS, motherboard chipset is the Intel ICH7 
> family.  Hardware monitoring of CPU and motherboard temperature via I2C works 
> fine.  Thanks!

I'm not sure why you would expect the EDID EEPROM on the ICH7 SMBus.
I've never seen an EDID EEPROM there. The EDID EEPROM is typically
accessed through an I2C bus on the graphics adapter. You will need a
driver for this. The binary nvidia X11 driver should work, the nvidiafb
framebuffer driver should work as well (that's what I am using myself).
After loading the driver, 2 or 3 additional I2C buses should be listed
by "i2cdetect -l" (don't forget to load i2c-dev beforehand), and
decode-edid.pl (or the more user-friendly ddcmon script) should find
the EDID on one of them.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
