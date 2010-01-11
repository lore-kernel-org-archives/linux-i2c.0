From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] m68knommu: driver for Freescale Coldfire I2C
 controller.
Date: Mon, 11 Jan 2010 09:37:29 +0100
Message-ID: <20100111093729.63455a90@hyperion.delvare>
References: <201001101600.41932.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752765Ab0AKIhf@vger.kernel.org>
In-Reply-To: <201001101600.41932.sfking@fdwdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven King <sfking@fdwdc.com>
Cc: gerg@snapgear.com, ben-linux@fluff.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 10 Jan 2010 16:00:41 -0800, Steven King wrote:
> Add support for the I2C controller used on Freescale/Motorola Coldfire MCUs. 
> 
> Signed-off-by: Steven King <sfking@fdwdc.com>
> 
>  drivers/i2c/busses/Kconfig   |   11 +
>  drivers/i2c/busses/Makefile  |    1 +
>  drivers/i2c/busses/i2c-mcf.c |  463 ++++++++++++++++++++++++++++++++++++++++++

Please come up with a longer name. i2c-coldfire, for example.

-- 
Jean Delvare
