From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c fixes for Linux 3.7
Date: Tue, 13 Nov 2012 22:43:37 +0100
Message-ID: <20121113224337.0eff943e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem fixes for Linux 3.7 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

 MAINTAINERS                         |   60 +++++++++++++++++++++++++++++-----
 drivers/i2c/muxes/i2c-mux-pinctrl.c |    2 +-
 2 files changed, 52 insertions(+), 10 deletions(-)

---------------

Guenter Roeck (1):
      i2c-mux-pinctrl: Fix probe error path

Jean Delvare (1):
      MAINTAINERS: i2c: 7 years, this is it

Thanks,
-- 
Jean Delvare
