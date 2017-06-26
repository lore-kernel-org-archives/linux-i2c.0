From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v11 3/4] i2c: aspeed: added driver for Aspeed I2C
Date: Mon, 26 Jun 2017 15:48:57 +0930
Message-ID: <CACPK8XepziqsQVC6R_97s24=8o5F-TZCO1+opZxBJW8SNHRHkg@mail.gmail.com>
References: <20170620211516.13095-1-brendanhiggins@google.com>
 <20170620211516.13095-4-brendanhiggins@google.com> <20170623184305.xqqhjgrbdmgk6lsr@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34319 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbdFZGTT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 26 Jun 2017 02:19:19 -0400
In-Reply-To: <20170623184305.xqqhjgrbdmgk6lsr@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Brendan Higgins <brendanhiggins@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <gregkh@linuxfoundation.org>, "David S . Miller" <davem@davemloft.net>, mchehab@kernel.org, martin.petersen@oracle.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Rick Altherr <raltherr@google.com>

On Sat, Jun 24, 2017 at 4:13 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Tue, Jun 20, 2017 at 02:15:15PM -0700, Brendan Higgins wrote:
>> Added initial master support for Aspeed I2C controller. Supports
>> fourteen busses present in AST24XX and AST25XX BMC SoCs by Aspeed.
>>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>
> Applied to for-next, thanks for all the hard work!

Congratulations Brendan. It's great to see this driver in the tree.

Cheers,

Joel
