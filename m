From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: can't write more than one byte to AT24C64 EEPROM using
 "eeprog"
Date: Wed, 26 Jul 2017 14:30:33 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1707261427010.32595@localhost.localdomain>
References: <20170725085131.Horde.ogXTYHLwBV6pmCIUgV7abh7@crashcourse.ca> <alpine.LFD.2.20.1707251344110.20856@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from cpanel2.indieserve.net ([199.212.143.6]:51974 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdGZSak (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 26 Jul 2017 14:30:40 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:32870 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1daR4u-0002gy-Km
        for linux-i2c@vger.kernel.org; Wed, 26 Jul 2017 14:30:36 -0400
In-Reply-To: <alpine.LFD.2.20.1707251344110.20856@localhost.localdomain>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org


  i've tossed all the previous post since it appears(?) i've
discovered the issue, which is explained here:

https://www.toradex.com/community/questions/10243/write-issue-with-eeprog-in-eeprom.html

if i read that correctly, "eeprog" is not leaving anywhere *near*
enough time for a byte write to complete, with a patch suggested here:

https://share.toradex.com/s07bedxtxfdc4wj?direct

that cranks up the wait period from 10 usec to 5 msec. does this make
sense, since that is *exactly* the symptom i'm seeing.

  thoughts? is no one else seeing this issue?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
