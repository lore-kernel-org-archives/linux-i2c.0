From: Michael Powell <mwpowellhtx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ArchLinux ARM I2C concurrent support
Date: Sun, 14 Apr 2013 09:00:42 -0500
Message-ID: <CAMEoF_Ftj8NZz0cMy8GsHRk8CapYK7H+b7NJyu6cS=HJ9aRWnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

I need to know about the I2C device support for ArchLinux ARM.

* Generally, am somewhat familiar with the Linux everything-is-a-file-
descriptor approach.
* Followed by we have an I2C device exposed as a device through /dev/i2c-0 file.
* No grouping or any other perms going on (yet), all at the root level
access (for now).

After which, questions about concurrency.

* I gather the usual file handling rules apply using open() and close().
* For a process (service, utility, whatever) to access the bus, must
open using open("/dev/i2c-0", O_RDWR).
* What about for multiple processes (services, utilities, watchdogs,
etc)? O_RDWR | O_DSYNC?

I assume there needs to be more of a synchronization integrity check going on?

Regards,

Michael Powell
