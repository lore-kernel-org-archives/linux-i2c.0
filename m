From: "=?UTF-8?q?Niklas=20S=C3=B6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: [PATCH v2] emev2: add slave support
Date: Sat,  5 Dec 2015 18:51:30 +0100
Message-ID: <1449337891-3880-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: ian.molton@codethink.co.uk, laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com, linux-sh@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: linux-i2c@vger.kernel.org

Add i2c slave support to EMEV2.

Tested using a EMEV2, BeagleBone Black and a 24c02 eeprom. While the
EMEV2 provided a emulated eeprom on iic0 using slave-24c02 the Bone
could talk to both the physical and the emulated eeprom. The EMEV2 coul=
d
talk to the physical eeprom while still provide the emulated eeprom.

Changes since v1:
- Fixed sparse errors, thanks Wolfram
- Updated email to contain +renesas

Niklas S=C3=B6derlund (1):
  i2c: emev2: add slave support

 drivers/i2c/busses/i2c-emev2.c | 112 +++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 111 insertions(+), 1 deletion(-)

--
2.6.3

