From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v3 0/8] Add IPROC I2C slave mode and NIC I2C support
Date: Sun, 20 Jan 2019 13:49:56 -0800
Message-ID: <e658ce66-98e3-3ca6-5786-56bfea6d176e@broadcom.com>
References: <1547791464-3540-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1547791464-3540-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, rjui@broadcom.com
Cc: mark.rutland@arm.com, heikki.krogerus@linux.intel.com, vigneshr@ti.com, ajayg@nvidia.com, wsa@the-dreams.de, rayagonoda.kokatanur@braodcom.com, aaron.wu@analog.com, pierre-yves.mordret@st.com, kramasub@codeaurora.org, linux-i2c@vger.kernel.org, manivannan.sadhasivam@linaro.org, jdelvare@suse.de, f.fainelli@gmail.com, eajames@linux.vnet.ibm.com, shreesha.rajashekar@broadcom.com, bcm-kernel-feedback-list@broadcom.com, geert@linux-m68k.org, devicetree@vger.kernel.org, arnd@arndb.de, robh+dt@kernel.org, ccheng@broadcom.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org, sbranden@broadcom.com, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org, jarkko.nikula@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

Hi Rayagonda/Wolfram,

I reviewed the entire patch series and added my Reviewed-by tag on 1/8
and 2/8. The rest of the patches in this series already had my
Signed-off-by tag.

Thanks,

Ray

On 1/17/2019 10:04 PM, Rayagonda Kokatanur wrote:
> Hi,
> This patchset contains support for IPROC I2C slave and NIC I2C support.
> Following are the brief changes done inorder to support both IPROC I2C
> slave mode and NIC I2C,
> 
> a. Add support to allow I2C rx transfer upto 255 bytes
> b. Add polling mode support to the iProc I2C driver. Polling mode is used
>    in certain SoCs where interrupt is not connected from the I2C block.
> c. Add warpper read/write access for register to support indirect register
>    access. This is required in certain SoCs with this iProc I2C
>    block registered.
> d. Remove the set RESET bit to LOW right after setting it to HIGH so that
>    wait duration can be met.
> 
> This patch series is based on kernel v5.0.0-rc2.
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
>   i2c: iproc: I2C read up to 255 bytes support
>   i2c: iproc: Add Slave mode support
> 
>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |  14 +-
>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  18 +
>  drivers/i2c/busses/Kconfig                         |   1 +
>  drivers/i2c/busses/i2c-bcm-iproc.c                 | 757 +++++++++++++++++----
>  4 files changed, 659 insertions(+), 131 deletions(-)
> 
