From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH 0/6] i2c-stm32f7: support suspend/resume & wakeup
Date: Fri, 13 Mar 2020 13:49:07 +0100
Message-ID: <0c852ecf-fab4-6df7-1f27-f80b3f2e2f48@st.com>
References: <1578317314-17197-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:2678 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726655AbgCMMta (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 13 Mar 2020 08:49:30 -0400
In-Reply-To: <1578317314-17197-1-git-send-email-alain.volmat@st.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alain Volmat <alain.volmat@st.com>, wsa@the-dreams.de, robh+dt@kernel.org
Cc: mark.rutland@arm.com, pierre-yves.mordret@st.com, mcoquelin.stm32@gmail.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com

Hi Alain

On 1/6/20 2:28 PM, Alain Volmat wrote:
> This serie replaces the previously sent serie "stm32: i2c: Add suspend/resume & add sleep pinctrls".
> 
> This serie adds support for pm sleep suspend / resume and allow I2C slave to be
> a wakeup-source for the system.
> 
> Alain Volmat (6):
>    ARM: dts: stm32: add i2c4 sleep pinctrl on stm32mp15xx-dkx
>    ARM: dts: stm32: add i2c2/i2c5 sleep pinctrl on stm32mp157c-ev1
>    ARM: dts: stm32: add i2c4 sleep pinctrl on stm32mp157c-ed1
>    i2c: i2c-stm32f7: add PM_SLEEP suspend/resume support
>    i2c: i2c-stm32f7: allow controller to be wakeup-source
>    ARM: dts: stm32: add wakeup-source in all I2C nodes of stm32mp157c
> 
>   arch/arm/boot/dts/stm32mp151.dtsi      |   6 ++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts  |   3 +-
>   arch/arm/boot/dts/stm32mp157c-ev1.dts  |   6 +-
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi |   3 +-
>   drivers/i2c/busses/i2c-stm32f7.c       | 187 ++++++++++++++++++++++++++++++++-
>   5 files changed, 196 insertions(+), 9 deletions(-)
> 

DT patches applied on stm32-next.

Regards
Alex
