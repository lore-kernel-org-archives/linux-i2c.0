From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] macintosh: therm_windtunnel: fix regression when instantiating devices
Date: Thu, 27 Feb 2020 12:23:57 +1100
Message-ID: <87imjsu8k2.fsf@mpe.ellerman.id.au>
References: <20200225141229.5424-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:44631 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgB0BYC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 26 Feb 2020 20:24:02 -0500
In-Reply-To: <20200225141229.5424-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-i2c@vger.kernel.org, debian-powerpc@lists.debian.org, Mathieu Malaterre <malat@debian.org>, Wolfram Sang <wsa@the-dreams.de>, Erhard Furtner <erhard_f@mailbox.org>

Wolfram Sang <wsa@the-dreams.de> writes:
> Removing attach_adapter from this driver caused a regression for at
> least some machines. Those machines had the sensors described in their
> DT, too, so they didn't need manual creation of the sensor devices. The
> old code worked, though, because manual creation came first. Creation of
> DT devices then failed later and caused error logs, but the sensors
> worked nonetheless because of the manually created devices.
>
> When removing attach_adaper, manual creation now comes later and loses
> the race. The sensor devices were already registered via DT, yet with
> another binding, so the driver could not be bound to it.
>
> This fix refactors the code to remove the race and only manually creates
> devices if there are no DT nodes present. Also, the DT binding is updated
> to match both, the DT and manually created devices. Because we don't
> know which device creation will be used at runtime, the code to start
> the kthread is moved to do_probe() which will be called by both methods.
>
> Fixes: 3e7bed52719d ("macintosh: therm_windtunnel: drop using attach_adapter")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201723
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Tested-by: Erhard Furtner <erhard_f@mailbox.org>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>
> I suggest this stable-tag: # v4.19+

Looks right to me.

> Adding the Debian-PPC List to reach further people maybe willing to
> test.
>
> This patch does not depend on "[PATCH RESEND] macintosh: convert to
> i2c_new_scanned_device". In fact, this one here should go in first as
> 5.6 material. I will rebase and resend the i2c_new_scanned_device()
> conversion on top of this regression fix.
>
> I can also take this via I2C if easier.

I think that would be best, it's more I2C related than powerpc arch
stuff that I could review.

I don't have a machine setup to test this easily, but Erhard has been
doing a good job of testing things so I'm happy for you to take it with
his Tested-by.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
