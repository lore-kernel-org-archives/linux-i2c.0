Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22D4C4167B
	for <linux-i2c@archiver.kernel.org>; Wed, 14 Dec 2022 06:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiLNGgz (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 14 Dec 2022 01:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLNGgy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Dec 2022 01:36:54 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EF11D66C;
        Tue, 13 Dec 2022 22:36:53 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3894B4A7;
        Wed, 14 Dec 2022 07:36:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1670999811;
        bh=pqZLJjSLZAKxhBkbCIz4ymcYgzML4TSQQaUHOIzQK9c=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=stcPsomhROJ0IEAxFOqvYJcwyKvlwiSHYq63GqfXtMEoGIyb6+92BaLTJNZbXU/CA
         26Xk9yrjqHeJP3crOTBCTIKMzfXUAu3JuY7qmEv7qVlSLId8AgwkvMfyaHFhPasYPE
         yYNS0g7Bqg77U0SFtLaNatxSca2qXYlR7vixmksg=
Message-ID: <7ddd576f-6e8a-7581-178c-2e8575227811@ideasonboard.com>
Date:   Wed, 14 Dec 2022 08:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 7/8] media: i2c: add DS90UB913 driver
Content-Language: en-US
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Shawn Tu <shawnx.tu@intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mike Pagano <mpagano@gentoo.org>,
        =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>,
        Marek Vasut <marex@denx.de>
References: <20221208104006.316606-1-tomi.valkeinen@ideasonboard.com>
 <20221208104006.316606-8-tomi.valkeinen@ideasonboard.com>
 <Y5YiazDtaxtLJyL0@pendragon.ideasonboard.com>
 <4d349785-ca37-d930-db3c-2581bba9fde0@ideasonboard.com>
In-Reply-To: <4d349785-ca37-d930-db3c-2581bba9fde0@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 14/12/2022 08:29, Tomi Valkeinen wrote:

>> wondering if the struct device of the DS90UB913 could be passed instead
>> of the port, to avoid passing the port throught
>> ds90ub9xx_platform_data.
> 
> Interesting thought. That would limit the number of remote i2c busses to 
> one, though. Not a problem for FPD-Link, but I wonder if that's assuming 
> too much for the future users. Then again, this is an in-kernel API so 
> we could extend it later if needed. So I'll try this out and see if I 
> hit any issues.

Right, so the issue with this one would be that it would prevent a 
single device uses. E.g. a single chip which acts as an ATR (similar to 
i2c-mux chips), i.e. it contains both the main and the remote i2c busses.

  Tomi

