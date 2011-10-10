From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: [PATCH V2] i2c: boilerplate function for byte swapped smbus_write/read_word_data
Date: Mon, 10 Oct 2011 10:07:42 +0100
Message-ID: <1318237663-13937-1-git-send-email-jic23@cam.ac.uk>
References: <20111009094118.44b616bf@endymion.delvare>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111009094118.44b616bf-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

V2: Jean's suggestions:

1) Documentation as comments on the smbus_write_word_data
and smbus_read_word_data entries in
Documetation/i2c/smbus-protocol
2) /* for swab 16 comment */
3) shorter names for the two functions (drop the _data part
as it doesn't tell us anything anyway).

V1:

Hi All,

Quite a number of devices rather unhelpfully handle smbus read/write word
commands but return the result byte swapped.  Hence drivers swap it back
again.

Examples based on quick grep or read users that byte swap(write is completely trivial)

drivers/hwmon/ad7418.c - no error handling so trivial
drivers/hwmon/ads1015.c - correct
drivers/hwmon/asb100.c - no error handling so trivial
drivers/hwmon/ds1621.c - correct
drivers/hwmon/ds620.c - no error handling so trivial
drivers/hwmon/gl518sm.c - no error handling so trivial
drivers/hwmon/gl520sm.c - no error handling so trivial
drivers/hwmon/jc42.c - correct
drivers/hwmon/lm73.c - no error handling
drivers/hwmon/lm75.c - correct
drivers/hwmon/lm92.c - some are byte swapped. Implementation doesn't handle errors
drivers/hwmon/tmp102.c - correct
drivers/hwmon/w83781.c - no error handling.
drivers/input/touchscreen/ad7879-i2c.c - no error handling
drivers/media/video/mt9m001.c - correct
drivers/media/video/mt9m111.c - no error handling
drivers/media/video/mt9t031.c - correct
drivers/media/video/mt9v022.c - correct
drivers/media/video/mt9v032.c - correct
drivers/media/video/vpx3220.c - correct
drivers/staging/iio/adc/ad7150.c - correct
drivers/staging/iio/adc/ad7152.c - correct
drivers/staging/iio/adc/ad7291.c - correct
drivers/staging/iio/adc/ad7746.c - correct
drivers/staging/iio/adc/ad799x_core.c - correct
drivers/staging/iio/adc/adt7410.c - correct
drivers/staging/iio/adc/adt75.c - correct

'correct' are those that need handle or at least pass on the error code without
mangling it.  The others typically just shove an error into some local
cache without taking any notice.

Just for the curious this is based on greping for i2c_smbus_write_word_data and
looking to see if the read does the swab16 as well.

Anyhow, so to the proposal.  Introduce a couple of inline static functions into
i2c.h.

My only use examples done so far are on top of unpublished iio
changes, so I'll leave the reader to take a look and decided
whether or not this is interesting enough to do.

Even if the driver uses equivalent functions we are saving about
6 lines per user.  I'm happy to do a series converting the easy
ones from the above if people don't mind the patch.

Jonathan Cameron (1):
  i2c: boilerplate function for byte swapped smbus_write/read_word_data

 Documentation/i2c/smbus-protocol |    8 ++++++++
 include/linux/i2c.h              |   17 +++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

-- 
1.7.3.4
