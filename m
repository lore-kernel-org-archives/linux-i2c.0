From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v6 1/5] irqchip/aspeed-i2c-ic: binding docs for Aspeed
 I2C Interrupt Controller
Date: Wed, 29 Mar 2017 23:11:45 +1100
Message-ID: <1490789505.3177.184.camel@kernel.crashing.org>
References: <20170328051226.21677-1-brendanhiggins@google.com>
         <20170328051226.21677-2-brendanhiggins@google.com>
         <1490690980.3177.108.camel@kernel.crashing.org>
         <CAFd5g47Pij6TxkmS6akWoAL0FZ2WLh+FWUrr099RiabWn+pneQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40589 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753381AbdC2MMv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 29 Mar 2017 08:12:51 -0400
In-Reply-To: <CAFd5g47Pij6TxkmS6akWoAL0FZ2WLh+FWUrr099RiabWn+pneQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, Marc Zyngier <marc.zyngier@arm.com>, Joel Stanley <joel@jms.id.au>, Vladimir Zapolskiy <vz@mleia.com>, Kachalov Anton <mouse@mayc.ru>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>

On Wed, 2017-03-29 at 03:34 -0700, Brendan Higgins wrote:
> I think I addressed this on the other email with the actual driver.
> Anyway, I thought that this is pretty much the dummy irqchip code is
> for; I have seen some other drivers do the same thing. It is true
> that
> this is a really basic "interrupt controller;" it cannot mask on its
> own, etc; nevertheless, I think you will pretty much end up with the
> same code for an "I2C controller;" it just won't use an irq_domain.

Don't worry too much about this. As I think I mention it's not a huge
deal at this stage, I just wanted to make sure you were aware of the
compromise(s) involved.

Regarding the other comment about the "fast mode", my main worry here
is that somebody might come up with a 2Mhz capable device, we'll hit
your 1Mhz test, enable fast mode, and shoot it with 3.4Mhz which it
might not be happy at all about...

I think the cut-off for switching to the "fast" mode should basically
be the fast speed mode frequency (which isn't clear from the spec but
seems to be 3.4Mhz). Otherwise people will end up with higher speeds
than what they asked for and that's bad.

Cheers,
Ben.
