From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: i2c-tools 4.0
Date: Tue, 8 Aug 2017 13:59:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1708081358330.10607@localhost.localdomain>
References: <20170803153414.4c9135ff@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from cpanel2.indieserve.net ([199.212.143.6]:45630 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbdHHR7x (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 8 Aug 2017 13:59:53 -0400
In-Reply-To: <20170803153414.4c9135ff@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>

On Thu, 3 Aug 2017, Jean Delvare wrote:

> Hi all,
>
> I have been delaying this for too long, let's release i2c-tools 4.0. I
> know that there are still a few things which I wanted to include in it
> which aren't ready (specifically, merging (parts of) tools/i2cbusses
> into the library, and documenting the API), but apparently I can't find
> the time for them. So I have come to the conclusion that we should
> release what we have, and build incrementally on top of it after it has
> been adopted by distributions.
>
> Therefore I would like to ask everyone to give good testing to the
> master branch of:
>
> https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/
>
> because it will become i2c-tools 4.0 in a near future.

  is it too late to suggest this patch:

https://www.toradex.com/community/questions/10243/write-issue-with-eeprog-in-eeprom.html
https://share.toradex.com/s07bedxtxfdc4wj?direct

to increase the write sleep time so that one can write multiple bytes
with eeprog?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
