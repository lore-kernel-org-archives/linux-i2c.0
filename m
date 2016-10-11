From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 0/5] i2c: i2c-piix4: set of coding style fixes
Date: Tue, 11 Oct 2016 18:24:36 +0100
Message-ID: <20161011172441.7422-1-palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, wsa@the-dreams.de, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

This patchset fixes several coding style issues.

Carlos Palminha (5):
  i2c: i2c-piix4: coding style fix - '*' adjacent to data name
  i2c: i2c-piix4: coding style fix - assignment in if condition
  i2c: i2c-piix4: coding style fix - long comments blocks
  i2c: i2c-piix4: coding style fix - spaces with open parenthesis
  i2c: i2c-piix4: coding style fix - quoted string split across lines

 drivers/i2c/busses/i2c-piix4.c | 144 +++++++++++++++++++++++------------------
 1 file changed, 82 insertions(+), 62 deletions(-)

-- 
2.9.3
