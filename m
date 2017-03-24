From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 04/10] i2c: meson: use i2c core for DT clock-frequency
 parsing
Date: Fri, 24 Mar 2017 07:47:14 +0100
Message-ID: <6aa0f7c1-1bd0-73eb-e05f-f733125bec8d@gmail.com>
References: <1a2ecdc8-a326-a7a7-22ec-658fd147daf4@gmail.com>
 <96c1b005-063e-ae22-ded4-fbb0b023f02b@gmail.com>
 <20170323203309.op7jepa4be2mwkop@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35423 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdCXGtX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 24 Mar 2017 02:49:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id z133so1333889wmb.2
        for <linux-i2c@vger.kernel.org>; Thu, 23 Mar 2017 23:49:21 -0700 (PDT)
In-Reply-To: <20170323203309.op7jepa4be2mwkop@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 23.03.2017 um 21:33 schrieb Wolfram Sang:
> 
>> +- i2c-scl-falling-time-ns
>> +  Number of nanoseconds the SCL signal takes to fall; t(f) in the I2C
>> +  specification.
>> +
>> +- i2c-scl-internal-delay-ns
>> +  Number of nanoseconds the IP core additionally needs to setup SCL.
>> +
>> +- i2c-scl-rising-time-ns
>> +  Number of nanoseconds the SCL signal takes to rise; t(r) in the I2C
>> +  specification.
>> +
>> +- i2c-sda-falling-time-ns
>> +  Number of nanoseconds the SDA signal takes to fall; t(f) in the I2C
>> +  specification.
> 
> Those are not used currently. Can the driver be updated to make use of
> them? Otherwise, we might just skip this section.
> 
Adding these properties was outcome of a discussion with Amlogic
maintainers. It's right that they aren't used by the driver and the
chip also provides no means to change the related timings.
So I will remove this part.
