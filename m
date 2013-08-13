From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/5] i2c: sirf: a bundle of fixes for stability
Date: Tue, 13 Aug 2013 17:11:26 +0800
Message-ID: <1376385091-30597-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

here it is a bundle of fixes to sirfsoc i2c driver to make the driver stable
in random hardware and connect random i2c clients.

Zhiwu Song (5):
  i2c: sirf: reset i2c controller early after we get a noack
  i2c: sirf: reset i2c controller after resuming
  i2c: sirf: fix the typo for setting bitrate to less than 100k
  i2c: sirfsoc: support reverse direction of address
  i2c: sirf: retry 3 times as sometimes we get random noack and timeout

 drivers/i2c/busses/i2c-sirf.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

-- 
1.8.2.3
