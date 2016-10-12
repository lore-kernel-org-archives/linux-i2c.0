From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v3 2/2] i2c: aspeed: added documentation for Aspeed I2C driver
Date: Wed, 12 Oct 2016 13:01:29 -0700
Message-ID: <CAFd5g47UYhgNO8SE8jcVGcV7Ti1xnwgQWMzKF17i3e1WFC9e9Q@mail.gmail.com>
References: <CAFd5g47W-dGVt6hA+FSpqxCqvd5ZpQP=FCCpYGErahF0iKqTEQ@mail.gmail.com>
 <1474327414-651-1-git-send-email-brendanhiggins@google.com>
 <1474327414-651-2-git-send-email-brendanhiggins@google.com> <20160923180219.GA9401@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yb0-f175.google.com ([209.85.213.175]:34931 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755906AbcJLUBa (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 12 Oct 2016 16:01:30 -0400
Received: by mail-yb0-f175.google.com with SMTP id 184so23399657yby.2
        for <linux-i2c@vger.kernel.org>; Wed, 12 Oct 2016 13:01:30 -0700 (PDT)
In-Reply-To: <20160923180219.GA9401@rob-hp-laptop>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>

I never got an acknowledgement to this email:
http://www.spinics.net/lists/devicetree/msg143944.html
The "bus" number is something that is defined as part of the hardware
specification for this device.

It seems we will not be able to do away with the "bus" number parameter.

Joel suggested going back to the way I was originally doing it:
http://www.spinics.net/lists/devicetree/msg144134.html

Cheers
