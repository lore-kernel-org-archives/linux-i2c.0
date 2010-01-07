From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 0/3] Add I2C support for Octeon SOCs.
Date: Thu, 07 Jan 2010 11:56:33 -0800
Message-ID: <4B463C71.3080005@caviumnetworks.com>
References: <4B463B1F.6000404@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B463B1F.6000404-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Bozic, Rade (EXT-Other - DE/Ulm)" <rade.bozic.ext-OYasijW0DpE@public.gmane.org>
Cc: linux-mips <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Bah...  I forgot to include Rade Bozic on the original message.  Now 
included.

David Daney wrote:
> This patch set adds I2C driver support for Cavium Networks' Octeon
> processor family.  The Octeon is a multi-core MIPS64 based SOC.
> 
> The first patch adds platform devices for the I2C devices.  The second
> patch is the main driver.  Finally the third patch registers some
> devices so we have something to control with the fancy new driver.
> 
> I will reply with the three patches.
> 
> David Daney (2):
>   MIPS: Octeon: Add I2C platform driver.
>   MIPS: Octeon: Register some devices on the I2C bus.
> 
> Rade Bozic (1):
>   I2C: Add driver for Cavium OCTEON I2C ports.
> 
>  arch/mips/cavium-octeon/octeon-platform.c |   85 +++++
>  arch/mips/include/asm/octeon/octeon.h     |    5 +
>  drivers/i2c/busses/Kconfig                |   10 +
>  drivers/i2c/busses/Makefile               |    1 +
>  drivers/i2c/busses/i2c-octeon.c           |  579 
> +++++++++++++++++++++++++++++
>  5 files changed, 680 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-octeon.c
> 
> 
