From: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/3] at24: Support 16-bit devices on SMBus
Date: Thu, 3 Sep 2015 17:20:43 -0500 (CDT)
Message-ID: <1314711793.101617.1441318843659.JavaMail.zimbra@xes-inc.com>
References: <361739546.82254.1441310010061.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <361739546.82254.1441310010061.JavaMail.zimbra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

----- Original Message -----
> From: "Aaron Sierra" <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
> Sent: Thursday, September 3, 2015 2:53:30 PM
> 
> Previously, the at24 driver would bail out in the case of a 16-bit
> addressable EEPROM attached to an SMBus controller. This is because
> SMBus block reads and writes don't map to I2C multi-byte reads and
> writes when the offset portion is 2 bytes.
> 
> Instead of bailing out, this patch settles for functioning with single
> byte read SMBus cycles. Writes can be block or single-byte, depending on
> SMBus controller features.
> 
> This patch introduces at24_smbus_read_byte_data to transparently handle
> single-byte reads from 8-bit and 16-bit devices.
> 
> Functionality has been tested with the following devices:
> 
>     AT24CM01 attached to Intel ISCH SMBus (1.8 KB/s)
>     AT24C512 attached to Intel I801 SMBus (1.4 KB/s)
> 
> Signed-off-by: Nate Case <ncase-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/misc/eeprom/Kconfig |  4 +++-
>  drivers/misc/eeprom/at24.c  | 40 +++++++++++++++++++++++++++++++++++-----
>  2 files changed, 38 insertions(+), 6 deletions(-)

All,
Shortly after submitting, I found that there are conflicts between this
patch and activity in i2c/for-next. Specifically with this patch:
     eeprom: at24: use i2c_smbus_read_i2c_block_data_or_emulated

Patches 1/3 and 2/3 don't have conflicts. I've reworked this patch (3/3)
and retested on top of i2c/for-next. Should I submit all three patches
as v2 or wait for the first two to be reviewed?

-Aaron
