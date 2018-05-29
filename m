From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 0/6] Fix R-Car I2C data byte sent twice issue
Date: Tue, 29 May 2018 14:33:10 +0100
Message-ID: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, stable@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org

Hello Greg,

this series fixes an issue with the I2C driver of the Renesas R-Car and
RZ/G1 family of chips. The issue is clearly visible with the CIP kernel
(4.4) running on a iwg20d board from iWave due to the way the bq32000
driver/device is interacting with the I2C driver/controller.
In the stable kernel (4.4) there is no support for the iwg20d, I tried
to replicate the same problem on a Koelsch board with no success, but
the problem is there.

Do you think this series is suitable for (4.4) stable considering I
can't reproduce the problem on the Koelsch board?

This patches apply on top of 4.4.133.

Thanks,
Fab

Wolfram Sang (6):
  i2c: rcar: make sure clocks are on when doing clock calculation
  i2c: rcar: rework hw init
  i2c: rcar: remove unused IOERROR state
  i2c: rcar: remove spinlock
  i2c: rcar: refactor setup of a msg
  i2c: rcar: init new messages in irq

 drivers/i2c/busses/i2c-rcar.c | 166 ++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 94 deletions(-)

-- 
2.7.4
