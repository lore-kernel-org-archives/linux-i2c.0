From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: i2c tools build failure with gcc 4.6
Date: Wed, 19 Dec 2012 17:07:33 -0800
Message-ID: <20121220010733.GA31336@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Seen with latest i2c-tools from svn repository.

gcc 4.6:

gcc-4.6  -Llib -li2c -o tools/i2cdetect tools/i2cdetect.o tools/i2cbusses.o
tools/i2cdetect.o: In function `main':
i2cdetect.c:(.text.startup+0x557): undefined reference to `i2c_smbus_write_quick'
i2cdetect.c:(.text.startup+0x5e9): undefined reference to `i2c_smbus_read_byte'
collect2: ld returned 1 exit status
make: *** [tools/i2cdetect] Error 1

gcc-4.4:
gcc-4.4  -Llib -li2c -o tools/i2cdetect tools/i2cdetect.o tools/i2cbusses.o

[ no error ]

Any idea ?

Guenter
