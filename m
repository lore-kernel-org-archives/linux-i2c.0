From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] i2c-tools: Add examples to manual pages
Date: Wed, 25 Oct 2017 16:30:17 +0200
Message-ID: <1508941817.5353.8.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43851 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbdJYOaV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 25 Oct 2017 10:30:21 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>, Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>

As suggested by rpjday back in August. I tried to follow the same style
Wolfram used for the i2ctransfer examples, for consistency.
---
Please review and tell me if it addresses all your concerns. I'm also
interested if people find this too verbose, or not enough. Not sure if
I found the right balance.

Once this is reviewed and committed, I think we are good to release
i2c-tools 4.0.

 tools/i2cdetect.8 |   34 +++++++++++++++++++++++++++++++++-
 tools/i2cdump.8   |   40 +++++++++++++++++++++++++++++++++++++++-
 tools/i2cget.8    |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/i2cset.8    |   31 ++++++++++++++++++++++++++++++-
 4 files changed, 154 insertions(+), 4 deletions(-)

--- a/tools/i2cdetect.8
+++ b/tools/i2cdetect.8
@@ -1,4 +1,4 @@
-.TH I2CDETECT 8 "April 2008"
+.TH I2CDETECT 8 "October 2017"
 .SH NAME
 i2cdetect \- detect I2C chips
 
@@ -81,6 +81,38 @@ Display the version and exit.
 .B "\-l"
 Output a list of installed busses.
 
+.SH EXAMPLES
+.PP
+List all available I2C busses:
+.nf
+.RS
+# i2cdetect -l
+.RE
+.fi
+.PP
+Immediately scan the standard addresses on I2C bus 9 (i2c-9), using the
+default method for each address (no user confirmation):
+.nf
+.RS
+# i2cdetect -y 9
+.RE
+.fi
+.PP
+Query the functionalities of I2C bus 1 (i2c-1):
+.nf
+.RS
+# i2cdetect -F 1
+.RE
+.fi
+.PP
+Scan addresses 0x10 to 0x17 on the I2C bus named "SMBus I801 adapter at efa0",
+using the "receive byte" method, after user confirmation:
+.nf
+.RS
+# i2cdetect -r "SMBus I801 adapter at efa0" 0x10 0x17
+.RE
+.fi
+
 .SH SEE ALSO
 i2cdump(8), i2cget(8), i2cset(8), i2ctransfer(8), sensors-detect(8)
 
--- a/tools/i2cdump.8
+++ b/tools/i2cdump.8
@@ -1,4 +1,4 @@
-.TH I2CDUMP 8 "May 2008"
+.TH I2CDUMP 8 "October 2017"
 .SH NAME
 i2cdump \- examine I2C registers
 
@@ -74,6 +74,44 @@ on random addresses. Anyway, it is of li
 knowledge of the chip you're working with and an idea of what you are looking
 for.
 
+.SH EXAMPLES
+.PP
+Dump the whole contents of I2C device at 7-bit address 0x50 on bus 9
+(i2c-9), using the default read method (byte mode), after user confirmation:
+.nf
+.RS
+# i2cdump 9 0x50
+.RE
+.fi
+.PP
+Immediately dump the whole contents of I2C device at 7-bit address 0x50 on
+bus 9 (i2c-9), using I2C block read transactions (no user confirmation):
+.nf
+.RS
+# i2cdump -y 9 0x50 i
+.RE
+.fi
+If the device is an EEPROM, the output would typically be the same as output
+of the previous example.
+.PP
+Dump registers 0x00 to 0x3f of the I2C device at 7-bit address 0x2d on
+bus 1 (i2c-1), using the default read method (byte mode), after user
+confirmation:
+.nf
+.RS
+# i2cdump -r 0x00-0x3f 1 0x2d
+.RE
+.fi
+.PP
+Dump the registers of the SMBus device at address 0x69 on bus 0 (i2c-0),
+using one SMBus block read transaction with error checking enabled, after
+user confirmation:
+.nf
+.RS
+# i2cdump 0 0x69 sp
+.RE
+.fi
+
 .SH SEE ALSO
 i2cdetect(8), i2cget(8), i2cset(8), i2ctransfer(8), isadump(8)
 
--- a/tools/i2cget.8
+++ b/tools/i2cget.8
@@ -1,4 +1,4 @@
-.TH I2CGET 8 "May 2008"
+.TH I2CGET 8 "October 2017"
 .SH "NAME"
 i2cget \- read from I2C/SMBus chip registers
 
