From: Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: Re: i2c-tools: lib/Module.mk: fixing LIB_LINKS dependency
Date: Thu, 14 Dec 2017 10:43:33 +0100
Message-ID: <CA+_SqVZ4dJBcL9+D3x42b0bJB2POasiu4Tz6gtTZHkmX=h56xg@mail.gmail.com>
References: <1513011624-1555-1-git-send-email-angelo@amarulasolutions.com> <20171214093649.61e8f1df@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34958 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdLNJoO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Dec 2017 04:44:14 -0500
Received: by mail-oi0-f47.google.com with SMTP id 184so3515498oii.2
        for <linux-i2c@vger.kernel.org>; Thu, 14 Dec 2017 01:44:14 -0800 (PST)
In-Reply-To: <20171214093649.61e8f1df@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>

DEar Jean,

On Thu, Dec 14, 2017 at 9:36 AM, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Angelo,
>
> On Mon, 11 Dec 2017 18:00:24 +0100, Angelo Compagnucci wrote:
>> LIB_LINKS should be added as a dependency only when
>> BUILD_DYNAMIC_LIB is enabled
>>
>> Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
>> ---
>>  lib/Module.mk | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/lib/Module.mk b/lib/Module.mk
>> index 8a58f5b..de189a2 100644
>> --- a/lib/Module.mk
>> +++ b/lib/Module.mk
>> @@ -27,10 +27,9 @@ LIB_SHSONAME       := $(LIB_SHBASENAME).$(LIB_MAINVER)
>>  LIB_SHLIBNAME        := $(LIB_SHBASENAME).$(LIB_VER)
>>  LIB_STLIBNAME        := libi2c.a
>>
>> -LIB_LINKS    := $(LIB_SHSONAME) $(LIB_SHBASENAME)
>> -
>>  LIB_TARGETS  :=
>>  ifeq ($(BUILD_DYNAMIC_LIB),1)
>> +LIB_LINKS    := $(LIB_SHSONAME) $(LIB_SHBASENAME)
>>  LIB_TARGETS  += $(LIB_SHLIBNAME)
>>  endif
>>  ifeq ($(BUILD_STATIC_LIB),1)
>
> This is correct, good catch. I'll commit it. In fact I thought about it
> when reviewing your previous patch, but (wrongly) assumed it did not
> matter. After adding all the missing dependencies, it clearly does.
>
> I have noticed another problem. While "make BUILD_STATIC_LIB=0"
> actually prevents the static flavor of the library from being built,
> "make BUILD_DYNAMIC_LIB=0" does not prevent the dynamic flavor of the
> library from being built. The reason is that USE_STATIC_LIB is not set,
> so tools depend on the dynamic library, which in turn gets built as a
> dependency.
>
> I suppose that BUILD_DYNAMIC_LIB=0 should imply USE_STATIC_LIB=1.
> Something like:
>
> --- a/Makefile
> +++ b/Makefile
> @@ -43,6 +43,8 @@ endif
>  ifeq ($(BUILD_DYNAMIC_LIB),0)
>  ifeq ($(BUILD_STATIC_LIB),0)
>  $(error BUILD_DYNAMIC_LIB and BUILD_STATIC_LIB cannot be disabled at the same time)
> +else
> +USE_STATIC_LIB := 1
>  endif
>  endif
>
> What do you think?

I think you are totally right. If BUILD_DYNAMIC_LIB is 0 the static
variant should be built and used too.

Could you realease a new version of i2c-tools with these patches? I'm
in the phase of updating the package in buildroot and I do really
prefer to have a new stable release than an old release with a bunch
of patches on top.

Thanks!

>
> Thanks,
> --
> Jean Delvare
> SUSE L3 Support
