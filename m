From: MikeB <mabnhdev@gmail.com>
Subject: Re: Looking for guidance to support 74CBTLV3253 mux
Date: Fri, 11 Nov 2016 06:47:12 -0500
Message-ID: <CAAuRgKAUNwnGRsfWb=H84svvzWKrCZq5GpBn7Xah47M0LcxOrQ@mail.gmail.com>
References: <CAAuRgKCgz5gtsCYxvykj9Nf1tMT+HLd--p1wb6ggBYcNJARfVQ@mail.gmail.com>
 <ca761330-e6de-243f-84eb-7a6c9dd9e59f@axentia.se> <f34feb2c-ca27-6b10-e783-aa70e58d99fe@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34374 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbcKKLrN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 11 Nov 2016 06:47:13 -0500
Received: by mail-yw0-f169.google.com with SMTP id t125so8650218ywc.1
        for <linux-i2c@vger.kernel.org>; Fri, 11 Nov 2016 03:47:13 -0800 (PST)
In-Reply-To: <f34feb2c-ca27-6b10-e783-aa70e58d99fe@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org

Thank you for the informative reply.  I was unfamiliar with the new
mux and parent locking schemes.  They do make the solution for this
problem much easier to deal with.  I'm working with release 4.4
(Ubuntu Xenial), so the mux/parent locking hadn't shown up on my radar
yet.  Unfortunately, the target release for my work is and will remain
4.4 for a while.

Regards, Mike

On Thu, Nov 10, 2016 at 8:01 AM, Peter Rosin <peda@axentia.se> wrote:
>> There is however one requirement, the CPLD-mux must be "mux-locked"
>> as explained in Documentation/i2c/i2c-topology. Otherwise accesses
>> to devices behind that mux will lock the PCA9547 mux for the full
>> duration of the transaction and thus lock out any attempts to update
>> the CPLD mux as part of the transaction.
