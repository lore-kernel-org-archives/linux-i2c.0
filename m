From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 2/2] i2c: aspeed: added documentation for Aspeed I2C driver
Date: Fri, 23 Sep 2016 15:32:03 +0930
Message-ID: <CACPK8XcWbgfW_==aVjUataA2Yk26TSaO2o3Vt0pR68qKpkYxuA@mail.gmail.com>
References: <201609100847.j1qUadzy%fengguang.wu@intel.com> <1473472551-11149-1-git-send-email-brendanhiggins@google.com>
 <1473472551-11149-2-git-send-email-brendanhiggins@google.com>
 <20160919213536.GA19274@rob-hp-laptop> <CAFd5g46WR34A1FLNvuRck84EX1F3gbPDnDuBo2j-SVUEJPvXfg@mail.gmail.com>
 <CAFd5g46j02sb2w_DwaXAgnfcO=ONmJGZwqdRneNd0QHq-t53rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34690 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757734AbcIWGCY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 23 Sep 2016 02:02:24 -0400
In-Reply-To: <CAFd5g46j02sb2w_DwaXAgnfcO=ONmJGZwqdRneNd0QHq-t53rA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Rob Herring <robh@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Jeremy Kerr <jk@ozlabs.org>

Hi Brendan,

On Wed, Sep 21, 2016 at 3:35 AM, Brendan Higgins
<brendanhiggins@google.com> wrote:
> First off, someone pointed out to me that the mapping that I used between
> addresses and bus numbers is not actually valid for busses 8-14.
>
> This could be fixed by checking the offset, but I am wondering if that is
> the right way to do it. It seems like this is not completely trivial so
> maybe this should be specified in the device tree? If that is the case,
> should I do this as another reg entry or go back to the way I was doing it
> before?

I don't see an alternative way to derive these numbers. As you
mention, the block of SRAM in the middle of the IP screwing up the
linear mapping.

I suggest going back to what you have in v2, with a mention in the
commit message as to why the bus property is necessary.

Cheers,

Joel
