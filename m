From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [2.6.37 -> 2.6.38 regression] "mv64xxx: I2C bus locked, block: 1,
 time_left: 0" every few seconds
Date: Sun, 1 Jan 2012 01:32:55 -0600
Message-ID: <20120101073255.GA2402@elie.hsd1.il.comcast.net>
References: <20120101042401.4bef017e@natsu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120101042401.4bef017e@natsu>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roman Mamedov <rm@romanrm.ru>, Manuel Roeder <manuel_roeder@gmx.de>, Michael Ott <michael@king-coder.de>
List-Id: linux-i2c@vger.kernel.org

Hi,

Roman Mamedov wrote[1]:

> This bug is still present for me in the latest kernel version in
> Debian testing (3.1.6).
>
> The last properly working kernel version seems to be:
[...]
> And the problem occurs since:
[...]

Thanks.  Arnaud, any hints?  To summarize:

 - Michael Ott reported with Debian kernel 2.6.38-3 (which is closely
   based on stable v2.6.38.2):

	syslog tell me every few seconds:
	i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0

 - Manuel Roeder reported the same and found that upstream v2.6.38
   triggers the problem and v2.6.37.6 does not.

 - Roman Mamedov finds the bug present in Debian 3.1.6-1 (which
   is closely based on stable v3.1.6) and Debian 2.6.37-2 (based on
   stable v2.6.37.2) but not Debian 2.6.37-1 (based on mainline
   v2.6.37).

The regression range described above seems a little inconsistent to
me, so maybe there's something more going on.

Jonathan

[1] http://bugs.debian.org/622325
