From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH 0/2] check I2C device id for pca984x chips
Date: Thu, 1 Feb 2018 15:41:16 +0100
Message-ID: <319e880e-8202-cb1c-fa59-b678eca3e847@axentia.se>
References: <20180122113657.32094-1-peda@axentia.se>
 <04535e9d-9ba4-2f27-e94c-12d877d26cda@cern.ch>
 <8549b310-ecfe-e60b-c7fc-fab7db2fd2f2@axentia.se>
 <318dc907-c091-a883-bf0c-346f32a66723@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0094.outbound.protection.outlook.com ([104.47.1.94]:63053
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751378AbeBAOl0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 1 Feb 2018 09:41:26 -0500
In-Reply-To: <318dc907-c091-a883-bf0c-346f32a66723@cern.ch>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On 2018-01-29 18:38, Adrian Fiergolski wrote:
>>> On 22.01.2018 at 12:36, Peter Rosin wrote:
>>>> This series tries to check the I2C device id, but instead of open
>>>> coding the check in the pca954x driver, I have a new function in
>>>> the core doing the work.
>>>>
>>>> The code is only compile-tested, hence the RFC, and I would really
>>>> like a Tested-by: tag from Adrian who presumably have one of these
>>>> chips.
>>>>
>>>> Also, I'm not sure if I should list all manufacturers that I know
>>>> about in the header, or if I should settle for the one that is
>>>> actually used and leave the others to be added by whomever needs
>>>> them...
>>>>
>>>> Cheers,
>>>> peda
>>>>
>>>> Peter Rosin (2):
>>>>   i2c: add i2c_get_device_id() to get the standard i2c device id
>>>>   i2c: mux: pca954x: verify the device id of the pca984x chips
>>>>
>>>>  drivers/i2c/i2c-core-base.c         | 33 ++++++++++++++++++++++++++++
>>>>  drivers/i2c/muxes/i2c-mux-pca954x.c | 43 +++++++++++++++++++++++++++++++++++++
>>>>  include/linux/i2c.h                 | 30 ++++++++++++++++++++++++++
>>>>  3 files changed, 106 insertions(+)
>>>>
> Hi Peter,
> 
> I have tested your patch with the pca9846 device and I confirm it works.
> Moreover, after short debugging, I can confirm that all read ids
> (manufacture, part and die) seem to be correct. Moreover, in case of
> misconfiguration, the probe function return a proper message and fails
> as expected.

Excellent, thanks!

I'll ping Wolfram later on for any input on the core changes (if needed),
but let's wait until the 4.16 merge-window closes and things settle down
a bit. This will land in 4.17 at the earliest.

Cheers,
Peter
