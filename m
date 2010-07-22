From: Greg Bean <gbean-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4] gpio: sx150x: Add Semtech I2C sx150x gpio expander
 driver.
Date: Thu, 22 Jul 2010 10:22:42 -0700
Message-ID: <4C487E62.9080106@codeaurora.org>
References: <1279818771-9428-1-git-send-email-gbean@codeaurora.org> <20100722101753.c73604eb.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100722101753.c73604eb.randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

 >> +	bool "Semtech SX150x I2C GPIO expander"
 >> +	depends on I2C=y
 >> +	default n
 >> +	help
 >> +	  Say yes here to provide support for Semtech SX150-series I2C
 >> +	  GPIO expanders. Compatible models include:
 >
 > Just curious, not complaining, but why does this driver (and some others)
 > need to be built-in instead of having the option of being built as a
 > loadable module?

It's that way because it requires unexported symbols from genirq and 
I2C.  If this driver is allowed to be a module, it can't find the 
unexported genirq symbols, and if I2C is allowed to be a module, then a 
bunch of i2c_smbus stuff can't be resolved...

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
