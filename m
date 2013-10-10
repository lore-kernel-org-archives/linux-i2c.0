From: Stephen GALLIMORE <stephen.gallimore@st.com>
Subject: RE: [PATCH v4 3/4] ARM: STi: Supply I2C configuration to STiH415 SoC
Date: Thu, 10 Oct 2013 14:33:19 +0200
Message-ID: <A3BF01DB4A606149A4C20C4C4C808F6C5BC8A70D4E@SAFEX1MAIL1.st.com>
References: <1381250576-7916-1-git-send-email-maxime.coquelin@st.com>
 <1381250576-7916-4-git-send-email-maxime.coquelin@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381250576-7916-4-git-send-email-maxime.coquelin@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime COQUELIN <maxime.coquelin@st.com>, Wolfram Sang <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: Stuart MENEFY <stuart.menefy@st.com>, Lee Jones <lee.jones@linaro.org>, Gabriel FERNANDEZ <gabriel.fernandez@st.com>, Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
List-Id: linux-i2c@vger.kernel.org


> -----Original Message-----
> From: Maxime COQUELIN [mailto:maxime.coquelin@st.com]
> Sent: 08 October 2013 17:43
>.....
> +
> +		i2c@fed40000 {
> +			compatible	= "st,comms-ssc-i2c";
> +			reg		= <0xfed40000 0x110>;
> +			interrupts	=  <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;

This should specify level (high) triggered, not edge triggered, for our
SoC integrations.

Note that level triggered is the default GIC setup and was therefore
what was being used when you specified "0" for the flags previously.

> +			clocks		= <&CLKS_ICN_REG_0>;
> +			clock-names	= "ssc";
> +			clock-frequency = <400000>;
> +			pinctrl-names	= "default";
> +			pinctrl-0	= <&pinctrl_i2c0_default>;
> +
> +			status		= "disabled";
> +		};
