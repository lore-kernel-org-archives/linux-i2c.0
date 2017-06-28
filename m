From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 5/5] i2c: pca-platform: use dev_warn/dev_info instead
 of printk
Date: Wed, 28 Jun 2017 13:57:01 +0300
Message-ID: <CAHp75VcSe641XecqUMCHgrDo9=iQgX-Ywt6TQBbTC5RvRD3rEg@mail.gmail.com>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz> <20170626004434.2757-6-chris.packham@alliedtelesis.co.nz>
 <CAHp75Ve-JFBMofDwoKKENL-AggXqMpKd7CbRZwJuPKWML13apA@mail.gmail.com> <20170628093717.wryvtbsxisilo3a2@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34199 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbdF1K5N (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Jun 2017 06:57:13 -0400
In-Reply-To: <20170628093717.wryvtbsxisilo3a2@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jun 28, 2017 at 12:37 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Not a chance! Where is the commit message?
>
> Don't you think $subject is clear enough?

I would add the comment at least on how the output is changed since
pr_*("%s:"..., i2c->adap.name,...)  to dev_*(&pdev->dev, ...)
replacement.

-- 
With Best Regards,
Andy Shevchenko
