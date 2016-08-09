From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/2] mfd: ti-smusbdig: Add support for the TI
 SM-USB-DIG
Date: Tue, 9 Aug 2016 16:27:42 +0100
Message-ID: <20160809152742.GS5243@dell>
References: <20160809145517.22815-1-afd@ti.com>
 <20160809145517.22815-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160809145517.22815-2-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 09 Aug 2016, Andrew F. Davis wrote:

> The TI SM-USB-DIG is a USB to SPI/I2C/1Wire/GPIO adapter.
> Add MFD core support.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/mfd/Kconfig             |   9 +++
>  drivers/mfd/Makefile            |   2 +
>  drivers/mfd/ti-smusbdig.c       | 138 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/ti-smusbdig.h |  75 ++++++++++++++++++++++
>  4 files changed, 224 insertions(+)
>  create mode 100644 drivers/mfd/ti-smusbdig.c
>  create mode 100644 include/linux/mfd/ti-smusbdig.h

Still requires a DT Ack.

Please ping the relevant guys.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
