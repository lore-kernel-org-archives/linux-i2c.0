From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] macintosh: windfarm: fix MODINFO regression
Date: Tue, 03 Mar 2020 19:58:19 +0100
Message-ID: <87d09tw9is.fsf@igel.home>
References: <20200303125046.5157-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:50025 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbgCCS6Y (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 3 Mar 2020 13:58:24 -0500
In-Reply-To: <20200303125046.5157-1-wsa@the-dreams.de> (Wolfram Sang's message
        of "Tue, 3 Mar 2020 13:50:46 +0100")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, debian-powerpc@lists.debian.org, Mathieu Malaterre <malat@debian.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Erhard Furtner <erhard_f@mailbox.org>

On Mär 03 2020, Wolfram Sang wrote:

> sound/aoa/codecs/onyx.c
> sound/aoa/codecs/tas.c

These are loaded explicitly via request_module (as snd-aoa-codec-%s).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
