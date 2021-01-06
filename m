Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADC0C433E0
	for <linux-i2c@archiver.kernel.org>; Wed,  6 Jan 2021 16:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F20123131
	for <linux-i2c@archiver.kernel.org>; Wed,  6 Jan 2021 16:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbhAFQDp (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:03:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:38232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbhAFQDp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 6 Jan 2021 11:03:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A5BEAAD75;
        Wed,  6 Jan 2021 16:03:03 +0000 (UTC)
Date:   Wed, 6 Jan 2021 17:03:02 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH v1 1/3] gpiolib: Follow usual pattern for
 gpiod_remove_lookup_table() call
Message-ID: <20210106170302.551cb579@endymion>
In-Reply-To: <20201228200618.58716-1-andriy.shevchenko@linux.intel.com>
References: <20201228200618.58716-1-andriy.shevchenko@linux.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Mon, 28 Dec 2020 22:06:16 +0200, Andy Shevchenko wrote:
> The usual pattern for the remove calls, like gpiod_remove_lookup_table(),
> is to be NULL-aware, i.o.w. become a no-op whenever parameter is NULL.
> Update gpiod_remove_lookup_table() call to follow this pattern.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index b02cc2abd3b6..611d6ea82d75 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -3460,6 +3460,10 @@ EXPORT_SYMBOL_GPL(gpiod_add_lookup_table);
>   */
>  void gpiod_remove_lookup_table(struct gpiod_lookup_table *table)
>  {
> +	/* Nothing to remove */
> +	if (!table)
> +		return;
> +
>  	mutex_lock(&gpio_lookup_lock);
>  
>  	list_del(&table->list);

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
