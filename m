From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] i2c: fix ACPI_I2C_OPREGION dependency
Date: Tue, 2 Jan 2018 13:07:03 -0500
Message-ID: <ea62b24e-a77b-f52e-46f2-ed38dfebd792@codeaurora.org>
References: <1511370357-17184-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511370357-17184-1-git-send-email-eric.auger@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

+linux-acpi

On 11/22/2017 12:05 PM, Eric Auger wrote:
> If CONFIG_I2C=m we fail getting ACPI_I2C_OPREGION set. Let's
> make ACPI_I2C_OPREGION depend on I2C.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/i2c/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> index efc3354..5951e9d 100644
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -26,7 +26,7 @@ config I2C
>  
>  config ACPI_I2C_OPREGION
>  	bool "ACPI I2C Operation region support"
> -	depends on I2C=y && ACPI
> +	depends on I2C && ACPI
>  	default y
>  	help
>  	  Say Y here if you want to enable ACPI I2C operation region support.
> 

Anybody picking this up?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
