From: Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v2 0/4] Add Actions Semi Owl family S700 I2C support
Date: Mon, 10 Dec 2018 12:25:37 +0100
Message-ID: <5434a04c-a492-a7a5-9783-383947b6d1fb@denx.de>
References: <20181126185821.2480449-1-pn@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126185821.2480449-1-pn@denx.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: afaerber@suse.de, manivannan.sadhasivam@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc: pn@denx.de, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@cubietech.com, thomas.liau@actions-semi.com, linux-actions@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Ping on this patch series!

On 11/26/18 7:58 PM, Parthiban Nallathambi wrote:
> This patch series adds support for Actions Semi Owl SoC family S700
> I2C controller. S700 provides 4 I2C masters and with cubieboard7
> 2 (I2C0 and I2C1) are exposed.
> 
> Added pinctrl definition for I2C controllers in cubieboard7. This patch
> depends on s700 pinctrl driver support (yet to be merged),
> https://lkml.org/lkml/2018/11/19/514
> https://lore.kernel.org/patchwork/patch/1012859/
> 
> Changelog in v2:
> - Initial version https://lore.kernel.org/patchwork/patch/1011911/ only
> added the I2C nodes using s900 compatible property. Now, new s700
> compatiable string is added and used for S700
> - Device tree bindings added with s700 compatible string
> - pinctrl definition for cubieboard7
> 
> Parthiban Nallathambi (4):
>    dt-bindings: i2c: Add S700 support for Actions Semi Soc's
>    i2c: Add Actions Semiconductor Owl family S700 I2C support
>    arm64: dts: actions: s700: Add I2C controller nodes
>    arm64: dts: actions: s700-cubieboard7: Enable I2C0 and I2C1
> 
>   .../devicetree/bindings/i2c/i2c-owl.txt       |  2 +-
>   .../boot/dts/actions/s700-cubieboard7.dts     | 53 +++++++++++++++++++
>   arch/arm64/boot/dts/actions/s700.dtsi         | 40 ++++++++++++++
>   drivers/i2c/busses/i2c-owl.c                  |  1 +
>   4 files changed, 95 insertions(+), 1 deletion(-)
> 

-- 
Thanks,
Parthiban N

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-22 Fax: (+49)-8142-66989-80 Email: pn@denx.de
