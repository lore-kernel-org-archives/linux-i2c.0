From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-tools: lib/Module.mk: fixing LIB_LINKS dependency
Date: Thu, 14 Dec 2017 09:36:49 +0100
Message-ID: <20171214093649.61e8f1df@endymion>
References: <1513011624-1555-1-git-send-email-angelo@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbdLNIgv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 14 Dec 2017 03:36:51 -0500
In-Reply-To: <1513011624-1555-1-git-send-email-angelo@amarulasolutions.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Angelo Compagnucci <angelo@amarulasolutions.com>
Cc: linux-i2c@vger.kernel.org

Hi Angelo,

On Mon, 11 Dec 2017 18:00:24 +0100, Angelo Compagnucci wrote:
> LIB_LINKS should be added as a dependency only when
> BUILD_DYNAMIC_LIB is enabled
> 
> Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> ---
>  lib/Module.mk | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/lib/Module.mk b/lib/Module.mk
> index 8a58f5b..de189a2 100644
> --- a/lib/Module.mk
> +++ b/lib/Module.mk
> @@ -27,10 +27,9 @@ LIB_SHSONAME	:= $(LIB_SHBASENAME).$(LIB_MAINVER)
>  LIB_SHLIBNAME	:= $(LIB_SHBASENAME).$(LIB_VER)
>  LIB_STLIBNAME	:= libi2c.a
>  
> -LIB_LINKS	:= $(LIB_SHSONAME) $(LIB_SHBASENAME)
> -
>  LIB_TARGETS	:=
>  ifeq ($(BUILD_DYNAMIC_LIB),1)
> +LIB_LINKS	:= $(LIB_SHSONAME) $(LIB_SHBASENAME)
>  LIB_TARGETS	+= $(LIB_SHLIBNAME)
>  endif
>  ifeq ($(BUILD_STATIC_LIB),1)

This is correct, good catch. I'll commit it. In fact I thought about it
when reviewing your previous patch, but (wrongly) assumed it did not
matter. After adding all the missing dependencies, it clearly does.

I have noticed another problem. While "make BUILD_STATIC_LIB=0"
actually prevents the static flavor of the library from being built,
"make BUILD_DYNAMIC_LIB=0" does not prevent the dynamic flavor of the
library from being built. The reason is that USE_STATIC_LIB is not set,
so tools depend on the dynamic library, which in turn gets built as a
dependency.

I suppose that BUILD_DYNAMIC_LIB=0 should imply USE_STATIC_LIB=1.
Something like:

--- a/Makefile
+++ b/Makefile
@@ -43,6 +43,8 @@ endif
 ifeq ($(BUILD_DYNAMIC_LIB),0)
 ifeq ($(BUILD_STATIC_LIB),0)
 $(error BUILD_DYNAMIC_LIB and BUILD_STATIC_LIB cannot be disabled at the same time)
+else
+USE_STATIC_LIB := 1
 endif
 endif

What do you think?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
