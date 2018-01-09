From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] lib/Module.mk: don't install dynamic library when
 disabled
Date: Tue, 9 Jan 2018 10:10:33 +0100
Message-ID: <20180109101033.53eb7625@endymion>
References: <ae2e0c9708aeb4a8fb301a1a4016cec7b05fc142.1514869230.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbeAIJKi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 9 Jan 2018 04:10:38 -0500
In-Reply-To: <ae2e0c9708aeb4a8fb301a1a4016cec7b05fc142.1514869230.git.baruch@tkos.co.il>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: linux-i2c@vger.kernel.org, Angelo Compagnucci <angelo@amarulasolutions.com>

Hi Baruch,

On Tue,  2 Jan 2018 07:00:30 +0200, Baruch Siach wrote:
> Do not attempt to install the dynamic library when build of that library
> is disabled. Fixes the following installation error:
> 
> install -m 755 lib/libi2c.so.0.1.0 .../target/usr/lib
> install: cannot stat 'lib/libi2c.so.0.1.0': No such file or directory
> lib/Module.mk:90: recipe for target 'install-lib' failed
> 
> Cc: Angelo Compagnucci <angelo@amarulasolutions.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  lib/Module.mk | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/Module.mk b/lib/Module.mk
> index 2ebc70d76ed9..c492961e0a4a 100644
> --- a/lib/Module.mk
> +++ b/lib/Module.mk
> @@ -88,9 +88,11 @@ clean-lib:
>  
>  install-lib: $(addprefix $(LIB_DIR)/,$(LIB_TARGETS))
>  	$(INSTALL_DIR) $(DESTDIR)$(libdir)
> +ifeq ($(BUILD_DYNAMIC_LIB),1)
>  	$(INSTALL_PROGRAM) $(LIB_DIR)/$(LIB_SHLIBNAME) $(DESTDIR)$(libdir)
>  	$(LN) $(LIB_SHLIBNAME) $(DESTDIR)$(libdir)/$(LIB_SHSONAME)
>  	$(LN) $(LIB_SHSONAME) $(DESTDIR)$(libdir)/$(LIB_SHBASENAME)
> +endif
>  ifeq ($(BUILD_STATIC_LIB),1)
>  	$(INSTALL_DATA) $(LIB_DIR)/$(LIB_STLIBNAME) $(DESTDIR)$(libdir)
>  endif

Ugh, this avalanche of fix-up patches is getting embarrassing :(

Thanks for the fix, committed.

-- 
Jean Delvare
SUSE L3 Support
