From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: Re: [PATCH 2/3] i2c: slave-eeprom: add eeprom simulator driver
Date: Wed, 26 Nov 2014 15:25:29 +0300
Message-ID: <2A7C987F-15E0-46FD-A711-E7F5BA9893FC@gmail.com>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de> <1416326695-13083-3-git-send-email-wsa@the-dreams.de> <CAOY=C6FSXWn2AKn9gp0oU69U8VkkyJAE7MMUTZsToy0P_Tf6AA@mail.gmail.com> <20141122181229.GB9698@katana>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20141122181229.GB9698@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Stijn Devriendt <highguy@gmail.com>, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Jean Delvare <jdelvare@suse.de>
List-Id: linux-i2c@vger.kernel.org


22 =CE=CF=D1=C2. 2014 =C7., =D7 21:12, Wolfram Sang <wsa@the-dreams.de>=
 =CE=C1=D0=C9=D3=C1=CC(=C1):

> IMO a repeated start is to ensure that two messages arrive at the sla=
ve
> without interruption from another master. I can't think why a slave
> should know which type of start that was. In fact, if it does that wo=
uld
> raise an eyebrow for me. Do you have an example?

It is used to implement Device ID reading.
Not sure, that the feature is really needed for the first release.

See [1] "3.1.17 Device ID" chapter on page "20 of 64"
See [2] "7.2.2 Device ID (PCA9671 ID field)" chapter

[1] UM10204 I2C-bus specification and user manual (http://www.nxp.com/d=
ocuments/user_manual/UM10204.pdf)
[2] PCA9671 (http://www.nxp.com/documents/data_sheet/PCA9671.pdf)

Alexander.

