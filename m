From: Asmaa Mnebhi <Asmaa@mellanox.com>
Subject: [PATCH v3 0/1] Add support for IPMB driver
Date: Mon, 29 Apr 2019 17:56:59 -0400
Message-ID: <cover.1556573807.git.Asmaa@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: minyard@acm.org, wsa@the-dreams.de, vadimp@mellanox.com, michaelsh@mellanox.com
Cc: Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Thank you for your feedback Wolfram. I have addressed your comments.

Concerning your questions:

"Why can't we use i2c_smbus_write_block_data()?"

i2c_smbus_write_block_data() does not allow me to pass the
requester_i2c_addr argument. Instead, it uses the
client->addr.
The client->addr in this driver is set to the
i2c address of the device where this driver is loaded
(since we used i2c_slave_register to register this device as
a slave).
But the address we want to pass to i2c_smbus_write_block_data_local
is actually the i2c address of the device on the other end of the
I2C bus. This is the case where our device acts as a master and
sends the IPMB (equivalent to I2C) response to the requester device
(which becomes the I2C slave).

"Can't we leave the default or will the compiler complain?"

I chose to leave the default because IPMB by definition only
allows master write. It doesn't do any reads. So if there is
any exetrnal device that tries to do a read, this i2c cb function
will just go to the default case.

"I really don't know enough about IPMB to judge if the design of
having one i2c-dev interface and another ipmb-dev interface is
a good solution"

I am open for discussion. My reasoning was that we need to interact
with user space so I used misc strictly to enable read/write.
Maybe we could do something similar to the i2c-slave-eeprom.c
where the eeprom_data struct uses bin_attributes?

Asmaa Mnebhi (1):
  Add support for IPMB driver

 drivers/char/ipmi/Kconfig        |   8 +
 drivers/char/ipmi/Makefile       |   1 +
 drivers/char/ipmi/ipmb_dev_int.c | 386 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 395 insertions(+)
 create mode 100644 drivers/char/ipmi/ipmb_dev_int.c

-- 
2.1.2
