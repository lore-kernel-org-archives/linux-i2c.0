From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH] m68knommu: AMCORE board, add iMX i2c support
Date: Thu, 20 Oct 2016 22:37:23 +1000
Message-ID: <07dab77f-e1d4-e027-0ac4-45a78ff7ded6@linux-m68k.org>
References: <1476911979-4926-1-git-send-email-angelo@sysam.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1476911979-4926-1-git-send-email-angelo@sysam.it>
Sender: linux-m68k-owner@vger.kernel.org
To: Angelo Dureghello <angelo@sysam.it>
Cc: linux-i2c@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Angelo,

On 20/10/16 07:19, Angelo Dureghello wrote:
> Add iMX i2c support for the Sysam AMCORE board.
>
> Signed-off-by: Angelo Dureghello <angelo@sysam.it>

CCing linux-m68k email list as well.

I will pick this up and push it in to the m68knommu
git tree, for-next branch.

Thanks
Greg


> ---
>  arch/m68k/configs/amcore_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/m68k/configs/amcore_defconfig b/arch/m68k/configs/amcore_defconfig
> index 2bf02e9..dc5adae 100644
> --- a/arch/m68k/configs/amcore_defconfig
> +++ b/arch/m68k/configs/amcore_defconfig
> @@ -87,7 +87,7 @@ CONFIG_I2C=y
>  # CONFIG_I2C_COMPAT is not set
>  CONFIG_I2C_CHARDEV=y
>  # CONFIG_I2C_HELPER_AUTO is not set
> -CONFIG_I2C_COLDFIRE=y
> +CONFIG_I2C_IMX=y
>  CONFIG_PPS=y
>  # CONFIG_HWMON is not set
>  # CONFIG_USB_SUPPORT is not set
>
