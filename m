From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v5 0/8] iProc I2C slave mode and NIC mode
Date: Fri, 22 Feb 2019 12:04:21 -0800
Message-ID: <5c5ed177-0e9e-6271-518c-6956a7a6c554@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Rob has reviewed all DT binding related changes from this patch series.
Could you please help to review the I2C driver related changes when you
have time?

Thanks,

Ray

On 2/14/2019 9:57 AM, Ray Jui wrote:
> This patch series adds the following support to the iProc I2C driver:
> - Increase maximum read transfer size to 255 bytes
> - I2C slave mode
> - Polling mode
> - NIC I2C mode
> 
> This patch series is based on kernel v5.0-rc3 and available at:
> https://github.com/Broadcom/arm64-linux.git
> branch: i2c-slave-v5
> 
> Changes from v4:
>  - Add more detailed explanations in the device tree binding document
>    changes, to address Rob's review comments
> 
> Changes from v3:
>  - Various minor fixes on commit messages and commits
>  - Rebased to v5.0-rc3
> 
> Changes from v2:
>  - Address Ray's review comments.
> 
> Changes from v1:
>  - Rebased to Linux v5.0.0-rc2
> 
> Ray Jui (1):
>   dt-bindings: i2c: iproc: make 'interrupts' optional
> 
> Rayagonda Kokatanur (5):
>   i2c: iproc: add polling support
>   i2c: iproc: use wrapper for read/write access
>   dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
>   i2c: iproc: add NIC I2C support
>   arm64: dts: Stingray: Add NIC i2c device node
> 
> Shreesha Rajashekar (2):
>   i2c: iproc: Extend I2C read up to 255 bytes
>   i2c: iproc: Add slave mode support
> 
>  .../bindings/i2c/brcm,iproc-i2c.txt           |  17 +-
>  .../boot/dts/broadcom/stingray/stingray.dtsi  |  18 +
>  drivers/i2c/busses/Kconfig                    |   1 +
>  drivers/i2c/busses/i2c-bcm-iproc.c            | 758 +++++++++++++++---
>  4 files changed, 663 insertions(+), 131 deletions(-)
> 
