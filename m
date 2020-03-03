From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] macintosh: therm_windtunnel: fix regression when instantiating devices
Date: Tue, 03 Mar 2020 22:08:52 +1100
Message-ID: <87y2shr8zf.fsf@mpe.ellerman.id.au>
References: <20200225141229.5424-1-wsa@the-dreams.de> <20200228170033.GB1130@ninjato>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:60919 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbgCCLJA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 3 Mar 2020 06:09:00 -0500
In-Reply-To: <20200228170033.GB1130@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linuxppc-dev@lists.ozlabs.org
Cc: linux-i2c@vger.kernel.org, debian-powerpc@lists.debian.org, Mathieu Malaterre <malat@debian.org>, Erhard Furtner <erhard_f@mailbox.org>

Wolfram Sang <wsa@the-dreams.de> writes:
> On Tue, Feb 25, 2020 at 03:12:29PM +0100, Wolfram Sang wrote:
>> Removing attach_adapter from this driver caused a regression for at
>> least some machines. Those machines had the sensors described in their
>> DT, too, so they didn't need manual creation of the sensor devices. The
>> old code worked, though, because manual creation came first. Creation of
>> DT devices then failed later and caused error logs, but the sensors
>> worked nonetheless because of the manually created devices.
>> 
>> When removing attach_adaper, manual creation now comes later and loses
>> the race. The sensor devices were already registered via DT, yet with
>> another binding, so the driver could not be bound to it.
>> 
>> This fix refactors the code to remove the race and only manually creates
>> devices if there are no DT nodes present. Also, the DT binding is updated
>> to match both, the DT and manually created devices. Because we don't
>> know which device creation will be used at runtime, the code to start
>> the kthread is moved to do_probe() which will be called by both methods.
>> 
>> Fixes: 3e7bed52719d ("macintosh: therm_windtunnel: drop using attach_adapter")
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201723
>> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
>> Tested-by: Erhard Furtner <erhard_f@mailbox.org>
>> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>
> Applied to for-current, thanks!

Thanks.

cheers
