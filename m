From: Tony Prisk <linux@prisktech.co.nz>
Subject: Re: [PATCH] i2c: vt8500: Add support for I2C bus on Wondermedia SoCs
Date: Tue, 21 May 2013 18:16:21 +1200
Message-ID: <519B1135.4060509@prisktech.co.nz>
References: <1368350634-12654-1-git-send-email-linux@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368350634-12654-1-git-send-email-linux@prisktech.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Prisk <linux@prisktech.co.nz>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, vt8500-wm8505-linux-kernel@googlegroups.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 12/05/13 21:23, Tony Prisk wrote:
> This patch adds support for the I2C bus controllers found on Wondermedia
> 8xxx-series SoCs. Only master-mode is supported.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>   .../devicetree/bindings/i2c/i2c-vt8500.txt         |   24 +
>   MAINTAINERS                                        |    1 +
>   drivers/i2c/busses/Kconfig                         |   10 +
>   drivers/i2c/busses/Makefile                        |    1 +
>   drivers/i2c/busses/i2c-wmt.c                       |  488 ++++++++++++++++++++
>   5 files changed, 524 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/i2c/i2c-vt8500.txt
>   create mode 100644 drivers/i2c/busses/i2c-wmt.c
>
>
This patch seems to have stalled. Any news?

Regards
Tony Prisk
