From: Asmaa Mnebhi <Asmaa@mellanox.com>
Subject: [PATCH v5 0/1] Add support for IPMB driver
Date: Thu,  2 May 2019 14:38:01 -0400
Message-ID: <cover.1556821099.git.Asmaa@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: minyard@acm.org, wsa@the-dreams.de, vadimp@mellanox.com, michaelsh@mellanox.com
Cc: Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Addressed Vadim's and Corey's comments.

1) I added support to instantiate several ipmb devices in the case
where there are multiple BMCs requesting data via IPMB to one
Satellite MC. Each instantiated device is named after the
IPMBus/I2C bus number it is associated with. I have documented all
this in IPMB.txt.

2) I think it might be confusing to use rol16 along with
GENMASK since it isn't as straight forward to read as a simple
(u8) typecast. I haven't really seen examples in the linux kernel
where this combo is being used as a substistute for typecasting;
while I have found multiple drivers where typecasting to (u8) is
being used: bt-bmc.c, kcs_bmc_aspeed.c, kcs_bmc_npcm7xx.c.
If you strongly feel it is worth it, I will change it.

3) I could eventually upstream the BMC driver I have been using
to test this ipmb-dev-int.
The reason I needed it is because the ipmb-dev-int driver is not
responsible for sending requests via I2C. It is only responsible
for receiving those requests and passing them to a user space program.
Once a response is received from the user space program, the driver
will forward that response back to the source requester.

The driver that I have on my bmc, is called ipmb-host. It works
hand in hand with ipmi_msghandler and ipmi_devintf to create
the /dev/ipmi0 device file to enable the use of ipmitool program
on the BMC. Once an ipmitool command is issued on the BMC, the
request message is sent to the Satellite MC. Once the BMC received
a response back from the Satellite MC, it will pass it to the
ipmitool program which will display the output to the user.

ipmb-dev-int does not need the msghandler not the devintf to be
loaded.

Asmaa Mnebhi (1):
  Add support for IPMB driver

 Documentation/IPMB.txt           |  64 +++++++
 drivers/char/ipmi/Kconfig        |   8 +
 drivers/char/ipmi/Makefile       |   1 +
 drivers/char/ipmi/ipmb_dev_int.c | 384 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 457 insertions(+)
 create mode 100644 Documentation/IPMB.txt
 create mode 100644 drivers/char/ipmi/ipmb_dev_int.c

-- 
2.1.2
