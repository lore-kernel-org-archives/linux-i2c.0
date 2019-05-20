From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/2] at24: use devm_i2c_new_dummy_device()
Date: Mon, 20 May 2019 09:10:40 +0200
Message-ID: <20190520071042.21072-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Now that we have a resource managed version of i2c_new_dummy_device(),
use it in at24.

v1 -> v2:
- i2c_new_dummy_device() returns ERR_PTR(), not NULL so check the value
  correctly
- remove the no longer needed i2c_unregister_device() in error path

Bartosz Golaszewski (2):
  eeprom: at24: use devm_i2c_new_dummy_device()
  eeprom: at24: drop unnecessary label

 drivers/misc/eeprom/at24.c | 75 ++++++++++++--------------------------
 1 file changed, 24 insertions(+), 51 deletions(-)

-- 
2.21.0
