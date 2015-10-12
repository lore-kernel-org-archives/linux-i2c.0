From: Kieran Bingham <kieranbingham@gmail.com>
Subject: Re: [RESEND PATCH v4 0/8] i2c: Relax mandatory I2C ID table passing
Date: Mon, 12 Oct 2015 12:36:24 +0100
Message-ID: <CAB3z_RrOKvQW5GiTEP2zqMaQ=EtpsqHB1GmUm-+D+12NM=USOg@mail.gmail.com>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
	<20151009211636.GA1481@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36765 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbbJLLg0 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Oct 2015 07:36:26 -0400
In-Reply-To: <20151009211636.GA1481@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>

Hi Wolfram,

On 9 October 2015 at 22:16, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> As said to Kieran personally in Dublin, I want a verification that all
> binding methods still work, especially runtime instantiation for drivers
> without i2c_device_ids.

Ok, I should be able to find some time to look at that this week.

>  Also, for the last patch, a verification should
> be done if the drivers i2c_device_id hasn't been used meanwhile.

I'll see what I can do ...

> I'd also like to see 'probe_new' instead of 'probe2' for the new function
> name. That should be it.

Ok, obviously this is only a temporary naming so I don't mind either way,
I'll do a rename for the next version

I've also just found a compile failure to fix up on !CONFIG_OF, this
can make its way into the respin.

>
> Thanks,
>
>    Wolfram

Regards

Kieran
