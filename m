From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v3 0/8] Add IPROC I2C slave mode and NIC I2C support
Date: Mon, 28 Jan 2019 11:31:31 -0800
Message-ID: <746cf074-69e0-7bd1-034e-c8d3156b5506@broadcom.com>
References: <1547791464-3540-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <e658ce66-98e3-3ca6-5786-56bfea6d176e@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e658ce66-98e3-3ca6-5786-56bfea6d176e@broadcom.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, rjui@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, shreesha.rajashekar@broadcom.com, sbranden@broadcom.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ccheng@broadcom.com, heikki.krogerus@linux.intel.com, geert@linux-m68k.org, arnd@arndb.de, manivannan.sadhasivam@linaro.org, ajayg@nvidia.com, ard.biesheuvel@linaro.org, eajames@linux.vnet.ibm.com, kramasub@codeaurora.org, vigneshr@ti.com, mika.westerberg@linux.intel.com, pierre-yves.mordret@st.com, f.fainelli@gmail.com, aaron.wu@analog.com, jdelvare@suse.de, andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com, robh+dt@kernel.org, mark.rutland@arm.com, rayagonoda.kokatanur@braodcom.com
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Just want to check if you had a chance to review the following patch series?

Thanks,

Ray

On 1/20/2019 1:49 PM, Ray Jui wrote:
> Hi Rayagonda/Wolfram,
> 
> I reviewed the entire patch series and added my Reviewed-by tag on 1/8
> and 2/8. The rest of the patches in this series already had my
> Signed-off-by tag.
> 
> Thanks,
> 
> Ray
> 
> On 1/17/2019 10:04 PM, Rayagonda Kokatanur wrote:
>> Hi,
>> This patchset contains support for IPROC I2C slave and NIC I2C support.
>> Following are the brief changes done inorder to support both IPROC I2C
>> slave mode and NIC I2C,
>>
>> a. Add support to allow I2C rx transfer upto 255 bytes
>> b. Add polling mode support to the iProc I2C driver. Polling mode is used
>>    in certain SoCs where interrupt is not connected from the I2C block.
>> c. Add warpper read/write access for register to support indirect register
>>    access. This is required in certain SoCs with this iProc I2C
>>    block registered.
>> d. Remove the set RESET bit to LOW right after setting it to HIGH so that
>>    wait duration can be met.
>>
>> This patch series is based on kernel v5.0.0-rc2.
>>
>> Changes from v2:
>>  - Address Ray's review comments.
>>
>> Changes from v1:
>>  - Rebased to Linux v5.0.0-rc2
>>
>> Ray Jui (1):
>>   dt-bindings: i2c: iproc: make 'interrupts' optional
>>
>> Rayagonda Kokatanur (5):
>>   i2c: iproc: add polling support
>>   i2c: iproc: use wrapper for read/write access
>>   dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
>>   i2c: iproc: add NIC I2C support
>>   arm64: dts: Stingray: Add NIC i2c device node
>>
>> Shreesha Rajashekar (2):
>>   i2c: iproc: I2C read up to 255 bytes support
>>   i2c: iproc: Add Slave mode support
>>
>>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |  14 +-
>>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  18 +
>>  drivers/i2c/busses/Kconfig                         |   1 +
>>  drivers/i2c/busses/i2c-bcm-iproc.c                 | 757 +++++++++++++++++----
>>  4 files changed, 659 insertions(+), 131 deletions(-)
>>
