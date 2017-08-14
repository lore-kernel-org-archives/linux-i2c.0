From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v1] i2c: aspeed: fixed potential null pointer dereference
Date: Mon, 14 Aug 2017 13:21:19 +0930
Message-ID: <CACPK8XfVrsg1KyxQBRJZf4Qn6mZaL2XPDMUwFoKgEAYL8SmP_A@mail.gmail.com>
References: <20170729010012.5032-1-brendanhiggins@google.com> <20170812113250.iydbbggbcvfvhxyo@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36562 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdHNDvl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 13 Aug 2017 23:51:41 -0400
In-Reply-To: <20170812113250.iydbbggbcvfvhxyo@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Patrick Venture <venture@google.com>, linux-i2c@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Aug 12, 2017 at 9:02 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Fri, Jul 28, 2017 at 06:00:12PM -0700, Brendan Higgins wrote:
>> Before I skipped null checks when the master is in the STOP state; this
>> fixes that.
>>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>
> Is there a suitable "Fixes:" tag for this?
>

The driver was introduced in 4.13, so we could add:

Fixes: f327c686d3ba ("i2c: aspeed: added driver for Aspeed I2C")

Cheers,

Joel
