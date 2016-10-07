From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL REQUEST] i2c for 4.9
Date: Fri, 7 Oct 2016 14:17:20 -0700
Message-ID: <CA+55aFxDBznCn_ui65W2F06ubZkdVVt2nQWn+ACFQpAQ26+aUw@mail.gmail.com>
References: <20161007093226.GA2058@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35515 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932146AbcJGVRW (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 7 Oct 2016 17:17:22 -0400
In-Reply-To: <20161007093226.GA2058@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Oct 7, 2016 at 2:32 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> here is the 4.9 pull request from I2C including:

Would you mind double-checking my merge.

It looked very trivial, but it would be good to have somebody else
give that gpio-pca953x.c conflict a look to verify that I didn't screw
up the 'id' variable split.

                    Linus
