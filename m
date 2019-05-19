From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/2] at24: use devm_i2c_new_dummy_device()
Date: Sun, 19 May 2019 22:40:10 +0200
Message-ID: <20190519204012.31861-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I see Linus pulled the new helper, so here's a patch using it in at24
and also a small code tweak for better readability.

Bartosz Golaszewski (2):
  eeprom: at24: use devm_i2c_new_dummy_device()
  eeprom: at24: drop unnecessary label

 drivers/misc/eeprom/at24.c | 65 ++++++++++++--------------------------
 1 file changed, 21 insertions(+), 44 deletions(-)

-- 
2.21.0
