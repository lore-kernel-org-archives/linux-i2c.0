From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/2] i2c: meson: add gxbb compatible string
Date: Wed, 14 Sep 2016 08:19:02 -0700
Message-ID: <7hr38mmrvd.fsf@baylibre.com>
References: <1473846557-18123-1-git-send-email-jbrunet@baylibre.com>
        <1473846557-18123-2-git-send-email-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32940 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756348AbcINPTT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Sep 2016 11:19:19 -0400
Received: by mail-pf0-f173.google.com with SMTP id g202so6713003pfb.0
        for <linux-i2c@vger.kernel.org>; Wed, 14 Sep 2016 08:19:03 -0700 (PDT)
In-Reply-To: <1473846557-18123-2-git-send-email-jbrunet@baylibre.com> (Jerome
        Brunet's message of "Wed, 14 Sep 2016 11:49:16 +0200")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Carlo Caione <carlo@caione.org>, Neil Armstrong <narmstrong@baylibre.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> From: Neil Armstrong <narmstrong@baylibre.com>
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/i2c/busses/i2c-meson.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
> index 76e28980904f..30977e31cd98 100644
> --- a/drivers/i2c/busses/i2c-meson.c
> +++ b/drivers/i2c/busses/i2c-meson.c
> @@ -473,6 +473,7 @@ static int meson_i2c_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id meson_i2c_match[] = {
>  	{ .compatible = "amlogic,meson6-i2c" },
> +	{ .compatible = "amlogic,meson-gxbb-i2c" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, meson_i2c_match);
