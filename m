From: Shivaraj Shetty <shettyshivaraj@gmail.com>
Subject: Re: [REF] Query regarding process call/repeated start in i2c driver
Date: Thu, 7 Sep 2017 20:13:58 +0530
Message-ID: <CANXXpoCfa496JK_E1wUtNiiEnKZS8fiG8pOOxeYUCOms93sJdg@mail.gmail.com>
References: <CANXXpoBfWccpXNza3xyVXDd7biAdrq+8DyzeRsGidVRE55iNyA@mail.gmail.com>
 <20170905175212.7lw5zaqq2lf5r2fg@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:36211 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754005AbdIGOoA (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 7 Sep 2017 10:44:00 -0400
Received: by mail-it0-f52.google.com with SMTP id 6so127388itl.1
        for <linux-i2c@vger.kernel.org>; Thu, 07 Sep 2017 07:44:00 -0700 (PDT)
In-Reply-To: <20170905175212.7lw5zaqq2lf5r2fg@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Hi Wolfram Sang,

I am facing issue on nxp-pca9505 I/O expander as I add support for
repeated start to bcm-iproc i2c driver.
I will check on code changes that I have done to support repeated
start, as you have confirmed that ideally i2c client shouldn't have
issue using repeated start instead of stop-start.

Thank you.

On 5 September 2017 at 23:22, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> 1. From I2C_AQ_COMB quirk it looks like if there are two messages in
>> single i2c_transfer api to i2c-core, it has to be repeated-start.
>> Is my understanding correct?
>
> Yes.
>
>> 2. On calling smbus api for word read (non process call), it calls i2c
>> transfer api with two messages (emulation on i2c case). Now if 1 is
>> true we end up in repeated start case.
>
> Yes, this is exactly how it is described in the SMBus Specification.
>
>> But this may not be expected by the i2c client.
>
> Quite the contrary, you usually run into more problems if you replace
> repeated start with STOP/START. For example, you could get interrupted
> by another master on the bus. But some clients also reset their state
> machine after STOP. What device are you talking about? Which device
> cannot handle repeated start? That would be interesting to know.
>
>> Basically how to know from the i2c host/core driver, if the client
>> wants to use Repeated start or not?
>
> The client driver knows what the client wants.
>
>> Why don't we have a way where i2c client driver can call the i2c core
>> api with flag to indicate whether to use repeated-start or not?
>> (similar to protocolparameter in smbus api - can be set as
>> I2C_SMBUS_PROC_CALL for process call)
>
> Because your client is not SMBus compatible, and you need work on I2C
> level then where you can describe your own transfers the way you want.
>



-- 
Regards,
Shivaraj Shetty
