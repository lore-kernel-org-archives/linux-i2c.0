From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 2/4] nvmem: add support for the write-protect pin
Date: Thu, 19 Dec 2019 10:58:17 +0000
Message-ID: <adc6cace-5ee8-5e17-3edc-79b35f00159c@linaro.org>
References: <20191210154157.21930-1-ktouil@baylibre.com>
 <20191210154157.21930-3-ktouil@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210154157.21930-3-ktouil@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Khouloud Touil <ktouil@baylibre.com>, bgolaszewski@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, baylibre-upstreaming@groups.io
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linus.walleij@linaro.org
List-Id: linux-i2c@vger.kernel.org



On 10/12/2019 15:41, Khouloud Touil wrote:
> The write-protect pin handling looks like a standard property that
> could benefit other users if available in the core nvmem framework.
> 
> Instead of modifying all the memory drivers to check this pin, make
> the NVMEM subsystem check if the write-protect GPIO being passed
> through the nvmem_config or defined in the device tree and pull it
> low whenever writing to the memory.
> 
> There was a suggestion for introducing the gpiodesc from pdata, but
> as pdata is already removed it could be replaced by adding it to
> nvmem_config.
> 
> Reference: https://lists.96boards.org/pipermail/dev/2018-August/001056.html
> 
> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
> ---
>   drivers/nvmem/core.c           | 19 +++++++++++++++++--
>   drivers/nvmem/nvmem.h          |  2 ++
>   include/linux/nvmem-provider.h |  3 +++
>   3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
