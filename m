From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] [ARM] tegra: Add i2c support
Date: Fri, 30 Jul 2010 18:06:54 +0530
Message-ID: <4C52C766.7040709@ti.com>
References: <1280450180-25016-1-git-send-email-ccross@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1280450180-25016-1-git-send-email-ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 07/30/2010 06:06 AM, Colin Cross wrote:
> +/* i2c_writel and i2c_readl will offset the register if necessary to talk
> + * to the I2C block inside the DVC block
> + */

Minor coding-style comment. Documentation/CodingStyle says the preferred
format for multi-line comments is to do:

/*
  * i2c_writel and i2c_readl ...
  * to the I2C block ...
  */

Not sure if you need to fix this in this patch, but it's probably a good 
idea to follow for future patches.

- Anand
