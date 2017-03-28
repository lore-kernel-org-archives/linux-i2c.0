From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 1/2] i2c: aspeed: added driver for Aspeed I2C
Date: Mon, 27 Mar 2017 22:22:25 -0700
Message-ID: <CAFd5g44EvJoZezud6QHMupY4zz2b+VpgvJFNDXz3AsOaAGHdjA@mail.gmail.com>
References: <1480467618-7497-1-git-send-email-brendanhiggins@google.com>
 <1480467618-7497-2-git-send-email-brendanhiggins@google.com> <3236642a-3907-d54f-a091-6a952d8ff1c9@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:36640 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752539AbdC1FW1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Mar 2017 01:22:27 -0400
Received: by mail-qt0-f182.google.com with SMTP id r45so55432500qte.3
        for <linux-i2c@vger.kernel.org>; Mon, 27 Mar 2017 22:22:26 -0700 (PDT)
In-Reply-To: <3236642a-3907-d54f-a091-6a952d8ff1c9@mleia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Kachalov Anton <mouse@mayc.ru>, robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, OpenBMC Maillist <openbmc@lists.ozlabs.org>

I think most of these comments were pretty straightforward except for
pulling out the "struct aspeed_i2c_controller" into a interrupt
controller, which is now known as "struct aspeed_i2c_ic". See
https://lkml.org/lkml/2017/3/28/20 for details.
