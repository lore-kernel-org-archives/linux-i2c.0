From: "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>
Subject: Re: [PATCH 2/5] i2c: Add STM32F4 I2C driver
Date: Thu, 2 Jun 2016 17:35:12 +0200
Message-ID: <CAOAejn0G3JzATKME5DaMV0GEBwQVWjkB1=ei-7LOQ98vzkUeVw@mail.gmail.com>
References: <1462980974-22091-1-git-send-email-cedric.madianga@gmail.com>
	<1462980974-22091-3-git-send-email-cedric.madianga@gmail.com>
	<CALszF6A-jiCBtSO1RFDdgHKTKmsonRXFVs0x2zHha1LJ3UhwtQ@mail.gmail.com>
	<CAOAejn0Fsizp9fK1mNn3BBeL2LeoVgt5_zF5656La4G2uDPH7g@mail.gmail.com>
	<CAOAejn1NQDJpGrTwGtpvSfVOGg3UuCkj8wLJ7B5LnW1-Z2VrQA@mail.gmail.com>
	<CALszF6ADLuZ0wK=L68FDzy5M5_eSPRTbNOjSoQw=dWDOjsPqCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33412 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161101AbcFBPfO (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 2 Jun 2016 11:35:14 -0400
In-Reply-To: <CALszF6ADLuZ0wK=L68FDzy5M5_eSPRTbNOjSoQw=dWDOjsPqCA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org

Hi,

>> +
>> +/**
>> + * stm32f4_i2c_xfer() - Transfer combined I2C message
>> + * @i2c_adap: Adapter pointer to the controller
>> + * @msgs: Pointer to data to be written.
>> + * @num: Number of messages to be executed
>> + */
>> +static int stm32f4_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[],
>> +                           int num)
>> +{
>> +       struct stm32f4_i2c_dev *i2c_dev = i2c_get_adapdata(i2c_adap);
>> +       int ret, i;
>> +
>> +       i2c_dev->busy = true;
>> +
>> +       ret = clk_prepare_enable(i2c_dev->clk);
>> +       if (ret) {
>> +               dev_err(i2c_dev->dev, "Failed to prepare_enable clock\n");
>> +               return ret;
>> +       }
>> +
>> +       stm32f4_i2c_hw_config(i2c_dev);
> Maybe you could call this only at probe and resume time?
> You would save some register accesses.
Some clarification about this point.
We need to call stm32f4_i2c_hw_config before each I2C transfer as at
the end of I2C communication the peripheral is automatically disabled
and configuration registers are reset.


BR,
Cedric
