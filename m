From: Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: Re: [PATCH i2c-tools] tools/Module.mk: Add missing dependencies
Date: Wed, 13 Dec 2017 11:36:31 +0100
Message-ID: <CA+_SqVY_3mrB17KWFaJYJefb7wpeYi5MhRXpcMoyQfGi1eQ0fQ@mail.gmail.com>
References: <20171212213355.5f25754e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46831 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbdLMKhM (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 13 Dec 2017 05:37:12 -0500
Received: by mail-oi0-f67.google.com with SMTP id t81so1225048oih.13
        for <linux-i2c@vger.kernel.org>; Wed, 13 Dec 2017 02:37:12 -0800 (PST)
In-Reply-To: <20171212213355.5f25754e@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>

On Tue, Dec 12, 2017 at 9:33 PM, Jean Delvare <jdelvare@suse.de> wrote:
> Better build the library before building the tools which link against
> it, otherwise parallel builds could run into a race and break.

Tested-by: Angelo Compagnucci <angelo@amarulasolutions.com>
Acked-by: Angelo Compagnucci <angelo@amarulasolutions.com>

> ---
>  lib/Module.mk   |    7 +++++++
>  tools/Module.mk |   10 +++++-----
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> --- a/lib/Module.mk
> +++ b/lib/Module.mk
> @@ -35,6 +35,13 @@ LIB_TARGETS  += $(LIB_STLIBNAME)
>  LIB_OBJECTS    += smbus.ao
>  endif
>
> +# Library file to link against (static or dynamic)
> +ifeq ($(USE_STATIC_LIB),1)
> +LIB_DEPS       := $(LIB_DIR)/$(LIB_STLIBNAME)
> +else
> +LIB_DEPS       := $(LIB_DIR)/$(LIB_SHBASENAME)
> +endif
> +
>  #
>  # Libraries
>  #
> --- a/tools/Module.mk
> +++ b/tools/Module.mk
> @@ -24,19 +24,19 @@ TOOLS_TARGETS       := i2cdetect i2cdump i2cse
>  # Programs
>  #
>
> -$(TOOLS_DIR)/i2cdetect: $(TOOLS_DIR)/i2cdetect.o $(TOOLS_DIR)/i2cbusses.o
> +$(TOOLS_DIR)/i2cdetect: $(TOOLS_DIR)/i2cdetect.o $(TOOLS_DIR)/i2cbusses.o $(LIB_DEPS)
>         $(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
>
> -$(TOOLS_DIR)/i2cdump: $(TOOLS_DIR)/i2cdump.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
> +$(TOOLS_DIR)/i2cdump: $(TOOLS_DIR)/i2cdump.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o $(LIB_DEPS)
>         $(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
>
> -$(TOOLS_DIR)/i2cset: $(TOOLS_DIR)/i2cset.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
> +$(TOOLS_DIR)/i2cset: $(TOOLS_DIR)/i2cset.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o $(LIB_DEPS)
>         $(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
>
> -$(TOOLS_DIR)/i2cget: $(TOOLS_DIR)/i2cget.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
> +$(TOOLS_DIR)/i2cget: $(TOOLS_DIR)/i2cget.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o $(LIB_DEPS)
>         $(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
>
> -$(TOOLS_DIR)/i2ctransfer: $(TOOLS_DIR)/i2ctransfer.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o
> +$(TOOLS_DIR)/i2ctransfer: $(TOOLS_DIR)/i2ctransfer.o $(TOOLS_DIR)/i2cbusses.o $(TOOLS_DIR)/util.o $(LIB_DEPS)
>         $(CC) $(LDFLAGS) -o $@ $^ $(TOOLS_LDFLAGS)
>
>  #
>
>
> --
> Jean Delvare
> SUSE L3 Support
