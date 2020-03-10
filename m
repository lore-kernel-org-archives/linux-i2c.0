From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] macintosh: windfarm: fix MODINFO regression
Date: Tue, 10 Mar 2020 22:05:09 +1100
Message-ID: <87wo7sii6y.fsf@mpe.ellerman.id.au>
References: <20200303125046.5157-1-wsa@the-dreams.de> <20200310091155.GA1987@ninjato>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:44559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgCJLFO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 10 Mar 2020 07:05:14 -0400
In-Reply-To: <20200310091155.GA1987@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linuxppc-dev@lists.ozlabs.org
Cc: linux-i2c@vger.kernel.org, debian-powerpc@lists.debian.org, Mathieu Malaterre <malat@debian.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Erhard Furtner <erhard_f@mailbox.org>

Wolfram Sang <wsa@the-dreams.de> writes:
> On Tue, Mar 03, 2020 at 01:50:46PM +0100, Wolfram Sang wrote:
>> Commit af503716ac14 made sure OF devices get an OF style modalias with
>> I2C events. It assumed all in-tree users were converted, yet it missed
>> some Macintosh drivers.
>> 
>> Add an OF module device table for all windfarm drivers to make them
>> automatically load again.
>> 
>> Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices registered via OF")
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199471
>> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
>> Tested-by: Erhard Furtner <erhard_f@mailbox.org>
>> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>
> Michael, I can take this via I2C again, if you ack it.

Thanks, done.

cheers
