From: Jeremy Murphy <jeremy.william.murphy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Monitor's EDID not recognised
Date: Fri, 7 Mar 2008 19:23:31 +1100
Message-ID: <200803071923.32035.jeremy.william.murphy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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


Apologies for what might be a frequently asked question, but I haven't found 
an answer on the web yet.

I have a Sony CPD-G520 (21" CRT monitor) for which I would like to be able to 
read the EDID.  However, sensors-detect finds SPD EEPROM where the EDID 
EEPROM probably, and typically, is.

This is an edit from sensors-detect output:

Next adapter: SMBus I801 adapter at 0400 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

It then gives the same output for 0x50 at 0x51, 0x52 and 0x53.  When I load 
the eeprom module it says that it is handling it.  The problem is that there 
are no valid EDIDs at those addresses, as reported by decode-edid.pl (it's a 
64-bit system so no get-edid).  So I'm not sure whether a) the EDID is 
corrupt, or b) it's not actually accessing the EDID.  Any ideas?

The graphics card is an NVIDIA 7600GS, motherboard chipset is the Intel ICH7 
family.  Hardware monitoring of CPU and motherboard temperature via I2C works 
fine.  Thanks!

Jeremy

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
