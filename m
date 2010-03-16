From: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH V2] MIPS: Octeon: Register EEPROM device on the I2C bus
Date: Tue, 16 Mar 2010 19:09:46 +0100
Message-ID: <20100316180946.GC20160@linux-mips.org>
References: <1268026190-18300-1-git-send-email-yang.shi@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1268026190-18300-1-git-send-email-yang.shi-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yang Shi <yang.shi-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 08, 2010 at 01:29:50PM +0800, Yang Shi wrote:

> An SPD resides on 0x50 of the I2C bus on CN56xx/57xx board,
> register this device.

I wonder what the use case for this patch is?  Normally Linux doesn't care
about SPD.

I also wonder how this will work for configurations with multiple memory
modules thus multiple SPD EEPROMS.

  Ralf
