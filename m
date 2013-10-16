From: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH v5 0/4] Add I2C support to ST SoCs
Date: Wed, 16 Oct 2013 16:54:36 +0200
Message-ID: <525EA8AC.4010607@st.com>
References: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1381754813-4679-1-git-send-email-maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Stephen GALLIMORE <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, Stuart MENEFY <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gabriel FERNANDEZ <gabriel.fernandez-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 10/14/2013 02:46 PM, Maxime COQUELIN wrote:
> The goal of this series is to add I2C support to ST SoCs.
> The DT definition is added for STiH415 and STiH416 SoCs on
> B2000 and B2020 boards.
>
> The series has been tested working on STiH416-B2020 board.
> It applies on top of v3.12-rc5.
>
> Changes since v4:
>    - Fixed IRQ flags to level high triggering as reported by Stephen Gallimore
>    - Revert back to generic DT properties for Anti-glitch filtering. Their DT
>      binding documentation will be updated when i2c DT binding docuementation
>      will be created (In Wolfram's ToDo list)
Do you agree with this approach?

Did you had time to review the driver?

Regards,
Maxime

> ...
>
> Maxime Coquelin (4):
>    i2c: busses: i2c-st: Add ST I2C controller
>    ARM: STi: Supply I2C configuration to STiH416 SoC
>    ARM: STi: Supply I2C configuration to STiH415 SoC
>    ARM: STi: Add I2C config to B2000 and B2020 boards
>
>   Documentation/devicetree/bindings/i2c/i2c-st.txt |   38 +
>   arch/arm/boot/dts/stih415-pinctrl.dtsi           |   36 +
>   arch/arm/boot/dts/stih415.dtsi                   |   53 ++
>   arch/arm/boot/dts/stih416-pinctrl.dtsi           |   35 +
>   arch/arm/boot/dts/stih416.dtsi                   |   53 ++
>   arch/arm/boot/dts/stih41x-b2000.dtsi             |    9 +
>   arch/arm/boot/dts/stih41x-b2020.dtsi             |   22 +
>   drivers/i2c/busses/Kconfig                       |   10 +
>   drivers/i2c/busses/Makefile                      |    1 +
>   drivers/i2c/busses/i2c-st.c                      |  867 ++++++++++++++++++++++
>   10 files changed, 1124 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/i2c/i2c-st.txt
>   create mode 100644 drivers/i2c/busses/i2c-st.c
>
