From: Peter Rosin <peda@axentia.se>
Subject: Re: Looking for guidance to support 74CBTLV3253 mux
Date: Fri, 11 Nov 2016 13:04:15 +0100
Message-ID: <19f4f235-ed83-2d5e-1568-a0292c927fda@axentia.se>
References: <CAAuRgKCgz5gtsCYxvykj9Nf1tMT+HLd--p1wb6ggBYcNJARfVQ@mail.gmail.com>
 <ca761330-e6de-243f-84eb-7a6c9dd9e59f@axentia.se>
 <f34feb2c-ca27-6b10-e783-aa70e58d99fe@axentia.se>
 <CAAuRgKAUNwnGRsfWb=H84svvzWKrCZq5GpBn7Xah47M0LcxOrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0094.outbound.protection.outlook.com ([104.47.2.94]:57197
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754572AbcKKNjO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 11 Nov 2016 08:39:14 -0500
In-Reply-To: <CAAuRgKAUNwnGRsfWb=H84svvzWKrCZq5GpBn7Xah47M0LcxOrQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: MikeB <mabnhdev@gmail.com>
Cc: linux-i2c@vger.kernel.org

On 2016-11-11 12:47, MikeB wrote:
> On Thu, Nov 10, 2016 at 8:01 AM, Peter Rosin <peda@axentia.se> wrote:
>>> There is however one requirement, the CPLD-mux must be "mux-locked"
>>> as explained in Documentation/i2c/i2c-topology. Otherwise accesses
>>> to devices behind that mux will lock the PCA9547 mux for the full
>>> duration of the transaction and thus lock out any attempts to update
>>> the CPLD mux as part of the transaction.
> 
> Thank you for the informative reply.  I was unfamiliar with the new
> mux and parent locking schemes.  They do make the solution for this
> problem much easier to deal with.  I'm working with release 4.4
> (Ubuntu Xenial), so the mux/parent locking hadn't shown up on my radar
> yet.  Unfortunately, the target release for my work is and will remain
> 4.4 for a while.

Lucky you :-)

Anyway, you might be able to backport the changes?

Start with:

a7ab72390b77062420fb50e4451f71c9321aae05
"i2c: mux: add common data for every i2c-mux instance"

through to

23fe440c59b9f08afe108e7ec7b6714cb2a3b955
"i2c: mux: drop old unused i2c-mux api"

And then:

785d32c7a9638a96730686663564d1842f7c2f03
"i2c: allow adapter drivers to override the adapter locking"

through to

f76b724ee915415c52068c622ca48c652c1bd10c
"i2c-mux: document i2c muxes and elaborate on parent-/mux-locked muxes"

There are a handful of commits right after that that are also
related, but they should be irrelevant to you...

Haven't tried it though, YMMV, and I might have forgotten a patch
or two that came in later, but I don't remember any serious fallout...

Cheers,
Peter
