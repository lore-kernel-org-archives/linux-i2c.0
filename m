From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v4 1/2] i2c: aspeed: added driver for Aspeed I2C
Date: Wed, 23 Nov 2016 15:52:42 -0800
Message-ID: <CAFd5g459KtB1YemK31nyoNV7VrqDGtpuGd9q=i-Ha9-CJ8VstA@mail.gmail.com>
References: <1478311099-6771-1-git-send-email-brendanhiggins@google.com>
 <1478311099-6771-2-git-send-email-brendanhiggins@google.com> <28078e6d-f5e4-da59-e226-baa9a60a4b19@kaod.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34583 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933813AbcKWXwu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Nov 2016 18:52:50 -0500
Received: by mail-qt0-f176.google.com with SMTP id n6so26393432qtd.1
        for <linux-i2c@vger.kernel.org>; Wed, 23 Nov 2016 15:52:43 -0800 (PST)
In-Reply-To: <28078e6d-f5e4-da59-e226-baa9a60a4b19@kaod.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, linux-i2c@vger.kernel.org

> is it safe to start a new transaction when in a interrupt handler ?

Yep, i2c_transfer and most of the other functions in the i2c API that
wrap the implementations already lock for you.

> Why do you multiply by * msg->len ?

I thought it might make sense to make timeout proportional to message
length, so their would be a timeout per byte, like what the hardware
already does. I guess we should just leave that up to the user to
determine on their own?

> use devm_kzalloc() may be ?

Whoops, good catch. Will update in next version.
