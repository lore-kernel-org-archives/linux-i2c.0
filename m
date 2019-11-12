From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 0/3] Use void pointers instead of char in I2C transfer APIs
Date: Tue, 12 Nov 2019 12:31:29 -0800
Message-ID: <20191112203132.163306-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-iio@vger.kernel.orgi, Luca Ceresoli <luca@lucaceresoli.net>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>linux-iio@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

While we indeed often deal with a stream of bytes when executing a
transfer, at the higher layers we usually work with more structured
data, and there is not really a reason to require casts to u8 * form the
callers. These series change I2C APIs to accept [const] void pointers,
and also adjust SMBUS implementation to use get/put_unaligned_16() and
memcpy() for moving data around.

Changes in v3:
- addressed Luca's comments
- added Jonathan's Acked-by
- split put_unaligned_le16 into a separate patch
- more call sites converted to get/put_unaligned_le16
- new patch using memcpy() for moving data around

Changes in v2:
- adjusted max1363 to the new i2c_master_send/recv signatures

Dmitry Torokhov (3):
  i2c: use void pointers for supplying data for reads and writes
  i2c: smbus: use get/put_unaligned_le16 when working with word data
  i2c: smbus: switch from loops to memcpy

 drivers/i2c/i2c-core-base.c  |  2 +-
 drivers/i2c/i2c-core-smbus.c | 40 +++++++++++++++---------------------
 drivers/iio/adc/max1363.c    | 14 +++++++------
 include/linux/i2c.h          | 28 +++++++++++++------------
 4 files changed, 41 insertions(+), 43 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog
