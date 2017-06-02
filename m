From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v9 5/5] i2c: aspeed: added slave support for Aspeed I2C
 driver
Date: Fri, 02 Jun 2017 22:04:50 +1000
Message-ID: <1496405090.2842.5.camel@kernel.crashing.org>
References: <20170602084603.30811-1-brendanhiggins@google.com>
         <20170602084603.30811-6-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44779 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbdFBMKm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Jun 2017 08:10:42 -0400
In-Reply-To: <20170602084603.30811-6-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org, ryan_chen@aspeedtech.com
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org

On Fri, 2017-06-02 at 01:46 -0700, Brendan Higgins wrote:
> Added slave support for Aspeed I2C controller. Supports fourteen busses
> present in AST24XX and AST25XX BMC SoCs by Aspeed.

(Not an issue for merging)

Have you looked at a "mode" by which you implement just enough of the
slave support to decode smbus notifications ?

This looks like it could be useful when using pmbus devices, as some of
them use smbus notifications fairly often.

Today only one driver calls i2c_handle_smbus_host_notify() (the Intel
one of course).

Cheers,
Ben.
