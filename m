From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v10 5/5] ARM: configs: stm32: Add I2C support for STM32
 defconfig
Date: Mon, 3 Apr 2017 16:36:00 +0200
Message-ID: <3b693eb4-b7f4-47bb-808e-17009b353b46@st.com>
References: <1484832316-5594-1-git-send-email-cedric.madianga@gmail.com>
 <1484832316-5594-6-git-send-email-cedric.madianga@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484832316-5594-6-git-send-email-cedric.madianga@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: M'boumba Cedric Madianga <cedric.madianga@gmail.com>, wsa@the-dreams.de, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, linus.walleij@linaro.org, patrice.chotard@st.com, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
List-Id: linux-i2c@vger.kernel.org

Hi,

On 01/19/2017 02:25 PM, M'boumba Cedric Madianga wrote:
> This patch adds I2C support for STM32 default configuration
>
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> ---

Applied on stm32-defconfig-for-v4.12

Regards
Alex

>  arch/arm/configs/stm32_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index 5a72d69..323d2a3 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -47,6 +47,9 @@ CONFIG_SERIAL_NONSTANDARD=y
>  CONFIG_SERIAL_STM32=y
>  CONFIG_SERIAL_STM32_CONSOLE=y
>  # CONFIG_HW_RANDOM is not set
> +CONFIG_I2C=y
> +CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_STM32F4=y
>  # CONFIG_HWMON is not set
>  # CONFIG_USB_SUPPORT is not set
>  CONFIG_NEW_LEDS=y
>
