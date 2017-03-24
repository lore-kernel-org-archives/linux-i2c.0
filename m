From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 05/10] i2c: meson: use full 12 bits for clock divider
Date: Fri, 24 Mar 2017 07:49:04 +0100
Message-ID: <9858a64d-85de-0798-affc-ab97e36c365b@gmail.com>
References: <1a2ecdc8-a326-a7a7-22ec-658fd147daf4@gmail.com>
 <fbc241ed-ec1e-b433-50af-5d0ebca09711@gmail.com>
 <20170323203404.nuobb4wtgsepnilu@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33718 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdCXGtY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 24 Mar 2017 02:49:24 -0400
Received: by mail-wr0-f195.google.com with SMTP id 20so687469wrx.0
        for <linux-i2c@vger.kernel.org>; Thu, 23 Mar 2017 23:49:23 -0700 (PDT)
In-Reply-To: <20170323203404.nuobb4wtgsepnilu@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 23.03.2017 um 21:34 schrieb Wolfram Sang:
> 
>> +	/* clock divider has 12 bits */
>> +	WARN_ON(div >= (1 << 12));
> 
> Do you insist on WARN_ON? I wonder what it gives over dev_err?
> 
Right, as we just read the bus frequency from DT there's not
really a benefit in seeing the call trace. I'll change it.
