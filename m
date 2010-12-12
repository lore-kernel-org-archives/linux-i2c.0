From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Const buffer pointers for SMBus/I2C block write functions
Date: Sun, 12 Dec 2010 14:23:28 +0100
Message-ID: <20101212142328.038f9575@endymion.delvare>
References: <201011160657.11061.roman.fietze@telemotive.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201011160657.11061.roman.fietze-rVvtEhYSWBkAey3BTtE3dg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roman Fietze <roman.fietze-rVvtEhYSWBkAey3BTtE3dg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Roman,

Sorry for the late answer.

On Tue, 16 Nov 2010 06:57:10 +0100, Roman Fietze wrote:
> If the SMBus and I2C block write functions in i2c-dev.h (the version
> from lm-sensors, not the kernel) would take const buffer pointers,
> this would allow callers to use const data to be sent via SMB/I2C.

The lm-sensors package no longer includes the "user-space version" of
i2c-dev. It is part of i2c-tools now.

Note that this file is an horror, BTW. It should be turned into a proper
library, to avoid the confusion with the kernel header file. This is on
my to-do list for year 2011.

> Please see the diff below.
> 
> 
> Index: include/linux/i2c-dev.h
> ===================================================================
> --- include/linux/i2c-dev.h	(revision 5881)
> +++ include/linux/i2c-dev.h	(working copy)
> @@ -258,7 +258,7 @@
>  }
>  
>  static inline __s32 i2c_smbus_write_block_data(int file, __u8 command, 
> -                                               __u8 length, __u8 *values)
> +                                               __u8 length, const __u8 *values)
>  {
>  	union i2c_smbus_data data;
>  	int i;
> @@ -296,7 +296,7 @@
>  }
>  
>  static inline __s32 i2c_smbus_write_i2c_block_data(int file, __u8 command,
> -                                               __u8 length, __u8 *values)
> +                                               __u8 length, const __u8 *values)
>  {
>  	union i2c_smbus_data data;
>  	int i;
> 

Yes, this makes sense. Patch applied, thanks.

-- 
Jean Delvare
