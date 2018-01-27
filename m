From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH 0/2] check I2C device id for pca984x chips
Date: Sat, 27 Jan 2018 09:37:19 +0100
Message-ID: <8549b310-ecfe-e60b-c7fc-fab7db2fd2f2@axentia.se>
References: <20180122113657.32094-1-peda@axentia.se>
 <04535e9d-9ba4-2f27-e94c-12d877d26cda@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr20138.outbound.protection.outlook.com ([40.107.2.138]:37856
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751849AbeA0Ihd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 27 Jan 2018 03:37:33 -0500
In-Reply-To: <04535e9d-9ba4-2f27-e94c-12d877d26cda@cern.ch>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On 2018-01-26 17:33, Adrian Fiergolski wrote:
> Hi Peter,
> 
> Sorry for the late reply.

No problem.

> Yes, it's true I have one of the chip. However, my yocto based build system
> depends on https://github.com/Xilinx/linux-xlnx and it's in version
> 4.9.0-xilinx-v2017.3.
> Apparently, there were some bigger changes in i2c core between this
> version and
> upstream, thus your patches don't apply.

I think the core changes fail to apply mostly because of the file renaming
that has been going on, and that it should be fairly trivial to adapt.
But I don't know for certain...

> Next week I will try to align only me i2c subdirectory with upstream.
> Provided it compiles, I will
> try then to apply and confirm your patches.

I'm looking forward to feedback, thanks!

Cheers,
Peter

> Regards,
> Adrian
> 
> On 22.01.2018 at 12:36, Peter Rosin wrote:
>> Hi!
>>
>> This series tries to check the I2C device id, but instead of open
>> coding the check in the pca954x driver, I have a new function in
>> the core doing the work.
>>
>> The code is only compile-tested, hence the RFC, and I would really
>> like a Tested-by: tag from Adrian who presumably have one of these
>> chips.
>>
>> Also, I'm not sure if I should list all manufacturers that I know
>> about in the header, or if I should settle for the one that is
>> actually used and leave the others to be added by whomever needs
>> them...
>>
>> Cheers,
>> peda
>>
>> Peter Rosin (2):
>>   i2c: add i2c_get_device_id() to get the standard i2c device id
>>   i2c: mux: pca954x: verify the device id of the pca984x chips
>>
>>  drivers/i2c/i2c-core-base.c         | 33 ++++++++++++++++++++++++++++
>>  drivers/i2c/muxes/i2c-mux-pca954x.c | 43 +++++++++++++++++++++++++++++++++++++
>>  include/linux/i2c.h                 | 30 ++++++++++++++++++++++++++
>>  3 files changed, 106 insertions(+)
>>
> 
