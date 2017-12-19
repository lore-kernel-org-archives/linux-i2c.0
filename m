From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c-tools: eeprog/Module.mk: Add missing dependency
Date: Tue, 19 Dec 2017 13:53:24 +0100
Message-ID: <20171219135324.20dd6e12@endymion>
References: <1513606297-5072-1-git-send-email-maxin.john@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36963 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755725AbdLSMx1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 19 Dec 2017 07:53:27 -0500
In-Reply-To: <1513606297-5072-1-git-send-email-maxin.john@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: maxin.john@gmail.com
Cc: linux-i2c@vger.kernel.org, "Maxin B. John" <maxin.john@intel.com>

On Mon, 18 Dec 2017 16:11:37 +0200, maxin.john@gmail.com wrote:
> From: "Maxin B. John" <maxin.john@intel.com>
> 
> Absence of this dependency caused parallel build to run into a race
> and break.
> 
> Signed-off-by: Maxin B. John <maxin.john@intel.com>
> ---
>  eeprog/Module.mk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/eeprog/Module.mk b/eeprog/Module.mk
> index 9d36869..d215855 100644
> --- a/eeprog/Module.mk
> +++ b/eeprog/Module.mk
> @@ -20,7 +20,7 @@ EEPROG_TARGETS	:= eeprog
>  # Programs
>  #
>  
> -$(EEPROG_DIR)/eeprog: $(EEPROG_DIR)/eeprog.o $(EEPROG_DIR)/24cXX.o
> +$(EEPROG_DIR)/eeprog: $(EEPROG_DIR)/eeprog.o $(EEPROG_DIR)/24cXX.o $(LIB_DEPS)
>  	$(CC) $(LDFLAGS) -o $@ $^ $(EEPROG_LDFLAGS)
>  
>  #

Good catch, sorry for missing that one. Applied, thanks.

-- 
Jean Delvare
SUSE L3 Support
