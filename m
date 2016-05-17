From: "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: Document the STM32 I2C bindings
Date: Tue, 17 May 2016 09:21:31 +0200
Message-ID: <CAOAejn3VJX4ZZZ9nXN+YOs_s-sXBOnGkvRXhZwP3undVnDjXMA@mail.gmail.com>
References: <1462980974-22091-1-git-send-email-cedric.madianga@gmail.com>
	<1462980974-22091-2-git-send-email-cedric.madianga@gmail.com>
	<20160516150440.GA6312@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35949 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbcEQHVc (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 17 May 2016 03:21:32 -0400
In-Reply-To: <20160516150440.GA6312@rob-hp-laptop>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, patrice.chotard@st.com, Wolfram Sang <wsa@the-dreams.de>, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

 Hi,

2016-05-16 17:04 GMT+02:00 Rob Herring <robh@kernel.org>:
> On Wed, May 11, 2016 at 05:36:10PM +0200, M'boumba Cedric Madianga wrote:
>> This patch adds documentation of device tree bindings for the STM32 I2C
>> controller.
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> ---
>>  .../devicetree/bindings/i2c/i2c-stm32.txt          | 33 ++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
>> new file mode 100644
>> index 0000000..73215c6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
>> @@ -0,0 +1,33 @@
>> +* I2C controller embedded in STMicroelectronics STM32 I2C platform
>> +
>> +Required properties :
>> +- compatible : Must be "st,i2c-stm32f4"
>
> Normal order is st,stm32f4-i2c
Ok Thanks, I will correct it in the V2.

>
> Rob

Cedric
