From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] eeprom: at24: Change nvmem stride to 1
Date: Wed, 6 Dec 2017 09:44:01 +0000
Message-ID: <7ecd75fb-bd2c-53ae-a74a-2f13a6de5ec3@linaro.org>
References: <1512352481-13613-1-git-send-email-david@lechnology.com>
 <CAMRc=McoGNhQZwdNNwXwKYhjZvLPwUQbbVM4YjgnSnth7fOZTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:46494 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754348AbdLFJoE (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Dec 2017 04:44:04 -0500
Received: by mail-wr0-f178.google.com with SMTP id x49so3160220wrb.13
        for <linux-i2c@vger.kernel.org>; Wed, 06 Dec 2017 01:44:03 -0800 (PST)
In-Reply-To: <CAMRc=McoGNhQZwdNNwXwKYhjZvLPwUQbbVM4YjgnSnth7fOZTw@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, David Lechner <david@lechnology.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org



On 04/12/17 17:44, Bartosz Golaszewski wrote:
>>          at24->nvmem_config.priv = at24;
>> -       at24->nvmem_config.stride = 4;
>> +       at24->nvmem_config.stride = 1;
>>          at24->nvmem_config.word_size = 1;
>>          at24->nvmem_config.size = chip.byte_len;
>>
>> --
>> 2.7.4
>>
> I can't find any documentation on what the stride config option does
> in nvmem, but looking at the code it's only used for alignment checks
> in nvmem core, so this patch should be ok. Still: I'm wondering if it
> shouldn't depend on the size of the eeprom or if we shouldn't make the
> chip you're using a special case.
> 
> @David: what is the chip you're using? Is it an at24mac402 by any
> chance? Were you affected by the read problem we fixed recently[1][2]
> in at24?
> 
> @Srinivas: any comments on that?
Stride is there to enforce address alignment. As long as there is no 
issue on addresses aligned to 1 byte on at24 I do not see any issue with 
the patch.

Thanks,
srini