@@ -58,6 +58,57 @@ in such a way that an SMBus read transac
 certain chips. This is particularly true if setting \fImode\fR to \fBcp\fP (write byte/read
 byte with PEC). Be extremely careful using this program.
 
+.SH EXAMPLES
+.PP
+Get the value of 8-bit register 0x11 of the I2C device at 7-bit address 0x2d
+on bus 1 (i2c-1), after user confirmation:
+.nf
+.RS
+# i2cget 1 0x2d 0x11
+.RE
+.fi
+.PP
+Get the value of 16-bit register 0x00 of the I2C device at 7-bit address 0x48
+on bus 1 (i2c-1), after user confirmation:
+.nf
+.RS
+# i2cget 1 0x48 0x00 w
+.RE
+.fi
+.PP
+Set the internal pointer register of a 24C02 EEPROM at 7-bit address 0x50
+on bus 9 (i2c-9) to 0x00, then read the first 2 bytes from that EEPROM:
+.nf
+.RS
+# i2cset -y 9 0x50 0x00 ; i2cget -y 9 0x50 ; i2cget -y 9 0x50
+.RE
+.fi
+This assumes that the device automatically increments its internal pointer
+register on every read, and supports read byte transactions (read without
+specifying the register address, "Receive Byte" in SMBus terminology.)
+Most EEPROM devices behave that way. Note that this is only safe as long as
+nobody else is accessing the I2C device at the same time. A safer approach
+would be to use a "Read Word" SMBus transaction instead, or an I2C Block
+Read transaction to read more than 2 bytes.
+.PP
+Set the internal pointer register of a 24C32 EEPROM at 7-bit address 0x53
+on bus 9 (i2c-9) to 0x0000, then read the first 2 bytes from that EEPROM:
+.nf
+.RS
+# i2cset -y 9 0x53 0x00 0x00 ; i2cget -y 9 0x53 ; i2cget -y 9 0x53
+.RE
+.fi
+This again assumes that the device automatically increments its internal
+pointer register on every read, and supports read byte transactions. While
+the previous example was for a small EEPROM using 8-bit internal addressing,
+this example is for a larger EEPROM using 16-bit internal addressing. Beware
+that running this command on a small EEPROM using 8-bit internal addressing
+would actually \fIwrite\fR 0x00 to the first byte of that EEPROM. The safety
+concerns raised above still stand, however in this case there is no SMBus
+equivalent, so this is the only way to read data from a large EEPROM if your
+master isn't fully I2C capable. With a fully I2C capable master, you would
+use \fIi2ctransfer\fR to achieve the same in a safe and faster way.
+
 .SH SEE ALSO
 i2cdetect(8), i2cdump(8), i2cset(8), i2ctransfer(8)
 
--- a/tools/i2cset.8
+++ b/tools/i2cset.8
@@ -1,4 +1,4 @@
-.TH I2CSET 8 "November 2008"
+.TH I2CSET 8 "October 2017"
 .SH "NAME"
 i2cset \- set I2C registers
 
@@ -92,6 +92,35 @@ a serial EEPROM on a memory DIMM (chip a
 DESTROY your memory, leaving your system unbootable!  Be extremely careful
 using this program.
 
+.SH EXAMPLES
+.PP
+Write value 0x42 to 8-bit register 0x11 of the I2C device at 7-bit
+address 0x2d on bus 1 (i2c-1), after user confirmation:
+.nf
+.RS
+# i2cset 1 0x2d 0x11 0x42
+.RE
+.fi
+.PP
+Immediately clear the 3 least significant bits of 8-bit register 0x11 of the
+I2C device at 7-bit address 0x2d on bus 1 (i2c-1) (no user confirmation):
+.nf
+.RS
+# i2cset -y -m 0x07 1 0x2d 0x11 0x00
+.RE
+.fi
+.PP
+Write value 0x5000 to 16-bit register 0x02 of the I2C device at 7-bit
+address 0x48 on bus 1 (i2c-1), after user confirmation:
+.nf
+.RS
+# i2cset 1 0x48 0x02 0x5000 w
+.RE
+.fi
+.PP
+Also see i2cget(8) for examples of combined usage of \fIi2cset\fR and
+\fIi2cget\fR.
+
 .SH SEE ALSO
 i2cdetect(8), i2cdump(8), i2cget(8), i2ctransfer(8), isaset(8)
 
-- 
Jean Delvare
SUSE L3 Support
