From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] i2c: nvidia-gpu: Handle timeout correctly in
 gpu_i2c_check_status()
Date: Tue, 24 Mar 2020 19:12:13 +0800
Message-ID: <9771BC92-1785-4E9A-81C7-E72C2C65CE22@canonical.com>
References: <20200311165806.12365-1-kai.heng.feng@canonical.com>
 <20200324110930.GH1134@ninjato>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35665 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgCXLMT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 24 Mar 2020 07:12:19 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jGhTl-00042R-Q4
        for linux-i2c@vger.kernel.org; Tue, 24 Mar 2020 11:12:17 +0000
Received: by mail-pg1-f197.google.com with SMTP id p13so13266115pgk.18
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2020 04:12:17 -0700 (PDT)
In-Reply-To: <20200324110930.GH1134@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: ajayg@nvidia.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "open list:I2C CONTROLLER DRIVER FOR NVIDIA GPU" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Hi Wolfram,

> On Mar 24, 2020, at 19:09, Wolfram Sang <wsa@the-dreams.de> wrote:
> 
> 
>> 	} while (time_is_after_jiffies(target));
>> 
>> -	if (time_is_before_jiffies(target)) {
>> +	if (time_is_before_eq_jiffies(target)) {
> 
> While unlikely, there is a tiny race between the time_is_* calls,
> jiffies could update inbetween them.
> 
> So, for the sake of good programming practice, I'd recommend to set a
> flag in the do_while-loop and the have the logic above solely based on
> the flag.
> 

Ok, I'll send a v2 based on your suggestion.

Kai-Heng
