From: Kieran Bingham <kieranbingham@gmail.com>
Subject: Re: [PATCH] i2c: return probe deferred status on dev_pm_domain_attach
Date: Mon, 12 Oct 2015 12:15:54 +0100
Message-ID: <CAB3z_RpBxhuiCXO00g1zgNvHFZx+cn4Dx6RYhQHtkFjW4L0nwA@mail.gmail.com>
References: <1444563571-12247-1-git-send-email-kieranbingham@gmail.com>
	<20151012072312.GB1477@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35059 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbbJLLP4 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Oct 2015 07:15:56 -0400
In-Reply-To: <20151012072312.GB1477@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Wolfram,

On 12 October 2015 at 08:23, Wolfram Sang <wsa@the-dreams.de> wrote:
> Hi Kiera,
>
> On Sun, Oct 11, 2015 at 12:39:31PM +0100, Kieran Bingham wrote:
>> A change of return status was introduced in commit 3fffd1283927
>> ("i2c: allow specifying separate wakeup interrupt in device tree")
>
> Thanks for catching this!

NP : Saw it when re-basing my other series.

>> The commit prevents the defer status being passed up the call stack
>> appropriately when dev_pm_domain_attach returns -EPROBE_DEFER.
>>
>> To fix we change this back to the original return status;
>
> What about going to the error path?

Sounds reasonable :D


>> Signed-off-by: Kieran Bingham <kieranbingham@gmail.com>
>
> Please add a "Fixes: <sha1>" tag here.

Sure.

>
>    Wolfram
>
