From: Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
Subject: Re: [PATCH v3] i2c: Add support for NXP PCA984x family.
Date: Wed, 13 Dec 2017 18:17:06 +0100
Message-ID: <854cba57-5640-5be1-dec2-fc7b8b7ea281@cern.ch>
References: <8a2f6d04-f156-a877-9e82-3f760488c932@enneenne.com>
 <20171211165811.5806-1-adrian.fiergolski@cern.ch>
 <f3883936-d621-cc48-444b-db08470d256f@axentia.se>
 <2acdb52a-c669-631d-2ef2-ab0da2899e00@cern.ch>
 <cb42475b-eacb-d059-2ee5-f2a57cf29159@axentia.se>
 <c7842a62-980d-b220-aa42-51cbb5398c5b@cern.ch>
 <5cbfd97a-146b-8851-c63a-f2f60da33f5b@axentia.se>
 <20171212220537.o4njv4lqp2ppmu7x@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0089.outbound.protection.outlook.com ([104.47.1.89]:19441
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752816AbdLMRRK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 13 Dec 2017 12:17:10 -0500
In-Reply-To: <20171212220537.o4njv4lqp2ppmu7x@ninjato>
Content-Language: en-GB
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org

On 12.12.2017 at 23:05, Wolfram Sang wrote:
>
>> Wolfram, do you have an opinion on the device id check using the
>> 0x7c address?
> I always thought there should be some core support for that feature, but
> IIRC I never knew of any device which had this implemented. But since it
> is described in the I2C Specification, it should be in core IMO.
>
I think one could simply use the code from my patch v3. However,
I haven't found any example of such dedicated function (i.e GENERAL_CALL)
in the core.
Do you have in mind sth like i2c_smbus_write_i2c_device_device_id function ?

Cheers,
Adrian
