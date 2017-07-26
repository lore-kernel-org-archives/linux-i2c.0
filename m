From: Jean Delvare <jdelvare@suse.de>
Subject: Re: observations on i2c-tools, man pages, possibly obsolete
 references
Date: Wed, 26 Jul 2017 16:07:07 +0200
Message-ID: <20170726160707.2e2ba1a2@endymion>
References: <20170725061144.Horde.dqeAbKSwCOLIHrYz8ePM3EB@crashcourse.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751613AbdGZOHS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 26 Jul 2017 10:07:18 -0400
In-Reply-To: <20170725061144.Horde.dqeAbKSwCOLIHrYz8ePM3EB@crashcourse.ca>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: rpjday@crashcourse.ca
Cc: linux-i2c@vger.kernel.org

Hello,

On Tue, 25 Jul 2017 06:11:44 -0400, rpjday@crashcourse.ca wrote:
>    first time pawing through the i2c-tools closely, some fairly trivial
> obervations from the perspective of a relative newbie. (i am basing these
> notes off of downloaded 3.1.2 tarball from
> http://fossies.org/linux/misc/i2c-tools-3.1.2.tar.gz/, hope that's
> correct.)

Looks reasonable, although by now you should be able to download from
the origin: https://www.kernel.org/pub/software/utils/i2c-tools/

>    first, despite what wolfram sang suggested, CCing maintainer jean
> delvare at jdelvare@suse.de is not mentioned in the top-level README file,
> at least not in this tarball. his email address is, of course, sprinkled
> profusely throughout the rest of the code base, but it's not in that
> README file.

Correct. My name and address were added to the master (development)
branch of i2c-tools, but that change was not propagated to the stable
branch (from which i2c-tools-3.1.2 was generated.) I have just fixed
it, thanks for reporting:

https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/commit/?h=i2c-tools-3.1&id=152c44190e1bb326c79a9974e7cb79f041990163

>    next, given that i2cget/ic2set/i2cdetect/i2cdump come as the collective
> set of tools, would it not make sense for each of those four man pages to
> refer under "See Also" to *all* of the other three tools?

I would tend to agree. All these tools (and now i2ctransfer) can be
used in combination depending on what you need to do, so it makes sense
for them to refer to each other.

> instead, while
> some man pages don't refer to all of the other three tools, some of those
> man pages refer oddly to what look like holdovers from lm-sensors or
> something else:
> 
>    * "man i2cdetect" refers to "sensors-detect(8)"
>    * "man i2cdump" refers to "isadump(8)"
>    * "man i2cset" refers to "isaset(8)"
> 
> should all those references still be there? it seems that any current
> references to older lm-sensors content are superfluous, especially since
> the fedora package for i2c-tools has no dependency on the lm_sensors
> package.

There is nothing wrong with referencing tools from other packages if
they happen to be related in at least some usage scenarios. See for
example the man page of gcc, it refers to gdb, ld and many other tools,
which are not part of the gcc package, but are used in conjunction with
gcc. The man page of lsusb refers to usbview, which is from a different
package, as an alternative. It also refers to lspci, also from a
different package, as a similar tool for a different bus type.

While there are obvious historical reasons for the references you
quoted above, I don't think they are fundamentally wrong. These tools
are not "old", they are still in the lm-sensors package, working and
useful.

>    one more note about the man pages: all but "i2cget" has a
> "Referenced By" section -- is that deliberate?

I can't see any such section here. What are you talking about exactly?

>    finally, regarding references in the code base to lm-sensors, the
> web site http://lm-sensors.org doesn't even seem to be available
> anymore, yet the file py-smbus/setup.py explicitly refers to it with:
> 
>      5 setup(  name="smbus",
>      6     version="1.1",
>      7     description="Python bindings for Linux SMBus access
> through i2c-dev",
>      8     author="Mark M. Hoffman",
>      9     author_email="mhoffman@lightlink.com",
>     10     maintainer="Mark M. Hoffman",
>     11     maintainer_email="linux-i2c@vger.kernel.org",
>     12     license="GPLv2",
>     13     url="http://lm-sensors.org/",   <------ there
>     ...

This is incorrect and should be changed, thanks for reporting. I'll
take care of it.

> while eeprom/decode-vaio contains the line:
> 
>    print("Deprecated old interface found.  Please upgrade to  
> lm_sensors 2.6.3 or greater.");

This one is correct. See this comment at the beginning of the script:

# The eeprom driver must be loaded. For kernels older than 2.6.0, the
# eeprom driver can be found in the lm-sensors package.

The print statement you quoted is only executed if running on an old
(2.4) kernel and the eeprom module is also old.

> one can simply "grep" for references to "lm-sensors" or "lm_sensors"
> to see if anything needs to be updated or removed.

I did, and will fix the references which shall be. Some will remain
because they are correct.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
