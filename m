From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 7/7] i2c: bcm2835: Add support for dynamic clock
Date: Thu, 29 Sep 2016 00:10:37 +0200
Message-ID: <05d1c9d8-644e-a2b1-2853-67b7b77f8509@tronnes.org>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
 <1475085056-5205-8-git-send-email-noralf@tronnes.org>
 <87r383g1kb.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.domeneshop.no ([194.63.252.55]:41316 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753890AbcI1WKo (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Sep 2016 18:10:44 -0400
In-Reply-To: <87r383g1kb.fsf@eliezer.anholt.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, wsa@the-dreams.de, swarren@wwwdotorg.org
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org


Den 28.09.2016 23:24, skrev Eric Anholt:
> Noralf Trønnes <noralf@tronnes.org> writes:
>
>> Support a dynamic clock by reading the frequency and setting the
>> divisor in the transfer function instead of during probe.
> Is this fixing some particular case you could note in the commit
> message?  As is, it makes me think that we should be using a notifier
> for when the parent clock (that's the one I assume you're talking about
> being dynamic) changes.  But maybe you're working around a variable VPU
> clock being set by the firmware, because we don't have a notifier for
> it?
>
> I'm a bit worried because I think this is going to be pretty expensive
> to be doing per transfer.

Actually I thought that this was a known problem, but trying to track
it down now, I can't find anything definitive. I don't have any tool
to look at the bus signals, so I couldn't actually test it.
Sorry about this, we can just drop this patch.

Noralf.
