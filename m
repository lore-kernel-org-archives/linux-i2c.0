From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 0/4] at24: move write-protect pin handling to nvmem
 core
Date: Thu, 19 Dec 2019 10:51:42 +0000
Message-ID: <cd9f342c-5576-57f5-c62d-a78c5876a7fd@linaro.org>
References: <20191210154157.21930-1-ktouil@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210154157.21930-1-ktouil@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Khouloud Touil <ktouil@baylibre.com>, bgolaszewski@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, baylibre-upstreaming@groups.io
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linus.walleij@linaro.org
List-Id: linux-i2c@vger.kernel.org



On 10/12/2019 15:41, Khouloud Touil wrote:
> The write-protect pin handling looks like a standard property that
> could benefit other users if available in the core nvmem framework.
>      
> Instead of modifying all the drivers to check this pin, make the
> nvmem subsystem check if the write-protect GPIO being passed
> through the nvmem_config or defined in the device tree and pull it
> low whenever writing to the memory.
> 
> This patchset:
> 
> - adds support for the write-protect pin split into two parts.
> The first patch modifies modifies the relevant binding document,
> while the second modifies the nvmem code to pull the write-protect
> GPIO low (if present) during write operations.
> 
> - removes support for the write-protect pin split into two parts.
> The first patch modifies the relevant binding document to remove
> the wp-gpio, while the second removes the relevant code in the
> at24 driver.
> 
> Changes since v1:
> -Add an explenation on how the wp-gpios works
> -keep reference to the wp-gpios in the at24 binding
> 
> Khouloud Touil (4):
>    dt-bindings: nvmem: new optional property write-protect-gpios
>    nvmem: add support for the write-protect pin
>    dt-bindings: at24: remove the optional property write-protect-gpios
>    eeprom: at24: remove the write-protect pin support
> 

Thanks Khouloud for this patchset,

I can take this via nvmem tree once we get an ack on dt bindings from DT 
maintainers.


--srini
>   .../devicetree/bindings/eeprom/at24.yaml      |  6 +-----
>   .../devicetree/bindings/nvmem/nvmem.yaml      |  9 +++++++++
>   drivers/misc/eeprom/at24.c                    |  9 ---------
>   drivers/nvmem/core.c                          | 19 +++++++++++++++++--
>   drivers/nvmem/nvmem.h                         |  2 ++
>   include/linux/nvmem-provider.h                |  3 +++
>   6 files changed, 32 insertions(+), 16 deletions(-)
> 
