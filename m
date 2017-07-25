From: rpjday@crashcourse.ca
Subject: observations on i2c-tools, man pages, possibly obsolete references
Date: Tue, 25 Jul 2017 06:11:44 -0400
Message-ID: <20170725061144.Horde.dqeAbKSwCOLIHrYz8ePM3EB@crashcourse.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from cpanel2.indieserve.net ([199.212.143.6]:52820 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbdGYKLp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 25 Jul 2017 06:11:45 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: jdelvare@suse.de


   first time pawing through the i2c-tools closely, some fairly trivial
obervations from the perspective of a relative newbie. (i am basing these
notes off of downloaded 3.1.2 tarball from
http://fossies.org/linux/misc/i2c-tools-3.1.2.tar.gz/, hope that's
correct.)

   first, despite what wolfram sang suggested, CCing maintainer jean
delvare at jdelvare@suse.de is not mentioned in the top-level README file,
at least not in this tarball. his email address is, of course, sprinkled
profusely throughout the rest of the code base, but it's not in that
README file.

   next, given that i2cget/ic2set/i2cdetect/i2cdump come as the collective
set of tools, would it not make sense for each of those four man pages to
refer under "See Also" to *all* of the other three tools? instead, while
some man pages don't refer to all of the other three tools, some of those
man pages refer oddly to what look like holdovers from lm-sensors or
something else:

   * "man i2cdetect" refers to "sensors-detect(8)"
   * "man i2cdump" refers to "isadump(8)"
   * "man i2cset" refers to "isaset(8)"

should all those references still be there? it seems that any current
references to older lm-sensors content are superfluous, especially since
the fedora package for i2c-tools has no dependency on the lm_sensors
package.

   one more note about the man pages: all but "i2cget" has a "Referenced
By" section -- is that deliberate?

   finally, regarding references in the code base to lm-sensors, the
web site http://lm-sensors.org doesn't even seem to be available
anymore, yet the file py-smbus/setup.py explicitly refers to it with:

     5 setup(  name="smbus",
     6     version="1.1",
     7     description="Python bindings for Linux SMBus access through  
i2c-dev",
     8     author="Mark M. Hoffman",
     9     author_email="mhoffman@lightlink.com",
    10     maintainer="Mark M. Hoffman",
    11     maintainer_email="linux-i2c@vger.kernel.org",
    12     license="GPLv2",
    13     url="http://lm-sensors.org/",   <------ there
    ...

while eeprom/decode-vaio contains the line:

   print("Deprecated old interface found.  Please upgrade to  
lm_sensors 2.6.3 or greater.");

one can simply "grep" for references to "lm-sensors" or "lm_sensors" to
see if anything needs to be updated or removed.

   that should be it for now, more in a bit.

rday
