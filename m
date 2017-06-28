From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 4/5] i2c: pca-platform: use device managed allocations
Date: Wed, 28 Jun 2017 12:23:00 +0300
Message-ID: <CAHp75VfE=gCO3EDvadxar=qdnqMHKAZg2TSvXBtYebx+Y_agEw@mail.gmail.com>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz> <20170626004434.2757-5-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33503 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdF1JXB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Jun 2017 05:23:01 -0400
In-Reply-To: <20170626004434.2757-5-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 26, 2017 at 3:44 AM, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> Switch to using the devm_ APIs and remove the now unnecessary error
> handling and most of the device removal code.


>         if (i2c_pca_add_numbered_bus(&i2c->adap) < 0) {
> -               ret = -ENODEV;
> -               goto e_adapt;
> +               return -ENODEV;

This is still shadows the actual error code.

-- 
With Best Regards,
Andy Shevchenko
