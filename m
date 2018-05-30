From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 0/3] Fix double address byte issue
Date: Wed, 30 May 2018 11:07:10 +0100
Message-ID: <1527674833-13122-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, stable@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org

Hello Greg,

Wolfram recommends the backporting of this series in order to
improve the situation with a race condition.
Do you think you can take this series for 4.4 stable?

This series applies on 4.4.133, and depends on series:
"Fix R-Car I2C data byte sent twice issue"

Thanks,
Fab

Wolfram Sang (3):
  i2c: rcar: don't issue stop when HW does it automatically
  i2c: rcar: check master irqs before slave irqs
  i2c: rcar: revoke START request early

 drivers/i2c/busses/i2c-rcar.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

-- 
2.7.4
