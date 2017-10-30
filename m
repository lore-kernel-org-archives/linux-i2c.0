From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3] i2c: aspeed: Deassert reset in probe
Date: Tue, 31 Oct 2017 07:05:46 +1100
Message-ID: <1509393946.26914.0.camel@kernel.crashing.org>
References: <20171030034438.26482-1-joel@jms.id.au>
         <20171030142446.rsvytlcfcuhnkhdj@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48469 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbdJ3UZv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 30 Oct 2017 16:25:51 -0400
In-Reply-To: <20171030142446.rsvytlcfcuhnkhdj@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Joel Stanley <joel@jms.id.au>
Cc: Brendan Higgins <brendanhiggins@google.com>, Philipp Zabel <philipp.zabel@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2017-10-30 at 15:24 +0100, Wolfram Sang wrote:
> checkpatch --strict says:
> 
> CHECK: braces {} should be used on all arms of this statement

And checkpatch should die a horrible death, so what ? :-)

Sorry, I can't help but trolling here when checkpatch enforce obviously
disgusting and wasteful coding style.

Ben.
