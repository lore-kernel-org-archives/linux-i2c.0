Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117E5EB64DA
	for <linux-i2c@archiver.kernel.org>; Thu, 15 Jun 2023 21:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjFOVtL (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFOVtJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 15 Jun 2023 17:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428272965
        for <linux-i2c@vger.kernel.org>; Thu, 15 Jun 2023 14:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0FF26217D
        for <linux-i2c@vger.kernel.org>; Thu, 15 Jun 2023 21:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C87C433C8;
        Thu, 15 Jun 2023 21:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686865748;
        bh=8sfT0KKH+qYYgBJrgFZoZLtkBwqNnR7GCNpcWMQ+UUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRsJxNUbqlfJPPKOPDhm2y0ILJQN102G4C4kbWbEjRewzbffT5Lds29mzEPD0NJcl
         mAVQ6Y83HnqO22XFnikkP6t0el2ZB2MQqsNmo2tsjWclRWPefY8TjmwN97wc2iZZzC
         HmPWLh71yP+WTt+tMoRUJsFdZHOF4LmaqXvk0UYoq/AiHoc59HA7rq26d1//m+jJV1
         E68aS/EgO6aMvbpOuZs4Q4+kjGkazEpkG/dTMcu3bZ4E0Ehn2si7b9npYw8RyxWzpn
         oh9bi/0C88ubNx40X+zOmFBK5tS5kJ4CYkKzOCgnHV3RbEp7uhUumAZ+mpFlWMjBCB
         foe51A9bJo1Ug==
Date:   Thu, 15 Jun 2023 23:49:04 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH 2/4] i2c: i801: Replace acpi_lock with I2C bus lock
Message-ID: <20230615214904.uj2gpsq35kzczuss@intel.intel>
References: <c39c8371-5ab5-45f7-d3cf-39ea50de0afb@gmail.com>
 <8f88906f-c7da-eb3a-2f14-0f4d46202517@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f88906f-c7da-eb3a-2f14-0f4d46202517@gmail.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hi Heiner,

On Sat, Mar 04, 2023 at 10:33:05PM +0100, Heiner Kallweit wrote:
> I2C core ensures in i2c_smbus_xfer() that the I2C bus lock is held when
> calling the smbus_xfer callback. That's i801_access() in our case.
> I think it's safe in general to assume that the I2C bus lock is held
> when the smbus_xfer callback is called.
> Therefore I see no need to define an own mutex.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Thanks,
Andi
