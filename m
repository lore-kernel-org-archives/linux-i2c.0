From: Gregory Fong <gregory.0xf0@gmail.com>
Subject: Re: [PATCH] i2c: brcmstb: allocate correct amount of memory for regmap
Date: Sun, 21 Feb 2016 22:33:14 -0800
Message-ID: <CADtm3G7ZHfVyoEcAcFGC4oPX=XHyedSWDMvg6nKPLQ5_is=ZiQ@mail.gmail.com>
References: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34681 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbcBVGdo (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 22 Feb 2016 01:33:44 -0500
Received: by mail-ig0-f177.google.com with SMTP id g6so79767860igt.1
        for <linux-i2c@vger.kernel.org>; Sun, 21 Feb 2016 22:33:43 -0800 (PST)
In-Reply-To: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>

On Sun, Feb 21, 2016 at 6:16 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> We want the size of the struct, not of a pointer to it. To be future
> proof, just dereference the pointer to get the desired type.

This looks like it fixes like a fairly serious issue: before this
change, the driver may modify memory that wasn't allocated for this
struct.  Shouldn't this also have Cc: stable?

>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
