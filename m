From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/3] Drop generic i2c chip driver module parameters
Date: Tue, 6 Oct 2009 17:56:11 +0200
Message-ID: <20091006175611.46bf0dfa@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

Here comes the first part of a large patch series which aims at
dropping the generic i2c chip driver module parameters that were
inherited from the lm-sensors project: probe, ignore, force and
force_<type>. The same functionality is much better handled in a
centralized way than replicated across a hundred drivers, and the
recent changes to the binding model make it possible. Actually, the
replacement interface is already implemented: these are the sysfs
new_device and delete_device entries which are now created in each i2c
adapter directory. It might need some tweaking in the future, but the
core functionality is there already.

The second part will require changes to individual drivers. For
historical reasons, affected are mostly hwmon drivers: 44 out of
the 49 i2c-based hwmon drivers are affected, and only a few other
drivers are affected outside of the hwmon subsystem. Some statistics on
these drivers:
* Removes 15 lines of source code per driver on average.
* Removes 1.4 kB of binary module per driver on average (-7.7%).

The third part will happen later, when all individual drivers are
updated. These are interface cleanups which must be synchronized
across all affected drivers, so it's quite a pain to handle. I'll keep
them in my local tree for now, and push them upstream once all the rest
is there already.

In the end, this is 140 lines removed from <linux/i2c.h> (-19%).

Full combined diffstat:

 Documentation/i2c/old-module-parameters |   44 +++++
 Documentation/i2c/writing-clients       |    2 
 drivers/hwmon/adm1021.c                 |   87 +++--------
 drivers/hwmon/adm1025.c                 |   85 +++--------
 drivers/hwmon/adm1026.c                 |   58 +++----
 drivers/hwmon/adm1029.c                 |   71 ++-------
 drivers/hwmon/adm1031.c                 |   35 +---
 drivers/hwmon/adm9240.c                 |   70 +++------
 drivers/hwmon/ads7828.c                 |   35 +---
 drivers/hwmon/adt7462.c                 |   38 +----
 drivers/hwmon/adt7470.c                 |   38 +----
 drivers/hwmon/adt7473.c                 |   38 +----
 drivers/hwmon/adt7475.c                 |   22 +-
 drivers/hwmon/asb100.c                  |   66 ++------
 drivers/hwmon/atxp1.c                   |   11 -
 drivers/hwmon/dme1737.c                 |   42 +----
 drivers/hwmon/ds1621.c                  |   31 +---
 drivers/hwmon/f75375s.c                 |   40 +----
 drivers/hwmon/fschmd.c                  |   60 +++----
 drivers/hwmon/gl518sm.c                 |   40 +----
 drivers/hwmon/gl520sm.c                 |   25 +--
 drivers/hwmon/lm63.c                    |   69 +++------
 drivers/hwmon/lm75.c                    |   65 +++-----
 drivers/hwmon/lm77.c                    |   90 +++++------
 drivers/hwmon/lm78.c                    |   69 +++------
 drivers/hwmon/lm80.c                    |   13 -
 drivers/hwmon/lm83.c                    |   93 +++---------
 drivers/hwmon/lm85.c                    |  171 +++++++++-------------
 drivers/hwmon/lm87.c                    |   53 ++-----
 drivers/hwmon/lm90.c                    |  242 +++++++++++++-------------------
 drivers/hwmon/lm92.c                    |   40 +----
 drivers/hwmon/lm93.c                    |   40 +----
 drivers/hwmon/lm95241.c                 |   57 +------
 drivers/hwmon/max1619.c                 |   76 +++-------
 drivers/hwmon/max6650.c                 |   30 ---
 drivers/hwmon/pcf8591.c                 |    5 
 drivers/hwmon/smsc47m192.c              |   39 ++---
 drivers/hwmon/thmc50.c                  |   40 +----
 drivers/hwmon/tmp401.c                  |   64 +++-----
 drivers/hwmon/tmp421.c                  |   48 ++----
 drivers/hwmon/w83781d.c                 |  141 +++++++-----------
 drivers/hwmon/w83791d.c                 |   69 ++-------
 drivers/hwmon/w83792d.c                 |   70 ++-------
 drivers/hwmon/w83793.c                  |   62 ++------
 drivers/hwmon/w83l785ts.c               |   82 +++-------
 drivers/hwmon/w83l786ng.c               |   68 ++------
 drivers/i2c/i2c-core.c                  |  102 ++-----------
 drivers/misc/eeprom/eeprom.c            |    8 -
 drivers/misc/ics932s401.c               |   46 ++----
 include/linux/i2c.h                     |  146 -------------------
 50 files changed, 1082 insertions(+), 1954 deletions(-)

-- 
Jean Delvare
