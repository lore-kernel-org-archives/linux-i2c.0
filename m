From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 0/2] i2c: meson: add support for Meson G12A SoC i2c controller
Date: Tue, 11 Dec 2018 13:41:25 -0800
Message-ID: <7hsgz3u4fu.fsf@baylibre.com>
References: <1543489197-183181-1-git-send-email-jian.hu@amlogic.com> <8a6a204b28523e5a181f9e85dda18fade76a26a3.camel@baylibre.com> <b2bceaf4-92ce-92a4-c382-713d29ae3b70@amlogic.com> <20181211203652.rogajl4ajwu7cs6f@ninjato>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211203652.rogajl4ajwu7cs6f@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jian Hu <jian.hu@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jianxin Pan <jianxin.pan@amlogic.com>, Hanjie Lin <hanjie.lin@amlogic.com>, linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

>> I am okay if it is reasonable below in file
>> arch/arm64/boot/dts/amlogic/meson-g12a.dtsi. I2c controller node just uses
>> axg's compatible.
>> 
>> 			i2c0: i2c@1f000 {
>> 				compatible = "amlogic,meson-axg-i2c";
>
> Actually, you should have
>
> 	compatible = "amlogic,meson-g12a-i2c", "amlogic,meson-axg-i2c";
>
> in the DT to have support for future SoC specific additions. And then,
> patch 1 is needed.
>
> Or do you handle this differently? I'd think this is DT standard.

It's a DT standard *if* there are actual hardware differences.  In this
case, the IP block is identical, so there are no driver changes.

We prefer to add a new compatible if and when there are actual
driver/hardware changes.

Kevin
