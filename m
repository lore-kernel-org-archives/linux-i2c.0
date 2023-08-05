Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAE1C0015E
	for <linux-i2c@archiver.kernel.org>; Sat,  5 Aug 2023 16:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjHEQxO (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sat, 5 Aug 2023 12:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjHEQxN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 5 Aug 2023 12:53:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6C31BD
        for <linux-i2c@vger.kernel.org>; Sat,  5 Aug 2023 09:53:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D07360B38
        for <linux-i2c@vger.kernel.org>; Sat,  5 Aug 2023 16:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB36C433C8;
        Sat,  5 Aug 2023 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691254391;
        bh=eQLWtSBsbN4fccoBk3bDrKLVG7PNvgEkjV4ufFawA2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CCErFRiZN612xZTez4U+5rtW8eihSUCmgWgay/Tt5oFot1ZFvmArrRoPil+AgUnQr
         eu2ruShIo63gxLj7LG0fuh7KudXRFGAOtKYq8wBNjPqfxEzB+Zb8gLoSgiOyJ42vht
         W49y6acQvB6FAE1qAaUkxQJMnX/DxfndSsYrVrYtMjIlaA1fjtRYAbLcVP03yo+GaX
         l6psOTFzQhZIkQ7zEyNMc8cHjkmGgm+SQITcPQT1m7cYTPyaRkR9+eLlOc9t7cYh72
         HJY8a5Eyw320h/3WuAjcItREpwYA+qzHC81NHrVqzgzK2sXnQ2oM4k/YLviAMOXJ0M
         MbxOTWRjWEtAA==
Date:   Sat, 5 Aug 2023 18:53:08 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel@pengutronix.de, linux-i2c@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Pavel Machek <pavel@ucw.cz>, Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH] i2c: Drop legacy callback .probe_new()
Message-ID: <20230805165308.qm544yp424ifkb2r@intel.intel>
References: <20230626094548.559542-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626094548.559542-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi,

On Mon, Jun 26, 2023 at 11:45:48AM +0200, Uwe Kleine-König wrote:
> Now that all drivers are converted to the (new) .probe() callback, the
> temporary .probe_new() can go away. \o/
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

this patch has not been taken yet anywhere, so that I'm in time
for

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi
