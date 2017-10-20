From: Peter Rosin <peda@axentia.se>
Subject: [PULL REQUEST] i2c-mux for 4.15-rc1
Date: Fri, 20 Oct 2017 17:27:34 +0200
Message-ID: <21496b51-370f-2009-b25c-881c524fe2b9@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

This cycle has been real quiet for me. There's only the one trivial patch
that somewhat simplifies DT parsing in the i2c-mux-reg driver.

Please pull.

Cheers,
Peter

The following changes since commit 33d930e59a98fa10a0db9f56c7fa2f21a4aef9b9:

  Linux 4.14-rc5 (2017-10-15 21:01:12 -0400)

are available in the git repository at:

  https://github.com/peda-r/i2c-mux.git i2c-mux/for-next

for you to fetch changes up to 3997fb74846f35d0364c5e88e54bc9b166d5a1bc:

  i2c: mux: reg: use of_property_read_bool() (2017-10-20 16:33:07 +0200)

----------------------------------------------------------------
Sergei Shtylyov (1):
      i2c: mux: reg: use of_property_read_bool()

 drivers/i2c/muxes/i2c-mux-reg.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)
